<?php 
include("includes/connection.php");

if(isset($_POST['sign_up'])){
			
			$name = mysqli_real_escape_string($con,$_POST['u_name']);
			$pass = mysqli_real_escape_string($con,$_POST['u_pass']);
			$email = mysqli_real_escape_string($con,$_POST['u_email']);
			$country = mysqli_real_escape_string($con,$_POST['u_country']);
			$gender = mysqli_real_escape_string($con,$_POST['u_gender']);
			$b_day = mysqli_real_escape_string($con,$_POST['u_birthday']);
			$status = "unverified";
			$posts = "No";
			
			$verification_code = mt_rand();
			
			$get_email = "select * from users where user_email='$email'";
			$run_email = mysqli_query($con,$get_email);
			$check = mysqli_num_rows($run_email);
			
			if($check==1)
			{
			echo "<script>alert('Email is already registered, plz try another!')</script>";
			exit();
			}
			
			if(strlen($pass)<8)
			{
			
				echo "<script>alert('Password should be minimum 8 characters!')</script>";
				exit();
			}
			else
			{
			
				$insert = "insert into users (user_name,user_pass,user_email,user_country,user_gender,user_b_day,user_image,register_date,last_login,status,ver_code,posts) values ('$name','$pass','$email','$country','$gender','$b_day','default.jpg',NOW(),NOW(),'$status','$verification_code','$posts')";
				$run_insert = mysqli_query($con,$insert);
			
				if($run_insert){
				$_SESSION['user_email']=$email;
				
				echo "<h3 style='width:400px;'>Hi $name, registration is almost complete</h3>
				<p style='width:400px;'>We have sent an email to <strong>$email</strong>, please check your inbox or spam folder for verification!.</p>
				";
				}
			
			}
			
			$to = $email;
			$subject = "Verify your email address."; 
			
			$message = "
			<html> 
					Hello <strong>$name</strong> You have just created an account on www.socialnetwork.com, please verify your email address by clicking below link:
					<a href='http://www.connectme.com/social_network/verify.php?code=$verification_code'>Click to Verify Your Email</a><br/> 
					<strong>Thank you for creating an account!</strong>
			</html> 
			";
			
			// Always set content-type when sending HTML email
			/*$headers = "MIME-Version: 1.0" . "\r\n";
			$headers .= "Content-type:text/html;charset=UTF-8" . "\r\n";
			$headers .= 'From: <admain@social.com>' . "\r\n";

			mail($to,$subject,$message,$headers);*/
		}
?>