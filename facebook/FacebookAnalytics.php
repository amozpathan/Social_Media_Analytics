<?php 
session_start();
if(!isset($_SESSION['user_email'])){
	
	header("location: index.php"); 
}
 $at=$_POST['at'];
 $id=$_SESSION['user_id'];
 $wd=getcwd();
 $wd=str_replace('\\','/',"$wd");
 $output=exec("cd $wd");
 $output=exec("java Fetch $at $id");
 $output=exec("Rscript FBwordcloud.R $id");
 header("Location: output.php");
?>