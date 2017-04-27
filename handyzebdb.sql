-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 27, 2017 at 12:38 PM
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
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `customerNumber` int(11) NOT NULL,
  `firstName` varchar(30) NOT NULL,
  `lastName` varchar(30) NOT NULL,
  `userName` varchar(15) NOT NULL,
  `password` varchar(20) NOT NULL,
  `address` varchar(50) NOT NULL,
  `email` varchar(30) DEFAULT NULL,
  `contactNumber` varchar(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`customerNumber`, `firstName`, `lastName`, `userName`, `password`, `address`, `email`, `contactNumber`, `status`) VALUES
(1, 'Jerome', 'Del Rosario', 'Muzhnik', 'password', 'City Camp Alley, Baguio City', 'jeromed.pepper@gmail.com', '09153478922', 1),
(2, 'Jay', 'Dadula', 'Jay', 'password', 'Baguio City', NULL, '09123456789', 1),
(3, 'Michael', 'Rivera', 'Shiru', 'password', 'Baguio City', NULL, '09098765432', 1),
(4, 'Rio Vann', 'Kolodzik', 'MVLE', 'password', 'Baguio City', NULL, '09090909090', 1),
(5, 'Josepablo', 'David', 'PPJJ', 'password', 'Baguio City', NULL, '09154893264', 1),
(6, 'David Wyatt', 'Cardenas', 'Moo Man', 'password', 'Baguio City', NULL, '09053216547', 1),
(7, 'Hiromi', 'Uematsu', 'Japan420', 'password', 'Ching Chong, Japan', '', '09156669999', 1),
(8, 'Samantha', 'Lopez', 'samiam', 'password', 'Baguio City', NULL, '09124563219', 1),
(9, 'Miggy', 'Sarmiento', 'Miggy2321241', 'password', 'Baguio City', NULL, '09159874561', 1);

-- --------------------------------------------------------

--
-- Table structure for table `message`
--

