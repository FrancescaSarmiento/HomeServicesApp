-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 26, 2017 at 02:30 AM
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
  `pasword` varchar(20) NOT NULL,
  `address` varchar(30) NOT NULL,
  `email` varchar(30) DEFAULT NULL,
  `contactNumber` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`customerNumber`, `firstName`, `lastName`, `userName`, `pasword`, `address`, `email`, `contactNumber`) VALUES
(1, 'Jerome', 'Del Rosario', 'Muzhnik', 'password', 'City Camp Alley, Baguio City', 'jeromed.pepper@gmail.com', '09153478922'),
(2, 'Dadula', 'Jason Paul', 'Jay', 'password', 'Baguio City', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `message`
--

CREATE TABLE `message` (
  `messageNumber` int(11) NOT NULL,
  `messageBody` text NOT NULL,
  `customerNumber` int(11) NOT NULL,
  `spNumber` int(11) NOT NULL,
  `sendTo` enum('customer','sp') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `service`
--

CREATE TABLE `service` (
  `serviceNumber` int(11) NOT NULL,
  `serviceType` enum('Repair','Assembly/Installation','Electrical','Painting','Plumbing') NOT NULL,
  `specification` text NOT NULL,
  `Price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `service`
--

INSERT INTO `service` (`serviceNumber`, `serviceType`, `specification`, `Price`) VALUES
(1, 'Repair', 'Roof repairs', 500),
(2, 'Plumbing', 'Toilet', 750),
(3, 'Assembly/Installation', 'ikea table', 500),
(4, 'Electrical', 'rewiring', 550);

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
  `email` varchar(30) NOT NULL,
  `contactNumber` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `service_provider`
--

INSERT INTO `service_provider` (`spNumber`, `firstName`, `lastName`, `userName`, `password`, `email`, `contactNumber`) VALUES
(1, 'Lexington', 'Steele', 'bigdaddylex23', 'password', 'lexington@hotmail.com', '09123456789'),
(2, 'Zebedee', 'Jimenez', 'bhosx_zeb', 'password', '2150936@slu.edu.ph', '09123456789');

-- --------------------------------------------------------

--
-- Table structure for table `sp_service`
--

CREATE TABLE `sp_service` (
  `spNumber` int(11) NOT NULL,
  `serviceNumber` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sp_service`
--

INSERT INTO `sp_service` (`spNumber`, `serviceNumber`) VALUES
(1, 1),
(1, 2),
(2, 1),
(2, 4);

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

CREATE TABLE `transaction` (
  `transactionNumber` int(11) NOT NULL,
  `customerNumber` int(11) NOT NULL,
  `spNumber` int(11) NOT NULL,
  `serviceNumber` int(11) NOT NULL,
  `date_started` date NOT NULL,
  `date_finished` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customerNumber`),
  ADD UNIQUE KEY `customerNumber` (`customerNumber`,`userName`,`email`);

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
  ADD PRIMARY KEY (`serviceNumber`);

--
-- Indexes for table `service_provider`
--
ALTER TABLE `service_provider`
  ADD PRIMARY KEY (`spNumber`),
  ADD UNIQUE KEY `spNumber` (`spNumber`,`userName`,`email`);

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
-- Constraints for dumped tables
--

--
-- Constraints for table `message`
--
ALTER TABLE `message`
  ADD CONSTRAINT `customer_message_fk` FOREIGN KEY (`customerNumber`) REFERENCES `customer` (`customerNumber`) ON UPDATE CASCADE,
  ADD CONSTRAINT `sp_message_fk` FOREIGN KEY (`spNumber`) REFERENCES `service_provider` (`spNumber`) ON UPDATE CASCADE;

--
-- Constraints for table `sp_service`
--
ALTER TABLE `sp_service`
  ADD CONSTRAINT `service_fk` FOREIGN KEY (`serviceNumber`) REFERENCES `service` (`serviceNumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `sp_fk` FOREIGN KEY (`spNumber`) REFERENCES `service_provider` (`spNumber`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `transaction`
--
ALTER TABLE `transaction`
  ADD CONSTRAINT `customer_transaction_fk` FOREIGN KEY (`customerNumber`) REFERENCES `customer` (`customerNumber`) ON UPDATE CASCADE,
  ADD CONSTRAINT `service_transaction_fk` FOREIGN KEY (`serviceNumber`) REFERENCES `service` (`serviceNumber`) ON UPDATE CASCADE,
  ADD CONSTRAINT `sp_transaction_fk` FOREIGN KEY (`spNumber`) REFERENCES `service_provider` (`spNumber`) ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
