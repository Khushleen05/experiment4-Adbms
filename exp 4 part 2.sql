DROP TABLE IF EXISTS StudentEnrollments;
CREATE TABLE StudentEnrollments (
    enrollment_id INT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    course_id VARCHAR(10) NOT NULL,
    enrollment_date DATE NOT NULL,
    UNIQUE(student_name, course_id)
);

-- Part A
START TRANSACTION;
INSERT INTO StudentEnrollments VALUES (1,'Ashish','CSE101','2024-07-01');
INSERT INTO StudentEnrollments VALUES (2,'Smaran','CSE102','2024-07-01');
INSERT INTO StudentEnrollments VALUES (3,'Vaibhav','CSE101','2024-07-01');
COMMIT;

START TRANSACTION;
INSERT INTO StudentEnrollments VALUES (4,'Ashish','CSE101','2024-07-02'); -- fails
ROLLBACK;

SELECT * FROM StudentEnrollments;

-- Part B
START TRANSACTION;
SELECT * FROM StudentEnrollments WHERE student_name='Ashish' AND course_id='CSE101' FOR UPDATE;
-- User B trying to update same row will block
COMMIT;

-- Part C
START TRANSACTION;
UPDATE StudentEnrollments SET enrollment_date='2024-07-04' WHERE student_name='Ashish' AND course_id='CSE101';
COMMIT;

START TRANSACTION;
SELECT * FROM StudentEnrollments WHERE student_name='Ashish' AND course_id='CSE101' FOR UPDATE;
UPDATE StudentEnrollments SET enrollment_date='2024-07-05' WHERE student_name='Ashish' AND course_id='CSE101';
COMMIT;

SELECT * FROM StudentEnrollments;