CREATE TABLE `message` (
  `messageNumber` int(11) NOT NULL,
  `messageBody` text NOT NULL,
  `customerNumber` int(11) NOT NULL,
  `spNumber` int(11) NOT NULL,
  `sendTo` enum('cust','sp') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `service`
--

CREATE TABLE `service` (
  `serviceNumber` int(11) NOT NULL,
  `serviceType` enum('Assembly/Installation','Repair','Plumbing','Electrical','Painting','Carpentry','Remodeling') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `service`
--

INSERT INTO `service` (`serviceNumber`, `serviceType`) VALUES
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
  `spNumber` int(11) NOT NULL,
  `firstName` varchar(30) NOT NULL,
  `lastName` varchar(30) NOT NULL,
  `userName` varchar(15) NOT NULL,
  `password` varchar(20) NOT NULL,
  `email` varchar(30) DEFAULT NULL,
  `contactNumber` varchar(11) NOT NULL,
  `availability` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `service_provider`
--

INSERT INTO `service_provider` (`spNumber`, `firstName`, `lastName`, `userName`, `password`, `email`, `contactNumber`, `availability`) VALUES
(1, 'James', 'Deen', 'jaaaaaymes', 'password', NULL, '1', 1),
(2, 'Mick', 'Blue', 'blubols29', 'password', NULL, '5', 1),
(3, 'Mr', 'Pete', 'asspire', 'password', NULL, '545', 1),
(4, 'Mr', 'Marcus', 'marcusindahouse', 'password', NULL, '6549', 1),
(5, 'Peter', 'North', 'pyter', 'password', NULL, '69', 1),
(6, 'Evan', 'Stone', 'mercurydrug', 'password', NULL, '89', 1),
(7, 'Rocco', 'Siffredi', 'RoccoLocco', 'password', NULL, '465987', 1),
(8, 'Lexington', 'Steele', 'daddysteele', 'password', NULL, '321', 1),
(9, 'Zebedee', 'Jimenez', 'bhosx_zeb', 'password', NULL, '78985612', 1),
(10, 'Johnny', 'Sins', 'heresjohny61', 'password', NULL, '09991234567', 1);

-- --------------------------------------------------------

--
-- Table structure for table `sp_service`
--

CREATE TABLE `sp_service` (
  `spNumber` int(11) NOT NULL,
  `serviceNumber` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sp_service`
--

INSERT INTO `sp_service` (`spNumber`, `serviceNumber`) VALUES
(1, 1),
(1, 3),
(1, 4),
(1, 7),
(2, 5),
(2, 1),
(2, 4),
(3, 6),
(4, 5),
(4, 4),
(5, 7),
(5, 1),
(5, 2),
(6, 6),
(6, 1),
(6, 3),
(7, 2),
(7, 1),
(7, 3),
(7, 4),
(7, 5),
(7, 6),
(7, 7),
(8, 2),
(8, 1),
(8, 4),
(9, 2),
(9, 5),
(9, 4);

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

CREATE TABLE `transaction` (
  `transactionNumber` int(11) NOT NULL,
  `customerNumber` int(11) NOT NULL,
  `spNumber` int(11) DEFAULT NULL,
  `serviceNumber` int(11) NOT NULL,
  `specification` text NOT NULL,
  `status` enum('Request Pending','Ongoing','Finished') NOT NULL,
  `date_started` timestamp NOT NULL,
  `date_finished` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customerNumber`),
  ADD UNIQUE KEY `USERNAME` (`userName`),
  ADD UNIQUE KEY `CONTACTNUMBER` (`contactNumber`);

--
-- Indexes for table `message`
--
ALTER TABLE `message`
  ADD PRIMARY KEY (`messageNumber`),
  ADD KEY `customerNumber` (`customerNumber`),
  ADD KEY `spNumber` (`spNumber`);

--
-- Indexes for table `service`
--
ALTER TABLE `service`
  ADD PRIMARY KEY (`serviceNumber`),
  ADD UNIQUE KEY `TYPE` (`serviceType`);

--
-- Indexes for table `service_provider`
--
ALTER TABLE `service_provider`
  ADD PRIMARY KEY (`spNumber`),
  ADD UNIQUE KEY `USERNAME` (`userName`),
  ADD UNIQUE KEY `CONTACTNUMBER` (`contactNumber`);

--
-- Indexes for table `sp_service`
--
ALTER TABLE `sp_service`
  ADD KEY `spNumber` (`spNumber`),
  ADD KEY `serviceNumber` (`serviceNumber`);

--
-- Indexes for table `transaction`
--
ALTER TABLE `transaction`
  ADD PRIMARY KEY (`transactionNumber`),
  ADD KEY `customerNumber` (`customerNumber`),
  ADD KEY `spNumber` (`spNumber`),
  ADD KEY `serviceNumber` (`serviceNumber`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `customerNumber` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `message`
--
ALTER TABLE `message`
  MODIFY `messageNumber` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `service`
--
ALTER TABLE `service`
  MODIFY `serviceNumber` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `service_provider`
--
ALTER TABLE `service_provider`
  MODIFY `spNumber` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `transaction`
--
ALTER TABLE `transaction`
  MODIFY `transactionNumber` int(11) NOT NULL AUTO_INCREMENT;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `message`
--
ALTER TABLE `message`
  ADD CONSTRAINT `message_customer_fk` FOREIGN KEY (`customerNumber`) REFERENCES `customer` (`customerNumber`) ON UPDATE CASCADE,
  ADD CONSTRAINT `message_sp_fk` FOREIGN KEY (`spNumber`) REFERENCES `service_provider` (`spNumber`) ON UPDATE CASCADE;

--
-- Constraints for table `sp_service`
--
ALTER TABLE `sp_service`
  ADD CONSTRAINT `spserv_service_fk` FOREIGN KEY (`serviceNumber`) REFERENCES `service` (`serviceNumber`) ON UPDATE CASCADE,
  ADD CONSTRAINT `spserv_sp_fk` FOREIGN KEY (`spNumber`) REFERENCES `service_provider` (`spNumber`) ON UPDATE CASCADE;

--
-- Constraints for table `transaction`
--
ALTER TABLE `transaction`
  ADD CONSTRAINT `transaction_cust_fk` FOREIGN KEY (`customerNumber`) REFERENCES `customer` (`customerNumber`) ON UPDATE CASCADE,
  ADD CONSTRAINT `transaction_service_fk` FOREIGN KEY (`serviceNumber`) REFERENCES `service` (`serviceNumber`) ON UPDATE CASCADE,
  ADD CONSTRAINT `transaction_sp_fk` FOREIGN KEY (`spNumber`) REFERENCES `service_provider` (`spNumber`) ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
