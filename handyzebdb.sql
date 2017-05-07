-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 04, 2017 at 12:43 PM
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

-- --------------------------------------------------------

--
-- Table structure for table `service`
--

CREATE TABLE `service` (
  `serviceId` int(11) NOT NULL,
  `serviceType` enum('Assembly/Installation','Repair','Plumbing','Electrical','Painting','Carpentry','Remodeling') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
  `rating` enum('1','2','3','4','5') DEFAULT NULL,
  `availability` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sp_service`
--

CREATE TABLE `sp_service` (
  `serviceId` int(11) NOT NULL,
  `spId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

CREATE TABLE `transaction` (
  `transactionId` int(11) NOT NULL,
  `customerId` int(11) NOT NULL,
  `spId` int(11) NOT NULL,
  `serviceId` int(11) NOT NULL,
  `specification` text NOT NULL,
  `status` enum('Assembly/Installation','Repair','Plumbing','Electrical','Painting','Carpentry','Remodeling') NOT NULL,
  `date_started` datetime NOT NULL,
  `date_finished` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `idNum` int(11) NOT NULL,
  `userName` varchar(15) NOT NULL,
  `password` varchar(20) NOT NULL,
  `userType` enum('Administrator','Customer','Service Provider') NOT NULL,
  `status` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD UNIQUE KEY `email_2` (`email`),
  ADD UNIQUE KEY `CONTACTNUMBER` (`contactNumber`),
  ADD KEY `CUSTOMERID` (`custId`),
  ADD KEY `EMAIL` (`email`);

--
-- Indexes for table `message`
--
ALTER TABLE `message`
  ADD PRIMARY KEY (`messageId`),
  ADD KEY `senderId` (`senderId`),
  ADD KEY `receiverId` (`receiverId`);

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
  ADD KEY `customerId` (`customerId`),
  ADD KEY `spId` (`spId`),
  ADD KEY `serviceId` (`serviceId`);

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
-- AUTO_INCREMENT for table `message`
--
ALTER TABLE `message`
  MODIFY `messageId` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `service`
--
ALTER TABLE `service`
  MODIFY `serviceId` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `transaction`
--
ALTER TABLE `transaction`
  MODIFY `transactionId` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `idNum` int(11) NOT NULL AUTO_INCREMENT;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `admin`
--
ALTER TABLE `admin`
  ADD CONSTRAINT `admin_user_fk` FOREIGN KEY (`adminId`) REFERENCES `user` (`idNum`) ON UPDATE CASCADE;

--
-- Constraints for table `customer`
--
ALTER TABLE `customer`
  ADD CONSTRAINT `customer_user_fk` FOREIGN KEY (`custId`) REFERENCES `user` (`idNum`);

--
-- Constraints for table `message`
--
ALTER TABLE `message`
  ADD CONSTRAINT `msg_rec_fk` FOREIGN KEY (`receiverId`) REFERENCES `user` (`idNum`) ON UPDATE CASCADE,
  ADD CONSTRAINT `msg_sender_fk` FOREIGN KEY (`senderId`) REFERENCES `user` (`idNum`) ON UPDATE CASCADE;

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
  ADD CONSTRAINT `tran_cust_fk` FOREIGN KEY (`customerId`) REFERENCES `customer` (`custId`) ON UPDATE CASCADE,
  ADD CONSTRAINT `tran_serv_fk` FOREIGN KEY (`serviceId`) REFERENCES `service` (`serviceId`) ON UPDATE CASCADE,
  ADD CONSTRAINT `tran_sp_fk` FOREIGN KEY (`spId`) REFERENCES `service_provider` (`spId`) ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
