-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 23, 2024 at 12:26 PM
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
-- Database: `earist_sis`
--

-- --------------------------------------------------------

--
-- Table structure for table `active_school_year`
--

CREATE TABLE `active_school_year` (
  `id` int(11) NOT NULL,
  `year_id` int(11) DEFAULT NULL,
  `semester_id` int(11) DEFAULT NULL,
  `status` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `company_settings`
--

CREATE TABLE `company_settings` (
  `id` int(11) NOT NULL,
  `company_name` varchar(255) NOT NULL,
  `logo_url` varchar(255) DEFAULT NULL,
  `header_color` varchar(7) NOT NULL,
  `footer_text` text DEFAULT NULL,
  `footer_color` varchar(7) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `company_settings`
--

INSERT INTO `company_settings` (`id`, `company_name`, `logo_url`, `header_color`, `footer_text`, `footer_color`) VALUES
(1, 'EARIST', '/uploads/1729588350063.png', '#f9014b', 'Copyright BSIT3A G1', '#eaf0db');

-- --------------------------------------------------------

--
-- Table structure for table `course_table`
--

CREATE TABLE `course_table` (
  `id` int(11) NOT NULL,
  `course_description` varchar(100) NOT NULL,
  `course_code` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `course_tagging_table`
--

CREATE TABLE `course_tagging_table` (
  `id` int(11) NOT NULL,
  `curriculum_id` int(11) DEFAULT NULL,
  `subject_id` int(11) DEFAULT NULL,
  `year_level_id` int(11) DEFAULT NULL,
  `semester_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `curriculum`
--

CREATE TABLE `curriculum` (
  `id` int(11) NOT NULL,
  `year_id` int(11) DEFAULT NULL,
  `course_id` int(11) DEFAULT NULL,
  `lock_status` varchar(20) DEFAULT NULL,
  `semester_id` int(11) DEFAULT NULL,
  `semester_description` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `curriculum`
--

INSERT INTO `curriculum` (`id`, `year_id`, `course_id`, `lock_status`, `semester_id`, `semester_description`) VALUES
(1, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `department_curriculum`
--

CREATE TABLE `department_curriculum` (
  `id` int(11) NOT NULL,
  `department_id` int(11) DEFAULT NULL,
  `curriculum_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `department_profs`
--

CREATE TABLE `department_profs` (
  `id` int(11) NOT NULL,
  `department_id` int(11) DEFAULT NULL,
  `prof_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `department_room`
--

CREATE TABLE `department_room` (
  `id` int(11) NOT NULL,
  `department_id` int(11) DEFAULT NULL,
  `room_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `department_section`
--

CREATE TABLE `department_section` (
  `id` int(11) NOT NULL,
  `curriculum_id` int(11) DEFAULT NULL,
  `section_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `department_table`
--

CREATE TABLE `department_table` (
  `id` int(11) NOT NULL,
  `department_description` varchar(100) NOT NULL,
  `department_code` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `enrolled_subject`
--

CREATE TABLE `enrolled_subject` (
  `id` int(11) NOT NULL,
  `student_number` int(11) DEFAULT NULL,
  `curriculum_id` int(11) DEFAULT NULL,
  `subject_id` int(11) DEFAULT NULL,
  `active_school_year_id` int(11) DEFAULT NULL,
  `midterm` decimal(5,2) NOT NULL,
  `finals` decimal(5,2) NOT NULL,
  `final_grade` decimal(5,2) DEFAULT NULL,
  `en_remarks` varchar(100) DEFAULT NULL,
  `completion_grade` decimal(5,2) DEFAULT NULL,
  `department_section_id` int(11) DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `time_tagged` timestamp NOT NULL DEFAULT current_timestamp(),
  `employee_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `enrollee_requirements`
--

CREATE TABLE `enrollee_requirements` (
  `id` int(11) NOT NULL,
  `person_id` int(11) DEFAULT NULL,
  `requirements_id` int(11) DEFAULT NULL,
  `requirements_status` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `exam_date_table`
--

CREATE TABLE `exam_date_table` (
  `exam_date_id` int(11) NOT NULL,
  `exam_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `exam_reference_result`
--

CREATE TABLE `exam_reference_result` (
  `id` int(11) NOT NULL,
  `passing_score` decimal(5,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `exam_result_table`
--

CREATE TABLE `exam_result_table` (
  `id` int(11) NOT NULL,
  `person_id` int(11) DEFAULT NULL,
  `result` decimal(5,2) NOT NULL,
  `active_school_year_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `exam_table`
--

CREATE TABLE `exam_table` (
  `id` int(11) NOT NULL,
  `person_id` int(11) DEFAULT NULL,
  `exam_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `exam_time_table`
--

CREATE TABLE `exam_time_table` (
  `id` int(11) NOT NULL,
  `exam_time` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `periodstat`
--

CREATE TABLE `periodstat` (
  `id` int(11) NOT NULL,
  `periodstat` varchar(50) NOT NULL,
  `period_stat` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `person_status_table`
--

CREATE TABLE `person_status_table` (
  `id` int(11) NOT NULL,
  `person_id` int(11) DEFAULT NULL,
  `exam_status` varchar(50) DEFAULT NULL,
  `requirements` text DEFAULT NULL,
  `residency` varchar(50) DEFAULT NULL,
  `student_registration_status` varchar(50) DEFAULT NULL,
  `exam_result` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `person_table`
--

CREATE TABLE `person_table` (
  `id` int(11) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) NOT NULL,
  `birthday` date DEFAULT NULL,
  `contact_no` varchar(15) DEFAULT NULL,
  `guardian` varchar(100) DEFAULT NULL,
  `guardian2` varchar(100) DEFAULT NULL,
  `last_school` varchar(100) DEFAULT NULL,
  `nationality` varchar(50) DEFAULT NULL,
  `civil_status` varchar(20) DEFAULT NULL,
  `year_graduated` year(4) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `barangay` varchar(100) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `department` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `person_table`
--

INSERT INTO `person_table` (`id`, `first_name`, `middle_name`, `last_name`, `birthday`, `contact_no`, `guardian`, `guardian2`, `last_school`, `nationality`, `civil_status`, `year_graduated`, `address`, `barangay`, `city`, `gender`, `department`, `email`) VALUES
(1, 'King Phillip', 'A.', 'Laxamana', '2024-10-23', '0965565852', 'safsafsaf', 'fasfasfasf', 'fasfafasfa', 'dafadgdag', 'afafas', '1999', 'asfasdfa', 'asfasf', 'fasfsaf', 'Male', 'agadsg', 'asgasgasdg@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `prof_table`
--

CREATE TABLE `prof_table` (
  `id` int(11) NOT NULL,
  `fname` varchar(50) NOT NULL,
  `mname` varchar(50) DEFAULT NULL,
  `lname` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `requirements_table`
--

CREATE TABLE `requirements_table` (
  `id` int(11) NOT NULL,
  `requirements_description` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `room_day`
--

CREATE TABLE `room_day` (
  `day_id` int(11) NOT NULL,
  `day_description` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `room_table`
--

CREATE TABLE `room_table` (
  `id` int(11) NOT NULL,
  `room_description` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `school_time`
--

CREATE TABLE `school_time` (
  `id` int(11) NOT NULL,
  `school_time_description` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `school_year`
--

CREATE TABLE `school_year` (
  `id` int(11) NOT NULL,
  `school_year_description` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `section_table`
--

CREATE TABLE `section_table` (
  `id` int(11) NOT NULL,
  `section_description` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `semester_table`
--

CREATE TABLE `semester_table` (
  `id` int(11) NOT NULL,
  `semester_description` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `student_curriculum`
--

CREATE TABLE `student_curriculum` (
  `id` int(11) NOT NULL,
  `student_number` varchar(20) NOT NULL,
  `curriculum_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student_curriculum`
--

INSERT INTO `student_curriculum` (`id`, `student_number`, `curriculum_id`) VALUES
(1, '1', 1),
(2, '2', 1),
(3, '3', 1);

-- --------------------------------------------------------

--
-- Table structure for table `student_numbering`
--

CREATE TABLE `student_numbering` (
  `id` int(11) NOT NULL,
  `student_number` varchar(20) NOT NULL,
  `person_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student_numbering`
--

INSERT INTO `student_numbering` (`id`, `student_number`, `person_id`) VALUES
(1, '1', 1);

-- --------------------------------------------------------

--
-- Table structure for table `student_status`
--

CREATE TABLE `student_status` (
  `id` int(11) NOT NULL,
  `student_number` varchar(20) NOT NULL,
  `active_curriculum` int(11) DEFAULT NULL,
  `balance` decimal(10,2) DEFAULT NULL,
  `enrolled_status` varchar(20) DEFAULT NULL,
  `year_level_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student_status`
--

INSERT INTO `student_status` (`id`, `student_number`, `active_curriculum`, `balance`, `enrolled_status`, `year_level_id`) VALUES
(1, '0000000', 1111, 1111.11, '11', NULL),
(3, '1', 1, 2.00, 'Enrolled ', 1),
(4, '2', 2, 2.00, 'Fail', 1);

-- --------------------------------------------------------

--
-- Table structure for table `subject_quota`
--

CREATE TABLE `subject_quota` (
  `id` int(11) NOT NULL,
  `department_section_id` int(11) DEFAULT NULL,
  `subject_id` int(11) DEFAULT NULL,
  `quota` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subject_table`
--

CREATE TABLE `subject_table` (
  `id` int(11) NOT NULL,
  `subject_code` varchar(20) NOT NULL,
  `subject_description` varchar(100) NOT NULL,
  `subject_unit` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `time_table`
--

CREATE TABLE `time_table` (
  `id` int(11) NOT NULL,
  `school_year_id` int(11) DEFAULT NULL,
  `school_time_start` time NOT NULL,
  `school_time_end` time NOT NULL,
  `department_section_id` int(11) DEFAULT NULL,
  `subject_id` int(11) DEFAULT NULL,
  `department_room_id` int(11) DEFAULT NULL,
  `prof_id` int(11) DEFAULT NULL,
  `room_day` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`) VALUES
(1, 'zpalaxamana', 'laxamana.kp.bsinfotech@gmail.com', '$2a$10$s0ttc8IlKcxiEr1VXXEVsueBploWAIdTrRNs556ifeVboZp6mkJee');

-- --------------------------------------------------------

--
-- Table structure for table `user_account`
--

CREATE TABLE `user_account` (
  `id` int(11) NOT NULL,
  `person_id` int(11) DEFAULT NULL,
  `employee_id` varchar(20) DEFAULT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `contact_number` varchar(15) DEFAULT NULL,
  `access_level` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `year_level`
--

CREATE TABLE `year_level` (
  `id` int(11) NOT NULL,
  `year_level_description` varchar(50) NOT NULL,
  `year_id` int(11) DEFAULT NULL,
  `year_description` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `year_level`
--

INSERT INTO `year_level` (`id`, `year_level_description`, `year_id`, `year_description`) VALUES
(1, '1', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `year_table`
--

CREATE TABLE `year_table` (
  `id` int(11) NOT NULL,
  `year_description` varchar(50) NOT NULL,
  `status` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `active_school_year`
--
ALTER TABLE `active_school_year`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_year_id_active_school_year` (`year_id`),
  ADD KEY `fk_semester_id_active_school_year` (`semester_id`);

--
-- Indexes for table `company_settings`
--
ALTER TABLE `company_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `course_table`
--
ALTER TABLE `course_table`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `course_code` (`course_code`);

--
-- Indexes for table `course_tagging_table`
--
ALTER TABLE `course_tagging_table`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_curriculum_id_course_tagging` (`curriculum_id`),
  ADD KEY `fk_subject_id_course_tagging` (`subject_id`),
  ADD KEY `fk_year_level_id_course_tagging` (`year_level_id`),
  ADD KEY `fk_semester_id_course_tagging` (`semester_id`);

--
-- Indexes for table `curriculum`
--
ALTER TABLE `curriculum`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_year_id_curriculum` (`year_id`),
  ADD KEY `fk_course_id_curriculum` (`course_id`),
  ADD KEY `fk_semester_id_curriculum` (`semester_id`);

--
-- Indexes for table `department_curriculum`
--
ALTER TABLE `department_curriculum`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_department_id_department_curriculum` (`department_id`),
  ADD KEY `fk_curriculum_id_department_curriculum` (`curriculum_id`);

--
-- Indexes for table `department_profs`
--
ALTER TABLE `department_profs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_department_id_department_profs` (`department_id`),
  ADD KEY `fk_prof_id_department_profs` (`prof_id`);

--
-- Indexes for table `department_room`
--
ALTER TABLE `department_room`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_department_id_department_room` (`department_id`),
  ADD KEY `fk_room_id_department_room` (`room_id`);

--
-- Indexes for table `department_section`
--
ALTER TABLE `department_section`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_curriculum_id_department_section` (`curriculum_id`),
  ADD KEY `fk_section_id_department_section` (`section_id`);

--
-- Indexes for table `department_table`
--
ALTER TABLE `department_table`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `department_code` (`department_code`);

--
-- Indexes for table `enrolled_subject`
--
ALTER TABLE `enrolled_subject`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_curriculum_id_enrolled_subject` (`curriculum_id`),
  ADD KEY `fk_subject_id_enrolled_subject` (`subject_id`),
  ADD KEY `fk_active_school_year_id_enrolled_subject` (`active_school_year_id`),
  ADD KEY `fk_department_section_id_enrolled_subject` (`department_section_id`);

--
-- Indexes for table `enrollee_requirements`
--
ALTER TABLE `enrollee_requirements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_person_id_enrollee_requirements` (`person_id`),
  ADD KEY `fk_requirements_id_enrollee_requirements` (`requirements_id`);

--
-- Indexes for table `exam_date_table`
--
ALTER TABLE `exam_date_table`
  ADD PRIMARY KEY (`exam_date_id`);

--
-- Indexes for table `exam_reference_result`
--
ALTER TABLE `exam_reference_result`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `exam_result_table`
--
ALTER TABLE `exam_result_table`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_person_id_exam_result_table` (`person_id`),
  ADD KEY `fk_active_school_year_id_exam_result_table` (`active_school_year_id`);

--
-- Indexes for table `exam_table`
--
ALTER TABLE `exam_table`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_person_id_exam_table` (`person_id`);

--
-- Indexes for table `exam_time_table`
--
ALTER TABLE `exam_time_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `periodstat`
--
ALTER TABLE `periodstat`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `person_status_table`
--
ALTER TABLE `person_status_table`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_person_id_person_status` (`person_id`);

--
-- Indexes for table `person_table`
--
ALTER TABLE `person_table`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `prof_table`
--
ALTER TABLE `prof_table`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `requirements_table`
--
ALTER TABLE `requirements_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `room_day`
--
ALTER TABLE `room_day`
  ADD PRIMARY KEY (`day_id`);

--
-- Indexes for table `room_table`
--
ALTER TABLE `room_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `school_time`
--
ALTER TABLE `school_time`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `school_year`
--
ALTER TABLE `school_year`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `section_table`
--
ALTER TABLE `section_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `semester_table`
--
ALTER TABLE `semester_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `student_curriculum`
--
ALTER TABLE `student_curriculum`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_curriculum_id_student_curriculum` (`curriculum_id`);

--
-- Indexes for table `student_numbering`
--
ALTER TABLE `student_numbering`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_person_id` (`person_id`);

--
-- Indexes for table `student_status`
--
ALTER TABLE `student_status`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_year_level_id_student_status` (`year_level_id`);

--
-- Indexes for table `subject_quota`
--
ALTER TABLE `subject_quota`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_department_section_id_subject_quota` (`department_section_id`),
  ADD KEY `fk_subject_id_subject_quota` (`subject_id`);

--
-- Indexes for table `subject_table`
--
ALTER TABLE `subject_table`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `subject_code` (`subject_code`);

--
-- Indexes for table `time_table`
--
ALTER TABLE `time_table`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_school_year_id_time_table` (`school_year_id`),
  ADD KEY `fk_department_section_id_time_table` (`department_section_id`),
  ADD KEY `fk_subject_id_time_table` (`subject_id`),
  ADD KEY `fk_department_room_id_time_table` (`department_room_id`),
  ADD KEY `fk_prof_id_time_table` (`prof_id`),
  ADD KEY `fk_room_day_time_table` (`room_day`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_account`
--
ALTER TABLE `user_account`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `fk_person_id_user_account` (`person_id`);

--
-- Indexes for table `year_level`
--
ALTER TABLE `year_level`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_year_id` (`year_id`);

--
-- Indexes for table `year_table`
--
ALTER TABLE `year_table`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `active_school_year`
--
ALTER TABLE `active_school_year`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `company_settings`
--
ALTER TABLE `company_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `course_table`
--
ALTER TABLE `course_table`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `course_tagging_table`
--
ALTER TABLE `course_tagging_table`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `curriculum`
--
ALTER TABLE `curriculum`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `department_curriculum`
--
ALTER TABLE `department_curriculum`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `department_profs`
--
ALTER TABLE `department_profs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `department_room`
--
ALTER TABLE `department_room`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `department_section`
--
ALTER TABLE `department_section`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `department_table`
--
ALTER TABLE `department_table`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `enrolled_subject`
--
ALTER TABLE `enrolled_subject`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `enrollee_requirements`
--
ALTER TABLE `enrollee_requirements`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `exam_date_table`
--
ALTER TABLE `exam_date_table`
  MODIFY `exam_date_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `exam_reference_result`
--
ALTER TABLE `exam_reference_result`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `exam_result_table`
--
ALTER TABLE `exam_result_table`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `exam_table`
--
ALTER TABLE `exam_table`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `exam_time_table`
--
ALTER TABLE `exam_time_table`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `periodstat`
--
ALTER TABLE `periodstat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `person_status_table`
--
ALTER TABLE `person_status_table`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `person_table`
--
ALTER TABLE `person_table`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `prof_table`
--
ALTER TABLE `prof_table`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `requirements_table`
--
ALTER TABLE `requirements_table`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `room_day`
--
ALTER TABLE `room_day`
  MODIFY `day_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `room_table`
--
ALTER TABLE `room_table`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `school_time`
--
ALTER TABLE `school_time`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `school_year`
--
ALTER TABLE `school_year`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `section_table`
--
ALTER TABLE `section_table`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `semester_table`
--
ALTER TABLE `semester_table`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `student_curriculum`
--
ALTER TABLE `student_curriculum`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `student_numbering`
--
ALTER TABLE `student_numbering`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `student_status`
--
ALTER TABLE `student_status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `subject_quota`
--
ALTER TABLE `subject_quota`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subject_table`
--
ALTER TABLE `subject_table`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `time_table`
--
ALTER TABLE `time_table`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user_account`
--
ALTER TABLE `user_account`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `year_level`
--
ALTER TABLE `year_level`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `year_table`
--
ALTER TABLE `year_table`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `active_school_year`
--
ALTER TABLE `active_school_year`
  ADD CONSTRAINT `fk_semester_id_active_school_year` FOREIGN KEY (`semester_id`) REFERENCES `semester_table` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_year_id_active_school_year` FOREIGN KEY (`year_id`) REFERENCES `year_table` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `course_tagging_table`
--
ALTER TABLE `course_tagging_table`
  ADD CONSTRAINT `fk_curriculum_id_course_tagging` FOREIGN KEY (`curriculum_id`) REFERENCES `curriculum` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_semester_id_course_tagging` FOREIGN KEY (`semester_id`) REFERENCES `semester_table` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_subject_id_course_tagging` FOREIGN KEY (`subject_id`) REFERENCES `subject_table` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_year_level_id_course_tagging` FOREIGN KEY (`year_level_id`) REFERENCES `year_level` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `curriculum`
--
ALTER TABLE `curriculum`
  ADD CONSTRAINT `fk_course_id_curriculum` FOREIGN KEY (`course_id`) REFERENCES `course_table` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_semester_id_curriculum` FOREIGN KEY (`semester_id`) REFERENCES `semester_table` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_year_id_curriculum` FOREIGN KEY (`year_id`) REFERENCES `year_table` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `department_curriculum`
--
ALTER TABLE `department_curriculum`
  ADD CONSTRAINT `fk_curriculum_id_department_curriculum` FOREIGN KEY (`curriculum_id`) REFERENCES `curriculum` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_department_id_department_curriculum` FOREIGN KEY (`department_id`) REFERENCES `department_table` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `department_profs`
--
ALTER TABLE `department_profs`
  ADD CONSTRAINT `fk_department_id_department_profs` FOREIGN KEY (`department_id`) REFERENCES `department_table` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_prof_id_department_profs` FOREIGN KEY (`prof_id`) REFERENCES `prof_table` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `department_room`
--
ALTER TABLE `department_room`
  ADD CONSTRAINT `fk_department_id_department_room` FOREIGN KEY (`department_id`) REFERENCES `department_table` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_room_id_department_room` FOREIGN KEY (`room_id`) REFERENCES `room_table` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `department_section`
--
ALTER TABLE `department_section`
  ADD CONSTRAINT `fk_curriculum_id_department_section` FOREIGN KEY (`curriculum_id`) REFERENCES `curriculum` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_section_id_department_section` FOREIGN KEY (`section_id`) REFERENCES `section_table` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `enrolled_subject`
--
ALTER TABLE `enrolled_subject`
  ADD CONSTRAINT `fk_active_school_year_id_enrolled_subject` FOREIGN KEY (`active_school_year_id`) REFERENCES `active_school_year` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_curriculum_id_enrolled_subject` FOREIGN KEY (`curriculum_id`) REFERENCES `curriculum` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_department_section_id_enrolled_subject` FOREIGN KEY (`department_section_id`) REFERENCES `department_section` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_subject_id_enrolled_subject` FOREIGN KEY (`subject_id`) REFERENCES `subject_table` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `enrollee_requirements`
--
ALTER TABLE `enrollee_requirements`
  ADD CONSTRAINT `fk_person_id_enrollee_requirements` FOREIGN KEY (`person_id`) REFERENCES `person_table` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_requirements_id_enrollee_requirements` FOREIGN KEY (`requirements_id`) REFERENCES `requirements_table` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `exam_result_table`
--
ALTER TABLE `exam_result_table`
  ADD CONSTRAINT `fk_active_school_year_id_exam_result_table` FOREIGN KEY (`active_school_year_id`) REFERENCES `active_school_year` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_person_id_exam_result_table` FOREIGN KEY (`person_id`) REFERENCES `person_table` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `exam_table`
--
ALTER TABLE `exam_table`
  ADD CONSTRAINT `fk_person_id_exam_table` FOREIGN KEY (`person_id`) REFERENCES `person_table` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `person_status_table`
--
ALTER TABLE `person_status_table`
  ADD CONSTRAINT `fk_person_id_person_status` FOREIGN KEY (`person_id`) REFERENCES `person_table` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `student_curriculum`
--
ALTER TABLE `student_curriculum`
  ADD CONSTRAINT `fk_curriculum_id_student_curriculum` FOREIGN KEY (`curriculum_id`) REFERENCES `curriculum` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `student_numbering`
--
ALTER TABLE `student_numbering`
  ADD CONSTRAINT `fk_person_id` FOREIGN KEY (`person_id`) REFERENCES `person_table` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `student_status`
--
ALTER TABLE `student_status`
  ADD CONSTRAINT `fk_year_level_id_student_status` FOREIGN KEY (`year_level_id`) REFERENCES `year_level` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `subject_quota`
--
ALTER TABLE `subject_quota`
  ADD CONSTRAINT `fk_department_section_id_subject_quota` FOREIGN KEY (`department_section_id`) REFERENCES `department_section` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_subject_id_subject_quota` FOREIGN KEY (`subject_id`) REFERENCES `subject_table` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `time_table`
--
ALTER TABLE `time_table`
  ADD CONSTRAINT `fk_department_room_id_time_table` FOREIGN KEY (`department_room_id`) REFERENCES `department_room` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_department_section_id_time_table` FOREIGN KEY (`department_section_id`) REFERENCES `department_section` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_prof_id_time_table` FOREIGN KEY (`prof_id`) REFERENCES `prof_table` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_room_day_time_table` FOREIGN KEY (`room_day`) REFERENCES `room_day` (`day_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_school_year_id_time_table` FOREIGN KEY (`school_year_id`) REFERENCES `school_year` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_subject_id_time_table` FOREIGN KEY (`subject_id`) REFERENCES `subject_table` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user_account`
--
ALTER TABLE `user_account`
  ADD CONSTRAINT `fk_person_id_user_account` FOREIGN KEY (`person_id`) REFERENCES `person_table` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `year_level`
--
ALTER TABLE `year_level`
  ADD CONSTRAINT `fk_year_id` FOREIGN KEY (`year_id`) REFERENCES `year_table` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
