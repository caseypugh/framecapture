<?
// Put this file on your webserver.
// Change the path to whatever you want.

$path = "frames";

$fp = fopen("{$frames}/{$_GET['name']}", 'wb');
fwrite($fp, $GLOBALS['HTTP_RAW_POST_DATA']);
fclose($fp);
?>