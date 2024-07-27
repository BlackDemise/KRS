-- Drop database if exists and create a new one
DROP DATABASE IF EXISTS swp391_sum24_se1808net_g5;
CREATE DATABASE IF NOT EXISTS swp391_sum24_se1808net_g5;
USE swp391_sum24_se1808net_g5;

-- Create tables
CREATE TABLE user (
    id INT AUTO_INCREMENT PRIMARY KEY,
    full_name CHAR(50) CHARACTER SET utf8mb4 NOT NULL,
    avatar VARCHAR(255) DEFAULT 'default_avatar.png',
    note TEXT,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone_number VARCHAR(12),
    dob DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    password VARCHAR(255) NOT NULL,
    status VARCHAR(10) CHECK (status IN ('Active', 'Inactive')),
    role_id INT DEFAULT 4,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    last_modified_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    created_by INT,
    last_modified_by INT
);

-- Create role table
CREATE TABLE role (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(50),
    description TEXT,
    created_at DATE,
    last_modified_at DATE,
    created_by INT,
    last_modified_by INT
);

-- Create subject table with category_id
CREATE TABLE subject (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    code VARCHAR(10),
    description TEXT,
    note TEXT,
    status VARCHAR(10) CHECK (status IN ('Active', 'Inactive')),
    category_id INT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    last_modified_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    created_by INT,
    last_modified_by INT
);

-- Create class table
CREATE TABLE class (
    class_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    teacher_id INT,
    subject_id INT,
    status VARCHAR(10) NOT NULL DEFAULT 'Active'
);

CREATE TABLE material (
    material_id int auto_increment primary key,
    material_name varchar(255) not null,
    material_description text,
    lesson_id int
);

