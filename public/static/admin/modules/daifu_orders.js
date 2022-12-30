/*
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

layui.define(["table", "form", "element","treeGrid"],
    function(e) {
        var t = layui.$,
            i = layui.table,
            u = layui.util,
            form = layui.form;
            tree = layui.treeGrid;
        i.render({
            elem: "#app-order-list",
            url: 'getOrdersList',
            //自定义响应字段
            response: {
                statusName: 'code' //数据状态的字段名称
                ,statusCode: 1 //数据状态一切正常的状态码
                ,msgName: 'msg' //状态信息的字段名称
                ,dataName: 'data' //数据详情的字段名称
            },
            cols: [[{
                type: "checkbox",
                fixed: "left"
            },
                {
                    field: "id",
                    width: 80,
                    title: "ID",
                    sort: !0
                },
                {
                    field: "uid",
                    width: 80,
                    title: "商户编号"
                },
		    {
                    field: "amount",
                    width: 80,
                    title: "交易金额",
                    templet: function (item){
                       return item.amount
                    },
                    style:"color:red"
                },

                {
                    field: "bank_name",
                    width: 100,
                    title: "银行名称"
                },
                {
                    field: "bank_number",
                    width: 100,
                    title: "银行卡号"
                },
                {
                    field: "bank_owner",
                    width: 100,
                    title: "真实姓名"
                },
		      {
                    field: "service_rate",
                    width: 80,
                    title: "手续费",
                    templet: function (item){
                        return Number(item.service_charge) + Number(item.single_service_charge);
                    },
                    style:"color:red"
                },

                {
                    field: "username",
                    width: 100,
                    title: "码商"
                },
                {
                    field: "is_to_channel",
                    width: 60,
                    title: "是否中转",
                    align: "center",
                    templet: function (item){
                        var name = '';
                        if (item.is_to_channel == 1){
                          name = '否';
                        }else{
                            name = '<span style="color: red">是</span>';
                        }
                        return name;
                    },
                },
                {
                    field: "daifu_transfer_name",
                    width: 50,
                    title: "中转平台"
                },
                {
                    field: "out_trade_no",
                    width: 50,
                    title: "平台订单号"
                },
                {
                    field: "trade_no",
                    width: 50,
                    title: "跑分平台订单号"

		}
                ,
                {
                    field: "create_time",
                    width: 50,
                    title: "创建时间",
                },
                {
                    field: "update_time",
                    width: 50,
                    title: "更新时间",
                },

                {
                    field: "status",
                    title: "订单状态",
                    templet: "#buttonTpl",
                    minWidth: 50,
                    align: "center"
                },
                
                  {
                    field: "error_reason",
                    title: "失败原因",
                    minWidth: 50,

                },
                {
                    field: "notify_result",
                    title: "回调状态",
                    templet: "#notifyButtonTpl",
                    minWidth: 50,
                    align: "center"
                },
                {
                    title: "操作",
                    align: "center",
                    minWidth: 320,
                    // fixed: "right",
                    toolbar: "#table-system-order"
                }
                ]],
            page: !0,
            limit: 10,
            limits: [10, 15, 20, 25, 30],
            text: "对不起，加载出现异常！"
        }),
            // i.render({
            //     elem: "#app-team-dfstats-list",
            //     url: 'getTeamStats',
            //     //自定义响应字段
            //     response: {
            //         statusName: 'code' //数据状态的字段名称
            //         ,statusCode: 0 //数据状态一切正常的状态码
            //         ,msgName: 'msg' //状态信息的字段名称
            //         ,dataName: 'data' //数据详情的字段名称
            //     }
            //     ,cols: [[
            //         {
            //         field:'userid',
            //         width:100,
            //         title: '团长ID',
            //     }
            //         ,{
            //             field:'username',
            //             title: '团长名称',
            //         }
            //         // ,{
            //         //     field:'money',
            //         //     title: '团队佣金余额',
            //         // }
            //         // ,{
            //         //     field:'cash_pledge',
            //         //     title: '团队总押金',
            //         // }
            //         ,{
            //             field:'total_amount',
            //             title: '跑量',
            //         }
            //
            //     ]],
            //     page: !0,
            //     limit: 10,
            //     limits: [10, 15, 20, 25, 30,50],
            //     text: "对不起，加载出现异常！"
            // }),
            tree.render({
               elem: "#app-team-dfstats-list"
                ,url: "getTeamStats"
                ,cellMinWidth: 100
                ,idField:'userid'//必須字段
                ,treeId:'userid'//树形id字段名称
                ,treeUpId:'pid'//树形父id字段名称
                ,treeShowName:'username'//以树形式显示的字段
                ,heightRemove:[".dHead",10]//不计算的高度,表格设定的是固定高度，此项不生效
                ,height:'100%'
                ,isFilter:false
                ,iconOpen:false//是否显示图标【默认显示】
                ,isOpenDefault:false//节点默认是展开还是折叠【默认展开】
                ,loading:true
                ,cols: [[
                    {
                        field:'userid',
                        width:100,
                        title: '团长ID',
                    }
                    ,{
                        field:'username',
                        title: '团长名称',
                    }
                    // ,{
                    //     field:'money',
                    //     title: '团队佣金余额',
                    // }
                    // ,{
                    //     field:'cash_pledge',
                    //     title: '团队总押金',
                    // }
                    ,{
                        field:'total_amount',
                        title: '跑量',
                    }

                ]]
                ,isPage:false
                ,parseData: function (res) {
                    if(res.code == 1)
                    {
                        return {
                            'code': 201, //接口状态
                            'msg': '无数据', //提示文本
                            'count': 0, //数据长度
                            'data': [] //数据列表，是直接填充进表格中的数组
                        }
                    }
                },
            });
            // 渲染码商列表
            i.render({
                elem: "#app-daifu-userstatic-list",
                url: "getUserStats",
                //自定义响应字段
                response: {
                    statusName: 'code' //数据状态的字段名称
                    , statusCode: 0 //数据状态一切正常的状态码
                    , msgName: 'msg' //状态信息的字段名称
                    , dataName: 'data' //数据详情的字段名称
                },
                cols: [[
                    {
                        field: "uid",
                        width: 100,
                        title: "商户ID",
                        sort: !0
                    },
                    {
                        field: "username",
                        title: "商户名"
                    },
                    {
                        field: "daifu_total_number",
                        title: "代付订单总数"
                    },
                    {
                        field: "daifu_success_number",
                        title: "代付完成订单总数"
                    },
                    {
                        field: "daifu_total",
                        title: "代付交易总额"
                    },
                    {
                        field: "daifu_success_total",
                        title: "代付订单成功总额"
                    },

                    {
                        field: "success_rate",
                        title: "成功率（%）"
                    }]],
                page: !0,
                limit: 10,
                limits: [10, 15, 20, 25, 30],
                text: "对不起，加载出现异常！"
            }),
            i.on("tool(app-order-list)",
                function(e) {
                    e.data;
                    if ("details" === e.event) {
                        t(e.tr);
                        layer.open({
                            type: 2,
                            title: "交易详情",
                            content: "details.html?id=" + e.data.id,
                            maxmin: !0,                             area: ['80%','60%'],
                            btn: ["确定", "取消"],
                            yes: function(e, t) {},
                            success: function(e, t) {}
                        })
                    }
                    else if ("add_notify" === e.event) {
                        //补发通知
                        t(e.tr);
                        t.ajax({
                            url: 'add_notify',
                            method:'POST',
                            data:{id:e.data.id},
                            success:function (res) {
                                if (res.code == 1){
                                    layer.msg(res.msg, {icon: 1,time: 1500},function () {
                                        layer.closeAll();
                                        i.reload('app-order-list');
                                    });

                                }else{
                                    layer.msg(res.msg, {icon: 2,time: 1500});
                                }
                            }
                        });
                    }
                    else if("auditSuccess" === e.event){
                        layer.prompt({
                            formType: 1,
                            title: "敏感操作，请验证口令"
                        }, function(d, f) {
                            // console.log(i);return false;
                            //检测口令
                            t.ajax({
                                url: '/admin/api/checkOpCommand?command='+ d,
                                method:'POST',
                                success:function (res) {
                                    if (res.code == 1){
                                        console.log(123)
                                        //口令正确
                                        // layer.close(f); //关闭弹层
                                        // t(e.tr);
                                        //正式补单操作
                                        t.ajax({
                                            url: 'auditSuccess',
                                            method:'POST',
                                            data:{id:e.data.id},
                                            success:function (res) {
                                                if (res.code == 1){
                                                    layer.closeAll();
                                                    i.reload('app-order-list');
                                                }else{
                                                    layer.msg(res.msg, {icon: 2,time: 1500});
                                                }
                                            }
                                        });
                                    }else{
                                        layer.msg(res.msg,{icon:2,time:1500});
                                        layer.close(d); //关闭弹层
                                    }
                                }
                            });
                        });

                    }
                    else if("transfer_df" === e.event){
                        layer.open({
                            title: '请选择转发通道',
                            area:['280','250'],
                            content:'<div>' +
                                '<div className="layui-form">' +

                                '<div class="layui-input-block" style="width: 100%;margin-left: 0" className="layui-input-block">'+
                                '<select name="channel" style="width: 100%" id="channel"  class="layui-select" className="layui-select" >\n' +
                                '        <option >请选择通道</option>\n' +
                                '      </select>'+
                                '</div>' +
                                '</div>' +
                                '</div>',
                            yes:function(index){
                                t.post("dfTransfer",{id:e.data.id,channel:t('#channel').val()},function (res){
                                    if (res.code == 1){
                                        layer.msg(res.msg,{icon:1,time: 1000},function (){
                                            i.reload('app-order-list');
                                        })
                                    }else{
                                        layer.msg(res.msg,{icon:2,time: 1500},function (){
                                            // layer.close(index)
                                        })
                                    }
                                })
                            }
                        })
                        t.ajax({
                            url: "getTransferDfChannel",
                            dataType: 'json',
                            type: 'post',
                            success: function (data) {
                                console.log(data);//下面会提到这个data是什么值
                                //使用循环遍历，给下拉列表赋值
                                t.each(data.data, function (index, value) {
                                    // console.log(value.department_id);
                                    t('#channel').append(new Option(value.channel_name,value.id));// 下拉菜单里添加元素
                                });
                                layui.form.render("select");//重新渲染 固定写法
                            }
                        })


                    }
                    else if("select_transfer" === e.event){
                        console.log(e);
                        var url = e.data.transfer_chart;
                        var img = "<img src="+url+" id='img1' width='100%' height='auto'/>"
                        layer.tab({
                            area: ['600px', '500px'],
                            tab: [{
                                title: '查看转款详情',
                                content: img
                            }]
                        });

                    }
                    else if("auditError" === e.event){
                           
                        layer.open({
                                  type: 1, 
                                  	anim:2,
                                	title:'提交关闭原因',
                                	area:['400px','400px'],
                                	btn:['确认','关闭'],
                                    content:t('#gbyuanyin') ,
                            	    success:function(){
                            	        form.render();  //更新渲染表单
                            	    }, 
                            	    yes:function (index, f) {//这里也可以用btn1替代yes
                            	      var reason =  t("#reason").find("option:selected").text();
                                         t.ajax({
                                            url: 'auditError',
                                            method:'POST',
                                            data:{id:e.data.id,reason:reason},
                                            success:function (res) {
                                                if (res.code == 1){
                                                    layer.closeAll();
                                                    i.reload('app-order-list');
                                                }else{
                                                    layer.msg(res.msg, {icon: 2,time: 1500});
                                                }
                                            }
                                        });
                                    },
                                  });
                                                        
                        
                        // layer.prompt({
                        //     formType: 1,
                        //     title: "敏感操作，请验证口令"
                        // }, function(d, f) {
                        //     // console.log(i);return false;
                        //     //检测口令
                        //     t.ajax({
                        //         url: '/admin/api/checkOpCommand?command='+ d,
                        //         method:'POST',
                        //         success:function (res) {
                        //             if (res.code == 1){
                        //                 console.log(123)
                        //                 //口令正确
                        //                 // layer.close(f); //关闭弹层
                        //                 // t(e.tr);
                        //                 //正式补单操作
                        //                 t.ajax({
                        //                     url: 'auditError',
                        //                     method:'POST',
                        //                     data:{id:e.data.id},
                        //                     success:function (res) {
                        //                         if (res.code == 1){
                        //                             layer.closeAll();
                        //                             i.reload('app-order-list');
                        //                         }else{
                        //                             layer.msg(res.msg, {icon: 2,time: 1500});
                        //                         }
                        //                     }
                        //                 });
                        //             }else{
                        //                 layer.msg(res.msg,{icon:2,time:1500});
                        //                 layer.close(d); //关闭弹层
                        //             }
                        //         }
                        //     });
                        // });


                    }else if("appoint_ms" === e.event){
                        layer.open({
                            type: 2,
                            title: "指定码商",
                            content: "appoint_ms.html?id=" + e.data.id,
                            maxmin: !0,
                            area: ["600px", "400px"],
                            btn: ["确定", "取消"],
                            yes: function (d, f) {
                                var l = window["layui-layer-iframe" + d],
                                    o = "app-appoint-ms-submit",
                                    r = f.find("iframe").contents().find("#" + o);
                                l.layui.form.on("submit(" + o + ")",
                                    function (r) {
                                        var l = r.field;
                                        //提交修改
                                        t.post("appoint_ms", l, function (res) {
                                            if (res.code == 1) {
                                                layer.closeAll();
                                                i.reload('app-order-list');
                                            }
                                            layer.msg(res.msg, {icon: res.code == 1 ? 1 : 2, time: 1500});
                                        });
                                    }),
                                    r.trigger("click")
                            },
                            success: function (e, t) {
                            }
                        })
                    }
                }),
            e("daifu_orders", {})
    });
