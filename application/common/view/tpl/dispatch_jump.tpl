{__NOLAYOUT__}
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>{$msg} - 跳转提示</title>
</head>
<body style="background-color: #f7f9fa;">
<div style="margin: -15px; padding: 8vh 0 2vh;color: #a6aeb3; background-color: #f7f9fa; text-align: center; font-family:NotoSansHans-Regular,'Microsoft YaHei',Arial,sans-serif; -webkit-font-smoothing: antialiased;">
    <div style="width: 750px; max-width: 85%; margin: 0 auto; background-color: #fff; -webkit-box-shadow: 0 2px 16px 0 rgba(118,133,140,0.22);-moz-box-shadow: 0 2px 16px 0 rgba(118,133,140,0.22);box-shadow: 0 2px 16px 0 rgba(118,133,140,0.22);">
        <div style="padding: 20px 10%; text-align: center; font-size: 16px;line-height: 16px;">
            <h1></h1>
           <!-- <a href="https://www.iredcap.cn" style="vertical-align: top;" target="_blank"> <img style="margin:32px auto; max-width: 95%; color: #0e2026;" src="__COMMON__/logo-color.png" /> </a>-->
        </div>
        <table width="600" style="background-color:#fff;margin:0 auto;" cellpadding="0" cellspacing="0">
            <tbody><tr>
                <td>
                    <table width="600" style="background-color:#fff;margin:0 auto;" cellpadding="0" cellspacing="0">
                        <tbody>
                        <tr>
                            <td colspan="3" style="height:40px;">&nbsp;</td>
                        </tr>
                        <tr>
                            <td width="40">&nbsp;</td>
                            <td width="520" style="line-height:20px;">
                                <p style="text-align:center;margin:0;padding:0;">
                                    {php}$errCode = $code == 1 ? 'success' : ($code == 0 ? 'wrong' : 'waring');{/php}
                                   <img src="__COMMON__/images/icon/{$errCode}.png" width="32" height="32" style="margin:0 12px;vertical-align:top;">
                                    <span style="font-size:24px;line-height:32px;color:{$code == 0 ? 'red' : 'green'};">{$msg}</span>
                                </p>
                                <p style="color:#7d7d7d;margin:20px 0px 24px 0px;font-size:18px;line-height:22px;padding:0 40px;text-align:center" hidden>
                                    此页面将在<span id="wait">{$wait} </span>秒后跳转
                                </p>
                            </td>
                            <td width="40">&nbsp;</td>
                        </tr>
                        <tr>
                            <td width="40">&nbsp;</td>
                        </tr>
                        </tbody>
                    </table>
                </td>
            </tr>
            </tbody></table>

    </div>
</div>
</body>
</html>
<script type="text/javascript">
    (function () {
        var wait = document.getElementById('wait');
        var interval = setInterval(function () {
            var time = --wait.innerHTML;
            if (time <= 0) {
                location.href = "{$url}";
                clearInterval(interval);
            }
        }, 1000);
    })();
</script>
</body>
</html>