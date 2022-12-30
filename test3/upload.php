<?php
header("Access-Control-Allow-Origin: *");//允许所有地址跨域请求
ini_set("display_errors", "On");
error_reporting(E_ALL);
$QR_ZIP_PATH = "uploads/Zip/";
$QR_PATH = "uploads/";
$tarName = md5(microtime());
require __DIR__ . "/vendor/autoload.php";

if(explode(".", $_FILES['mypic']['name'])[1] != "zip")
{
    echo "nofile find";die();
}
else
{
    move_uploaded_file($_FILES["mypic"]["tmp_name"],$QR_ZIP_PATH  .$tarName.".zip");
    $cmd = "unzip ".$QR_ZIP_PATH  .$tarName.".zip"." -d ".$QR_ZIP_PATH  .$tarName;
    exec($cmd, $res);
    unlink($QR_ZIP_PATH  .$tarName.".zip");
    $filesnames = scandir($QR_ZIP_PATH .$tarName);
}
$pictureLists = [];
foreach ($filesnames as $file)
{
    $fArray = explode(".", $file);
    if(!empty($fArray[1]) && ($fArray[1]=="jpg" || $fArray[1]=="png"|| $fArray[1]=="jpeg"))
    {
        $pictureLists[] = $file;
    }
}
foreach ($pictureLists as $k=>$p)
{
    $where = array();
    $orderNum = explode(".", $p)[0];

    $qrPath = md5(microtime()).".jpg";

    copy($QR_ZIP_PATH .$tarName."/".$p,$QR_PATH  .$qrPath);
    $imageInfo =  getRawQrImage($QR_PATH  .$qrPath);
    // unlink(self::QR_PATH  .$qrPath);
    if(empty($imageInfo))
    {
        $notHaveQrList[] = $orderNum;
        continue;
    }
    copy($imageInfo['path'],$QR_PATH  . $qrPath);
    unlink($imageInfo['path']);

    $data['ordernum'] = $orderNum;
    $data['qr_image'] = "http://45.127.99.187/test3/".$QR_PATH  . $qrPath;
    $data['qr_url'] = $imageInfo['url'];
    $reslut[] = $data;
}
echo json_encode($reslut);die();


function identify($imagePath)
{
    $cmd = "identify ".$imagePath;
    exec($cmd,$res);
    $imageInfo = explode(" ",$res[0])[2];
    $width = explode("x", $imageInfo)[0];
    $higth = explode("x", $imageInfo)[1];
    $scale = intval($higth*(7/20));
    $widthStart = intval($width*(1/6));
    $lengthStart = intval($higth*(1/5));
    if($width == 720 &&  $higth == 1280)
    {
        $res = getQrcodeFromImage($imagePath, $imagePath, 448, 510, 130);
        if(!empty($res))
        {
            return $res;
        }
    }

    if($width == 1080 &&  $higth == 1920)
    {
        $res = getQrcodeFromImage($imagePath, $imagePath, 680, 809, 199, 9, 1,1);
        if(!empty($res))
        {
            return $res;
        }
    }

    if($width == 1080 &&  $higth == 2280)
    {
        $res = getQrcodeFromImage($imagePath, $imagePath, 680, 989, 199, 9, 1,1);
        if(!empty($res))
        {
            return $res;
        }

        $res = getQrcodeFromImage($imagePath, $imagePath, 680, 800, 199, 9, 1,1);
        if(!empty($res))
        {
            return $res;
        }
    }

    $res = getQrcodeFromImage($imagePath, $imagePath, $scale, $lengthStart, $widthStart);
    if(empty($res))
    {
        $res = getQrcodeFromImage($imagePath, $imagePath, intval($higth*(6/20)), $lengthStart, $widthStart);
        if(empty($res))
        {
            $res = getQrcodeFromImage($imagePath, $imagePath, intval($higth*(8/20)), $lengthStart, $widthStart);
            if(empty($res))
            {
                $res = getQrcodeFromImage($imagePath, $imagePath, intval($higth*(3063/10000)), intval($higth*(3/10))+40,  intval($width*(22/100)), 0);
                if(empty($res))
                {
                    $res = getQrcodeFromImage($imagePath, $imagePath, intval($higth*(11/40)), intval($higth*(3/10)), $widthStart+10, 0);
                }
            }
        }

    }
    return $res;
}

//获取纯的ｕｒｌ图片和ｕｒｌ路径
function getRawQrImage($imgPath)
{
    $url = identify($imgPath);
    if(empty($url))
    {
        return false;
    }

    $url = str_replace("https://qr.alipay.com/_d?_b=peerpay&enableWK=YES&",
        "https://mclient.alipay.com/h5/peerpay.htm?",
        $url);

    $imagePath = encodeFromUrl($url);

    $data["url"] = $url;
    $data["path"] = $imagePath;

    return $data;
}

//获取二维码图片
function getQrcodeFromImage($imagePath,$idfiyPath,$scale = 0, $lengthStart=0, $widthStart = 0, $times = 0, $wstep= 2, $hstep =20)
{
    $res = [];

    $qrcode = new Zxing\QrReader($idfiyPath);
    $text = $qrcode->text();
    if(!empty($text))
    {
        return $text;
    }

    exec("zbarimg ".$idfiyPath, $res);
    if(empty($res[0]) || strpos($res[0], "QR-Code:") === false)
    {
        if ($times > 10) {
            return false;
        }
        $times++;
        $lengthStart = $lengthStart + $hstep;
        $widthStart = $widthStart + $wstep;
        $tempImage = "uploads/"."/chart-cropped.png";
        $cmd = "convert " . $imagePath . " -crop " . $scale . "x" . $scale . "+" . $widthStart . "+" . $lengthStart . " ".$tempImage;
        exec($cmd);
        echo $cmd;die();
        return getQrcodeFromImage($imagePath, $tempImage, $scale, $lengthStart, $widthStart, $times);
    }

    return str_replace("QR-Code:","", $res[0]);
}

//加密图片地址
function encodeFromUrl($url)
{
    $res = [];
    $outputiamge = "uploads/".md5(time().$url)."_qr.png";
    $cmd = "qrencode '".$url."' -o ".$outputiamge;
    exec($cmd, $res);
    return $outputiamge;

}
?>