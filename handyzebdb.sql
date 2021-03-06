-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 13, 2017 at 03:56 PM
-- Server version: 5.7.14
-- PHP Version: 5.6.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `handyzebdb`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `adminId` int(11) NOT NULL,
  `firstName` varchar(30) NOT NULL,
  `lastName` varchar(30) NOT NULL,
  `email` varchar(50) NOT NULL,
  `contactNumber` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`adminId`, `firstName`, `lastName`, `email`, `contactNumber`) VALUES
(1, 'Jerome', 'Del Rosario', '2150536@slu.edu.ph', '09153478922');

-- --------------------------------------------------------

--
-- Table structure for table `booking`
--

CREATE TABLE `booking` (
  `bookingId` int(11) NOT NULL,
  `custId` int(11) NOT NULL,
  `spId` int(11) NOT NULL,
  `serviceId` int(11) NOT NULL,
  `bookingStatus` enum('pending','ongoing','done','cancelled','accepted','rejected') NOT NULL DEFAULT 'pending',
  `reserved_date` datetime NOT NULL,
  `dateStarted` datetime DEFAULT NULL,
  `dateFinished` datetime DEFAULT NULL,
  `notifTimestamp` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `booking`
--

INSERT INTO `booking` (`bookingId`, `custId`, `spId`, `serviceId`, `bookingStatus`, `reserved_date`, `dateStarted`, `dateFinished`, `notifTimestamp`) VALUES
(3, 7, 11, 3, 'pending', '2017-05-12 10:00:00', NULL, NULL, '2017-05-11 17:13:33'),
(4, 7, 12, 4, 'ongoing', '2017-05-10 10:00:00', '2017-05-10 15:00:00', NULL, '2017-05-11 17:11:03'),
(5, 7, 12, 6, 'ongoing', '2017-05-11 08:00:00', '2017-05-09 09:30:00', NULL, '2017-05-11 17:11:03'),
(7, 7, 11, 5, 'done', '2017-05-07 14:00:00', '2017-05-07 15:30:00', '2017-05-07 18:51:00', '2017-05-11 17:11:03'),
(8, 7, 12, 2, 'accepted', '2017-05-23 00:00:00', NULL, NULL, '2017-05-11 17:11:03'),
(9, 7, 12, 5, 'rejected', '2017-05-22 00:00:00', NULL, NULL, '2017-05-11 17:11:03'),
(11, 7, 11, 6, 'pending', '2017-06-02 08:00:00', NULL, NULL, NULL),
(12, 7, 12, 6, 'ongoing', '2017-05-09 00:00:00', '2017-05-09 11:00:00', '2017-05-09 16:00:00', NULL),
(13, 7, 12, 6, 'ongoing', '2017-05-13 03:00:00', NULL, NULL, NULL),
(14, 7, 11, 4, 'pending', '2017-05-14 00:00:00', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `custId` int(11) NOT NULL,
  `firstName` varchar(30) NOT NULL,
  `lastName` varchar(30) NOT NULL,
  `address` varchar(50) NOT NULL,
  `email` varchar(30) NOT NULL,
  `contactNumber` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`custId`, `firstName`, `lastName`, `address`, `email`, `contactNumber`) VALUES
(4, 'Wyatt', 'Cardenas', 'Baguio City', 'email1@slu.edu.ph', '1'),
(5, 'Josepablo', 'David', 'Baguio City', 'email2@slu.edu.ph', '2'),
(6, 'Hiromi', 'Uematsu', 'Sunrise Land', 'email3@slu.edu.ph', '3'),
(7, 'Samantha', 'Lopez', 'Baguio City', 'email4@slu.edu.ph', '4'),
(8, 'Frachesca', 'Sarmiento', 'Baguio City', 'email5@slu.edu.ph', '5'),
(9, 'Rio Vann', 'Kolodzik', 'Boundary ng Poland ken nu Germany', 'email6@slu.edu.ph', '6'),
(10, 'Jay', 'Dadula', 'Baguio City', 'email7@slu.edu.ph', '7'),
(3, 'Michael', 'Rivera', 'Baguio City', 'email@slu.edu.ph', '0'),
(2, 'Jerome', 'Del Rosario', 'Baguio City', 'jeromed.pepper@gmail.com', '09153478922');

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE `feedback` (
  `feedbackId` int(11) NOT NULL,
  `transactionId` int(11) NOT NULL,
  `custId` int(11) NOT NULL,
  `spId` int(11) NOT NULL,
  `rating` enum('1','2','3','4','5') NOT NULL,
  `remarks` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `feedback`
--

INSERT INTO `feedback` (`feedbackId`, `transactionId`, `custId`, `spId`, `rating`, `remarks`) VALUES
(1, 3, 7, 11, '5', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `message`
--

CREATE TABLE `message` (
  `messageId` int(11) NOT NULL,
  `senderId` int(11) NOT NULL,
  `receiverId` int(11) NOT NULL,
  `messageBody` text NOT NULL,
  `timeSent` datetime NOT NULL,
  `timeReceived` datetime DEFAULT NULL,
  `timeRead` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `message`
--

INSERT INTO `message` (`messageId`, `senderId`, `receiverId`, `messageBody`, `timeSent`, `timeReceived`, `timeRead`) VALUES
(1, 7, 11, 'I would like to inquire more specifically on the services you can provide', '2017-05-08 06:00:00', NULL, NULL),
(45, 7, 11, 'asdfasdfasdf', '2017-05-11 13:46:16', NULL, NULL),
(46, 7, 11, 'asdf', '2017-05-11 13:50:28', NULL, NULL),
(47, 7, 11, 'asdf', '2017-05-11 13:51:13', NULL, NULL),
(48, 7, 11, 'asdf', '2017-05-11 13:51:19', NULL, NULL),
(49, 7, 11, 'asdfsd', '2017-05-11 13:53:37', NULL, NULL),
(62, 12, 7, 'asdfsdfasdf', '2017-05-11 11:00:00', NULL, NULL),
(63, 7, 12, 'wadfasd', '2017-05-11 06:00:00', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `paymentdetails`
--

CREATE TABLE `paymentdetails` (
  `invoiceId` int(11) NOT NULL,
  `transactionId` int(11) NOT NULL,
  `serviceMade` mediumtext NOT NULL,
  `amount` decimal(8,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `paymentdetails`
--

INSERT INTO `paymentdetails` (`invoiceId`, `transactionId`, `serviceMade`, `amount`) VALUES
(1, 3, 'Painted three rooms', '200.00'),
(2, 3, 'painted the garage', '500.00'),
(3, 4, 'Fixed doorway', '300.00');

-- --------------------------------------------------------

--
-- Table structure for table `service`
--

CREATE TABLE `service` (
  `serviceId` int(11) NOT NULL,
  `serviceType` enum('Assembly/Installation','Repair','Plumbing','Electrical','Painting','Carpentry','Remodeling') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `service`
--

INSERT INTO `service` (`serviceId`, `serviceType`) VALUES
(1, 'Assembly/Installation'),
(2, 'Repair'),
(3, 'Plumbing'),
(4, 'Electrical'),
(5, 'Painting'),
(6, 'Carpentry'),
(7, 'Remodeling');

-- --------------------------------------------------------

--
-- Table structure for table `service_provider`
--

CREATE TABLE `service_provider` (
  `spId` int(11) NOT NULL,
  `firstName` varchar(30) NOT NULL,
  `lastName` varchar(30) NOT NULL,
  `email` varchar(50) NOT NULL,
  `contactNumber` varchar(11) NOT NULL,
  `shift_start` time NOT NULL,
  `shift_end` time NOT NULL,
  `working_days` varchar(27) NOT NULL,
  `availability` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `service_provider`
--

INSERT INTO `service_provider` (`spId`, `firstName`, `lastName`, `email`, `contactNumber`, `shift_start`, `shift_end`, `working_days`, `availability`) VALUES
(11, 'Zebedee', 'Jimenez', 'email10@slu.edu.ph', '10', '07:30:00', '18:00:00', 'Sun,Mon,Tue,Wed,Thu,Fri,Sat', 1),
(12, 'Johnny', 'Sins', 'email12@slu.edu.ph', '11', '09:00:00', '20:00:00', 'Mon,Wed,Fri', 1);

-- --------------------------------------------------------

--
-- Table structure for table `sp_service`
--

CREATE TABLE `sp_service` (
  `serviceId` int(11) NOT NULL,
  `spId` int(11) NOT NULL,
  `fixedRate` decimal(8,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sp_service`
--

INSERT INTO `sp_service` (`serviceId`, `spId`, `fixedRate`) VALUES
(1, 11, '0.00'),
(6, 11, '0.00'),
(1, 12, '0.00'),
(2, 12, '0.00'),
(3, 12, '0.00'),
(4, 12, '0.00'),
(5, 12, '0.00'),
(6, 12, '0.00'),
(7, 12, '0.00');

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

CREATE TABLE `transaction` (
  `transactionId` int(11) NOT NULL,
  `bookingId` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `spStatus` enum('pending','approved') NOT NULL DEFAULT 'pending',
  `custStatus` enum('pending','approved') NOT NULL DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `transaction`
--

INSERT INTO `transaction` (`transactionId`, `bookingId`, `timestamp`, `spStatus`, `custStatus`) VALUES
(3, 7, '2017-05-07 09:50:00', 'approved', 'approved'),
(4, 12, '2017-05-09 01:13:08', 'approved', 'approved');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `idNum` int(11) NOT NULL,
  `userName` varchar(15) NOT NULL,
  `password` varchar(20) NOT NULL,
  `userType` enum('Administrator','Customer','Service Provider') NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `balance` decimal(5,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`idNum`, `userName`, `password`, `userType`, `status`, `balance`) VALUES
(1, 'jeddeh', 'password', 'Administrator', 0, '0.00'),
(2, 'muzhnik', 'password', 'Customer', 1, '0.00'),
(3, 'shiru', 'password', 'Customer', 1, '0.00'),
(4, 'moo_man', 'password', 'Customer', 1, '0.00'),
(5, 'pjd', 'password', 'Customer', 1, '0.00'),
(6, 'japan', 'password', 'Customer', 1, '0.00'),
(7, 'samiam', 'password', 'Customer', 1, '0.00'),
(8, 'miggy', 'password', 'Customer', 1, '0.00'),
(9, 'rvk', 'password', 'Customer', 1, '0.00'),
(10, 'prodijay', 'password', 'Customer', 1, '0.00'),
(11, 'bhosx_zeb', 'password', 'Service Provider', 1, '0.00'),
(12, 'papa_johnny', 'password', 'Service Provider', 1, '0.00');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `contactNumber` (`contactNumber`),
  ADD KEY `adminId` (`adminId`);

--
-- Indexes for table `booking`
--
ALTER TABLE `booking`
  ADD PRIMARY KEY (`bookingId`),
  ADD KEY `custId` (`custId`),
  ADD KEY `spId` (`spId`),
  ADD KEY `serviceId` (`serviceId`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD UNIQUE KEY `email_2` (`email`),
  ADD UNIQUE KEY `CONTACTNUMBER` (`contactNumber`),
  ADD KEY `CUSTOMERID` (`custId`),
  ADD KEY `EMAIL` (`email`);

--
-- Indexes for table `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`feedbackId`),
  ADD KEY `custId` (`custId`),
  ADD KEY `spId` (`spId`),
  ADD KEY `transactionId` (`transactionId`);

--
-- Indexes for table `message`
--
ALTER TABLE `message`
  ADD PRIMARY KEY (`messageId`),
  ADD KEY `senderId` (`senderId`),
  ADD KEY `receiverId` (`receiverId`);

--
-- Indexes for table `paymentdetails`
--
ALTER TABLE `paymentdetails`
  ADD PRIMARY KEY (`invoiceId`),
  ADD KEY `transactionId` (`transactionId`);

--
-- Indexes for table `service`
--
ALTER TABLE `service`
  ADD PRIMARY KEY (`serviceId`),
  ADD UNIQUE KEY `serviceType` (`serviceType`);

--
-- Indexes for table `service_provider`
--
ALTER TABLE `service_provider`
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `contactNumber` (`contactNumber`),
  ADD KEY `spId` (`spId`);

--
-- Indexes for table `sp_service`
--
ALTER TABLE `sp_service`
  ADD KEY `serviceId` (`serviceId`),
  ADD KEY `spId` (`spId`);

--
-- Indexes for table `transaction`
--
ALTER TABLE `transaction`
  ADD PRIMARY KEY (`transactionId`),
  ADD KEY `transaction_ibfk_1` (`bookingId`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`idNum`),
  ADD UNIQUE KEY `USERNAME` (`userName`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `booking`
--
ALTER TABLE `booking`
  MODIFY `bookingId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
--
-- AUTO_INCREMENT for table `feedback`
--
ALTER TABLE `feedback`
  MODIFY `feedbackId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `message`
--
ALTER TABLE `message`
  MODIFY `messageId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;
--
-- AUTO_INCREMENT for table `paymentdetails`
--
ALTER TABLE `paymentdetails`
  MODIFY `invoiceId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `service`
--
ALTER TABLE `service`
  MODIFY `serviceId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `transaction`
--
ALTER TABLE `transaction`
  MODIFY `transactionId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `idNum` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `admin`
--
ALTER TABLE `admin`
  ADD CONSTRAINT `admin_user_fk` FOREIGN KEY (`adminId`) REFERENCES `user` (`idNum`) ON UPDATE CASCADE;

--
-- Constraints for table `booking`
--
ALTER TABLE `booking`
  ADD CONSTRAINT `booking_ibfk_1` FOREIGN KEY (`custId`) REFERENCES `customer` (`custId`),
  ADD CONSTRAINT `booking_ibfk_2` FOREIGN KEY (`spId`) REFERENCES `service_provider` (`spId`),
  ADD CONSTRAINT `booking_ibfk_3` FOREIGN KEY (`serviceId`) REFERENCES `service` (`serviceId`);

--
-- Constraints for table `customer`
--
ALTER TABLE `customer`
  ADD CONSTRAINT `customer_user_fk` FOREIGN KEY (`custId`) REFERENCES `user` (`idNum`);

--
-- Constraints for table `feedback`
--
ALTER TABLE `feedback`
  ADD CONSTRAINT `feedback_ibfk_1` FOREIGN KEY (`custId`) REFERENCES `customer` (`custId`),
  ADD CONSTRAINT `feedback_ibfk_2` FOREIGN KEY (`spId`) REFERENCES `service_provider` (`spId`),
  ADD CONSTRAINT `feedback_ibfk_3` FOREIGN KEY (`transactionId`) REFERENCES `transaction` (`transactionId`);

--
-- Constraints for table `message`
--
ALTER TABLE `message`
  ADD CONSTRAINT `msg_rec_fk` FOREIGN KEY (`receiverId`) REFERENCES `user` (`idNum`) ON UPDATE CASCADE,
  ADD CONSTRAINT `msg_sender_fk` FOREIGN KEY (`senderId`) REFERENCES `user` (`idNum`) ON UPDATE CASCADE;

--
-- Constraints for table `paymentdetails`
--
ALTER TABLE `paymentdetails`
  ADD CONSTRAINT `paymentdetails_ibfk_1` FOREIGN KEY (`transactionId`) REFERENCES `transaction` (`transactionId`);

--
-- Constraints for table `service_provider`
--
ALTER TABLE `service_provider`
  ADD CONSTRAINT `sp_user_fk` FOREIGN KEY (`spId`) REFERENCES `user` (`idNum`) ON UPDATE CASCADE;

--
-- Constraints for table `sp_service`
--
ALTER TABLE `sp_service`
  ADD CONSTRAINT `spserv_service_fk` FOREIGN KEY (`serviceId`) REFERENCES `service` (`serviceId`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `spserv_sp_fk` FOREIGN KEY (`spId`) REFERENCES `service_provider` (`spId`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `transaction`
--
ALTER TABLE `transaction`
  ADD CONSTRAINT `transaction_ibfk_1` FOREIGN KEY (`bookingId`) REFERENCES `booking` (`bookingId`) ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
