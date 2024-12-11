
CREATE DATABASE SMS;
USE SMS;


CREATE TABLE Students (
    StudentID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Gender ENUM('Male', 'Female', 'Other') NOT NULL,
    DateOfBirth DATE NOT NULL,
    PhoneNumber VARCHAR(15),
    Email VARCHAR(100),
    Address VARCHAR(255)
);


CREATE TABLE Courses (
    CourseID INT AUTO_INCREMENT PRIMARY KEY,
    CourseName VARCHAR(100) NOT NULL,
    CourseDuration INT NOT NULL, -- Duration in months
    CourseFee DECIMAL(10, 2) NOT NULL
);


CREATE TABLE Enrollments (
    EnrollmentID INT AUTO_INCREMENT PRIMARY KEY,
    StudentID INT NOT NULL,
    CourseID INT NOT NULL,
    EnrollmentDate DATE NOT NULL,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);


-- Insert students
INSERT INTO Students (FirstName, LastName, Gender, DateOfBirth, PhoneNumber, Email, Address)
VALUES
('Aarav', 'Sharma', 'Male', '2003-04-15', '9876543210', 'aarav.sharma@example.com', 'Delhi, India'),
('Isha', 'Mehta', 'Female', '2002-09-22', '9876541230', 'isha.mehta@example.com', 'Mumbai, India'),
('Kabir', 'Gupta', 'Male', '2004-01-19', '9876512345', 'kabir.gupta@example.com', 'Bangalore, India'),
('Priya', 'Verma', 'Female', '2003-06-10', '9876532109', 'priya.verma@example.com', 'Chennai, India'),
('Rohan', 'Singh', 'Male', '2001-12-05', '9876598765', 'rohan.singh@example.com', 'Kolkata, India');

-- Insert courses
INSERT INTO Courses (CourseName, CourseDuration, CourseFee)
VALUES
('Computer Science Basics', 6, 10000.00),
('Advanced Programming', 12, 20000.00),
('Database Management', 8, 15000.00),
('Web Development', 10, 18000.00);

-- Insert enrollments
INSERT INTO Enrollments (StudentID, CourseID, EnrollmentDate)
VALUES
(1, 1, '2024-01-10'),
(1, 3, '2024-02-15'),
(2, 2, '2024-01-20'),
(3, 4, '2024-02-10'),
(4, 1, '2024-01-25'),
(5, 2, '2024-03-05');


-- 1. List all students
SELECT * FROM Students;

-- 2. List all courses
SELECT * FROM Courses;

-- 3. Find all students enrolled in 'Web Development'
SELECT 
    s.FirstName, s.LastName, c.CourseName, e.EnrollmentDate
FROM 
    Students s
JOIN 
    Enrollments e ON s.StudentID = e.StudentID
JOIN 
    Courses c ON e.CourseID = c.CourseID
WHERE 
    c.CourseName = 'Web Development';

-- 4. Count the number of students in each course
SELECT 
    c.CourseName, COUNT(e.StudentID) AS TotalStudents
FROM 
    Courses c
LEFT JOIN 
    Enrollments e ON c.CourseID = e.CourseID
GROUP BY 
    c.CourseID;

-- 5. Find courses taken by 'Priya Verma'
SELECT 
    s.FirstName, s.LastName, c.CourseName, e.EnrollmentDate
FROM 
    Students s
JOIN 
    Enrollments e ON s.StudentID = e.StudentID
JOIN 
    Courses c ON e.CourseID = c.CourseID
WHERE 
    s.FirstName = 'Priya' AND s.LastName = 'Verma';
