-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 22, 2018 at 03:57 PM
-- Server version: 10.1.26-MariaDB
-- PHP Version: 7.1.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `social_network`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `admin_id` int(10) NOT NULL,
  `admin_email` varchar(100) NOT NULL,
  `admin_pass` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `comment_id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `comment` text NOT NULL,
  `comment_author` text NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `friends`
--

CREATE TABLE `friends` (
  `f1` varchar(100) NOT NULL,
  `f2` varchar(100) NOT NULL,
  `friends_since` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `status` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `friends`
--

INSERT INTO `friends` (`f1`, `f2`, `friends_since`, `status`) VALUES
('1', '2', '2018-02-22 08:38:36.268755', 0),
('14', '1', '2018-02-22 09:45:56.105233', 0),
('14', '2', '2018-02-22 10:01:06.965742', 0);

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `msg_id` int(11) NOT NULL,
  `sender` int(11) NOT NULL,
  `receiver` int(11) NOT NULL,
  `msg_sub` text NOT NULL,
  `msg_topic` text NOT NULL,
  `reply` text NOT NULL,
  `status` text NOT NULL,
  `msg_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`msg_id`, `sender`, `receiver`, `msg_sub`, `msg_topic`, `reply`, `status`, `msg_date`) VALUES
(1, 14, 1, 'hey', 'how r u?', 'no_reply', 'unread', '2018-02-22 09:47:40');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `post_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `topic_id` int(11) NOT NULL,
  `post_title` text NOT NULL,
  `post_content` text NOT NULL,
  `post_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`post_id`, `user_id`, `topic_id`, `post_title`, `post_content`, `post_date`) VALUES
(1, 2, 1, 'Education', 'Education is the passport to the future,for tomorrow belongs to those who prepare for it today!!!', '2018-02-22 07:50:34'),
(2, 2, 3, 'Cricket', 'The harder the battle the sweeter the victory!!!', '2018-02-22 07:52:00'),
(3, 2, 7, 'GATE2018', 'Finally appeared for the gate exam.', '2018-02-22 07:52:52'),
(4, 2, 3, 'Inspiration for playing', 'YOU CANT WIN UNLESS YOU LEARN HOW TO LOSE.....', '2018-02-22 07:54:20'),
(5, 2, 5, 'BE TOLERANT', 'INTOLERANCE IS NOW THE RISING ISSUES AMONG YOUTH..........', '2018-02-22 07:55:30'),
(6, 2, 10, 'Be healthy ', 'Health is Wealth!!!!!', '2018-02-22 07:56:06'),
(7, 2, 3, 'CHAMPIONS!!!!!', 'Champions believe in themselves even if no one does.........', '2018-02-22 07:57:32'),
(8, 5, 5, 'Violence', 'Violence is now incresing day by day!!!!', '2018-02-22 08:05:17'),
(9, 5, 0, 'Football ', 'Hurray!!!!!The team won the football match by 3 points.....', '2018-02-22 08:06:02'),
(10, 5, 1, 'Studies', 'Study hard to be successful!!!!', '2018-02-22 08:06:40'),
(11, 5, 2, 'Movie time!!', 'OH!!!!The Filmstars have already arrived in the sets', '2018-02-22 08:07:38'),
(12, 6, 4, 'Election time', 'Yessss!!! We have finally won the elections....', '2018-02-22 08:09:45'),
(13, 6, 4, 'Elections', 'Vote Vote for BJP.....', '2018-02-22 08:11:07'),
(14, 6, 6, 'Technofest', 'Yes this world is becoming techno savvy!!! ', '2018-02-22 08:12:06'),
(15, 6, 6, 'Technotsav', 'Technotsav is held @ D.Y.Patil college ', '2018-02-22 08:12:52'),
(16, 6, 4, 'Congress', 'Politics have no relation to morals.....', '2018-02-22 08:13:41'),
(17, 7, 1, 'EDUCATE', 'LEARN TO EARN......', '2018-02-22 08:15:47'),
(18, 7, 5, 'Social issue', 'ITS NOT SOCIAL ISSUES I CARE ABOUT.....', '2018-02-22 08:17:14'),
(19, 7, 5, 'Issues', 'You can achieve great economic gains by solving problems....', '2018-02-22 08:18:09'),
(20, 7, 10, 'Healthy thoughts', 'Stay Healthy always.....', '2018-02-22 08:19:01'),
(21, 8, 1, 'STUDY', 'PADHAI KARO AAGE BADHO......', '2018-02-22 08:21:50'),
(22, 8, 6, 'Techno', 'Yes there are now new advancement in technologie...... ', '2018-02-22 08:22:52'),
(23, 8, 7, 'Congo!!!', 'Whoooo!! I have finally cracked the exam..... ', '2018-02-22 08:23:51'),
(24, 9, 3, 'Wishes', 'All the best !!!!! Play well....', '2018-02-22 08:25:41'),
(25, 9, 10, 'Breakfast', 'Eat healthy breakfast !!!', '2018-02-22 08:26:18'),
(26, 9, 2, 'Star', 'She\'s BEAUTIFUL.....', '2018-02-22 08:27:12'),
(27, 9, 6, 'Technology', 'The science if today is the technology of tomorrow!!', '2018-02-22 08:28:38'),
(28, 9, 7, 'Difficulty....', 'The exam was too tough.....', '2018-02-22 08:29:13'),
(29, 9, 4, 'Elect the best one....', 'NaMo won the elections......', '2018-02-22 08:29:57'),
(30, 10, 2, 'Stars', 'The hero has the best style!!!!', '2018-02-22 08:31:54'),
(31, 10, 3, 'Hockey', 'Hockey is our national game....', '2018-02-22 08:32:45'),
(32, 10, 1, 'Learn', 'EDUCATE YOURSELF!!!', '2018-02-22 08:33:24'),
(33, 10, 6, 'Comforts of tech', 'Comfort is increasing due to the technology....', '2018-02-22 08:34:11');

