<?php 
session_start();
if(!isset($_SESSION['user_email'])){
	
	header("location: index.php"); 
}
 $ck=$_POST['ck'];
 $cs=$_POST['cs'];
 $at=$_POST['at'];
 $as=$_POST['as'];
 $id=$_SESSION['user_id'];
 $wd=getcwd();
 $wd=str_replace('\\','/',"$wd");
 $output=exec("cd $wd");
 $output=exec("java Fetch $ck $cs $at $as $id");
 $output=exec("Rscript TWITTERwordcloud.R $id");
 echo "<script>alert('Data received successfully !');</script>";
 header("Location: output.php");
?>