<?php
ini_set("display_errors", "On");
error_reporting(E_ALL | E_STRICT);
require __DIR__ . "/vendor/autoload.php";
$qrcode = new Zxing\QrReader('uploads/chart-cropped.png');
$text = $qrcode->text(); //return decoded text from QR Code

//$qrcode = new Zxing\QrReader('/home/wwwroot/www.test2.com/6239936_092702973000_2.jpg');
//$text = $qrcode->text(); //return decoded text from QR Code
echo $text;die();