-- --------------------------------------------------------

--
-- Table structure for table `topics`
--

CREATE TABLE `topics` (
  `topic_id` int(11) NOT NULL,
  `topic_title` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `topics`
--

INSERT INTO `topics` (`topic_id`, `topic_title`) VALUES
(1, 'Education'),
(2, 'Entertainment'),
(3, 'Sports'),
(4, 'Politics'),
(5, 'Social Issues'),
(6, 'Technology'),
(7, 'GATE2018'),
(8, 'GRE/MS'),
(9, 'CAT2018'),
(10, 'Health'),
(11, 'Share Market');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `user_name` varchar(100) NOT NULL,
  `user_pass` varchar(100) NOT NULL,
  `user_email` varchar(100) NOT NULL,
  `user_country` varchar(100) NOT NULL,
  `user_gender` varchar(100) NOT NULL,
  `user_b_day` date NOT NULL,
  `user_image` text NOT NULL,
  `register_date` date NOT NULL,
  `last_login` date NOT NULL,
  `status` text NOT NULL,
  `ver_code` varchar(100) NOT NULL,
  `posts` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `user_name`, `user_pass`, `user_email`, `user_country`, `user_gender`, `user_b_day`, `user_image`, `register_date`, `last_login`, `status`, `ver_code`, `posts`) VALUES
(1, 'Rimmon Bhosale', '123456789', 'rimmon281996@gmail.com', 'India', 'Male', '1996-09-28', 'default.jpg', '2018-02-22', '2018-02-22', 'unverified', '1801224642', 'No'),
(2, 'Siddhi Kulkarni', 'siddhi1996', 'siddhikulkarni96@gmail.com', 'India', 'Female', '1996-06-12', 'default.jpg', '2018-02-22', '2018-02-22', 'unverified', '423971265', 'yes'),
(3, 'Sakshi Rasal ', 'sakshi1996', 'sakshirasal962@gmail.com', 'India', 'Female', '1996-03-15', 'default.jpg', '2018-02-22', '2018-02-22', 'unverified', '508397406', 'No'),
(4, 'Priyanka Supanekar', 'priyanka1996', 'priyankasupanekar962@gmail.com', 'India', 'Female', '1996-05-25', 'default.jpg', '2018-02-22', '2018-02-22', 'unverified', '544327659', 'No'),
(5, 'Somesh Kondekar', 'somesh1996', 'somesh@gmail.com', 'India', 'Male', '1996-05-12', 'default.jpg', '2018-02-22', '2018-02-22', 'unverified', '1173709784', 'yes'),
(6, 'Simran Mulla', 'simran1996', 'simran96@gmail.com', 'India', 'Female', '1996-11-30', 'default.jpg', '2018-02-22', '2018-02-22', 'unverified', '1737812413', 'yes'),
(7, 'amita ', 'amita1996', 'amita96@gmail.com', 'India', 'Female', '1996-11-08', 'default.jpg', '2018-02-22', '2018-02-22', 'unverified', '605587705', 'yes'),
(8, 'Prajakta', 'prajakta1996', 'prajakta96@gmail.com', 'India', 'Female', '1996-06-20', 'default.jpg', '2018-02-22', '2018-02-22', 'unverified', '194447877', 'yes'),
(9, 'Shubhangi Patil', 'shubhangi1996', 'shubhangi96@gmail.com', 'India', 'Female', '1996-03-16', 'default.jpg', '2018-02-22', '2018-02-22', 'unverified', '1150282987', 'yes'),
(10, 'Vaibhav Solanke', 'vaibhav1996', 'vaibhav96@gmail.com', 'India', 'Male', '1996-09-09', 'default.jpg', '2018-02-22', '2018-02-22', 'unverified', '1826448744', 'yes'),
(11, 'Lekhraj Panjwani', '123456789', 'lekhraj1996@gmail.com', 'India', 'Male', '2000-02-28', 'default.jpg', '2018-02-22', '2018-02-22', 'unverified', '1104842678', 'No'),
(12, 'Akshay Sangar', '123456789', 'akshay1996@gmail.com', 'India', 'Male', '1996-05-02', 'default.jpg', '2018-02-22', '2018-02-22', 'unverified', '1433887066', 'No'),
(13, 'Abhishek Kulkarni', '123456789', 'abhi1996@gmail.com', 'India', 'Male', '1996-05-02', 'default.jpg', '2018-02-22', '2018-02-22', 'unverified', '1331703858', 'No'),
(14, 'Pankaj Kumbhar', '123123123', 'pankaj@gmail.com', 'India', 'Male', '1997-01-10', '240_320.png', '2018-02-22', '2018-02-22', 'unverified', '709107056', 'No');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`admin_id`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`comment_id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`msg_id`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`post_id`);

--
-- Indexes for table `topics`
--
ALTER TABLE `topics`
  ADD PRIMARY KEY (`topic_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `admin_id` int(10) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `comment_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `msg_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `post_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;
--
-- AUTO_INCREMENT for table `topics`
--
ALTER TABLE `topics`
  MODIFY `topic_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
