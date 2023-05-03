<?php 
session_start();
if(!isset($_SESSION['user_email'])){
}
	header("location: index.php"); 
 $wd=getcwd();
 $wd=str_replace('\\','/',"$wd");
 $output=exec("cd $wd");
 $output=exec("Rscript wordcloud.R");
 header("Location: wordcloud.html");
?>