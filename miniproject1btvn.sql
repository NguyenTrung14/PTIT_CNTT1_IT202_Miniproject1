DROP DATABASE IF EXISTS elearning_db;
CREATE DATABASE elearning_db;
USE elearning_db;

CREATE TABLE student (
  student_id  VARCHAR(20) PRIMARY KEY,
  full_name   VARCHAR(100) NOT NULL,
  dob         DATE NOT NULL,
  email       VARCHAR(120) NOT NULL,
  CONSTRAINT uq_student_email UNIQUE (email)
) ENGINE=InnoDB;

CREATE TABLE instructor (
  instructor_id VARCHAR(20) PRIMARY KEY,
  full_name     VARCHAR(100) NOT NULL,
  email         VARCHAR(120) NOT NULL,
  CONSTRAINT uq_instructor_email UNIQUE (email),
  CONSTRAINT chk_instructor_email CHECK (email LIKE '%@%')
) ENGINE=InnoDB;

CREATE TABLE course (
  course_id     VARCHAR(20) PRIMARY KEY,
  course_name   VARCHAR(120) NOT NULL,
  short_desc    VARCHAR(255),
  sessions      INT NOT NULL,
  instructor_id VARCHAR(20) NOT NULL,

  CONSTRAINT chk_course_sessions CHECK (sessions > 0),

  CONSTRAINT fk_course_instructor
    FOREIGN KEY (instructor_id) REFERENCES instructor(instructor_id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE enrollment (
  student_id   VARCHAR(20) NOT NULL,
  course_id    VARCHAR(20) NOT NULL,
  enroll_date  DATE NOT NULL,

  PRIMARY KEY (student_id, course_id),

  CONSTRAINT fk_enroll_student
    FOREIGN KEY (student_id) REFERENCES student(student_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,

  CONSTRAINT fk_enroll_course
    FOREIGN KEY (course_id) REFERENCES course(course_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE result (
  student_id  VARCHAR(20) NOT NULL,
  course_id   VARCHAR(20) NOT NULL,
  mid_score   DECIMAL(4,2) NOT NULL,
  final_score DECIMAL(4,2) NOT NULL,

  CONSTRAINT chk_mid_score CHECK (mid_score BETWEEN 0 AND 10),
  CONSTRAINT chk_final_score CHECK (final_score BETWEEN 0 AND 10),

  PRIMARY KEY (student_id, course_id),

  CONSTRAINT fk_result_enrollment
    FOREIGN KEY (student_id, course_id)
    REFERENCES enrollment(student_id, course_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
) ENGINE=InnoDB;

INSERT INTO student (student_id, full_name, dob, email) VALUES
('SV001', 'Nguyễn Văn An',  '2005-03-12', 'an.sv001@uni.edu'),
('SV002', 'Trần Thị Bình',  '2005-07-21', 'binh.sv002@uni.edu'),
('SV003', 'Lê Minh Châu',   '2004-11-02', 'chau.sv003@uni.edu'),
('SV004', 'Phạm Gia Duy',   '2005-01-15', 'duy.sv004@uni.edu'),
('SV005', 'Vũ Thảo Linh',   '2004-09-30', 'linh.sv005@uni.edu');

INSERT INTO instructor (instructor_id, full_name, email) VALUES
('GV001', 'TS. Nguyễn Hải',     'hai.gv001@uni.edu'),
('GV002', 'ThS. Trần Quang',    'quang.gv002@uni.edu'),
('GV003', 'TS. Lê Thu',         'thu.gv003@uni.edu'),
('GV004', 'ThS. Phạm Long',     'long.gv004@uni.edu'),
('GV005', 'TS. Vũ Mai',         'mai.gv005@uni.edu');

INSERT INTO course (course_id, course_name, short_desc, sessions, instructor_id) VALUES
('C001', 'Cơ sở dữ liệu',     'SQL, thiết kế CSDL, chuẩn hóa', 12, 'GV001'),
('C002', 'Lập trình Web',     'HTML/CSS/JS cơ bản đến nâng cao', 15, 'GV002'),
('C003', 'Cấu trúc dữ liệu',  'Danh sách, cây, đồ thị', 14, 'GV003'),
('C004', 'Mạng máy tính',     'TCP/IP, routing, security', 10, 'GV004'),
('C005', 'Kỹ thuật phần mềm', 'UML, Agile, kiểm thử', 11, 'GV005');

INSERT INTO enrollment (student_id, course_id, enroll_date) VALUES
('SV001', 'C001', '2025-12-01'),
('SV001', 'C002', '2025-12-03'),
('SV002', 'C001', '2025-12-01'),
('SV002', 'C003', '2025-12-05'),
('SV003', 'C002', '2025-12-03'),
('SV003', 'C004', '2025-12-06'),
('SV004', 'C005', '2025-12-07'),
('SV005', 'C001', '2025-12-02');

INSERT INTO result (student_id, course_id, mid_score, final_score) VALUES
('SV001', 'C001', 7.50, 8.00),
('SV001', 'C002', 6.50, 7.25),
('SV002', 'C001', 8.00, 8.50),
('SV002', 'C003', 7.00, 7.75),
('SV003', 'C002', 9.00, 9.25),
('SV003', 'C004', 6.75, 7.00),
('SV004', 'C005', 8.25, 8.75),
('SV005', 'C001', 5.50, 6.25);


UPDATE student
SET email = 'an.new.sv001@uni.edu'
WHERE student_id = 'SV001';

UPDATE course
SET short_desc = 'HTML/CSS/JS + du an mini website'
WHERE course_id = 'C002';

UPDATE result
SET final_score = 9.75
WHERE student_id = 'SV003' AND course_id = 'C002';

DELETE FROM enrollment
WHERE student_id = 'SV005' AND course_id = 'C001';

SELECT * FROM student;
SELECT * FROM instructor;
SELECT * FROM course;
SELECT * FROM enrollment;
SELECT * FROM result;
