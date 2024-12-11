const express = require("express");
const mysql = require("mysql2");
const bodyParser = require("body-parser");
const cors = require("cors");

const app = express();
const PORT = 3000;

// Middleware
app.use(cors());
app.use(bodyParser.json());

// MySQL connection
const db = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "123ekta",
  database: "SMS",
});

db.connect((err) => {
  if (err) {
    console.error("Database connection failed:", err);
  } else {
    console.log("Database connected");
  }
});

// Routes

// Get all students
app.get("/students", (req, res) => {
  const query = "SELECT * FROM Students";
  db.query(query, (err, results) => {
    if (err) {
      console.error(err);
      res.status(500).send("Error retrieving students");
    } else {
      res.json(results);
    }
  });
});

// Add a new student
app.post("/students", (req, res) => {
  const {
    FirstName,
    LastName,
    Gender,
    DateOfBirth,
    PhoneNumber,
    Email,
    Address,
  } = req.body;
  const query = `INSERT INTO Students (FirstName, LastName, Gender, DateOfBirth, PhoneNumber, Email, Address) VALUES (?, ?, ?, ?, ?, ?, ?)`;
  db.query(
    query,
    [FirstName, LastName, Gender, DateOfBirth, PhoneNumber, Email, Address],
    (err, result) => {
      if (err) {
        console.error(err);
        res.status(500).send("Error adding student");
      } else {
        res.status(201).send({
          message: "Student added successfully",
          StudentID: result.insertId,
        });
      }
    }
  );
});

// Get all courses
app.get("/courses", (req, res) => {
  const query = "SELECT * FROM Courses";
  db.query(query, (err, results) => {
    if (err) {
      console.error(err);
      res.status(500).send("Error retrieving courses");
    } else {
      res.json(results);
    }
  });
});

// Add a new course
app.post("/courses", (req, res) => {
  const { CourseName, CourseDuration, CourseFee } = req.body;
  const query = `INSERT INTO Courses (CourseName, CourseDuration, CourseFee) VALUES (?, ?, ?)`;
  db.query(query, [CourseName, CourseDuration, CourseFee], (err, result) => {
    if (err) {
      console.error(err);
      res.status(500).send("Error adding course");
    } else {
      res.status(201).send({
        message: "Course added successfully",
        CourseID: result.insertId,
      });
    }
  });
});

// Get enrollments by student
app.get("/enrollments/:studentId", (req, res) => {
  const { studentId } = req.params;
  const query = `SELECT c.CourseName, e.EnrollmentDate FROM Enrollments e JOIN Courses c ON e.CourseID = c.CourseID WHERE e.StudentID = ?`;
  db.query(query, [studentId], (err, results) => {
    if (err) {
      console.error(err);
      res.status(500).send("Error retrieving enrollments");
    } else {
      res.json(results);
    }
  });
});

// Add a new enrollment
app.post("/enrollments", (req, res) => {
  const { StudentID, CourseID, EnrollmentDate } = req.body;
  const query = `INSERT INTO Enrollments (StudentID, CourseID, EnrollmentDate) VALUES (?, ?, ?)`;
  db.query(query, [StudentID, CourseID, EnrollmentDate], (err, result) => {
    if (err) {
      console.error(err);
      res.status(500).send("Error adding enrollment");
    } else {
      res.status(201).send({
        message: "Enrollment added successfully",
        EnrollmentID: result.insertId,
      });
    }
  });
});

// Start server
app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});
