-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 24, 2026 at 06:00 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `inventory_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` bigint(20) NOT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `full_name`, `password`, `username`) VALUES
(1, 'System Administrator', '24RP11469', '24RP06444');

-- --------------------------------------------------------

--
-- Table structure for table `asset`
--

CREATE TABLE `asset` (
  `id` bigint(20) NOT NULL,
  `brand` varchar(255) DEFAULT NULL,
  `condition_status` varchar(255) DEFAULT NULL,
  `device_type` varchar(255) DEFAULT NULL,
  `model` varchar(255) DEFAULT NULL,
  `purchase_date` date DEFAULT NULL,
  `serial_number` varchar(255) DEFAULT NULL,
  `specifications` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `tag_number` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `asset`
--

INSERT INTO `asset` (`id`, `brand`, `condition_status`, `device_type`, `model`, `purchase_date`, `serial_number`, `specifications`, `status`, `tag_number`) VALUES
(1, 'mugema', 'Good', 'Mobile Phone', 'ifone', '2026-04-24', '', 'welcome', 'Available', '12'),
(2, 'congo', 'Poor', 'Laptop', 'eleven', '2026-04-24', '12345', 'nice one', 'Available', '11'),
(3, 'aitel', 'Fair', 'Laptop', 'Core i3', '2026-04-07', 'SN-23454', '8GB', 'Available', 'AST-002'),
(4, 'Techno', 'Good', 'Mobile Phone', 'techno canon', '2026-04-25', 'SN-23423', '8GB,180PX HD ', 'Assigned', 'AST-012');

-- --------------------------------------------------------

--
-- Table structure for table `assignment`
--

CREATE TABLE `assignment` (
  `id` bigint(20) NOT NULL,
  `assigned_date` date DEFAULT NULL,
  `department` varchar(255) DEFAULT NULL,
  `employee_name` varchar(255) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `return_date` date DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `asset_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `assignment`
--

INSERT INTO `assignment` (`id`, `assigned_date`, `department`, `employee_name`, `remarks`, `return_date`, `status`, `asset_id`) VALUES
(1, '2026-04-24', 'service', 'mugema ', '12', NULL, 'Active', 1),
(4, '2026-04-24', 'IT', 'IGIRANEZA Regis', '60', '2026-04-24', 'Returned', 2),
(5, '2026-04-24', 'IT', ' Regis', '', '2026-04-24', 'Returned', 3),
(6, '2026-04-24', 'HR', 'UWIMBABAZI OLIVE', '67', NULL, 'Active', 4);

-- --------------------------------------------------------

--
-- Table structure for table `audit_log`
--

CREATE TABLE `audit_log` (
  `id` bigint(20) NOT NULL,
  `action` varchar(255) DEFAULT NULL,
  `action_date` datetime(6) DEFAULT NULL,
  `details` varchar(255) DEFAULT NULL,
  `performed_by` varchar(255) DEFAULT NULL,
  `asset_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `audit_log`
--

INSERT INTO `audit_log` (`id`, `action`, `action_date`, `details`, `performed_by`, `asset_id`) VALUES
(1, 'Registered', '2026-04-22 22:20:22.000000', 'Asset details added', 'System Administrator', 1),
(2, 'Registered', '2026-04-22 22:22:05.000000', 'Asset details added', 'System Administrator', 2),
(3, 'Updated', '2026-04-24 13:29:10.000000', 'Asset details updated', 'System Administrator', 1),
(4, 'Assigned', '2026-04-24 13:37:25.000000', 'Assigned to mugema  (service)', 'System Administrator', 1),
(5, 'Returned', '2026-04-24 13:38:07.000000', 'Returned by mugema ', 'System Administrator', 1),
(6, 'Assigned', '2026-04-24 14:42:07.000000', 'Assigned to IGIRANEZA Regis (IT)', 'System Administrator', 2),
(7, 'Deleted Assignment', '2026-04-24 14:52:28.000000', 'Deleted assignment for mugema ', 'System Administrator', 1),
(8, 'Registered', '2026-04-24 14:53:33.000000', 'Asset details added', 'System Administrator', 3),
(9, 'Assigned', '2026-04-24 14:54:42.000000', 'Assigned to  Regis (IT)', 'System Administrator', 3),
(10, 'Deleted Assignment', '2026-04-24 14:55:10.000000', 'Deleted assignment for mugema ', 'System Administrator', 1),
(11, 'Returned', '2026-04-24 14:56:37.000000', 'Returned by IGIRANEZA Regis', 'System Administrator', 2),
(12, 'Registered', '2026-04-24 15:58:06.000000', 'Asset details added', 'System Administrator', 4),
(13, 'Updated', '2026-04-24 15:58:21.000000', 'Asset details updated', 'System Administrator', 4),
(14, 'Updated', '2026-04-24 15:58:45.000000', 'Asset details updated', 'System Administrator', 4),
(15, 'Assigned', '2026-04-24 15:59:43.000000', 'Assigned to UWIMBABAZI OLIVE (HR)', 'System Administrator', 4),
(16, 'Returned', '2026-04-24 15:59:56.000000', 'Returned by  Regis', 'System Administrator', 3);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UK_gfn44sntic2k93auag97juyij` (`username`);

--
-- Indexes for table `asset`
--
ALTER TABLE `asset`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UK_7ibor876cho756afxko4y98cs` (`tag_number`);

--
-- Indexes for table `assignment`
--
ALTER TABLE `assignment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKp4xufrrwsc72xaffg2yv1hiu1` (`asset_id`);

--
-- Indexes for table `audit_log`
--
ALTER TABLE `audit_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK2xbe143hi0uddjujkiy3jtqpl` (`asset_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `asset`
--
ALTER TABLE `asset`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `assignment`
--
ALTER TABLE `assignment`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `audit_log`
--
ALTER TABLE `audit_log`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `assignment`
--
ALTER TABLE `assignment`
  ADD CONSTRAINT `FKp4xufrrwsc72xaffg2yv1hiu1` FOREIGN KEY (`asset_id`) REFERENCES `asset` (`id`);

--
-- Constraints for table `audit_log`
--
ALTER TABLE `audit_log`
  ADD CONSTRAINT `FK2xbe143hi0uddjujkiy3jtqpl` FOREIGN KEY (`asset_id`) REFERENCES `asset` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
