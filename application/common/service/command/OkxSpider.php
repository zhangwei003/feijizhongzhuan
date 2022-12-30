<?php
/**
 *  +----------------------------------------------------------------------
 *  | 狂神系统系统 [ WE CAN DO IT JUST THINK ]
 *  +----------------------------------------------------------------------
 *  | Copyright (c) 2018 http://www.iredcap.cn All rights reserved.
 *  +----------------------------------------------------------------------
 *  | Licensed ( https://www.apache.org/licenses/LICENSE-2.0 )
 *  +----------------------------------------------------------------------
 *  | Author: Brian Waring <BrianWaring98@gmail.com>
 *  +----------------------------------------------------------------------
 */

namespace app\common\service\command;


use think\console\Command;
use think\console\Input;
use think\console\Output;
use think\Db;
use think\Log;
use think\Model;
use QL\QueryList;
use QL\Ext\Chrome;


/**
 * 推送等待订单至队列   5分钟一次
 *
 * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
 *
 */
class OkxSpider extends Command
{

    /**
     * 配置定时器的信息
     *
     * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
     *
     */
    protected function configure()
    {
        $this->setName('OkxSpider')->setDescription('Crawl transaction row data');
    }

    /**
     *
     * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
     *
     * @param Input $input
     * @param Output $output
     * @return int|null|void
     */
    protected function execute(Input $input, Output $output)
    {
        $ql = QueryList::getInstance();
        // 注册插件，默认注册的方法名为: chrome
        $ql->use(Chrome::class);

        $playlists_ql = $ql->chrome(function ($page, $browser)  {
            $page->setUserAgent('Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36');
            $page->goto("https://www.okx.com/cn/p2p-markets/cny/buy-usdt");
            $page->evaluate("
                // 定义函数
                function page_scroll() {
                    var i = 1
                    var element = document.documentElement
                    element.scrollTop = 0;  // 不管他在哪里，都让他先回到最上面
        
                    // 设置定时器，时间即为滚动速度
                    function main() {
                        if (element.scrollTop + element.clientHeight == element.scrollHeight) {
                            clearInterval(interval)
                            console.log('已经到底部了')
                        } else {
                            element.scrollTop += 300;
                            console.log(i);
                            i += 1;
                        }
                    }
                    // 定义ID
                    interval = setInterval(main, 300)
                }
                page_scroll()
                
                function page_click() {
                    function clickNext(){
                        let next = document.querySelectorAll('#right-arrow yt-icon');
                        if (next){
                           for (var i = 0, len = next.length; i < len; i++) {
                                next[i].click()           
                            }
                        }else{
                             clearInterval(clickInterval)
                        }
                    }
                    clickInterval = setInterval(clickNext, 300) 
                }
                page_click()
               
            ");
            $page->waitForTimeout('10000');
            $html = $page->content();
            $browser->close();
            return $html;
        }, [
            'headless' => false, // 启动可视化Chrome浏览器,方便调试
            'devtools' => true,
            'args' => ['--no-sandbox']
        ]);

        $lists_data = $playlists_ql
            ->rules([
                'merchant_name' => ['.merchant-name a', 'text'],
                'price_buy' => ['.c-buy', 'text'],
                'pay_method' => ['.payment-list', 'html'],
            ])
            ->range('.fiat-entrust')
            ->queryData(function ($item) use ($ql) {
                $item['pay_method'] = $ql::html($item['pay_method'])->find('.pay-method')->texts();
                $item['pay_method'] = !empty($item['pay_method']->all()) ? implode(',', $item['pay_method']->all()): '';
                return $item;
            });

        if (!empty($lists_data)){
            Db::query('truncate table cm_tg_trading_house_data');
            //只获取前十
            Db::name('tg_trading_house_data')->insertAll(array_slice($lists_data,0,10));
        }

        Log::notice("[". date('Y-m-d H:i:s' ,time()) ."] 采集数据完成");
        $output->info("采集数据完成");

    }
}