-- Create post table
CREATE TABLE post (
    post_id INT AUTO_INCREMENT PRIMARY KEY,
    title TEXT NOT NULL,
    content TEXT NOT NULL,
    user_id INT NOT NULL,
    post_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Create comment table
CREATE TABLE comment (
    comment_id INT AUTO_INCREMENT PRIMARY KEY,
    content TEXT NOT NULL,
    user_id INT NOT NULL,
    post_id INT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Create tag table
CREATE TABLE tag (
    tag_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Create lesson table
CREATE TABLE lesson (
    lesson_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    last_modified_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    created_by INT,
    last_modified_by INT,
    subject_id INT NOT NULL,
    status VARCHAR(10) NOT NULL DEFAULT 'Active'
);

-- Create question table
CREATE TABLE question (
    question_id INT AUTO_INCREMENT PRIMARY KEY,
    content TEXT NOT NULL,
    lesson_id INT NOT NULL,
    status VARCHAR(10) NOT NULL DEFAULT 'Active'
);

-- Create answer table
CREATE TABLE answer (
    answer_id INT AUTO_INCREMENT PRIMARY KEY,
    answer TEXT NOT NULL,
    is_correct BIT NOT NULL DEFAULT 0,
    question_id INT
);

-- Create exam table
CREATE TABLE exam (
    exam_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    duration INT NOT NULL,
    class_id INT NOT NULL,
    created_by INT,
    UNIQUE (title, class_id)
);

-- Create category table
CREATE TABLE category (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    note TEXT,
    status VARCHAR(10) CHECK (status IN ('Active', 'Inactive')),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    last_modified_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    created_by INT,
    last_modified_by INT
);

-- Create subject_manager table
CREATE TABLE subject_manager (
    user_id INT NOT NULL,
    subject_id INT NOT NULL,
    PRIMARY KEY (user_id, subject_id)
);

-- Create student_class table
CREATE TABLE student_class (
    user_id INT NOT NULL,
    class_id INT NOT NULL,
    PRIMARY KEY (user_id, class_id)
);

-- Create post_tag table
CREATE TABLE post_tag (
    post_id INT NOT NULL,
    tag_id INT NOT NULL,
    PRIMARY KEY (post_id, tag_id)
);

-- Create exam_question table
CREATE TABLE exam_question (
    exam_id INT NOT NULL,
    question_id INT NOT NULL,
    PRIMARY KEY (exam_id, question_id)
);

-- Create exam_details table
CREATE TABLE exam_details (
    ed_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    user_id INT NOT NULL,
    exam_id INT NOT NULL,
    question_id INT NOT NULL,
    submitted_answer INT,
    correct_answer INT,
    taken_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Create practice_details table
CREATE TABLE practice_details (
    student_id INT,
    lesson_id INT,
    taken_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (student_id, lesson_id, taken_at)
);

-- Create flashcard table
CREATE TABLE flashcard (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    status VARCHAR(10) CHECK (status IN ('Show', 'Hidden')),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    last_modified_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    subject_id INT,
    created_by INT,
    last_modified_by INT
);

-- Create flashcard_set table
CREATE TABLE flashcard_set (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    answer TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    last_modified_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    flashcard_id INT,
    created_by INT,
    last_modified_by INT
);

create table flashcard_access (
	fa_id int auto_increment primary key,
    fl_id int,
    user_id int,
    access_time datetime
);

-- Add constraints
ALTER TABLE post ADD CONSTRAINT FK_post_user FOREIGN KEY (user_id) REFERENCES user(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE comment ADD CONSTRAINT FK_comment_user FOREIGN KEY (user_id) REFERENCES user(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE comment ADD CONSTRAINT FK_comment_post FOREIGN KEY (post_id) REFERENCES post(post_id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE lesson ADD CONSTRAINT FK_lesson_subject FOREIGN KEY (subject_id) REFERENCES subject(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE question ADD CONSTRAINT FK_question_lesson FOREIGN KEY (lesson_id) REFERENCES lesson(lesson_id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE exam ADD CONSTRAINT FK_exam_class FOREIGN KEY (class_id) REFERENCES class(class_id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE subject ADD CONSTRAINT FK_subject_category FOREIGN KEY (category_id) REFERENCES category(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE subject_manager ADD CONSTRAINT FK_subject_manager_user FOREIGN KEY (user_id) REFERENCES user(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE subject_manager ADD CONSTRAINT FK_subject_manager_subject FOREIGN KEY (subject_id) REFERENCES subject(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE student_class ADD CONSTRAINT FK_student_class_user FOREIGN KEY (user_id) REFERENCES user(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE student_class ADD CONSTRAINT FK_student_class_class FOREIGN KEY (class_id) REFERENCES class(class_id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE post_tag ADD CONSTRAINT FK_post_tag_post FOREIGN KEY (post_id) REFERENCES post(post_id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE post_tag ADD CONSTRAINT FK_post_tag_tag FOREIGN KEY (tag_id) REFERENCES tag(tag_id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE exam_question ADD CONSTRAINT FK_exam_question_exam FOREIGN KEY (exam_id) REFERENCES exam(exam_id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE exam_question ADD CONSTRAINT FK_exam_question_question FOREIGN KEY (question_id) REFERENCES question(question_id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE exam_details ADD CONSTRAINT FK_exam_details_user FOREIGN KEY (user_id) REFERENCES user(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE exam_details ADD CONSTRAINT FK_exam_details_exam FOREIGN KEY (exam_id) REFERENCES exam(exam_id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE exam_details ADD CONSTRAINT FK_exam_details_question FOREIGN KEY (question_id) REFERENCES question(question_id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE exam_details ADD CONSTRAINT FK_exam_details_submitted FOREIGN KEY (submitted_answer) REFERENCES answer(answer_id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE exam_details ADD CONSTRAINT FK_exam_details_correct FOREIGN KEY (correct_answer) REFERENCES answer(answer_id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE class ADD CONSTRAINT FK_teacher_class FOREIGN KEY (teacher_id) REFERENCES user(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE class ADD CONSTRAINT FK_subject_class FOREIGN KEY (subject_id) REFERENCES subject(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE user ADD CONSTRAINT FK_user_role FOREIGN KEY (role_id) REFERENCES role(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE answer ADD CONSTRAINT FK_answer_question FOREIGN KEY (question_id) REFERENCES question(question_id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE exam ADD CONSTRAINT FK_exam_creator FOREIGN KEY (created_by) REFERENCES user(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE practice_details ADD CONSTRAINT FK_practice_lesson FOREIGN KEY (lesson_id) REFERENCES lesson(lesson_id);
ALTER TABLE practice_details ADD CONSTRAINT FK_practice_student FOREIGN KEY (student_id) REFERENCES user(id);
ALTER TABLE material ADD CONSTRAINT FK_Material_Lesson FOREIGN KEY (lesson_id) REFERENCES lesson(lesson_id);
ALTER TABLE flashcard ADD CONSTRAINT FK_flashcard_subject FOREIGN KEY (subject_id) REFERENCES subject(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE flashcard ADD CONSTRAINT FK_flashcard_created_by FOREIGN KEY (created_by) REFERENCES user(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE flashcard ADD CONSTRAINT FK_flashcard_last_modified_by FOREIGN KEY (last_modified_by) REFERENCES user(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE flashcard_set ADD CONSTRAINT FK_flashcard_set_flashcard FOREIGN KEY (flashcard_id) REFERENCES flashcard(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE flashcard_set ADD CONSTRAINT FK_flashcard_set_created_by FOREIGN KEY (created_by) REFERENCES user(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE flashcard_set ADD CONSTRAINT FK_flashcard_set_last_modified_by FOREIGN KEY (last_modified_by) REFERENCES user(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE flashcard_access ADD CONSTRAINT FK_fl_access_flashcard FOREIGN KEY (fl_id) REFERENCES flashcard(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE flashcard_access ADD CONSTRAINT FK_user FOREIGN KEY (user_id) REFERENCES user(id) ON UPDATE CASCADE ON DELETE CASCADE;
-- Insert data into role table
INSERT INTO role (title, description) VALUES
('ROLE_ADMINISTRATOR', 'Manage all'),
('ROLE_MANAGER', 'Manage classes'),
('ROLE_TEACHER', 'Manage students in classes'),
('ROLE_STUDENT', 'Study');

-- Insert data into user table
INSERT INTO user (full_name, email, phone_number, dob, note, password, status, role_id) VALUES
('Nguyễn Văn A', 'a@gmail.com', '1234567890', '2000-01-01', 'Note about A', '$2a$12$Fk8sRsuuofDx1hqi2wpvUeSYNkhWz7BHmtgkCkWc49pK12uTAJ1HS', 'Active', 1),
('Nguyễn Văn B', 'b@gmail.com', '1234567890', '2000-01-01', 'Note about B', '$2a$12$jILq.xrmTzVRcGLVj0XrWevQE/AZ2nu/AAVqFqD4hv1QdMkedykA.', 'Active', 2),
('Nguyễn Văn C', 'c@gmail.com', '1234567890', '2000-01-01', 'Note about C', '$2a$12$h7qXYiYJG8jqLVP9QkvSL.wwfzqd9anJrZtNu4ZrqLqddUrk8/l5y','Active', 2),
('Nguyễn Văn D', 'd@gmail.com', '1234567890', '2000-01-01', 'Note about D', '$2a$12$.evgJEf1MDXo7avwRAe90OkPOBKxtQIEaGQghP9IwGMkDO1fWDISC', 'Active', 2),
('Nguyễn Văn E', 'e@gmail.com', '1234567890', '2000-01-01', 'Note about E', '$2a$12$x.D73iYi5CrAPH5QfKeuJeaAKmyaRrPHrWwT9G9D9xo47kPqgCJb6', 'Active', 2),
('Nguyễn Văn F', 'f@gmail.com', '1234567890', '2000-01-01', 'Note about F', '$2a$12$x.D73iYi5CrAPH5QfKeuJeaAKmyaRrPHrWwT9G9D9xo47kPqgCJb6', 'Active', 3),
('Nguyễn Văn H', 'h@gmail.com', '1234567890', '2000-01-01', 'Note about H', '$2a$12$x.D73iYi5CrAPH5QfKeuJeaAKmyaRrPHrWwT9G9D9xo47kPqgCJb6', 'Active', 3),
('Nguyễn Văn I', 'i@gmail.com', '1234567890', '2000-01-01', 'Note about I', '$2a$12$x.D73iYi5CrAPH5QfKeuJeaAKmyaRrPHrWwT9G9D9xo47kPqgCJb6', 'Active', 3),
('Nguyễn Văn K', 'k@gmail.com', '1234567890', '2000-01-01', 'Note about K', '$2a$12$x.D73iYi5CrAPH5QfKeuJeaAKmyaRrPHrWwT9G9D9xo47kPqgCJb6', 'Active', 3),
('Nguyễn Văn L', 'l@gmail.com', '1234567890', '2000-01-01', 'Note about L', '$2a$12$x.D73iYi5CrAPH5QfKeuJeaAKmyaRrPHrWwT9G9D9xo47kPqgCJb6', 'Active', 3),
('Nguyễn Văn M', 'm@gmail.com', '1234567890', '2000-01-01', 'Note about M', '$2a$12$x.D73iYi5CrAPH5QfKeuJeaAKmyaRrPHrWwT9G9D9xo47kPqgCJb6', 'Active', 3),
('Nguyễn Văn N', 'n@gmail.com', '1234567890', '2000-01-01', 'Note about N', '$2a$12$x.D73iYi5CrAPH5QfKeuJeaAKmyaRrPHrWwT9G9D9xo47kPqgCJb6', 'Active', 4),
('Nguyễn Văn O', 'o@gmail.com', '1234567890', '2000-01-01', 'Note about O', '$2a$12$x.D73iYi5CrAPH5QfKeuJeaAKmyaRrPHrWwT9G9D9xo47kPqgCJb6', 'Active', 4),
('Nguyễn Văn P', 'p@gmail.com', '1234567890', '2000-01-01', 'Note about P', '$2a$12$x.D73iYi5CrAPH5QfKeuJeaAKmyaRrPHrWwT9G9D9xo47kPqgCJb6', 'Active', 4),
('Nguyễn Văn Q', 'q@gmail.com', '1234567890', '2000-01-01', 'Note about Q', '$2a$12$x.D73iYi5CrAPH5QfKeuJeaAKmyaRrPHrWwT9G9D9xo47kPqgCJb6', 'Active', 4),
('Nguyễn Văn S', 's@gmail.com', '1234567890', '2000-01-01', 'Note about S', '$2a$12$x.D73iYi5CrAPH5QfKeuJeaAKmyaRrPHrWwT9G9D9xo47kPqgCJb6', 'Active', 4),
('Nguyễn Văn T', 't@gmail.com', '1234567890', '2000-01-01', 'Note about T', '$2a$12$x.D73iYi5CrAPH5QfKeuJeaAKmyaRrPHrWwT9G9D9xo47kPqgCJb6', 'Active', 4),
('Nguyễn Văn X', 'x@gmail.com', '1234567890', '2000-01-01', 'Note about X', '$2a$12$x.D73iYi5CrAPH5QfKeuJeaAKmyaRrPHrWwT9G9D9xo47kPqgCJb6', 'Active', 4),
('Nguyễn Văn Y', 'y@gmail.com', '1234567890', '2000-01-01', 'Note about Y', '$2a$12$x.D73iYi5CrAPH5QfKeuJeaAKmyaRrPHrWwT9G9D9xo47kPqgCJb6', 'Active', 4),
('Nguyễn Văn W', 'w@gmail.com', '1234567890', '2000-01-01', 'Note about W', '$2a$12$x.D73iYi5CrAPH5QfKeuJeaAKmyaRrPHrWwT9G9D9xo47kPqgCJb6', 'Active', 4),
('Nguyễn Văn Z', 'z@gmail.com', '1234567890', '2000-01-01', 'Note about Z', '$2a$12$x.D73iYi5CrAPH5QfKeuJeaAKmyaRrPHrWwT9G9D9xo47kPqgCJb6', 'Active', 4),
('Nguyễn Văn R', 'r@gmail.com', '1234567890', '2000-01-01', 'Note about R', '$2a$12$x.D73iYi5CrAPH5QfKeuJeaAKmyaRrPHrWwT9G9D9xo47kPqgCJb6', 'Active', 4),
('Nguyễn Văn AA', 'aa@gmail.com', '1234567890', '2000-01-01', 'Note about AA', '$2a$12$x.D73iYi5CrAPH5QfKeuJeaAKmyaRrPHrWwT9G9D9xo47kPqgCJb6', 'Active', 4),
('Nguyễn Văn AB', 'ab@gmail.com', '1234567890', '2000-01-01', 'Note about AB', '$2a$12$x.D73iYi5CrAPH5QfKeuJeaAKmyaRrPHrWwT9G9D9xo47kPqgCJb6', 'Active', 4),
('Nguyễn Văn AC', 'ac@gmail.com', '1234567890', '2000-01-01', 'Note about AC', '$2a$12$x.D73iYi5CrAPH5QfKeuJeaAKmyaRrPHrWwT9G9D9xo47kPqgCJb6', 'Active', 4);

-- Insert data into category table
INSERT INTO category (name, description, note, status) VALUES
('Programming', 'All about programming', 'Notes about programming', 'Active'),
('Testing', 'All about testing', 'Notes about testing', 'Active'),
('Requirement', 'All about requirement', 'Notes about requirement', 'Active'),
('Project', 'All about project', 'Notes about project', 'Active'),
('Ethics', 'All about ethics', 'Notes about ethics', 'Active');

-- Insert data into subject table
INSERT INTO subject (name, code, description, note, status, created_by, last_modified_by, category_id) VALUES
('Basic Cross-Platform Application Programming With .NET', 'PRN211', 'Description for PRN211', 'Notes for PRN211', 'Active', 1, 1, 1),
('Software Testing', 'SWT301', 'Description for SWT301', 'Notes for SWT301', 'Active', 2, 2, 2),
('Software Requirement', 'SWR302', 'Description for SWR302', 'Notes for SWR302', 'Active', 3, 3, 3),
('Application Development Project', 'SWP391', 'Description for SWP391', 'Notes for SWP391', 'Active', 4, 4, 4),
('Ethics in IT', 'ITE302c', 'Description for ITE302c', 'Notes for ITE302c', 'Active', 5, 5, 5);

-- Insert data into class table
INSERT INTO class (name, teacher_id, subject_id, status) VALUES
('SE1808', 1, 1, 'Active'),
('SE1234', 2, 2, 'Active'),
('SE2432', 3, 3, 'Active'),
('SE1808', 4, 4, 'Active'),
('SE1990', 5, 5, 'Active');

-- Insert data into student_class table
INSERT INTO student_class (user_id, class_id) VALUES 
(15, 3), (12, 3), (17, 4), (13, 1), (13, 2), (14, 5), (22, 3), (14, 3), 
(15, 4), (20, 2), (19, 5), (18, 1), (16, 1), (23, 3), (25, 4), (17, 3), 
(21, 3), (24, 1), (24, 2), (18, 2), (23, 2), (25, 1), (18, 5), (21, 4), 
(15, 5), (19, 2), (13, 4), (24, 5), (20, 5), (22, 5), (22, 4), (19, 3), 
(21, 1), (22, 1), (18, 3), (12, 4), (16, 2), (23, 5), (21, 5), (15, 2), 
(17, 5), (17, 1), (13, 3), (16, 5), (20, 1), (19, 4), (18, 4);

-- Insert data into lesson table
INSERT INTO lesson (name, subject_id, status) VALUES
('Chapter 01: Introduction to .NET Platform & Visual Studio.NET', 1, 'Active'),
('Chapter 02: C# Programming', 1, 'Active'),
('Chapter 03: Object-Oriented Programming with C#', 1, 'Active'),
('Chapter 04: Collections & Generic', 1, 'Active'),
('Chapter 05: Design Pattern in .NET', 1, 'Active'),
('Chapter 06: Delegate , Event & LINQ', 1, 'Active'),
('Chapter 07: Building WPF Application', 1, 'Active'),
('Chapter 08: Working with Databases Using Entity Framework Core', 1, 'Active'),
('Chapter 09: Working with Files and System.IO', 1, 'Active'),
('Chapter 10: Working with XML and JSON Serializing', 1, 'Active'),
('Chapter 11: Introduction to Concurrency Programming', 1, 'Active');

-- Insert data into question table
INSERT INTO question (content, lesson_id) VALUES
('Question 1: What is the purpose of an object in C#? ', 3),
('Question 2: Which of the following is not a pillar of Object-Oriented Programming? ', 3),
('Question 3: What keyword is used to inherit from a base class in C#? ', 3),
('Question 4: What is a constructor in C#? ', 3),
('Question 5: What is the correct way to define a class in C#? ', 3),
('Question 6: What is encapsulation in C#? ', 3),
('Question 7: What is the purpose of properties in C#? ', 3),
('Question 8: What is polymorphism in C#? ', 3);

-- Insert data into answer table
INSERT INTO answer (answer, is_correct, question_id) VALUES
('To hold data', 0, 1),
('To perform actions', 0, 1),
('To encapsulate data and methods into a single unit', b'1', 1),
('To create graphical user interfaces', 0, 1),
('Inheritance', 0, 2),
('Encapsulation', 0, 2),
('Polymorphism', b'1', 2),
('Compilation', 0, 2),
('extends', 0, 3),
('inherits', 0, 3),
('using', b'1', 3),
('base', 0, 3),
('A method that is automatically called when an object is created', 0, 4),
('A method that destroys an object', 0, 4),
('A method that modifies an object', b'1', 4),
('A method that clones an object', 0, 4),
('class MyClass()', 0, 5),
('MyClass class', 0, 5),
('class: MyClass', b'1', 5),
('class MyClass {}', 0, 5),
('The process of hiding the details and exposing only the essential features of a particular object', 0, 6),
('The ability of an object to take on many forms', 0, 6),
('The mechanism of basing an object upon another object', b'1', 6),
('The process of converting a data type to another data type', 0, 6),
('To ensure that the private fields of a class cannot be accessed directly', 0, 7),
('To provide a public way of getting and setting the private fields', 0, 7),
('To make the code more efficient', b'1', 7),
('To make the code easier to write', 0, 7),
('The ability of a message to be displayed in more than one form', 0, 8),
('The ability of an object to take on many forms', 0, 8),
('The ability of multiple classes to inherit from a single class', b'1', 8),
('The ability of a class to have multiple methods with the same name but different parameters', 0, 8);

-- Insert data into exam table
INSERT INTO exam (title, duration, class_id, created_by) VALUES 
('Progress Test 1', 60, 1, 1),
('Progress Test 1', 90, 2, 2),
('Progress Test 1', 120, 3, 3),
('Progress Test 1', 60, 4, 4),
('Progress Test 1', 90, 5, 5),
('Progress Test 2', 120, 1, 1),
('Progress Test 2', 60, 2, 2),
('Progress Test 2', 90, 3, 3),
('Progress Test 2', 120, 4, 4),
('Progress Test 2', 60, 5, 5);

-- Insert data into exam_question table
INSERT INTO exam_question (exam_id, question_id) VALUES
(1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (1, 6),
(2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (2, 6),
(3, 1), (3, 2), (3, 3), (3, 4), (3, 5), (3, 6),
(4, 1), (4, 2), (4, 3), (4, 4), (4, 5), (4, 6),
(5, 1), (5, 2), (5, 3), (5, 4), (5, 5), (5, 6),
(6, 1), (6, 2), (6, 3), (6, 4), (6, 5), (6, 6),
(7, 1), (7, 2), (7, 3), (7, 4), (7, 5), (7, 6),
(8, 1), (8, 2), (8, 3), (8, 4), (8, 5), (8, 6);

-- Insert data into exam_details table
INSERT INTO exam_details (user_id, exam_id, question_id, submitted_answer, correct_answer) VALUES
(10, 1, 1, 1, 3),
(11, 2, 1, 2, 3),
(12, 3, 1, 3, 3),
(13, 4, 1, 4, 3),
(14, 5, 2, 5, 7),
(15, 6, 2, 6, 7),
(16, 7, 2, 7, 7),
(17, 8, 2, 8, 7),
(18, 9, 3, 9, 11),
(19, 10, 3, 10, 11),
(20, 1, 3, 11, 11),
(21, 2, 3, 12, 11),
(22, 3, 4, 13, 15),
(23, 4, 4, 14, 15),
(24, 5, 4, 15, 15),
(25, 6, 4, 16, 15),
(10, 7, 5, 17, 19),
(11, 8, 5, 18, 19),
(12, 9, 5, 19, 19),
(13, 10, 5, 20, 19);

INSERT INTO material (material_name, material_description, lesson_id)
VALUES ('Chapter1-PRN212.docx', 'This is Chapter1', 1),
       ('Chapter1.1-PRN212.docx', 'This is Chapter1 extended', 1);