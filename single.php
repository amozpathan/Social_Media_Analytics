<?php 
session_start();
include("includes/connection.php");
include("functions/functions.php");

if(!isset($_SESSION['user_email'])){
	
	header("location: index.php"); 
}
else {
?>
<!DOCTYPE html> 
<html>
	<head>
<style>
#wrap	{
	width: 100%; /* Spans the width of the page */
	height: 51px; 
	margin: 0; /* Ensures there is no space between sides of the screen and the menu */
	z-index: 99; /* Makes sure that your menu remains on top of other page elements */
	position: relative; 
	}
.navbar	{
	height: 50px;
        padding: 0;
	margin: 0;
	position: absolute; /* Ensures that the menu doesn’t affect other elements */
	border-right: 1px solid #54879d; 
	}
.navbar li 	{
			height: auto;
			width: 150px;  /* Each menu item is 150px wide */
			float: left;  /* This lines up the menu items horizontally */
			text-align: center;  /* All text is placed in the center of the box */
			list-style: none;  /* Removes the default styling (bullets) for the list */
			font: normal bold 12px/1.2em Arial, Verdana, Helvetica;  
			padding: 0;
			margin: 0;
			 }
.navbar a	{							
		padding: 18px 0;  /* Adds a padding on the top and bottom so the text appears centered vertically */
		text-decoration: none;  /* Removes the default hyperlink styling. */
		color: white; /* Text color is white */
		display: block;
		}
		 .navbar li:hover, a:hover {} 
.navbar li ul 	{
		display: none;  /* Hides the drop-down menu */
		height: auto;									
		}				

.navbar li:hover ul 	{
                        display: block; /* Displays the drop-down box when the menu item is hovered over */
                        }
 .navbar li ul li {background-color: #4ABDAC;} 
 
.navbar li ul li a 	{
		border-left: 1px solid #1f5065; 
		border-right: 1px solid #1f5065; 
		border-top: 1px solid #74a3b7; 
		border-bottom: 1px solid #1f5065; 
		}
.text{
		 font-family: -apple-system, BlinkMacSystemFont, sans-serif;
	    
	}
</style>
</head>
	<link rel="stylesheet" href="styles/home_style.css" media="all"/>
	</head> 
	
<body>
	<!--Container starts--> 
	<div class="container">
		<!--Header Wrapper Starts-->
		<div id="head_wrap">
			<!--Header Starts-->
			<div id="header">
				<ul id="menu" class="navbar">
					<li><a href="home.php">Home</a></li>
					<li><a href="members.php">Friends</a></li>
					<li><a href="#">Topics</a>
						<ul>
						<?php 
					
						$get_topics = "select * from topics"; 
						$run_topics = mysqli_query($con,$get_topics);
						
						while($row=mysqli_fetch_array($run_topics)){
							
							$topic_id = $row['topic_id'];
							$topic_title = $row['topic_title'];
						
						echo "<li><a href='topic.php?topic=$topic_id'>$topic_title</a></li>";
						}
					?>
					</ul>
					<li><a href="twitter.php">Twitter</a></li>
					<li><a href="facebook.php">Facebook</a></li>
				</ul>
				<form method="get" action="results.php" id="form1">
					<input type="text" name="user_query" placeholder="Search a topic"/> 
					<input type="submit" name="search" value="Search"/>
				</form>
			</div>
			<!--Header ends-->
		</div>
		<!--Header Wrapper ends-->
			<!--Content area starts-->
			<div class="content">
				<!--user timeline starts-->
				<div id="user_timeline">
					<div id="user_details">
					<?php 
					$user = $_SESSION['user_email'];
					$get_user = "select * from users where user_email='$user'"; 
					$run_user = mysqli_query($con,$get_user);
					$row=mysqli_fetch_array($run_user);
					
					$user_id = $row['user_id']; 
					$user_name = $row['user_name'];
					$user_country = $row['user_country'];
					$user_image = $row['user_image'];
					$register_date = $row['register_date'];
					$last_login = $row['last_login'];
					
					
					echo "
						<center><img src='user/user_images/$user_image' width='200' height='200'/></center>
						<div id='user_mention'>
						<p><strong>Name:</strong> $user_name</p>
						<p><strong>Country:</strong> $user_country</p>
						<p><strong>Last Login:</strong> $last_login</p>
						<p><strong>Member Since:</strong> $register_date</p>
						
						<p><a href='my_messages.php'>Messages (2)</a></p>
						<p><a href='my_posts.php'>My Posts (3)</a></p>
						<p><a href='edit_profile.php'>Edit My Account</a></p>
						<p><a href='logout.php'>Logout</a></p>
						</div>
					";
					?>
					</div>
				</div>
				<!--user timeline ends-->
				<!--Content timeline starts-->
				<div id="content_timeline"> 
						<?php single_post();?>
				</div>
				<!--Content timeline ends-->
			</div>
			<!--Content area ends-->
		
	</div>
	<!--Container ends-->

</body>
</html>
<?php } ?>