<?php

require './vendor/autoload.php';

use QL\QueryList;
use QL\Ext\Chrome;

$db = \think\Db::connect(array(
    ''
));

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
        'buy' => ['.c-buy', 'text'],
        'method' => ['.payment-list', 'html']
    ])
    ->range('.fiat-entrust')
    ->queryData(function ($item) use ($ql) {
        $item['method'] = $ql::html($item['method'])->find('.pay-method')->texts();
        $item['method'] = !empty($item['method']->all()) ? implode(',', $item['method']->all()): '';
        return $item;
    });



print_r($lists_data);die();



