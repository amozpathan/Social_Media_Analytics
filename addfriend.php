<?php 
session_start();
include("includes/connection.php");
include("functions/functions.php");
addfriend();
function addfriend()
	{
		
			$friend= $_GET['u_id']; 
			$user_id=$_SESSION['user_id'];
			$con = mysqli_connect("localhost","root","","social_network") or die("Connection was not established");

		
			$insert = "insert into friends (f1,f2) values ('$user_id','$friend')";
			
			$run = mysqli_query($con,$insert); 
			
			echo "<script>alert('You are now friend !');</script>";
			header("Location: user_profile.php?u_id=$friend");
		
		
	}
?>