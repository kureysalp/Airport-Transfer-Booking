-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1
-- Üretim Zamanı: 10 Şub 2020, 16:36:22
-- Sunucu sürümü: 10.4.8-MariaDB
-- PHP Sürümü: 7.3.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `dama_taxi_db`
--

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `bookings`
--

CREATE TABLE `bookings` (
  `bookingID` int(11) NOT NULL,
  `transfer_date` varchar(15) NOT NULL,
  `transfer_time` time NOT NULL,
  `flightNumber` varchar(10) NOT NULL,
  `from_dest` varchar(100) NOT NULL,
  `to_dest` varchar(100) NOT NULL,
  `passengers` int(11) NOT NULL,
  `luggage` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `vehicle` varchar(20) NOT NULL,
  `price` int(11) NOT NULL,
  `is_return` varchar(15) NOT NULL,
  `submit_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Tablo döküm verisi `bookings`
--

INSERT INTO `bookings` (`bookingID`, `transfer_date`, `transfer_time`, `flightNumber`, `from_dest`, `to_dest`, `passengers`, `luggage`, `name`, `email`, `phone`, `vehicle`, `price`, `is_return`, `submit_date`) VALUES
(10080, '02 Jan 2020', '02:30:00', 'tk123', 'Fatih', 'Istanbul Airport (IST)', 2, 2, 'aaa', 'a', '222', 'Economy', 34, 'No', '2020-01-30 13:48:33'),
(10081, '04 Jan 2020', '03:45:00', 'tk123', 'Fatih', 'Istanbul Airport (IST)', 1, 1, 'alp', 'kureysalp@gmail.com', '545455', 'Economy', 34, 'No', '2020-01-30 13:54:29'),
(10082, '17 Jan 2020', '04:15:00', 'tk123', 'Fatih', 'Istanbul Airport (IST)', 1, 1, 'alp', 'kureysalp@gmail.com', '555', 'Economy', 34, 'No', '2020-01-30 13:55:41'),
(10083, '03 Jan 2020', '03:30:00', 'tk123', 'Fatih', 'Istanbul Airport (IST)', 1, 1, 'alp', 'kureysalp@gmail.com', '54655', 'Economy', 34, 'No', '2020-01-30 13:56:59'),
(10084, '03 Jan 2020', '03:30:00', 'tk123', 'Fatih', 'Istanbul Airport (IST)', 1, 1, 'alp', 'kureysalp@gmail.com', '54655', 'Economy', 68, 'Yes', '2020-01-30 13:58:00'),
(10085, '09 Jan 2020', '00:00:00', '-', 'Istanbul Airport (IST)', 'Fatih', 1, 1, 'alp', 'kureysalp@gmail.com', '54655', 'Economy', 68, 'RETURN TRANSFER', '2020-01-30 13:58:00'),
(10086, '11 Jan 2020', '00:30:00', 'TK123', 'Fatih', 'Istanbul Airport (IST)', 2, 3, 'ALP', 'kureysalp@gmail.com', '555555', 'Comfort', 36, 'No', '2020-01-31 13:01:24'),
(10087, '16 Jan 2020', '00:45:00', 'TK123', 'Fatih', 'Istanbul Airport (IST)', 2, 3, 'ALP', 'kureysalp@gmail.com', '555555', 'Comfort', 36, 'No', '2020-01-31 13:03:04'),
(10088, '17 Jan 2020', '01:45:00', 'TK123', 'Fatih', 'Istanbul Airport (IST)', 2, 3, 'ALP', 'kureysalp@gmail.com', '555555', 'Comfort', 36, 'No', '2020-01-31 13:04:05'),
(10089, '03 Jan 2020', '00:30:00', 'tk123', 'Fatih', 'Istanbul Airport (IST)', 1, 1, 'a', 'kureysalp@gmail.com', '4', 'Comfort', 36, 'No', '2020-01-31 13:04:37'),
(10090, '08 Jan 2020', '04:00:00', 'sd', 'Fatih', 'Istanbul Airport (IST)', 1, 1, 'alp', 'kureysalp@gmail.com', '123', 'Comfort', 36, 'No', '2020-01-31 13:05:08'),
(10091, '07 Jan 2020', '01:00:00', 'tk123', 'Fatih', 'Istanbul Airport (IST)', 1, 1, 'alp', 'kureysalp@gmail.com', '444', 'Comfort', 72, 'Yes', '2020-01-31 13:20:51'),
(10092, '01 Jan 2020', '00:00:00', '-', 'Istanbul Airport (IST)', 'Fatih', 1, 1, 'alp', 'kureysalp@gmail.com', '444', 'Comfort', 72, 'RETURN TRANSFER', '2020-01-31 13:20:51'),
(10093, '15 Jan 2020', '01:15:00', 'tk123', 'Fatih', 'Istanbul Airport (IST)', 1, 1, 'alp', 'kureysalp@gmail.com', '444', 'Comfort', 36, 'Yes', '2020-01-31 13:22:40'),
(10094, '16 Jan 2020', '00:00:00', '-', 'Istanbul Airport (IST)', 'Fatih', 1, 1, 'alp', 'kureysalp@gmail.com', '444', 'Comfort', 36, 'RETURN TRANSFER', '2020-01-31 13:22:40'),
(10095, '16 Jan 2020', '03:45:00', 'tk123', 'Fatih', 'Istanbul Airport (IST)', 2, 3, 'aa', 'kureysalp@gmail.com', '5445', 'Comfort', 72, 'Yes', '2020-01-31 13:39:57'),
(10096, '15 Jan 2020', '03:30:00', '-', 'Istanbul Airport (IST)', 'Fatih', 2, 3, 'aa', 'kureysalp@gmail.com', '5445', 'Comfort', 72, 'RETURN TRANSFER', '2020-01-31 13:39:57'),
(10097, '16 Jan 2020', '03:00:00', 'tk123', 'Fatih', 'Istanbul Airport (IST)', 2, 3, 'aa', 'kureysalp@gmail.com', '222', 'Comfort', 72, 'Yes', '2020-01-31 13:40:38'),
(10098, '23 Jan 2020', '00:30:00', '-', 'Istanbul Airport (IST)', 'Fatih', 2, 3, 'aa', 'kureysalp@gmail.com', '222', 'Comfort', 72, 'RETURN TRANSFER', '2020-01-31 13:40:38'),
(10099, '09 Jan 2020', '03:45:00', 't123', 'Fatih', 'Istanbul Airport (IST)', 2, 3, 'aa', 'kureysalp@gmail.com', '5554', 'Comfort', 80, 'Yes', '2020-01-31 14:46:23'),
(10100, '23 Jan 2020', '04:00:00', '-', 'Istanbul Airport (IST)', 'Fatih', 2, 3, 'aa', 'kureysalp@gmail.com', '5554', 'Comfort', 40, 'RETURN TRANSFER', '2020-01-31 14:46:23'),
(10101, '14 Feb 2020', '02:00:00', 'tk123', 'Fatih', 'Atrium Alışveriş Merkezi', 2, 2, 'alp', 'kureysalp@gmail.com', '5555555555', 'Economy', 34, 'No', '2020-02-10 14:18:04'),
(10102, '13 Feb 2020', '00:30:00', 'tk123', 'Fatih', 'Atrium Alışveriş Merkezi', 2, 2, 'alp', 'kureysalp@gmail.com', '5555555555', 'Economy', 34, 'No', '2020-02-10 14:19:39'),
(10103, '06 Feb 2020', '00:45:00', 'tk123', 'Fatih', 'Atrium Alışveriş Merkezi', 2, 2, 'alp', 'kureysalp@gmail.com', '5555555555', 'Economy', 34, 'No', '2020-02-10 14:22:36'),
(10104, '11 Feb 2020', '00:45:00', 'tk123', 'Fatih', 'Atrium Alışveriş Merkezi', 2, 2, 'alp', 'kureysalp@gmail.com', '5555555555', 'Economy', 34, 'No', '2020-02-10 14:25:29'),
(10105, '01 Feb 2020', '00:45:00', 'tk123', 'Fatih', 'Atrium Alışveriş Merkezi', 2, 2, 'alp', 'kureysalp@gmail.com', '5555555555', 'Economy', 34, 'No', '2020-02-10 14:28:36'),
(10106, '08 Feb 2020', '01:00:00', 'tk123', 'Fatih', 'Atrium Alışveriş Merkezi', 1, 1, 'alp', 'kureysalp@gmail.com', '5455555555', 'Economy', 34, 'No', '2020-02-10 14:30:12'),
(10107, '08 Feb 2020', '01:00:00', 'tk123', 'Fatih', 'Atrium Alışveriş Merkezi', 1, 1, 'alp', 'kureysalp@gmail.com', '5455555555', 'Economy', 34, 'No', '2020-02-10 14:30:46'),
(10108, '14 Feb 2020', '01:00:00', 'tk123', 'Fatih', 'Atrium Alışveriş Merkezi', 1, 1, 'alp', 'kureysalp@gmail.com', '555555555', 'Economy', 34, 'No', '2020-02-10 14:33:11'),
(10109, '20 Feb 2020', '00:45:00', 'tk13', 'Fatih', 'Atrium Alışveriş Merkezi', 1, 1, 'alp', 'kureysalp@gmail.com', '5454545', 'Economy', 34, 'No', '2020-02-10 14:36:01'),
(10110, '20 Feb 2020', '00:45:00', 'tk13', 'Fatih', 'Atrium Alışveriş Merkezi', 1, 1, 'alp', 'kureysalp@gmail.com', '5454545', 'Economy', 34, 'No', '2020-02-10 14:39:28'),
(10111, '20 Feb 2020', '00:45:00', 'tk13', 'Fatih', 'Atrium Alışveriş Merkezi', 1, 1, 'alp', 'kureysalp@gmail.com', '5454545', 'Economy', 34, 'No', '2020-02-10 14:41:11'),
(10112, '20 Feb 2020', '00:45:00', 'tk13', 'Fatih', 'Atrium Alışveriş Merkezi', 1, 1, 'alp', 'kureysalp@gmail.com', '5454545', 'Economy', 34, 'No', '2020-02-10 14:41:47'),
(10113, '20 Feb 2020', '00:45:00', 'tk13', 'Fatih', 'Atrium Alışveriş Merkezi', 1, 1, 'alp', 'kureysalp@gmail.com', '5454545', 'Economy', 34, 'No', '2020-02-10 14:41:55'),
(10114, '20 Feb 2020', '00:45:00', 'tk13', 'Fatih', 'Atrium Alışveriş Merkezi', 1, 1, 'alp', 'kureysalp@gmail.com', '5454545', 'Economy', 34, 'No', '2020-02-10 14:43:22'),
(10115, '20 Feb 2020', '00:45:00', 'tk13', 'Fatih', 'Atrium Alışveriş Merkezi', 1, 1, 'alp', 'kureysalp@gmail.com', '5454545', 'Economy', 34, 'No', '2020-02-10 14:43:28'),
(10116, '20 Feb 2020', '00:45:00', 'tk13', 'Fatih', 'Atrium Alışveriş Merkezi', 1, 1, 'alp', 'kureysalp@gmail.com', '5454545', 'Economy', 34, 'No', '2020-02-10 14:44:28'),
(10117, '20 Feb 2020', '00:45:00', 'tk13', 'Fatih', 'Atrium Alışveriş Merkezi', 1, 1, 'alp', 'kureysalp@gmail.com', '5454545', 'Economy', 34, 'No', '2020-02-10 14:44:30');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `packages`
--

CREATE TABLE `packages` (
  `package_ID` int(11) NOT NULL,
  `vehicle_Name` varchar(20) NOT NULL,
  `brand` varchar(60) NOT NULL,
  `pax` int(11) NOT NULL,
  `bags` int(11) NOT NULL,
  `image_URL` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Tablo döküm verisi `packages`
--

INSERT INTO `packages` (`package_ID`, `vehicle_Name`, `brand`, `pax`, `bags`, `image_URL`) VALUES
(1, 'Economy', 'Renault Megan, Wolksvagen Jetta, Skoda Octavia', 2, 2, 'images/sedan.png'),
(3, 'Comfort', 'Ford Focus, Wolksvagen Passat', 3, 3, 'images/e-class.png'),
(4, 'Minivan', 'Mercedes Vito', 7, 7, 'images/minivan.png'),
(5, 'Premium Minibus', 'Mercedes V-Class', 7, 7, 'images/vito.png'),
(6, 'Minibus', 'Mercedes Sprinter', 15, 15, 'images/sprinter.png'),
(7, 'Premium', 'Mercedes E-Class', 2, 2, 'images/vip.png');

--
-- Dökümü yapılmış tablolar için indeksler
--

--
-- Tablo için indeksler `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`bookingID`);

--
-- Tablo için indeksler `packages`
--
ALTER TABLE `packages`
  ADD PRIMARY KEY (`package_ID`);

--
-- Dökümü yapılmış tablolar için AUTO_INCREMENT değeri
--

--
-- Tablo için AUTO_INCREMENT değeri `bookings`
--
ALTER TABLE `bookings`
  MODIFY `bookingID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10118;

--
-- Tablo için AUTO_INCREMENT değeri `packages`
--
ALTER TABLE `packages`
  MODIFY `package_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
