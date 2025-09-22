DROP TABLE IF EXISTS StudentEnrollments;

CREATE TABLE StudentEnrollments (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100),
    course_id VARCHAR(10),
    enrollment_date DATE
);

INSERT INTO StudentEnrollments VALUES
(1, 'Ashish', 'CSE101', '2024-06-01'),
(2, 'Smaran', 'CSE102', '2024-06-01'),
(3, 'Vaibhav', 'CSE103', '2024-06-01');
COMMIT;

-- Part A: Deadlock
-- Session 1
START TRANSACTION;
UPDATE StudentEnrollments SET course_id = 'CSE201' WHERE student_id = 1;

-- Session 2
START TRANSACTION;
UPDATE StudentEnrollments SET course_id = 'CSE202' WHERE student_id = 2;

-- Back to Session 1
UPDATE StudentEnrollments SET course_id = 'CSE301' WHERE student_id = 2;

-- Back to Session 2
UPDATE StudentEnrollments SET course_id = 'CSE302' WHERE student_id = 1;
-- Deadlock → one transaction aborted

-- Part B: MVCC
-- Session A
START TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SELECT * FROM StudentEnrollments WHERE student_id = 1;

-- Session B
START TRANSACTION;
UPDATE StudentEnrollments SET enrollment_date = '2024-07-10' WHERE student_id = 1;
COMMIT;

-- Back to Session A
SELECT * FROM StudentEnrollments WHERE student_id = 1;
COMMIT;

-- Part C: Locking vs MVCC
-- Case 1: Locking
-- Session X
START TRANSACTION;
SELECT * FROM StudentEnrollments WHERE student_id = 1 FOR UPDATE;

-- Session Y (blocks)
SELECT * FROM StudentEnrollments WHERE student_id = 1;

-- Case 2: MVCC
-- Session X
START TRANSACTION;
UPDATE StudentEnrollments SET course_id = 'CSE401' WHERE student_id = 1;

-- Session Y
START TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SELECT * FROM StudentEnrollments WHERE student_id = 1;
COMMIT;
