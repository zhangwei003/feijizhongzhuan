/*
 *  +----------------------------------------------------------------------
 *  | 中通支付系统 [ WE CAN DO IT JUST THINK ]
 *  +----------------------------------------------------------------------
 *  | Copyright (c) 2018 http://www.iredcap.cn All rights reserved.
 *  +----------------------------------------------------------------------
 *  | Licensed ( https://www.apache.org/licenses/LICENSE-2.0 )
 *  +----------------------------------------------------------------------
 *  | Author: Brian Waring <BrianWaring98@gmail.com>
 *  +----------------------------------------------------------------------
 */


layui.define(["table", "form","treeGrid"],
    function (e) {
        var t = layui.$,
            q = layui.$,
            i = layui.table,
            u = layui.util,
            n = layui.form;
            tree = layui.treeGrid;
        //渲染码商二维码
        i.render({
            elem: "#app-pay-code-list",
            url: "getPaycodesLists",
            //自定义响应字段
            response: {
                statusCode: 1 //数据状态一切正常的状态码
            },
            cols: [
                [{
                    type: "checkbox",
                    fixed: "left"
                }, {
                    field: "id",
                    width: 80,
                    title: "ID",
                    sort: !0
                }, {
                    field: "username",
                    width: 150,
                    title: "码商用户名"
                }, {
                    field: "bank_name",
                    width: 150,
                    title: "银行卡名称"
                }, {
                    field: "account_name",
                    width: 150,
                    title: "账户名"
                }, {
                    field: "account_number",
                    width: 150,
                    title: "收款账号"
                }, {
                    field: "balance",
                    width: 150,
                    title: "余额（来自短信）"
                },
                    {
                        field: "status",
                        title: "状态",
                        templet: "#buttonTpl",
                        minWidth: 80,
                        align: "center"
                    },
                    //
                    // {
                    //     field: "is_lock",
                    //     title: "锁定状态",
                    //     templet: "#buttonTpl1",
                    //     minWidth: 80,
                    //     align: "center"
                    // },

                    {
                        field: "create_time",
                        width: 100,
                        title: "添加时间"
                    }
                    , {
                    title: "操作",
                    // width: 500,
                    align: "center",
                    fixed: "right",
                    toolbar: "#table-pay-code"
                }]
            ],
            page: !0,
            limit: 10,
            limits: [10, 15, 20, 25, 30],
            text: "对不起，加载出现异常！"
        }),
            i.on("tool(app-pay-code-list)",
                function (t) {
                    var e = t.data;
                    "del" === t.event ? layer.confirm("确定删除此二维码？",
                        function (d) {
                            q.ajax({
                                url: 'delPayCode?id=' + e.id,
                                method: 'POST',
                                success: function (res) {
                                    if (res.code == 1) {
                                        t.del()
                                    }
                                    layer.msg(res.msg, {icon: res.code == 1 ? 1 : 2, time: 1500});
                                    layer.close(d); //关闭弹层
                                }
                            });
                        }) : "edit" === t.event && layer.open({
                        type: 2,
                        title: "编辑文章",
                        content: "edit.html?id=" + e.id,
                        maxmin: !0,
                        maxmin: !0, area: ['80%', '60%'],
                        btn: ["确定", "取消"],
                        yes: function (e, i) {
                            var l = window["layui-layer-iframe" + e],
                                a = i.find("iframe").contents().find("#app-article-form-edit");
                            l.layui.form.on("submit(app-article-form-edit)",
                                function (i) {
                                    var l = i.field;
                                    layui.$.post("edit", l, function (res) {
                                        if (res.code == 1) {
                                            //更新数据表
                                            t.update({
                                                label: l.label,
                                                title: l.title,
                                                author: l.author,
                                                status: l.status
                                            }),
                                                n.render(),
                                                layer.close(e)
                                        }
                                        layer.msg(res.msg, {icon: res.code == 1 ? 1 : 2, time: 1500});
                                    });
                                }),
                                a.trigger("click")
                        }
                    })
                });
        i.render({
            elem: "#app-uid-list",
            url: "getuidLists",
            //自定义响应字段
            response: {
                statusCode: 1 //数据状态一切正常的状态码
            },
            cols: [
                [{
                    type: "checkbox",
                    fixed: "left"
                }, {
                    field: "name",
                    width: 120,
                    title: "类型",
                },
                    {
                    field: "id",
                    width: 80,
                    title: "ID",
                    sort: !0
                }, {
                    field: "username",
                    width: 150,
                    title: "码商用户名"
                }, {
                    field: "account_name",
                    width: 150,
                    title: "收款人"
                }, {
                    field: "bank_name",
                    width: 150,
                    title: "支付宝账号"
                }, {
                    field: "account_number",
                    width: 150,
                    title: "支付宝UID"
                },
                    {
                        field: "status",
                        title: "状态",
                        templet: "#buttonTpl",
                        minWidth: 80,
                        align: "center"
                    },

                    {
                        field: "create_time",
                        width: 100,
                        title: "添加时间"
                    }
                    , {
                    title: "操作",
                    // width: 500,
                    align: "center",
                    fixed: "right",
                    toolbar: "#table-pay-code"
                }]
            ],
            page: !0,
            limit: 10,
            limits: [10, 15, 20, 25, 30],
            text: "对不起，加载出现异常！"
        }),
            i.on("tool(app-uid-list)",
                function (t) {
                    var e = t.data;
                    if("del" === t.event){
                        layer.confirm("确定删除此二维码？",
                            function (d) {
                                q.ajax({
                                    url: 'delPayCode?id=' + e.id,
                                    method: 'POST',
                                    success: function (res) {
                                        if (res.code == 1) {
                                            t.del()
                                        }
                                        layer.msg(res.msg, {icon: res.code == 1 ? 1 : 2, time: 1500});
                                        layer.close(d); //关闭弹层
                                    }
                                });
                            })
                    }else if("edit" === t.event ){
                        layer.open({
                            type: 2,
                            title: "编辑文章",
                            content: "edit.html?id=" + e.id,
                            maxmin: !0,
                            maxmin: !0, area: ['80%', '60%'],
                            btn: ["确定", "取消"],
                            yes: function (e, i) {
                                var l = window["layui-layer-iframe" + e],
                                    a = i.find("iframe").contents().find("#app-article-form-edit");
                                l.layui.form.on("submit(app-article-form-edit)",
                                    function (i) {
                                        var l = i.field;
                                        layui.$.post("edit", l, function (res) {
                                            if (res.code == 1) {
                                                //更新数据表
                                                t.update({
                                                    label: l.label,
                                                    title: l.title,
                                                    author: l.author,
                                                    status: l.status
                                                }),
                                                    n.render(),
                                                    layer.close(e)
                                            }
                                            layer.msg(res.msg, {icon: res.code == 1 ? 1 : 2, time: 1500});
                                        });
                                    }),
                                    a.trigger("click")
                            }
                        })
                    }else if("testuid" === t.event){
                        layer.open({
                            type: 2,
                            title: "测码",
                            content: "testuid.html?id=" + e.id,
                            maxmin: !0,
                            maxmin: !0, area: ['80%', '60%'],
                    })}

                });



        i.render({
            elem: "#app-alipaycode-list",
            url: "getalipaycodeLists",
            //自定义响应字段
            response: {
                statusCode: 1 //数据状态一切正常的状态码
            },
            cols: [
                [{
                    type: "checkbox",
                    fixed: "left"
                },
                    {
                        field: "id",
                        width: 80,
                        title: "ID",
                        sort: !0
                    }, {
                    field: "username",
                    width: 150,
                    title: "码商用户名"
                }, {
                    field: "account_name",
                    width: 150,
                    title: "收款人"
                }, {
                    field: "bank_name",
                    width: 150,
                    title: "支付宝账号"
                },
                    {
                        field: "status",
                        title: "状态",
                        templet: "#buttonTpl",
                        minWidth: 80,
                        align: "center"
                    },

                    {
                        field: "create_time",
                        width: 100,
                        title: "添加时间"
                    }
                    , {
                    title: "操作",
                    // width: 500,
                    align: "center",
                    fixed: "right",
                    toolbar: "#table-pay-code"
                }]
            ],
            page: !0,
            limit: 10,
            limits: [10, 15, 20, 25, 30],
            text: "对不起，加载出现异常！"
        }),
            i.on("tool(app-alipaycode-list)",
                function (t) {
                    var e = t.data;
                    if("del" === t.event){
                        layer.confirm("确定删除此二维码？",
                            function (d) {
                                q.ajax({
                                    url: 'delPayCode?id=' + e.id,
                                    method: 'POST',
                                    success: function (res) {
                                        if (res.code == 1) {
                                            t.del()
                                        }
                                        layer.msg(res.msg, {icon: res.code == 1 ? 1 : 2, time: 1500});
                                        layer.close(d); //关闭弹层
                                    }
                                });
                            })
                    }else if("edit" === t.event ){
                        layer.open({
                            type: 2,
                            title: "编辑文章",
                            content: "edit.html?id=" + e.id,
                            maxmin: !0,
                            maxmin: !0, area: ['80%', '60%'],
                            btn: ["确定", "取消"],
                            yes: function (e, i) {
                                var l = window["layui-layer-iframe" + e],
                                    a = i.find("iframe").contents().find("#app-article-form-edit");
                                l.layui.form.on("submit(app-article-form-edit)",
                                    function (i) {
                                        var l = i.field;
                                        layui.$.post("edit", l, function (res) {
                                            if (res.code == 1) {
                                                //更新数据表
                                                t.update({
                                                    label: l.label,
                                                    title: l.title,
                                                    author: l.author,
                                                    status: l.status
                                                }),
                                                    n.render(),
                                                    layer.close(e)
                                            }
                                            layer.msg(res.msg, {icon: res.code == 1 ? 1 : 2, time: 1500});
                                        });
                                    }),
                                    a.trigger("click")
                            }
                        })
                    }
                });

        i.render({
            elem: "#app-order-list",  //码商订单dom
            url: 'getOrdersList',
            //自定义响应字段
            response: {
                statusName: 'code' //数据状态的字段名称
                , statusCode: 1 //数据状态一切正常的状态码
                , msgName: 'msg' //状态信息的字段名称
                , dataName: 'data' //数据详情的字段名称
            },
            cols: [[{
                type: "checkbox",
                fixed: "left"
            },
                {
                    field: "id",
                    width: 50,
                    title: "ID",
                    sort: !0
                },
                {
                    field: "shuid",
                    width: 100,
                    title: "所属商户号",
                },
                {
                    field: "shname",
                    width: 100,
                    title: "所属商户",
                },
                {
                    field: "order_no",
                    width: 150,
                    title: "订单号",
                },
                {
                    field: "username",
                    width: 100,
                    title: "所属码商",
                },
                {
                    field: "pay_user_name",
                    width: 100,
                    title: "支付用户【商户上报】",
                },
                {
                    field: "order_price",
                    width: 100,
                    title: "订单金额",
                },
                {
                    field: "order_pay_price",
                    width: 100,
                    title: "支付金额",
                },
                {
                    field: "code_id",
                    width: 100,
                    title: "收款信息",
                    templet: function (d) {
                        return '账户:' + d.account_name + ' 银行:' + d.bank_name + ' 卡号:' + d.account_number
                        // if (d.request_elapsed_time > 0) {
                        //     return d.add_time;
                        // }
                        // return "<span style='color: red'>" + d.add_time + "</span>";
                    }
                },
                {
                    field: "note",
                    width: 80,
                    title: "回调方式",
                },

                {
                    field: "visite_info",
                    width: 100,
                    title: "访问信息信息",
                    templet: function (d) {
                        var visite_ip = d.visite_ip ? d.visite_ip : '--';
                        var visite_clientos = d.visite_clientos ? d.visite_clientos : '--'
                        return 'IP:' + visite_ip + ' 设备:' + visite_clientos
                    }
                },

                {
                    field: "add_time",
                    width: 200,
                    title: "创建时间",
                    templet: function (d) {
                        return u.toDateString(d.add_time * 1000);
                    }
                },
                {
                    field: "pay_time",
                    width: 200,
                    title: "支付时间",
                    templet: function (d) {

                        return d.pay_time ? u.toDateString(d.pay_time * 1000) : '--';
                    }
                },


                {
                    field: "pay_username",
                    width: 100,
                    title: "付款人姓名",
                },

                {
                    field: "status",
                    title: "订单状态",
                    templet: "#buttonTpl",
                    minWidth: 80,
                    align: "center"
                },
                {
                    field: "is_status",
                    title: "回调状态",
                    templet: "#buttonIsStatus",
                    minWidth: 80,
                    align: "center"
                },

                {
                    field: "sure_order_role",
                    width: 100,
                    title: "操作员角色",
                    templet: function (d) {
                        role = '--';
                        if (d.sure_order_role == 1) {
                            role = '码商'
                        }
                        if (d.sure_order_role == 2) {
                            role = '管理员'
                        }

                        return role;
                    }
                },

                {
                    title: "操作",
                    align: "center",
                    minWidth: 450,
                    // fixed: "right",
                    toolbar: "#table-system-order"
                },
            ]],
            page: !0,
            limit: 10,
            limits: [10, 15, 20, 25, 30, 50],
            text: "对不起，加载出现异常！"
        }),
            i.on("tool(app-order-list)",
                function (e) {
                    e.data;
                    if ("details" === e.event) {
                        t(e.tr);
                        layer.open({
                            type: 2,
                            title: "交易详情",
                            content: "details.html?id=" + e.data.id,
                            maxmin: !0, area: ['80%', '60%'],
                            btn: ["确定", "取消"],
                            yes: function (e, t) {
                            },
                            success: function (e, t) {
                            }
                        })
                    } else if ("add_notify" === e.event) {
                        //补发通知
                        t(e.tr);
                        var index = layer.load(0, {shade: false}); //0代表加载的风格，支持0-2
                        t.ajax({
                            url: 'subnotify?order_id=' + e.data.id,
                            method: 'POST',
                            success: function (res) {
                                layer.closeAll();
                                if (res.code == 1) {
                                    layer.msg(res.msg, {icon: 1, time: 3000}, function () {

                                        i.reload('app-order-list');
                                    });

                                } else {
                                    layer.msg(res.msg, {icon: 2, time: 3000});
                                }
                            }
                        });
                    } else if ("selectInfo" === e.event){
                        layer.open({
                            type: 2,
                            title: "短信详情",
                            content: "smsinfo.html?id=" + e.data.id,
                            maxmin: !0,                             area: ['80%','60%'],
                        })
                    }else if ("budan" === e.event) {
                        layer.prompt({
                            formType: 1,
                            title: "敏感操作，请验证口令"
                        }, function (d, f) {
                            // console.log(i);return false;
                            //检测口令
                            t.ajax({
                                url: '/admin/api/checkOpCommand?command=' + d,
                                method: 'POST',
                                success: function (res) {
                                    if (res.code == 1) {
                                        //口令正确
                                        layer.close(f); //关闭弹层
                                        t(e.tr);
                                        layer.open({
                                            type: 2,
                                            title: "补单详情",
                                            content: "budanDetails.html?id=" + e.data.id,
                                            maxmin: !0, area: ['80%', '60%'],
                                            btn: ["确定", "取消"],
                                            yes: function (e1, layero) {
                                                var bd_remarks = t.trim(layero.find('iframe').contents().find('#bd_remarks').val());
                                                if (bd_remarks === '') {
                                                    layer.msg('补单人请填写补单备注', {icon: 2, time: 1500});
                                                }
                                                if (bd_remarks.length > 255) {
                                                    layer.msg('补单备注最长255个字符', {icon: 2, time: 1500});
                                                }
                                                //正式补单操作
                                                t.ajax({
                                                    url: 'update?id=' + e.data.id,
                                                    method: 'POST',
                                                    data: {bd_remarks: bd_remarks},
                                                    success: function (res) {
                                                        if (res.code == 1) {
                                                            layer.closeAll();
                                                            i.reload('app-order-list');
                                                        } else {
                                                            layer.msg(res.msg, {icon: 2, time: 1500});
                                                        }
                                                    }
                                                });
                                            },
                                            // success: function(e, t) {
                                            //
                                            //     //正式补单操作
                                            //     //                 t.ajax({
                                            //     //                     url: 'update?id='+ e.data.id,
                                            //     //                     method:'POST',
                                            //     //                     success:function (res) {
                                            //     //                         if (res.code == 1){
                                            //     //                             e.update()
                                            //     //                         }
                                            //     //                         layer.msg(res.msg, {icon: res.code == 1 ? 1: 2,time: 1500});
                                            //     //                         layer.close(d); //关闭弹层
                                            //     //                     }
                                            //     //                 });
                                            //
                                            //
                                            //
                                            //
                                            //
                                            // }
                                        })
                                        // layer.confirm("你确定要修改该订单吗？", function(m,n) {
                                        //     //弹出补单时候的详情页 和原来的页面分开吧
                                        //     layer.close(n); //关闭弹层
                                        //
                                        //
                                        //
                                        //
                                        //
                                        //         // t.ajax({
                                        //         //     url: 'update?id='+ e.data.id,
                                        //         //     method:'POST',
                                        //         //     success:function (res) {
                                        //         //         if (res.code == 1){
                                        //         //             e.update()
                                        //         //         }
                                        //         //         layer.msg(res.msg, {icon: res.code == 1 ? 1: 2,time: 1500});
                                        //         //         layer.close(d); //关闭弹层
                                        //         //     }
                                        //         // });
                                        //     })
                                        // layer.open({
                                        //     type: 2
                                        //     ,title: '增减余额'
                                        //     ,content: 'changeBalance.html?uid=' + e.data.uid
                                        //     ,maxmin: true
                                        //     ,area: ['80%','60%']
                                        //     ,btn: ['确定', '取消']
                                        //     ,yes: function(index, layero){
                                        //         var iframeWindow = window['layui-layer-iframe'+ index]
                                        //             ,submitID = 'app-user-manage-submit'
                                        //             ,submit = layero.find('iframe').contents().find('#'+ submitID);
                                        //
                                        //         //监听提交
                                        //         iframeWindow.layui.form.on('submit('+ submitID +')', function(obj){
                                        //             var field = obj.field; //获取提交的字段
                                        //
                                        //             //提交 Ajax 成功后，静态更新表格中的数据
                                        //             t.ajax({
                                        //                 url:'changeBalance.html?uid=' + e.data.uid,
                                        //                 method:'POST',
                                        //                 data:field,
                                        //                 success:function (res) {
                                        //                     if (res.code == 1){
                                        //                         console.log(11111);
                                        //                         layer.closeAll();
                                        //                         //parent.parent.layui.table.reload('app-balance-list'); //重载表格
                                        //                         i.reload('app-balance-list');
                                        //                     }else{
                                        //                         layer.msg(res.msg, {icon: 2,time: 1500});
                                        //                     }
                                        //                 }
                                        //             });
                                        //         });
                                        //         submit.trigger('click');
                                        //     }
                                        // });
                                    } else {
                                        layer.msg(res.msg, {icon: 2, time: 1500});
                                        layer.close(d); //关闭弹层
                                    }
                                }
                            });
                        });
                        // function(d, i) {
                        //     layer.close(i),
                        //         layer.confirm("你确定要修改该订单吗？", function(d) {
                        //                 t.ajax({
                        //                     url: 'update?id='+ e.data.id,
                        //                     method:'POST',
                        //                     success:function (res) {
                        //                         if (res.code == 1){
                        //                             e.update()
                        //                         }
                        //                         layer.msg(res.msg, {icon: res.code == 1 ? 1: 2,time: 1500});
                        //                         layer.close(d); //关闭弹层
                        //                     }
                        //                 });
                        //             })
                        // });
                    } else if ("issueOrder" === e.event) {
                        layer.prompt({
                            formType: 1,
                            title: "敏感操作，请验证口令"
                        }, function (d, f) {
                            // console.log(i);return false;
                            //检测口令
                            t.ajax({
                                url: '/admin/api/checkOpCommand?command=' + d,
                                method: 'POST',
                                success: function (res) {
                                    if (res.code == 1) {
                                        //口令正确
                                        layer.close(f); //关闭弹层
                                        t(e.tr);
                                        //正式补单操作

                                        t.ajax({
                                            url: 'issueOrder',
                                            method: 'POST',
                                            data: {user_id: 0, coerce: 0, id: e.data.id},
                                            success: function (res) {
                                                if (res.code == 1) {
                                                    layer.closeAll();
                                                    i.reload('app-order-list');
                                                } else {
                                                    layer.msg(res.msg, {icon: 2, time: 1500});
                                                }
                                            }
                                        });
                                    } else {
                                        layer.msg(res.msg, {icon: 2, time: 1500});
                                        layer.close(d); //关闭弹层
                                    }
                                }
                            });
                        });
                        // function(d, i) {
                        //     layer.close(i),
                        //         layer.confirm("你确定要修改该订单吗？", function(d) {
                        //                 t.ajax({
                        //                     url: 'update?id='+ e.data.id,
                        //                     method:'POST',
                        //                     success:function (res) {
                        //                         if (res.code == 1){
                        //                             e.update()
                        //                         }
                        //                         layer.msg(res.msg, {icon: res.code == 1 ? 1: 2,time: 1500});
                        //                         layer.close(d); //关闭弹层
                        //                     }
                        //                 });
                        //             })
                        // });
                    }else if ("refundOrder" === e.event) {
                        layer.prompt({
                            formType: 1,
                            title: "敏感操作，请验证口令"
                        }, function (d, f) {
                            // console.log(i);return false;
                            //检测口令
                            t.ajax({
                                url: '/admin/api/checkOpCommand?command=' + d,
                                method: 'POST',
                                success: function (res) {
                                    if (res.code == 1) {
                                        //口令正确
                                        layer.close(f); //关闭弹层
                                        t(e.tr);
                                        //正式补单操作

                                        t.ajax({
                                            url: 'refundOrder',
                                            method: 'POST',
                                            data: {user_id: 0, coerce: 0, id: e.data.id},
                                            success: function (res) {
                                                if (res.code == 1) {
                                                    layer.closeAll();
                                                    i.reload('app-order-list');
                                                } else {
                                                    layer.msg(res.msg, {icon: 2, time: 1500});
                                                }
                                            }
                                        });
                                    } else {
                                        layer.msg(res.msg, {icon: 2, time: 1500});
                                        layer.close(d); //关闭弹层
                                    }
                                }
                            });
                        });
                        // function(d, i) {
                        //     layer.close(i),
                        //         layer.confirm("你确定要修改该订单吗？", function(d) {
                        //                 t.ajax({
                        //                     url: 'update?id='+ e.data.id,
                        //                     method:'POST',
                        //                     success:function (res) {
                        //                         if (res.code == 1){
                        //                             e.update()
                        //                         }
                        //                         layer.msg(res.msg, {icon: res.code == 1 ? 1: 2,time: 1500});
                        //                         layer.close(d); //关闭弹层
                        //                     }
                        //                 });
                        //             })
                        // });
                    }else if ('abnormal' == e.event){
                        let type = t(this).attr('data-type'); //1：姓名不符 2：金额不符
                        layer.prompt({
                            formType: 1,
                            title: "敏感操作，请验证口令"
                        }, function (d, f) {
                            // console.log(i);return false;
                            //检测口令
                            t.ajax({
                                url: '/admin/api/checkOpCommand?command=' + d,
                                method: 'POST',
                                success: function (res) {
                                    if (res.code == 1) {
                                        //口令正确
                                        layer.close(f); //关闭弹层
                                        t(e.tr);
                                        //正式补单操作
                                        t.ajax({
                                            url: 'abnormalOrderSave',
                                            method: 'POST',
                                            data: {abnormal: type, id: e.data.id},
                                            success: function (res) {
                                                if (res.code == 1) {
                                                    layer.closeAll();
                                                    i.reload('app-order-list');
                                                } else {
                                                    layer.msg(res.msg, {icon: 2, time: 1500});
                                                }
                                            }
                                        });
                                    } else {
                                        layer.msg(res.msg, {icon: 2, time: 1500});
                                        layer.close(d); //关闭弹层
                                    }
                                }
                            });
                        });
                    }else if('blockIp' === e.event){
                        layer.prompt({
                            formType: 1,
                            title: "敏感操作，请验证口令"
                        }, function (d, f) {
                            // console.log(i);return false;
                            //检测口令
                            t.ajax({
                                url: '/admin/api/checkOpCommand?command=' + d,
                                method: 'POST',
                                success: function (res) {
                                    if (res.code == 1) {
                                        //口令正确
                                        layer.close(f); //关闭弹层
                                        t(e.tr);
                                        //正式补单操作
                                        t.ajax({
                                            url: 'blockIp',
                                            method: 'POST',
                                            data: {id: e.data.id},
                                            success: function (res) {
                                                if (res.code == 1) {
                                                    layer.closeAll();
                                                    i.reload('app-order-list');
                                                    layer.msg(res.msg, {icon: 1, time: 1500});
                                                } else {
                                                    layer.msg(res.msg, {icon: 2, time: 1500});
                                                }
                                            }
                                        });
                                    } else {
                                        layer.msg(res.msg, {icon: 2, time: 1500});
                                        layer.close(d); //关闭弹层
                                    }
                                }
                            });
                        });
                    }
                }),


            i.render({
                elem: "#app-uidorder-list",  //码商订单dom
                url: 'getuidOrdersList',
                //自定义响应字段
                response: {
                    statusName: 'code' //数据状态的字段名称
                    , statusCode: 1 //数据状态一切正常的状态码
                    , msgName: 'msg' //状态信息的字段名称
                    , dataName: 'data' //数据详情的字段名称
                },
                cols: [[{
                    type: "checkbox",
                    fixed: "left"
                },
                    {
                        field: "id",
                        width: 50,
                        title: "ID",
                        sort: !0
                    },
                    {
                        field: "name",
                        width: 100,
                        title: "类型",

                    },
                    {
                        field: "shuid",
                        width: 100,
                        title: "所属商户号",
                    },
                    {
                        field: "shname",
                        width: 100,
                        title: "所属商户",
                    },
                    {
                        field: "order_no",
                        width: 150,
                        title: "订单号",
                    },
                    {
                        field: "username",
                        width: 100,
                        title: "所属码商",
                    },
                    // {
                    //     field: "pname",
                    //     width: 100,
                    //     title: "上级码商",
                    //     templet: function (d) {
                    //         var pname = d.pname ? d.pname : '--'
                    //         return pname
                    //     }
                    // },
                    {
                        field: "pay_user_name",
                        width: 100,
                        title: "支付用户【商户上报】",
                    },
                    {
                        field: "order_price",
                        width: 100,
                        title: "订单金额",
                    },
                    {
                        field: "order_pay_price",
                        width: 100,
                        title: "支付金额",
                    },
                    {
                        field: "code_id",
                        width: 100,
                        title: "收款信息",
                        templet: function (d) {
                            return '账户:' + d.account_name + ' 银行:' + d.bank_name + ' 卡号:' + d.account_number
                            // if (d.request_elapsed_time > 0) {
                            //     return d.add_time;
                            // }
                            // return "<span style='color: red'>" + d.add_time + "</span>";
                        }
                    },

                    {
                        field: "visite_info",
                        width: 100,
                        title: "访问信息信息",
                        templet: function (d) {
                            var visite_ip = d.visite_ip ? d.visite_ip : '--';
                            var visite_clientos = d.visite_clientos ? d.visite_clientos : '--'
                            return 'IP:' + visite_ip + ' 设备:' + visite_clientos
                        }
                    },

                    {
                        field: "add_time",
                        width: 200,
                        title: "创建时间",
                        templet: function (d) {
                            return u.toDateString(d.add_time * 1000);
                        }
                    },
                    {
                        field: "pay_time",
                        width: 200,
                        title: "支付时间",
                        templet: function (d) {

                            return d.pay_time ? u.toDateString(d.pay_time * 1000) : '--';
                        }
                    },


                    {
                        field: "pay_username",
                        width: 100,
                        title: "付款人姓名",
                    },

                    {
                        field: "status",
                        title: "订单状态",
                        templet: "#buttonTpl",
                        minWidth: 80,
                        align: "center"
                    },
                    {
                        field: "is_status",
                        title: "回调状态",
                        templet: "#buttonIsStatus",
                        minWidth: 80,
                        align: "center"
                    },

                    {
                        field: "sure_order_role",
                        width: 100,
                        title: "操作员角色",
                        templet: function (d) {
                            role = '--';
                            if (d.sure_order_role == 1) {
                                role = '码商'
                            }
                            if (d.sure_order_role == 2) {
                                role = '管理员'
                            }

                            return role;
                        }
                    },

                    {
                        title: "操作",
                        align: "center",
                        minWidth: 450,
                        // fixed: "right",
                        toolbar: "#table-system-order"
                    },
                ]],
                page: !0,
                limit: 10,
                limits: [10, 15, 20, 25, 30, 50],
                text: "对不起，加载出现异常！"
            }),

            i.on("tool(app-uidorder-list)",
                function (e) {
                    e.data;
                    if ("details" === e.event) {
                        t(e.tr);
                        layer.open({
                            type: 2,
                            title: "交易详情",
                            content: "details.html?id=" + e.data.id,
                            maxmin: !0, area: ['80%', '60%'],
                            btn: ["确定", "取消"],
                            yes: function (e, t) {
                            },
                            success: function (e, t) {
                            }
                        })
                    } else if ("add_notify" === e.event) {
                        //补发通知
                        t(e.tr);
                        var index = layer.load(0, {shade: false}); //0代表加载的风格，支持0-2
                        t.ajax({
                            url: 'subnotify?order_id=' + e.data.id,
                            method: 'POST',
                            success: function (res) {
                                layer.closeAll();
                                if (res.code == 1) {
                                    layer.msg(res.msg, {icon: 1, time: 3000}, function () {

                                        i.reload('app-order-list');
                                    });

                                } else {
                                    layer.msg(res.msg, {icon: 2, time: 3000});
                                }
                            }
                        });
                    } else if ("budan" === e.event) {
                        layer.prompt({
                            formType: 1,
                            title: "敏感操作，请验证口令"
                        }, function (d, f) {
                            // console.log(i);return false;
                            //检测口令
                            t.ajax({
                                url: '/admin/api/checkOpCommand?command=' + d,
                                method: 'POST',
                                success: function (res) {
                                    if (res.code == 1) {
                                        //口令正确
                                        layer.close(f); //关闭弹层
                                        t(e.tr);
                                        layer.open({
                                            type: 2,
                                            title: "补单详情",
                                            content: "budanDetails.html?id=" + e.data.id,
                                            maxmin: !0, area: ['80%', '60%'],
                                            btn: ["确定", "取消"],
                                            yes: function (e1, layero) {
                                                var bd_remarks = t.trim(layero.find('iframe').contents().find('#bd_remarks').val());
                                                if (bd_remarks === '') {
                                                    layer.msg('补单人请填写补单备注', {icon: 2, time: 1500});
                                                }
                                                if (bd_remarks.length > 255) {
                                                    layer.msg('补单备注最长255个字符', {icon: 2, time: 1500});
                                                }
                                                //正式补单操作
                                                t.ajax({
                                                    url: 'update?id=' + e.data.id,
                                                    method: 'POST',
                                                    data: {bd_remarks: bd_remarks},
                                                    success: function (res) {
                                                        if (res.code == 1) {
                                                            layer.closeAll();
                                                            i.reload('app-order-list');
                                                        } else {
                                                            layer.msg(res.msg, {icon: 2, time: 1500});
                                                        }
                                                    }
                                                });
                                            },
                                        })

                                    } else {
                                        layer.msg(res.msg, {icon: 2, time: 1500});
                                        layer.close(d); //关闭弹层
                                    }
                                }
                            });
                        });
                    } else if ("issueOrder" === e.event) {
                        layer.prompt({
                            formType: 1,
                            title: "敏感操作，请验证口令"
                        }, function (d, f) {
                            // console.log(i);return false;
                            //检测口令
                            t.ajax({
                                url: '/admin/api/checkOpCommand?command=' + d,
                                method: 'POST',
                                success: function (res) {
                                    if (res.code == 1) {
                                        //口令正确
                                        layer.close(f); //关闭弹层
                                        t(e.tr);
                                        //正式补单操作

                                        t.ajax({
                                            url: 'issueOrder',
                                            method: 'POST',
                                            data: {user_id: 0, coerce: 0, id: e.data.id},
                                            success: function (res) {
                                                if (res.code == 1) {
                                                    layer.closeAll();
                                                    i.reload('app-order-list');
                                                } else {
                                                    layer.msg(res.msg, {icon: 2, time: 1500});
                                                }
                                            }
                                        });
                                    } else {
                                        layer.msg(res.msg, {icon: 2, time: 1500});
                                        layer.close(d); //关闭弹层
                                    }
                                }
                            });
                        });
                    }else if ("refundOrder" === e.event) {
                        layer.prompt({
                            formType: 1,
                            title: "敏感操作，请验证口令"
                        }, function (d, f) {
                            // console.log(i);return false;
                            //检测口令
                            t.ajax({
                                url: '/admin/api/checkOpCommand?command=' + d,
                                method: 'POST',
                                success: function (res) {
                                    if (res.code == 1) {
                                        //口令正确
                                        layer.close(f); //关闭弹层
                                        t(e.tr);
                                        //正式补单操作

                                        t.ajax({
                                            url: 'refundOrder',
                                            method: 'POST',
                                            data: {user_id: 0, coerce: 0, id: e.data.id},
                                            success: function (res) {
                                                if (res.code == 1) {
                                                    layer.closeAll();
                                                    i.reload('app-order-list');
                                                } else {
                                                    layer.msg(res.msg, {icon: 2, time: 1500});
                                                }
                                            }
                                        });
                                    } else {
                                        layer.msg(res.msg, {icon: 2, time: 1500});
                                        layer.close(d); //关闭弹层
                                    }
                                }
                            });
                        });
                        // function(d, i) {
                        //     layer.close(i),
                        //         layer.confirm("你确定要修改该订单吗？", function(d) {
                        //                 t.ajax({
                        //                     url: 'update?id='+ e.data.id,
                        //                     method:'POST',
                        //                     success:function (res) {
                        //                         if (res.code == 1){
                        //                             e.update()
                        //                         }
                        //                         layer.msg(res.msg, {icon: res.code == 1 ? 1: 2,time: 1500});
                        //                         layer.close(d); //关闭弹层
                        //                     }
                        //                 });
                        //             })
                        // });
                    }else if ('abnormal' == e.event){
                        let type = t(this).attr('data-type'); //1：姓名不符 2：金额不符
                        layer.prompt({
                            formType: 1,
                            title: "敏感操作，请验证口令"
                        }, function (d, f) {
                            // console.log(i);return false;
                            //检测口令
                            t.ajax({
                                url: '/admin/api/checkOpCommand?command=' + d,
                                method: 'POST',
                                success: function (res) {
                                    if (res.code == 1) {
                                        //口令正确
                                        layer.close(f); //关闭弹层
                                        t(e.tr);
                                        //正式补单操作
                                        t.ajax({
                                            url: 'abnormalOrderSave',
                                            method: 'POST',
                                            data: {abnormal: type, id: e.data.id},
                                            success: function (res) {
                                                if (res.code == 1) {
                                                    layer.closeAll();
                                                    i.reload('app-order-list');
                                                } else {
                                                    layer.msg(res.msg, {icon: 2, time: 1500});
                                                }
                                            }
                                        });
                                    } else {
                                        layer.msg(res.msg, {icon: 2, time: 1500});
                                        layer.close(d); //关闭弹层
                                    }
                                }
                            });
                        });
                    }else if('blockIp' === e.event){
                        layer.prompt({
                            formType: 1,
                            title: "敏感操作，请验证口令"
                        }, function (d, f) {
                            // console.log(i);return false;
                            //检测口令
                            t.ajax({
                                url: '/admin/api/checkOpCommand?command=' + d,
                                method: 'POST',
                                success: function (res) {
                                    if (res.code == 1) {
                                        //口令正确
                                        layer.close(f); //关闭弹层
                                        t(e.tr);
                                        //正式补单操作
                                        t.ajax({
                                            url: 'blockIp',
                                            method: 'POST',
                                            data: {id: e.data.id},
                                            success: function (res) {
                                                if (res.code == 1) {
                                                    layer.closeAll();
                                                    i.reload('app-order-list');
                                                    layer.msg(res.msg, {icon: 1, time: 1500});
                                                } else {
                                                    layer.msg(res.msg, {icon: 2, time: 1500});
                                                }
                                            }
                                        });
                                    } else {
                                        layer.msg(res.msg, {icon: 2, time: 1500});
                                        layer.close(d); //关闭弹层
                                    }
                                }
                            });
                        });
                    }
                }),


            i.render({
                elem: "#app-alipayorder-list",  //码商订单dom
                url: 'getalipayCodeOrdersList',
                //自定义响应字段
                response: {
                    statusName: 'code' //数据状态的字段名称
                    , statusCode: 1 //数据状态一切正常的状态码
                    , msgName: 'msg' //状态信息的字段名称
                    , dataName: 'data' //数据详情的字段名称
                },
                cols: [[{
                    type: "checkbox",
                    fixed: "left"
                },
                    {
                        field: "id",
                        width: 50,
                        title: "ID",
                        sort: !0
                    },
                    {
                        field: "shuid",
                        width: 100,
                        title: "所属商户号",
                    },
                    {
                        field: "shname",
                        width: 100,
                        title: "所属商户",
                    },
                    {
                        field: "order_no",
                        width: 150,
                        title: "订单号",
                    },
                    {
                        field: "username",
                        width: 100,
                        title: "所属码商",
                    },
                    // {
                    //     field: "pname",
                    //     width: 100,
                    //     title: "上级码商",
                    //     templet: function (d) {
                    //         var pname = d.pname ? d.pname : '--'
                    //         return pname
                    //     }
                    // },
                    {
                        field: "pay_user_name",
                        width: 100,
                        title: "支付用户【商户上报】",
                    },
                    {
                        field: "order_price",
                        width: 100,
                        title: "订单金额",
                    },
                    {
                        field: "order_pay_price",
                        width: 100,
                        title: "支付金额",
                    },
                    {
                        field: "code_id",
                        width: 100,
                        title: "收款信息",
                        templet: function (d) {
                            return '账户:' + d.account_name + ' 银行:' + d.bank_name + ' 卡号:' + d.account_number
                            // if (d.request_elapsed_time > 0) {
                            //     return d.add_time;
                            // }
                            // return "<span style='color: red'>" + d.add_time + "</span>";
                        }
                    },

                    {
                        field: "visite_info",
                        width: 100,
                        title: "访问信息信息",
                        templet: function (d) {
                            var visite_ip = d.visite_ip ? d.visite_ip : '--';
                            var visite_clientos = d.visite_clientos ? d.visite_clientos : '--'
                            return 'IP:' + visite_ip + ' 设备:' + visite_clientos
                        }
                    },

                    {
                        field: "add_time",
                        width: 200,
                        title: "创建时间",
                        templet: function (d) {
                            return u.toDateString(d.add_time * 1000);
                        }
                    },
                    {
                        field: "pay_time",
                        width: 200,
                        title: "支付时间",
                        templet: function (d) {

                            return d.pay_time ? u.toDateString(d.pay_time * 1000) : '--';
                        }
                    },


                    {
                        field: "pay_username",
                        width: 100,
                        title: "付款人姓名",
                    },

                    {
                        field: "status",
                        title: "订单状态",
                        templet: "#buttonTpl",
                        minWidth: 80,
                        align: "center"
                    },
                    {
                        field: "is_status",
                        title: "回调状态",
                        templet: "#buttonIsStatus",
                        minWidth: 80,
                        align: "center"
                    },

                    {
                        field: "sure_order_role",
                        width: 100,
                        title: "操作员角色",
                        templet: function (d) {
                            role = '--';
                            if (d.sure_order_role == 1) {
                                role = '码商'
                            }
                            if (d.sure_order_role == 2) {
                                role = '管理员'
                            }

                            return role;
                        }
                    },

                    {
                        title: "操作",
                        align: "center",
                        minWidth: 450,
                        // fixed: "right",
                        toolbar: "#table-system-order"
                    },
                ]],
                page: !0,
                limit: 10,
                limits: [10, 15, 20, 25, 30, 50],
                text: "对不起，加载出现异常！"
            }),

            i.on("tool(app-alipayorder-list)",
                function (e) {
                    e.data;
                    if ("details" === e.event) {
                        t(e.tr);
                        layer.open({
                            type: 2,
                            title: "交易详情",
                            content: "details.html?id=" + e.data.id,
                            maxmin: !0, area: ['80%', '60%'],
                            btn: ["确定", "取消"],
                            yes: function (e, t) {
                            },
                            success: function (e, t) {
                            }
                        })
                    } else if ("add_notify" === e.event) {
                        //补发通知
                        t(e.tr);
                        var index = layer.load(0, {shade: false}); //0代表加载的风格，支持0-2
                        t.ajax({
                            url: 'subnotify?order_id=' + e.data.id,
                            method: 'POST',
                            success: function (res) {
                                layer.closeAll();
                                if (res.code == 1) {
                                    layer.msg(res.msg, {icon: 1, time: 3000}, function () {

                                        i.reload('app-order-list');
                                    });

                                } else {
                                    layer.msg(res.msg, {icon: 2, time: 3000});
                                }
                            }
                        });
                    } else if ("budan" === e.event) {
                        layer.prompt({
                            formType: 1,
                            title: "敏感操作，请验证口令"
                        }, function (d, f) {
                            // console.log(i);return false;
                            //检测口令
                            t.ajax({
                                url: '/admin/api/checkOpCommand?command=' + d,
                                method: 'POST',
                                success: function (res) {
                                    if (res.code == 1) {
                                        //口令正确
                                        layer.close(f); //关闭弹层
                                        t(e.tr);
                                        layer.open({
                                            type: 2,
                                            title: "补单详情",
                                            content: "budanDetails.html?id=" + e.data.id,
                                            maxmin: !0, area: ['80%', '60%'],
                                            btn: ["确定", "取消"],
                                            yes: function (e1, layero) {
                                                var bd_remarks = t.trim(layero.find('iframe').contents().find('#bd_remarks').val());
                                                if (bd_remarks === '') {
                                                    layer.msg('补单人请填写补单备注', {icon: 2, time: 1500});
                                                }
                                                if (bd_remarks.length > 255) {
                                                    layer.msg('补单备注最长255个字符', {icon: 2, time: 1500});
                                                }
                                                //正式补单操作
                                                t.ajax({
                                                    url: 'update?id=' + e.data.id,
                                                    method: 'POST',
                                                    data: {bd_remarks: bd_remarks},
                                                    success: function (res) {
                                                        if (res.code == 1) {
                                                            layer.closeAll();
                                                            i.reload('app-order-list');
                                                        } else {
                                                            layer.msg(res.msg, {icon: 2, time: 1500});
                                                        }
                                                    }
                                                });
                                            },
                                        })

                                    } else {
                                        layer.msg(res.msg, {icon: 2, time: 1500});
                                        layer.close(d); //关闭弹层
                                    }
                                }
                            });
                        });
                    } else if ("issueOrder" === e.event) {
                        layer.prompt({
                            formType: 1,
                            title: "敏感操作，请验证口令"
                        }, function (d, f) {
                            // console.log(i);return false;
                            //检测口令
                            t.ajax({
                                url: '/admin/api/checkOpCommand?command=' + d,
                                method: 'POST',
                                success: function (res) {
                                    if (res.code == 1) {
                                        //口令正确
                                        layer.close(f); //关闭弹层
                                        t(e.tr);
                                        //正式补单操作

                                        t.ajax({
                                            url: 'issueOrder',
                                            method: 'POST',
                                            data: {user_id: 0, coerce: 0, id: e.data.id},
                                            success: function (res) {
                                                if (res.code == 1) {
                                                    layer.closeAll();
                                                    i.reload('app-order-list');
                                                } else {
                                                    layer.msg(res.msg, {icon: 2, time: 1500});
                                                }
                                            }
                                        });
                                    } else {
                                        layer.msg(res.msg, {icon: 2, time: 1500});
                                        layer.close(d); //关闭弹层
                                    }
                                }
                            });
                        });
                    }else if ("refundOrder" === e.event) {
                        layer.prompt({
                            formType: 1,
                            title: "敏感操作，请验证口令"
                        }, function (d, f) {
                            // console.log(i);return false;
                            //检测口令
                            t.ajax({
                                url: '/admin/api/checkOpCommand?command=' + d,
                                method: 'POST',
                                success: function (res) {
                                    if (res.code == 1) {
                                        //口令正确
                                        layer.close(f); //关闭弹层
                                        t(e.tr);
                                        //正式补单操作

                                        t.ajax({
                                            url: 'refundOrder',
                                            method: 'POST',
                                            data: {user_id: 0, coerce: 0, id: e.data.id},
                                            success: function (res) {
                                                if (res.code == 1) {
                                                    layer.closeAll();
                                                    i.reload('app-order-list');
                                                } else {
                                                    layer.msg(res.msg, {icon: 2, time: 1500});
                                                }
                                            }
                                        });
                                    } else {
                                        layer.msg(res.msg, {icon: 2, time: 1500});
                                        layer.close(d); //关闭弹层
                                    }
                                }
                            });
                        });
                        // function(d, i) {
                        //     layer.close(i),
                        //         layer.confirm("你确定要修改该订单吗？", function(d) {
                        //                 t.ajax({
                        //                     url: 'update?id='+ e.data.id,
                        //                     method:'POST',
                        //                     success:function (res) {
                        //                         if (res.code == 1){
                        //                             e.update()
                        //                         }
                        //                         layer.msg(res.msg, {icon: res.code == 1 ? 1: 2,time: 1500});
                        //                         layer.close(d); //关闭弹层
                        //                     }
                        //                 });
                        //             })
                        // });
                    }else if ('abnormal' == e.event){
                        let type = t(this).attr('data-type'); //1：姓名不符 2：金额不符
                        layer.prompt({
                            formType: 1,
                            title: "敏感操作，请验证口令"
                        }, function (d, f) {
                            // console.log(i);return false;
                            //检测口令
                            t.ajax({
                                url: '/admin/api/checkOpCommand?command=' + d,
                                method: 'POST',
                                success: function (res) {
                                    if (res.code == 1) {
                                        //口令正确
                                        layer.close(f); //关闭弹层
                                        t(e.tr);
                                        //正式补单操作
                                        t.ajax({
                                            url: 'abnormalOrderSave',
                                            method: 'POST',
                                            data: {abnormal: type, id: e.data.id},
                                            success: function (res) {
                                                if (res.code == 1) {
                                                    layer.closeAll();
                                                    i.reload('app-order-list');
                                                } else {
                                                    layer.msg(res.msg, {icon: 2, time: 1500});
                                                }
                                            }
                                        });
                                    } else {
                                        layer.msg(res.msg, {icon: 2, time: 1500});
                                        layer.close(d); //关闭弹层
                                    }
                                }
                            });
                        });
                    }else if('blockIp' === e.event){
                        layer.prompt({
                            formType: 1,
                            title: "敏感操作，请验证口令"
                        }, function (d, f) {
                            // console.log(i);return false;
                            //检测口令
                            t.ajax({
                                url: '/admin/api/checkOpCommand?command=' + d,
                                method: 'POST',
                                success: function (res) {
                                    if (res.code == 1) {
                                        //口令正确
                                        layer.close(f); //关闭弹层
                                        t(e.tr);
                                        //正式补单操作
                                        t.ajax({
                                            url: 'blockIp',
                                            method: 'POST',
                                            data: {id: e.data.id},
                                            success: function (res) {
                                                if (res.code == 1) {
                                                    layer.closeAll();
                                                    i.reload('app-order-list');
                                                    layer.msg(res.msg, {icon: 1, time: 1500});
                                                } else {
                                                    layer.msg(res.msg, {icon: 2, time: 1500});
                                                }
                                            }
                                        });
                                    } else {
                                        layer.msg(res.msg, {icon: 2, time: 1500});
                                        layer.close(d); //关闭弹层
                                    }
                                }
                            });
                        });
                    }
                }),


            i.render({
                elem: "#app-abnormal-order-list",  //码商异常订单
                url: 'getAbnormalOrdersList',
                //自定义响应字段
                response: {
                    statusName: 'code' //数据状态的字段名称
                    , statusCode: 1 //数据状态一切正常的状态码
                    , msgName: 'msg' //状态信息的字段名称
                    , dataName: 'data' //数据详情的字段名称
                },
                cols: [[{
                    type: "checkbox",
                    fixed: "left"
                },
                    {
                        field: "id",
                        width: 50,
                        title: "ID",
                        sort: !0
                    },
                    {
                        field: "order_no",
                        width: 150,
                        title: "订单号",
                    },
                    {
                        field: "username",
                        width: 100,
                        title: "所属码商",
                    },
                    {
                        field: "pay_user_name",
                        width: 100,
                        title: "支付用户【商户上报】",
                    },
                    {
                        field: "order_pay_price",
                        width: 100,
                        title: "支付金额",
                    },
                    {
                        field: "code_id",
                        width: 100,
                        title: "收款信息",
                        templet: function (d) {
                            return '账户:' + d.account_name + ' 银行:' + d.bank_name + ' 卡号:' + d.account_number
                            // if (d.request_elapsed_time > 0) {
                            //     return d.add_time;
                            // }
                            // return "<span style='color: red'>" + d.add_time + "</span>";
                        }
                    },

                    {
                        field: "visite_info",
                        width: 100,
                        title: "访问信息信息",
                        templet: function (d) {
                            var visite_ip = d.visite_ip ? d.visite_ip : '--';
                            var visite_clientos = d.visite_clientos ? d.visite_clientos : '--'
                            return 'IP:' + visite_ip + ' 设备:' + visite_clientos
                        }
                    },

                    {
                        field: "add_time",
                        width: 200,
                        title: "创建时间",
                        templet: function (d) {
                            return u.toDateString(d.add_time * 1000);
                        }
                    },
                    {
                        field: "pay_time",
                        width: 200,
                        title: "支付时间",
                        templet: function (d) {

                            return d.pay_time ? u.toDateString(d.pay_time * 1000) : '--';
                        }
                    },


                    {
                        field: "pay_username",
                        width: 100,
                        title: "付款人姓名",
                    },

                    {
                        field: "status",
                        title: "订单状态",
                        templet: "#buttonTpl",
                        minWidth: 80,
                        align: "center"
                    },

                    {
                        field: "sure_order_role",
                        width: 100,
                        title: "操作员角色",
                        templet: function (d) {
                            role = '--';
                            if (d.sure_order_role == 1) {
                                role = '码商'
                            }
                            if (d.sure_order_role == 2) {
                                role = '管理员'
                            }

                            return role;
                        }
                    },

                    {
                        field: "abnormal",
                        width: 100,
                        title: "异常结果",
                        templet: function (d){
                            str = '';
                            if (d.name_abnormal){
                                str += '<button class="layui-btn layui-btn-warm layui-btn-xs">姓名不符</button>'
                            }
                            if (d.money_abnormal){
                                str += '<button class="layui-btn layui-btn-warm layui-btn-xs">金额不符</button>'
                            }
                            return str;
                        }
                    },

                    {
                        title: "操作",
                        align: "center",
                        minWidth: 220,
                        // fixed: "right",
                        toolbar: "#table-system-order"
                    },
                ]],
                page: !0,
                limit: 10,
                limits: [10, 15, 20, 25, 30, 50],
                text: "对不起，加载出现异常！"
            }),
            i.on("tool(app-abnormal-order-list)",
                function (e) {
                    e.data;
                    if ("details" === e.event) {
                        t(e.tr);
                        layer.open({
                            type: 2,
                            title: "交易详情",
                            content: "details.html?id=" + e.data.id,
                            maxmin: !0, area: ['80%', '60%'],
                            btn: ["确定", "取消"],
                            yes: function (e, t) {
                            },
                            success: function (e, t) {
                            }
                        })
                    } else if ("add_notify" === e.event) {
                        //补发通知
                        t(e.tr);
                        var index = layer.load(0, {shade: false}); //0代表加载的风格，支持0-2
                        t.ajax({
                            url: 'subnotify?order_id=' + e.data.id,
                            method: 'POST',
                            success: function (res) {
                                layer.closeAll();
                                if (res.code == 1) {
                                    layer.msg(res.msg, {icon: 1, time: 3000}, function () {

                                        i.reload('app-order-list');
                                    });

                                } else {
                                    layer.msg(res.msg, {icon: 2, time: 3000});
                                }
                            }
                        });
                    } else if ("budan" === e.event) {
                        layer.prompt({
                            formType: 1,
                            title: "敏感操作，请验证口令"
                        }, function (d, f) {
                            // console.log(i);return false;
                            //检测口令
                            t.ajax({
                                url: '/admin/api/checkOpCommand?command=' + d,
                                method: 'POST',
                                success: function (res) {
                                    if (res.code == 1) {
                                        //口令正确
                                        layer.close(f); //关闭弹层
                                        t(e.tr);
                                        layer.open({
                                            type: 2,
                                            title: "补单详情",
                                            content: "budanDetails.html?id=" + e.data.id,
                                            maxmin: !0, area: ['80%', '60%'],
                                            btn: ["确定", "取消"],
                                            yes: function (e1, layero) {
                                                var bd_remarks = t.trim(layero.find('iframe').contents().find('#bd_remarks').val());
                                                if (bd_remarks === '') {
                                                    layer.msg('补单人请填写补单备注', {icon: 2, time: 1500});
                                                }
                                                if (bd_remarks.length > 255) {
                                                    layer.msg('补单备注最长255个字符', {icon: 2, time: 1500});
                                                }
                                                //正式补单操作
                                                t.ajax({
                                                    url: 'update?id=' + e.data.id,
                                                    method: 'POST',
                                                    data: {bd_remarks: bd_remarks},
                                                    success: function (res) {
                                                        if (res.code == 1) {
                                                            layer.closeAll();
                                                            i.reload('app-order-list');
                                                        } else {
                                                            layer.msg(res.msg, {icon: 2, time: 1500});
                                                        }
                                                    }
                                                });
                                            },
                                            // success: function(e, t) {
                                            //
                                            //     //正式补单操作
                                            //     //                 t.ajax({
                                            //     //                     url: 'update?id='+ e.data.id,
                                            //     //                     method:'POST',
                                            //     //                     success:function (res) {
                                            //     //                         if (res.code == 1){
                                            //     //                             e.update()
                                            //     //                         }
                                            //     //                         layer.msg(res.msg, {icon: res.code == 1 ? 1: 2,time: 1500});
                                            //     //                         layer.close(d); //关闭弹层
                                            //     //                     }
                                            //     //                 });
                                            //
                                            //
                                            //
                                            //
                                            //
                                            // }
                                        })
                                        // layer.confirm("你确定要修改该订单吗？", function(m,n) {
                                        //     //弹出补单时候的详情页 和原来的页面分开吧
                                        //     layer.close(n); //关闭弹层
                                        //
                                        //
                                        //
                                        //
                                        //
                                        //         // t.ajax({
                                        //         //     url: 'update?id='+ e.data.id,
                                        //         //     method:'POST',
                                        //         //     success:function (res) {
                                        //         //         if (res.code == 1){
                                        //         //             e.update()
                                        //         //         }
                                        //         //         layer.msg(res.msg, {icon: res.code == 1 ? 1: 2,time: 1500});
                                        //         //         layer.close(d); //关闭弹层
                                        //         //     }
                                        //         // });
                                        //     })
                                        // layer.open({
                                        //     type: 2
                                        //     ,title: '增减余额'
                                        //     ,content: 'changeBalance.html?uid=' + e.data.uid
                                        //     ,maxmin: true
                                        //     ,area: ['80%','60%']
                                        //     ,btn: ['确定', '取消']
                                        //     ,yes: function(index, layero){
                                        //         var iframeWindow = window['layui-layer-iframe'+ index]
                                        //             ,submitID = 'app-user-manage-submit'
                                        //             ,submit = layero.find('iframe').contents().find('#'+ submitID);
                                        //
                                        //         //监听提交
                                        //         iframeWindow.layui.form.on('submit('+ submitID +')', function(obj){
                                        //             var field = obj.field; //获取提交的字段
                                        //
                                        //             //提交 Ajax 成功后，静态更新表格中的数据
                                        //             t.ajax({
                                        //                 url:'changeBalance.html?uid=' + e.data.uid,
                                        //                 method:'POST',
                                        //                 data:field,
                                        //                 success:function (res) {
                                        //                     if (res.code == 1){
                                        //                         console.log(11111);
                                        //                         layer.closeAll();
                                        //                         //parent.parent.layui.table.reload('app-balance-list'); //重载表格
                                        //                         i.reload('app-balance-list');
                                        //                     }else{
                                        //                         layer.msg(res.msg, {icon: 2,time: 1500});
                                        //                     }
                                        //                 }
                                        //             });
                                        //         });
                                        //         submit.trigger('click');
                                        //     }
                                        // });
                                    } else {
                                        layer.msg(res.msg, {icon: 2, time: 1500});
                                        layer.close(d); //关闭弹层
                                    }
                                }
                            });
                        });
                        // function(d, i) {
                        //     layer.close(i),
                        //         layer.confirm("你确定要修改该订单吗？", function(d) {
                        //                 t.ajax({
                        //                     url: 'update?id='+ e.data.id,
                        //                     method:'POST',
                        //                     success:function (res) {
                        //                         if (res.code == 1){
                        //                             e.update()
                        //                         }
                        //                         layer.msg(res.msg, {icon: res.code == 1 ? 1: 2,time: 1500});
                        //                         layer.close(d); //关闭弹层
                        //                     }
                        //                 });
                        //             })
                        // });
                    } else if ("issueOrder" === e.event) {
                        layer.prompt({
                            formType: 1,
                            title: "敏感操作，请验证口令"
                        }, function (d, f) {
                            // console.log(i);return false;
                            //检测口令
                            t.ajax({
                                url: '/admin/api/checkOpCommand?command=' + d,
                                method: 'POST',
                                success: function (res) {
                                    if (res.code == 1) {
                                        //口令正确
                                        layer.close(f); //关闭弹层
                                        t(e.tr);
                                        //正式补单操作

                                        t.ajax({
                                            url: 'issueOrder',
                                            method: 'POST',
                                            data: {user_id: 0, coerce: 0, id: e.data.id},
                                            success: function (res) {
                                                if (res.code == 1) {
                                                    layer.closeAll();
                                                    i.reload('app-order-list');
                                                } else {
                                                    layer.msg(res.msg, {icon: 2, time: 1500});
                                                }
                                            }
                                        });
                                    } else {
                                        layer.msg(res.msg, {icon: 2, time: 1500});
                                        layer.close(d); //关闭弹层
                                    }
                                }
                            });
                        });
                        // function(d, i) {
                        //     layer.close(i),
                        //         layer.confirm("你确定要修改该订单吗？", function(d) {
                        //                 t.ajax({
                        //                     url: 'update?id='+ e.data.id,
                        //                     method:'POST',
                        //                     success:function (res) {
                        //                         if (res.code == 1){
                        //                             e.update()
                        //                         }
                        //                         layer.msg(res.msg, {icon: res.code == 1 ? 1: 2,time: 1500});
                        //                         layer.close(d); //关闭弹层
                        //                     }
                        //                 });
                        //             })
                        // });
                    }else if ("refundOrder" === e.event) {
                        layer.prompt({
                            formType: 1,
                            title: "敏感操作，请验证口令"
                        }, function (d, f) {
                            // console.log(i);return false;
                            //检测口令
                            t.ajax({
                                url: '/admin/api/checkOpCommand?command=' + d,
                                method: 'POST',
                                success: function (res) {
                                    if (res.code == 1) {
                                        //口令正确
                                        layer.close(f); //关闭弹层
                                        t(e.tr);
                                        //正式补单操作

                                        t.ajax({
                                            url: 'refundOrder',
                                            method: 'POST',
                                            data: {user_id: 0, coerce: 0, id: e.data.id},
                                            success: function (res) {
                                                if (res.code == 1) {
                                                    layer.closeAll();
                                                    i.reload('app-order-list');
                                                } else {
                                                    layer.msg(res.msg, {icon: 2, time: 1500});
                                                }
                                            }
                                        });
                                    } else {
                                        layer.msg(res.msg, {icon: 2, time: 1500});
                                        layer.close(d); //关闭弹层
                                    }
                                }
                            });
                        });
                        // function(d, i) {
                        //     layer.close(i),
                        //         layer.confirm("你确定要修改该订单吗？", function(d) {
                        //                 t.ajax({
                        //                     url: 'update?id='+ e.data.id,
                        //                     method:'POST',
                        //                     success:function (res) {
                        //                         if (res.code == 1){
                        //                             e.update()
                        //                         }
                        //                         layer.msg(res.msg, {icon: res.code == 1 ? 1: 2,time: 1500});
                        //                         layer.close(d); //关闭弹层
                        //                     }
                        //                 });
                        //             })
                        // });
                    }
                }),
            i.render({
                elem: "#app-balance-details-list",
                url: 'getBillsList',
                //添加请求字段
                where: {
                    uid: t("input[ name='uid' ] ").val()
                },
                //自定义响应字段
                response: {
                    statusName: 'code' //数据状态的字段名称
                    , statusCode: 1 //数据状态一切正常的状态码
                    , msgName: 'msg' //状态信息的字段名称
                    , dataName: 'data' //数据详情的字段名称
                },
                cols: [[
                    {
                        field: "id",
                        width: 50,
                        title: "ID",
                    },
                    {
                        field: "username",
                        width: 100,
                        title: "用户名",
                    },


                    {
                        field: "jl_class_text",
                        width: 100,
                        title: "账变类型",
                        templet: function (d) {
                            let str = d.jl_class_text;
                            if (d.jl_class == 8 && d.jc_class == '-'){
                                str = '<span style="color: red">'+str+'</span>'
                            }else if(d.jl_class == 8 && d.jc_class == '+') {
                                str = '<span style="color: #0C0C0C">' + str + '</span>'
                            }
                            return str;
                        }
                    },

                    {
                        field: "pre_amount",
                        width: 100,
                        title: "变动前",
                    },
                    {
                        width: 100,
                        field: "num",
                        title: "变动金额",
                        templet: function (d) {
                            let str = d.num;
                            if (d.jc_class == '-'){
                                str = '<span style="color: red">'+d.jc_class+str+'</span>'
                            }else if(d.jc_class == '+') {
                                str = '<span style="color:green">'+d.jc_class+ str + '</span>'
                            }
                            return str;
                        }
                    },

                    {
                        field: "last_amount",
                        width: 100,
                        title: "变动后",
                    },
                    // {
                    //     field: "jc_class",
                    //     width: 200,
                    //     title: "类型",
                    // },
                    {
                        field: "info",
                        width: 200,
                        title: "流水备注",
                    },
                    {
                        field: "addtime",
                        width: 200,
                        title: "时间",
                        templet: function (d) {
                            return u.toDateString(d.addtime * 1000);
                        }
                    }]],
                page: {
                    limit: 10,
                    limits: [10, 15, 20, 25, 30]
                },
                text: "对不起，加载出现异常！"
            }),



            i.render({
                elem: "#app-user-manage",
                url: "getList",
                //自定义响应字段
                response: {
                    statusName: 'code' //数据状态的字段名称
                    , statusCode: 1 //数据状态一切正常的状态码
                    , msgName: 'msg' //状态信息的字段名称
                    , dataName: 'data' //数据详情的字段名称
                },
                cols: [[{
                    type: "checkbox",
                    fixed: "left"
                },
                    {
                        field: "uid",
                        width: 80,
                        title: "商户UID",
                        sort: !0
                    },
                    {
                        field: "username",
                        width: 130,
                        title: "商户名"
                    },
                    {
                        field: "last_login_time",
                        width: 100,
                        title: "最后登录时间",
                        templet: function (d) {
                            if (d.last_login_time) {
                                return u.toDateString(d.last_login_time * 1000);

                            } else {
                                return '未登陆过';
                            }
                        }
                    },
                    {
                        title: "操作",
                        minWidth: 450,
                        align: "center",
                        // fixed: "right",
                        toolbar: "#table-useradmin-webuser"
                    }]],
                page: !0,
                limit: 10,
                limits: [10, 15, 20, 25, 30],
                text: "对不起，加载出现异常！"
            }),
            i.on("tool(app-user-manage)",
                function (e) {
                    if ("del" === e.event) {
                        layer.prompt({
                                formType: 1,
                                title: "敏感操作，请验证口令"
                            },
                            function (d, i) {
                                layer.close(i),
                                    layer.confirm("真的删除此商户吗？",
                                        function (d) {
                                            t.ajax({
                                                url: 'del?uid=' + e.data.uid,
                                                method: 'POST',
                                                success: function (res) {
                                                    if (res.code == 1) {
                                                        e.del()
                                                    }
                                                    layer.msg(res.msg, {icon: res.code == 1 ? 1 : 2, time: 1500});
                                                    layer.close(d); //关闭弹层
                                                }
                                            });
                                        })
                            });
                    } else if ("cleargoogleauth" === e.event) {
                        layer.prompt({
                                formType: 1,
                                title: "敏感操作，请验证口令"
                            },
                            function (d, i) {
                                layer.close(i),
                                    layer.confirm("真的清除此商户GOOGLE身份验证吗？",
                                        function (d) {
                                            t.ajax({
                                                url: 'clearGoogleAuth?uid=' + e.data.uid,
                                                method: 'POST',
                                                success: function (res) {
                                                    if (res.code == 1) {
                                                        e.del()
                                                    }
                                                    layer.msg(res.msg, {icon: res.code == 1 ? 1 : 2, time: 1500});
                                                    layer.close(d); //关闭弹层
                                                }
                                            });
                                        })
                            });
                    } else if ("blind_tg_group_id" === e.event) {
                        var mch_secret = e.data.mch_secret;
                        layer.alert("请发送文本:【mch:" + mch_secret + "】到商户群")
                    } else if ("unblind_tg_group_id" === e.event) {
                        layer.confirm("真的要解绑此商户的TG群吗？",
                            function (d) {
                                t.ajax({
                                    url: 'unblindTgGroup?uid=' + e.data.uid,
                                    method: 'POST',
                                    success: function (res) {
                                        layer.msg(res.msg, {icon: res.code == 1 ? 1 : 2, time: 1500}, function () {
                                            layer.close(d); //关闭弹层

                                            window.location.reload();
                                        });
                                    }
                                });
                            })
                    } else if ("profit" === e.event) {
                        t(e.tr);
                        layer.open({
                            type: 2,
                            title: "商户支付渠道",
                            content: "profit.html?id=" + e.data.uid,
                            maxmin: !0,
                            maxmin: !0, area: ['80%', '60%'],
                            btn: ["确定", "取消"],
                            yes: function (f, t) {
                                var l = window["layui-layer-iframe" + f],
                                    r = "app-user-profit-submit",
                                    n = t.find("iframe").contents().find("#" + r);
                                l.layui.form.on("submit(" + r + ")",
                                    function (t) {
                                        var l = t.field;
                                        console.log(l);
                                        layui.$.post("profit", l, function (res) {
                                            if (res.code == 1) {
                                                i.render(),
                                                    layer.close(f)
                                            }
                                            layer.msg(res.msg, {icon: res.code == 1 ? 1 : 2, time: 1500});
                                        });
                                    }),
                                    n.trigger("click")
                            },
                            success: function (e, t) {
                            }
                        })
                    } else if ("daifuProfit" === e.event) {
                        t(e.tr);
                        layer.open({
                            type: 2,
                            title: "商户支付渠道",
                            content: "daifuProfit.html?uid=" + e.data.uid,
                            maxmin: !0,
                            maxmin: !0,
                            area: ['80%', '60%'],
                            btn: ["确定", "取消"],
                            yes: function (f, t) {
                                var l = window["layui-layer-iframe" + f],
                                    r = "app-user-daifuProfit-submit",
                                    n = t.find("iframe").contents().find("#" + r);
                                l.layui.form.on("submit(" + r + ")",
                                    function (t) {
                                        var l = t.field;
                                        console.log(l);
                                        layui.$.post("daifuProfit", l, function (res) {
                                            if (res.code == 1) {
                                                i.render(),
                                                    layer.close(f)
                                            }
                                            layer.msg(res.msg, {icon: res.code == 1 ? 1 : 2, time: 1500});
                                        });
                                    }),
                                    n.trigger("click")
                            },
                            success: function (e, t) {
                            }
                        })
                    } else if ("edit" === e.event) {
                        t(e.tr);
                        layer.open({
                            type: 2,
                            title: "编辑用户",
                            content: "edit.html?id=" + e.data.uid,
                            maxmin: !0,
                            maxmin: !0, area: ['80%', '60%'],
                            btn: ["确定", "取消"],
                            yes: function (f, t) {
                                var l = window["layui-layer-iframe" + f],
                                    r = "app-user-manage-submit",
                                    n = t.find("iframe").contents().find("#" + r);
                                l.layui.form.on("submit(" + r + ")",
                                    function (t) {
                                        var l = t.field;
                                        layui.$.post("edit", l, function (res) {
                                            if (res.code == 1) {
                                                //更新数据表
                                                e.update({
                                                    username: l.username,
                                                    phone: l.phone,
                                                    qq: l.qq,
                                                    is_agent: l.is_agent,
                                                    status: l.status
                                                }), i.render(),
                                                    layer.close(f)
                                            }
                                            layer.msg(res.msg, {icon: res.code == 1 ? 1 : 2, time: 1500});
                                        });
                                    }),
                                    n.trigger("click")
                            },
                            success: function (e, t) {
                            }
                        })
                    } else if ("appoint_ndex" === e.event) {
                        t(e.tr);
                        layer.open({
                            type: 2,
                            title: "指定渠道",
                            content: "appoint_ndex.html?uid=" + e.data.uid,
                            maxmin: !0,
                            maxmin: !0, area: ['80%', '60%'],
                            // btn: ["确定", "取消"],
                        })
                    } else if ("view_secret" === e.event) {
                        t(e.tr);
                        layer.open({
                            type: 2,
                            title: "信息",
                            content: "view_secret.html?id=" + e.data.uid,
                            maxmin: !0,
                            maxmin: !0, area: ['80%', '60%'],
                            btn: [],
                            success: function (e, t) {
                            }
                        })
                    } else if ("userpaycode" === e.event) {
                        t(e.tr);
                        layer.open({
                            type: 2,
                            title: "商户支付产品",
                            content: "codes.html?id=" + e.data.uid,
                            maxmin: !0,
                            maxmin: !0, area: ['80%', '60%'],
                            btn: ["确定", "取消"],
                            yes: function (f, t) {
                                var l = window["layui-layer-iframe" + f],
                                    r = "app-user-profit-submit",
                                    n = t.find("iframe").contents().find("#" + r);
                                l.layui.form.on("submit(" + r + ")",
                                    function (t) {
                                        var l = t.field;
                                        console.log(l);
                                        layui.$.post("codes?id=" + e.data.uid, l, function (res) {
                                            if (res.code == 1) {
                                                i.render(),
                                                    layer.close(f)
                                            }
                                            layer.msg(res.msg, {icon: res.code == 1 ? 1 : 2, time: 1500});
                                        });
                                    }),
                                    n.trigger("click")
                            },
                            success: function (e, t) {
                            }
                        })
                    }else if ("mark_abnormal" === e.event) {
                       let hint_msg = e.data.mark_abnormal ? '确定取消商户标记？': '确定标记商户？'
                       let val = e.data.mark_abnormal ? 0 :  1;
                        layer.confirm(hint_msg,
                            function (d) {
                                t.ajax({
                                    url: 'mark_abnormal?uid=' + e.data.uid + '&val=' + val ,
                                    method: 'POST',
                                    success: function (res) {
                                        layer.msg(res.msg, {icon: res.code == 1 ? 1 : 2, time: 1500}, function () {
                                            layer.close(d); //关闭弹层

                                            window.location.reload();
                                        });
                                    }
                                });
                            })
                    }
                }),

            i.render({
                elem: "#app-user-stat-manage",
                url: "getUserListStat",
                //自定义响应字段
                response: {
                    statusCode: 1 //数据状态一切正常的状态码
                },
                cols: [
                    [{
                        type: "checkbox",
                        fixed: "left"
                    }, {
                        field: "username",
                        title: "商户名称"
                    },{
                        field: "total_number",
                        title: "总单数"
                    },{
                        field: "success_number",
                        title: "成功单数"
                    },{
                        field: "total_amount",
                        title: "总金额（元）"
                    },{
                        field: "success_amount",
                        title: "成功金额（元）"
                    }],

                ],
                page: !0,
                limit: 10,
                limits: [10, 15, 20, 25, 30],
                text: "对不起，加载出现异常！"
            }),

            i.render({
                elem: "#app-user-auth-manage",
                url: "getAuthList",
                //自定义响应字段
                response: {
                    statusName: 'code' //数据状态的字段名称
                    , statusCode: 1 //数据状态一切正常的状态码
                    , msgName: 'msg' //状态信息的字段名称
                    , dataName: 'data' //数据详情的字段名称
                },
                cols: [[{
                    type: "checkbox",
                    fixed: "left"
                },
                    {
                        field: "id",
                        width: 100,
                        title: "ID",
                        sort: !0
                    },
                    {
                        field: "uid",
                        width: 100,
                        title: "商户UID",
                        sort: !0
                    },
                    {
                        field: "realname",
                        width: 150,
                        title: "姓名"
                    },
                    {
                        field: "sfznum",
                        width: 180,
                        title: "身份证号码"
                    },
                    {
                        field: "card",
                        title: "认证信息"
                    },
                    {
                        field: "status",
                        title: "认证状态",
                        templet: "#buttonTpl",
                        minWidth: 80,
                        align: "center"
                    },
                    {
                        field: "create_time",
                        title: "创建时间",
                        width: 180,
                        sort: !0,
                        templet: function (d) {
                            return u.toDateString(d.create_time * 1000);
                        }
                    },
                    {
                        field: "update_time",
                        title: "更新时间",
                        width: 180,
                        sort: !0,
                        templet: function (d) {
                            return u.toDateString(d.update_time * 1000);
                        }
                    },
                    {
                        title: "操作",
                        minWidth: 150,
                        align: "center",
                        fixed: "right",
                        toolbar: "#table-useradmin-webuser"
                    }]],
                page: !0,
                limit: 10,
                limits: [10, 15, 20, 25, 30],
                text: "对不起，加载出现异常！"
            }),
            i.on("tool(app-user-auth-manage)",
                function (e) {
                    if ("del" === e.event) layer.prompt({
                            formType: 1,
                            title: "敏感操作，请验证口令"
                        },
                        function (t, i) {
                            layer.close(i),
                                layer.confirm("真的删除行么",
                                    function (t) {
                                        e.del(),
                                            layer.close(t)
                                    })
                        });
                    else if ("auth" === e.event) {
                        t(e.tr);
                        layer.open({
                            type: 2,
                            title: "审核用户认证信息",
                            content: "userAuthInfo.html?id=" + e.data.uid,
                            maxmin: !0,
                            maxmin: !0, area: ['80%', '60%'],
                            btn: ["确定", "取消"],
                            yes: function (f, t) {
                                var l = window["layui-layer-iframe" + f],
                                    r = "app-user-auth-manage-submit",
                                    n = t.find("iframe").contents().find("#" + r);
                                l.layui.form.on("submit(" + r + ")",
                                    function (t) {
                                        var l = t.field;
                                        console.log(l)
                                        layui.$.post("userAuthInfo", l, function (res) {
                                            if (res.code == 1) {
                                                //更新数据表
                                                e.update({
                                                    status: l.status
                                                }), i.render(),
                                                    layer.close(f)
                                            }
                                            layer.msg(res.msg, {icon: res.code == 1 ? 1 : 2, time: 1500});
                                        });
                                    }),
                                    n.trigger("click")
                            },
                            success: function (e, t) {
                            }
                        })
                    }
                }),
            e("user", {}),
            i.render({
                elem: "#app-user-cal",
                url: "calList",
                //自定义响应字段
                response: {
                    statusName: 'code' //数据状态的字段名称
                    , statusCode: 1 //数据状态一切正常的状态码
                    , msgName: 'msg' //状态信息的字段名称
                    , dataName: 'data' //数据详情的字段名称
                },
                cols: [[
                    {
                        field: "order_money",
                        width: 200,
                        title: "订单总金额"
                    },
                    {
                        field: "order_paid_money",
                        width: 200,
                        title: "订单完成金额"
                    },
                    {
                        field: "cash_amount",
                        width: 200,
                        title: "总提现金额"
                    },
                    {
                        field: "cash_fee",
                        width: 200,
                        title: "总手续费"
                    },

                    {
                        field: "increase",
                        width: 200,
                        title: "总人工增加金额"
                    },
                    {
                        field: "reduce",
                        width: 200,
                        title: "总人工减少金额"
                    },
                ]],
                page: !0,
                limit: 10,
                limits: [10, 15, 20, 25, 30],
                text: "对不起，加载出现异常！"
            }),
            i.on("tool(app-user-cal)",
                function (e) {
                    if ("del" === e.event) {
                        layer.prompt({
                                formType: 1,
                                title: "敏感操作，请验证口令"
                            },
                            function (d, i) {
                                layer.close(i),
                                    layer.confirm("真的删除此商户吗,此商户所有数据将被清除？",
                                        function (d) {
                                            t.ajax({
                                                url: 'del?uid=' + e.data.uid,
                                                method: 'POST',
                                                success: function (res) {
                                                    if (res.code == 1) {
                                                        e.del()
                                                    }
                                                    layer.msg(res.msg, {icon: res.code == 1 ? 1 : 2, time: 1500});
                                                    layer.close(d); //关闭弹层
                                                }
                                            });
                                        })
                            });
                    } else if ("cleargoogleauth" === e.event) {
                        layer.prompt({
                                formType: 1,
                                title: "敏感操作，请验证口令"
                            },
                            function (d, i) {
                                layer.close(i),
                                    layer.confirm("真的清除此商户GOOGLE身份验证吗？",
                                        function (d) {
                                            t.ajax({
                                                url: 'clearGoogleAuth?uid=' + e.data.uid,
                                                method: 'POST',
                                                success: function (res) {
                                                    if (res.code == 1) {
                                                        e.del()
                                                    }
                                                    layer.msg(res.msg, {icon: res.code == 1 ? 1 : 2, time: 1500});
                                                    layer.close(d); //关闭弹层
                                                }
                                            });
                                        })
                            });
                    } else if ("profit" === e.event) {
                        t(e.tr);
                        layer.open({
                            type: 2,
                            title: "商户支付渠道",
                            content: "profit.html?id=" + e.data.uid,
                            maxmin: !0,
                            maxmin: !0, area: ['80%', '60%'],
                            btn: ["确定", "取消"],
                            yes: function (f, t) {
                                var l = window["layui-layer-iframe" + f],
                                    r = "app-user-profit-submit",
                                    n = t.find("iframe").contents().find("#" + r);
                                l.layui.form.on("submit(" + r + ")",
                                    function (t) {
                                        var l = t.field;
                                        console.log(l);
                                        layui.$.post("profit", l, function (res) {
                                            if (res.code == 1) {
                                                i.render(),
                                                    layer.close(f)
                                            }
                                            layer.msg(res.msg, {icon: res.code == 1 ? 1 : 2, time: 1500});
                                        });
                                    }),
                                    n.trigger("click")
                            },
                            success: function (e, t) {
                            }
                        })
                    } else if ("edit" === e.event) {
                        t(e.tr);
                        layer.open({
                            type: 2,
                            title: "编辑用户",
                            content: "edit.html?id=" + e.data.uid,
                            maxmin: !0,
                            maxmin: !0, area: ['80%', '60%'],
                            btn: ["确定", "取消"],
                            yes: function (f, t) {
                                var l = window["layui-layer-iframe" + f],
                                    r = "app-user-manage-submit",
                                    n = t.find("iframe").contents().find("#" + r);
                                l.layui.form.on("submit(" + r + ")",
                                    function (t) {
                                        var l = t.field;
                                        layui.$.post("edit", l, function (res) {
                                            if (res.code == 1) {
                                                //更新数据表
                                                e.update({
                                                    username: l.username,
                                                    phone: l.phone,
                                                    qq: l.qq,
                                                    is_agent: l.is_agent,
                                                    status: l.status
                                                }), i.render(),
                                                    layer.close(f)
                                            }
                                            layer.msg(res.msg, {icon: res.code == 1 ? 1 : 2, time: 1500});
                                        });
                                    }),
                                    n.trigger("click")
                            },
                            success: function (e, t) {
                            }
                        })
                    } else if ("userpaycode" === e.event) {
                        t(e.tr);
                        layer.open({
                            type: 2,
                            title: "商户支付产品",
                            content: "codes.html?id=" + e.data.uid,
                            maxmin: !0,
                            maxmin: !0, area: ['80%', '60%'],
                            btn: ["确定", "取消"],
                            yes: function (f, t) {
                                var l = window["layui-layer-iframe" + f],
                                    r = "app-user-profit-submit",
                                    n = t.find("iframe").contents().find("#" + r);
                                l.layui.form.on("submit(" + r + ")",
                                    function (t) {
                                        var l = t.field;
                                        console.log(l);
                                        layui.$.post("codes?id=" + e.data.uid, l, function (res) {
                                            if (res.code == 1) {
                                                i.render(),
                                                    layer.close(f)
                                            }
                                            layer.msg(res.msg, {icon: res.code == 1 ? 1 : 2, time: 1500});
                                        });
                                    }),
                                    n.trigger("click")
                            },
                            success: function (e, t) {
                            }
                        })
                    }
                }),

            i.render({
                elem: "#app-user-appoint",
                url: "appoint_get_list",
                //添加请求字段
                where: {
                    uid: t("input[ name='uid' ] ").val()
                },
                //自定义响应字段
                response: {
                    statusName: 'code' //数据状态的字段名称
                    , statusCode: 1 //数据状态一切正常的状态码
                    , msgName: 'msg' //状态信息的字段名称
                    , dataName: 'data' //数据详情的字段名称
                },
                cols: [[{
                    type: "checkbox",
                    fixed: "left"
                },
                    {
                        field: "uid",
                        width: 100,
                        title: "商户UID",
                        sort: !0
                    },
                    {
                        field: "code",
                        width: 150,
                        title: "支付产品"
                    },
                    {
                        field: "ch_name",
                        width: 180,
                        title: "支付渠道"
                    },
                    {
                        field: "createtime",
                        width: 180,
                        title: "创建时间",
                        templet: function (d) {
                            if (d.createtime) {
                                return u.toDateString(d.createtime * 1000);

                            } else {
                                return ' ';
                            }
                        }
                    },

                    {
                        title: "操作",
                        minWidth: 400,
                        align: "center",
                        // fixed: "right",
                        toolbar: "#table-useradmin-webuser"
                    }]],
                page: !0,
                limit: 10,
                limits: [10, 15, 20, 25, 30],
                text: "对不起，加载出现异常！"
            }),


            i.on("tool(app-user-appoint)",
                function (e) {
                    if ("appoint_del" === e.event) {
                        layer.prompt({
                                formType: 1,
                                title: "敏感操作，请验证口令"
                            },
                            function (d, i) {
                                layer.close(i),
                                    layer.confirm("真的删除此商户吗？",
                                        function (d) {
                                            t.ajax({
                                                url: 'appoint_del?appoint_id=' + e.data.appoint_id,
                                                method: 'POST',
                                                success: function (res) {
                                                    if (res.code == 1) {
                                                        e.del()
                                                    }
                                                    layer.msg(res.msg, {icon: res.code == 1 ? 1 : 2, time: 1500});
                                                    layer.close(d); //关闭弹层
                                                }
                                            });
                                        })
                            });
                    } else if ("appoint_edit" === e.event) {
                        t(e.tr);
                        layer.open({
                            type: 2,
                            title: "编辑用户",
                            content: "appoint_edit.html?appoint_id=" + e.data.appoint_id,
                            maxmin: !0,
                            maxmin: !0, area: ['80%', '60%'],
                            btn: ["确定", "取消"],
                            yes: function (f, t) {
                                var l = window["layui-layer-iframe" + f],
                                    r = "app-user-appoint-submit",
                                    n = t.find("iframe").contents().find("#" + r);
                                l.layui.form.on("submit(" + r + ")",
                                    function (t) {
                                        var l = t.field;
                                        console.log(l);
                                        layui.$.post("appoint_edit", l, function (res) {
                                            if (res.code == 1) {
                                                //更新数据表
                                                e.update({
                                                    username: l.username,
                                                    phone: l.phone,
                                                    qq: l.qq,
                                                    is_agent: l.is_agent,
                                                    status: l.status
                                                }), i.render(),
                                                    layer.close(f)
                                            }
                                            layer.msg(res.msg, {icon: res.code == 1 ? 1 : 2, time: 1500});
                                        });
                                    }),
                                    n.trigger("click")
                            },
                            success: function (e, t) {
                            }
                        })
                    }
                }),

            tree.render({
                elem: "#app-team-stats-list"
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
                    ,{
                        field:'money',
                        title: '团队佣金余额',
                    }
                    ,{
                        field:'uid_rate',
                        title: '团长UID费率',
                    }
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
            i.render({
                elem: "#app-ms-stats",
                url: "getMsStats",
                //自定义响应字段
                response: {
                    statusName: 'code' //数据状态的字段名称
                    , statusCode: 0 //数据状态一切正常的状态码
                    , msgName: 'msg' //状态信息的字段名称
                    , dataName: 'data' //数据详情的字段名称
                },
                cols: [[
                    {
                        field: "username",
                        title: "码商昵称",
                        sort: !0
                    },
                    {
                        field: "total_number",
                        title: "订单总数"
                    },
                    {
                        field: "success_number",
                        title: "完成订单总数"
                    },
                    {
                        field: "total_amount",
                        title: "交易总额"
                    },
                    {
                        field: "success_amount",
                        title: "订单成功总额"
                    },

                    {
                        field: "success_rate",
                        title: "成功率（%）"
                    }]],
                page: !0,
                parseData: function (res) {
                        if(res.count == 0)
                        {
                            return {
                                'code': 201, //接口状态
                                'msg': '无数据', //提示文本
                                'count': 0, //数据长度
                                'data': [] //数据列表，是直接填充进表格中的数组
                            }
                        }
                    },
                limit: 10,
                limits: [10, 15, 20, 25, 30],
                text: "对不起，加载出现异常！"
            }),
        // uid码子统计
        i.render({
            elem: "#app-uid-static",
            url: "get_uid_static",
            //自定义响应字段
            response: {
                statusName: 'code' //数据状态的字段名称
                , statusCode: 0 //数据状态一切正常的状态码
                , msgName: 'msg' //状态信息的字段名称
                , dataName: 'data' //数据详情的字段名称
            },
            cols: [[
                {
                    field: "account_name",
                    width: 130,
                    title: "支付宝昵称",
                    sort: !0
                },
                {
                    field: "bank_name",
                    width: 220,
                    title: "支付宝账号"
                },
                {
                    field: "total_number",
                    width: 120,
                    title: "订单总数"
                },
                {
                    field: "success_number",
                    width: 120,
                    title: "完成订单总数"
                },
                {
                    field: "total_amount",
                    width: 130,
                    title: "交易总额"
                },
                {
                    field: "success_amount",
                    width: 130,
                    title: "订单成功总额"
                },

                {
                    field: "success_rate",
                    width: 130,
                    title: "成功率（%）"
                }]],
            page: !0
            ,parseData: function (res) {
            if(res.count == 0)
            {
                return {
                    'code': 201, //接口状态
                    'msg': '无数据', //提示文本
                    'count': 0, //数据长度
                    'data': [] //数据列表，是直接填充进表格中的数组
                }
            }
        },
            limit: 10,
            limits: [10, 15, 20, 25, 30],
            text: "对不起，加载出现异常！"
        }),
            //卡转卡码子统计
            i.render({
                elem: "#app-kzk-static",
                url: "get_ewm_static?code_type=30",
                //自定义响应字段
                response: {
                    statusName: 'code' //数据状态的字段名称
                    , statusCode: 0 //数据状态一切正常的状态码
                    , msgName: 'msg' //状态信息的字段名称
                    , dataName: 'data' //数据详情的字段名称
                },
                cols: [[
                    {
                        field: "account_name",
                        width: 130,
                        title: "收款人",
                        sort: !0
                    },
                    {
                        field: "account_number",
                        width: 220,
                        title: "银行卡号"
                    },
                    {
                        field: "total_number",
                        width: 120,
                        title: "订单总数"
                    },
                    {
                        field: "success_number",
                        width: 120,
                        title: "完成订单总数"
                    },
                    {
                        field: "total_amount",
                        width: 130,
                        title: "交易总额"
                    },
                    {
                        field: "success_amount",
                        width: 130,
                        title: "订单成功总额"
                    },

                    {
                        field: "success_rate",
                        width: 130,
                        title: "成功率（%）"
                    }]],
                page: !0
                ,parseData: function (res) {
                    if(res.count == 0)
                    {
                        return {
                            'code': 201, //接口状态
                            'msg': '无数据', //提示文本
                            'count': 0, //数据长度
                            'data': [] //数据列表，是直接填充进表格中的数组
                        }
                    }
                },
                limit: 10,
                limits: [10, 15, 20, 25, 30],
                text: "对不起，加载出现异常！"
            }),
        // 渲染码商列表
        i.render({
            elem: "#app-uid-userstatic-list",
            url: "getuidshstatic",
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
                    width: 80,
                    title: "商户UID",
                    sort: !0
                },
                {
                    field: "username",
                    width: 130,
                    title: "商户名"
                },
                {
                    field: "zongdanliang",
                    width: 120,
                    title: "订单总数"
                },
                {
                    field: "chenggongdanliang",
                    width: 120,
                    title: "完成订单总数"
                },
                {
                    field: "alipayUid_total",
                    width: 130,
                    title: "交易总额"
                },
                {
                    field: "success_money",
                    width: 130,
                    title: "订单成功总额"
                },

                {
                    field: "success_rate",
                    width: 80,
                    title: "成功率"
                }]],
            page: !0
            ,parseData: function (res) {
                if(res.count == 0)
                {
                    return {
                        'code': 201, //接口状态
                        'msg': '无数据', //提示文本
                        'count': 0, //数据长度
                        'data': [] //数据列表，是直接填充进表格中的数组
                    }
                }
            },
            limit: 10,
            limits: [10, 15, 20, 25, 30],
            text: "对不起，加载出现异常！"
        }),
        i.render({
            elem: "#app-ms-list",
            url: 'getmslist',
            //自定义响应字段
            response: {
                statusName: 'code' //数据状态的字段名称
                , statusCode: 1 //数据状态一切正常的状态码
                , msgName: 'msg' //状态信息的字段名称
                , dataName: 'data' //数据详情的字段名称
            },
            cols: [[{
                type: "checkbox",
                fixed: "left"
            },
                {
                    field: "userid",
                    width: 70,
                    title: "ID",
                    sort: !0
                },
                {
                    field: "username",
                    width: 120,
                    title: "用户名"
                },


                // {
                //     field: "mobile",
                //     width: 120,
                //     title: "手机号"
                // },
                {
                    field: "money",
                    width: 120,
                    title: "余额"
                },

                {
                    field: "cash_pledge",
                    width: 120,
                    title: "押金"
                },

                {
                    field: "p_username",
                    width: 120,
                    title: "上级代理"
                },
                {
                    field: "weight",
                    width: 120,
                    title: "权重",
                    edit: "text"
                },
                {
                    field: "level",
                    width: 120,
                    title: "码商代理层级",

                },
		     //  {
                  //  title: "状态",
                    // width: 500,
                   // align: "center",
                     //   width: 120,
                  //  toolbar: "#table-ms-status"
              //  },

                {
                    title: "接单状态",
                    // width: 500,
                    align: "center",
			width: 120,
                    toolbar: "#table-ms-jdstatus"
                },

                {
                    title: "操作",
                    align: "center",
                    minWidth: 450,
                    toolbar: "#table-ms-webuser"
                }
            ]],
            page: !0,
            limit: 10,
            limits: [10, 15, 20, 25, 30],
            text: "对不起，加载出现异常！"
        }),
            i.on("tool(app-ms-list)",
                function (e) {
                    if ("del" === e.event) {
                        layer.prompt({
                                formType: 1,
                                title: "敏感操作，请验证口令"
                            },
                            function (d, i) {
                                layer.close(i),
                                    layer.confirm("真的删除此码商吗？",
                                        function (d) {
                                            t.ajax({
                                                url: 'del?userid=' + e.data.userid,
                                                method: 'POST',
                                                success: function (res) {
                                                    if (res.code == 1) {
                                                        e.del()
                                                    }
                                                    layer.msg(res.msg, {icon: res.code == 1 ? 1 : 2, time: 1500});
                                                    layer.close(d); //关闭弹层
                                                }
                                            });
                                        })
                            });
                    }else if ("edit" === e.event) {
                        t(e.tr);
                        layer.open({
                            type: 2,
                            title: "编辑码商",
                            content: "edit.html?userid=" + e.data.userid,
                            maxmin: !0,
                            maxmin: !0,
                            area: ['80%', '60%'],
                            btn: ["确定", "取消"],
                            yes: function (f, t) {
                                var l = window["layui-layer-iframe" + f],
                                    r = "app-ms-list-submit",
                                    n = t.find("iframe").contents().find("#" + r);

                                l.layui.form.on("submit(" + r + ")",
                                    function (t) {
                                        var l = t.field;
                                        layui.$.post("edit", l, function (res) {
                                            if (res.code == 1) {
                                                window.location.fresh
                                                i.reload('app-ms-list');

                                                layer.close(f)
                                            }
                                            layer.msg(res.msg, {icon: res.code == 1 ? 1 : 2, time: 1500});
                                        });
                                    }),
                                    n.trigger("click")
                            },
                            success: function (e, t) {
                            }
                        })
                    } else if ("cleargoogleauth" === e.event) {
                        layer.prompt({
                                formType: 1,
                                title: "敏感操作，请验证口令"
                            },
                            function (d, i) {
                                layer.close(i),
                                    layer.confirm("真的清除此码商GOOGLE身份验证吗？",
                                        function (d) {
                                            t.ajax({
                                                url: '/admin/ms/clearGoogleAuth?id=' + e.data.userid,
                                                method: 'POST',
                                                success: function (res) {
                                                    layer.msg(res.msg, {icon: res.code == 1 ? 1 : 2, time: 1500});
                                                    layer.close(d); //关闭弹层
                                                }
                                            });
                                        })
                            });
                    } else if("assign_channels" === e.event){
                        t(e.tr);
                        layer.open({
                            type: 2,
                            title: "设置码商费率",
                            content: "assign_channels.html?id=" + e.data.userid,
                            maxmin: !0,
                            maxmin: !0, area: ['80%', '60%'],
                            btn: ["确定", "取消"],
                            yes: function (f, t) {
                                var l = window["layui-layer-iframe" + f],
                                    r = "app-user-profit-submit",
                                    n = t.find("iframe").contents().find("#" + r);
                                l.layui.form.on("submit(" + r + ")",
                                    function (t) {
                                        var l = t.field;
                                        console.log(l);
                                        layui.$.post("assign_channels", l, function (res) {
                                            if (res.code == 1) {
                                                i.render(),
                                                    layer.close(f)
                                            }
                                            layer.msg(res.msg, {icon: res.code == 1 ? 1 : 2, time: 1500});
                                        });
                                    }),
                                    n.trigger("click")
                            },
                            success: function (e, t) {
                            }
                        })
                    }else if ("op_balance" === e.event) {  //增加用户资金余额
                                            layer.open({
                                                type: 2
                                                , title: '增减余额'
                                                , content: 'changeBalance.html?userid=' + e.data.userid
                                                , maxmin: true
                                                , area: ['80%', '60%']
                                                , btn: ['确定', '取消']
                                                , yes: function (index, layero) {
                                                    var iframeWindow = window['layui-layer-iframe' + index]
                                                        , submitID = 'app-user-manage-submit'
                                                        ,
                                                        submit = layero.find('iframe').contents().find('#' + submitID);

                                                    //监听提交
                                                    iframeWindow.layui.form.on('submit(' + submitID + ')', function (obj) {
                                                        var field = obj.field; //获取提交的字段

                                                        //提交 Ajax 成功后，静态更新表格中的数据
                                                        t.ajax({
                                                            url: 'changeBalance.html?uid=' + e.data.uid,
                                                            method: 'POST',
                                                            data: field,
                                                            success: function (res) {
                                                                if (res.code == 1) {
                                                                    layer.msg(res.msg, {icon: 1, time: 1500},function (){
                                                                        layer.closeAll();
                                                                        i.reload('app-ms-list', {
                                                                            where: field,
                                                                            page: {
                                                                                curr: 1,
                                                                            }
                                                                        });
                                                                    });

                                                                } else {
                                                                    layer.msg(res.msg, {icon: 2, time: 1500});
                                                                }
                                                            }
                                                        });
                                                    });
                                                    submit.trigger('click');
                                                }
                                            });
                    } else if ("op_white_ip" === e.event) {  //增加用户资金余额
                        layer.prompt({
                                formType: 1,
                                title: "敏感操作，请验证口令",
                            },
                            function (d, f) {
                                // console.log(i);return false;
                                //检测口令
                                t.ajax({
                                    url: '/admin/api/checkOpCommand?command=' + d,
                                    method: 'POST',
                                    success: function (res) {
                                        if (res.code == 1) {
                                            //口令正确
                                            layer.close(d); //关闭弹层
                                            t(e.tr);
                                            layer.open({
                                                type: 2
                                                , title: '增减余额'
                                                , content: 'changeWhiteIp.html?ms_id=' + e.data.userid
                                                , maxmin: true
                                                , area: ['80%', '60%']
                                                , btn: ['确定', '取消']
                                                , yes: function (index, layero) {
                                                    var iframeWindow = window['layui-layer-iframe' + index]
                                                        , submitID = 'app-user-manage-submit'
                                                        ,
                                                        submit = layero.find('iframe').contents().find('#' + submitID);

                                                    //监听提交
                                                    iframeWindow.layui.form.on('submit(' + submitID + ')', function (obj) {
                                                        var field = obj.field; //获取提交的字段

                                                        //提交 Ajax 成功后，静态更新表格中的数据
                                                        t.ajax({
                                                            url: 'changeWhiteIp.html?ms_id=' + e.data.userid,
                                                            method: 'POST',
                                                            data: field,
                                                            success: function (res) {
                                                                if (res.code == 1) {
                                                                    layer.msg(res.msg, {icon: 2, time: 1500});
                                                                    layer.closeAll();
                                                                } else {
                                                                    layer.msg(res.msg, {icon: 2, time: 1500});
                                                                }
                                                            }
                                                        });
                                                    });
                                                    submit.trigger('click');
                                                }
                                            });
                                        } else {
                                            layer.msg(res.msg, {icon: 2, time: 1500});
                                            layer.close(d); //关闭弹层
                                        }
                                    }
                                });
                            });
                    } else if ("details" === e.event) {
                        window.location.href = '/admin/ms/bills?uid=' + e.data.userid
                        // t(e.tr);
                        // layer.open({
                        //     type: 2,
                        //     title: "账户明细",
                        //     content: "details.html?id=" + e.data.uid,
                        //     maxmin: !0,
                        //     area:  ['80%', '60%'],
                        //     yes: function(f, t) {},
                        //     success: function(e, t) {}
                        // })
                    }else if ("blind_tg_group_id" === e.event) {
                        var ms_secret = e.data.ms_secret;
                        layer.alert("请发送文本:【ms:" + ms_secret + "】到码商群")
                    } else if ("unblind_tg_group_id" === e.event) {
                        layer.confirm("真的要解绑此码商的TG群吗？",
                            function (d) {
                                t.ajax({
                                    url: 'unblindTgGroup?userid=' + e.data.userid,
                                    method: 'POST',
                                    success: function (res) {
                                        layer.msg(res.msg, {icon: res.code == 1 ? 1 : 2, time: 1500}, function () {
                                            layer.close(d); //关闭弹层
                                            window.location.reload();
                                        });
                                    }
                                });
                            })
                    }
                }),
                        i.on("edit(app-ms-list)",function(e){
                        var value = e.value;
                        var data = e.data;
                        var userid = data.userid
                        t.post('editMsWeight',{userid:userid,value:value},function(res){
                            if(res.code == 1){
                                layer.msg('修改成功',{icon:1,time:1500},function(){
                                    window.location.reload()
                                })
                            }else{
                                layer.msg(res.msg,{icon:2,time:1500},function(){
                                    window.location.reload()
                                })
                            }
                        },'json')
                    })
    });
