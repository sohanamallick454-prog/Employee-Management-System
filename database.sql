CREATE DATABASE IF NOT EXISTS ems_db;
USE ems_db;

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('admin', 'employee') NOT NULL,
    employee_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE employees (
    id INT PRIMARY KEY AUTO_INCREMENT,
    employee_code VARCHAR(20) UNIQUE NOT NULL,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    department VARCHAR(50) NOT NULL,
    position VARCHAR(50) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    phone VARCHAR(15),
    address TEXT,
    hire_date DATE NOT NULL,
    status ENUM('active', 'inactive') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO users (username, password, role, employee_id) VALUES 
('admin', 'admin123', 'admin', NULL),
('john.doe', 'emp123', 'employee', 1);

INSERT INTO employees (employee_code, name, email, department, position, salary, phone, address, hire_date) VALUES
('EMP001', 'John Doe', 'john.doe@example.com', 'IT', 'Software Developer', 75000.00, '9876543210', '123 Main St, New York', '2023-01-15'),
('EMP002', 'Jane Smith', 'jane.smith@example.com', 'HR', 'HR Manager', 85000.00, '9876543211', '456 Oak Ave, Los Angeles', '2023-06-20'),
('EMP003', 'Mike Johnson', 'mike.johnson@example.com', 'Finance', 'Accountant', 65000.00, '9876543212', '789 Pine Rd, Chicago', '2023-03-10');

SELECT * FROM employees;
USE ems_db;
SHOW TABLES;

CREATE DATABASE IF NOT EXISTS ems_db;
USE ems_db;

CREATE TABLE employees (
    id INT PRIMARY KEY AUTO_INCREMENT,
    employee_code VARCHAR(20) UNIQUE NOT NULL,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    department VARCHAR(50) NOT NULL,
    position VARCHAR(50) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    phone VARCHAR(15),
    address TEXT,
    hire_date DATE NOT NULL,
    status VARCHAR(20) DEFAULT 'active'
);

-- Add a new employee
INSERT INTO employees (employee_code, name, email, department, position, salary, phone, address, hire_date, status) VALUES
('EMP004', 'Sarah Wilson', 'sarah@example.com', 'Marketing', 'Marketing Manager', 72000.00, '9876543213', '321 Elm St', '2024-01-10', 'active');

-- Add user for this employee
INSERT INTO users (username, password, role, employee_id) VALUES
('sarah', 'sarah123', 'employee', 4);


-- Insert with different code
INSERT INTO employees (employee_code, name, email, department, position, salary, phone, address, hire_date, status) VALUES
('EMP005', 'Sarah Wilson', 'sarah@example.com', 'Marketing', 'Marketing Manager', 72000.00, '9876543213', '321 Elm St', '2024-01-10', 'active');

-- Then add user
INSERT INTO users (username, password, role, employee_id) VALUES
('sara', 'sarah125', 'employee', 5);

USE ems_db;

-- Create announcements table
CREATE TABLE announcements (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    content TEXT NOT NULL,
    posted_date DATE NOT NULL,
    status VARCHAR(20) DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO announcements (title, content, posted_date, status) VALUES
('🎉 Holiday Announcement', 'Company will remain closed on June 15th for a public holiday. Plan your work accordingly.', '2026-06-10', 'active'),
('🏆 Employee of the Month', 'Congratulations to Sarah Johnson for being awarded Employee of the Month for May 2026!', '2026-06-01', 'active'),
('💻 New HR Portal Launch', 'The new Employee Management System is now live. Please update your profiles.', '2026-05-25', 'active');

INSERT IGNORE INTO employees (employee_code, name, email, department, position, salary, phone, address, hire_date, status) VALUES
('EMP002', 'Jane Smith', 'jane.smith@example.com', 'HR', 'HR Manager', 85000.00, '9876543211', '456 Oak Ave, Los Angeles', '2023-06-20', 'active'),
('EMP003', 'Mike Johnson', 'mike.johnson@example.com', 'Finance', 'Accountant', 65000.00, '9876543212', '789 Pine Rd, Chicago', '2023-03-10', 'active'),
('EMP004', 'Sarah Wilson', 'sarah.wilson@example.com', 'Marketing', 'Marketing Manager', 72000.00, '9876543213', '321 Elm St, Boston', '2024-01-10', 'active'),
('EMP005', 'Robert Brown', 'robert.brown@example.com', 'IT', 'Senior Developer', 95000.00, '9876543214', '567 Maple Dr, Seattle', '2024-02-15', 'active'),
('EMP006', 'Lisa Davis', 'lisa.davis@example.com', 'HR', 'Recruiter', 55000.00, '9876543215', '890 Cedar Ln, Denver', '2024-03-01', 'active');

INSERT IGNORE INTO users (username, password, role, employee_id) VALUES 
('jane.smith', 'emp123', 'employee', 2),
('mike.johnson', 'emp123', 'employee', 3),
('sarah.wilson', 'emp123', 'employee', 4),
('robert.brown', 'emp123', 'employee', 5),
('lisa.davis', 'emp123', 'employee', 6);

USE ems_db;

-- Ensure all employees exist
INSERT IGNORE INTO employees (employee_code, name, email, department, position, salary, phone, address, hire_date, status) VALUES
('EMP004', 'Sarah Wilson', 'sarah.wilson@example.com', 'Marketing', 'Marketing Manager', 72000.00, '9876543213', '321 Elm St, Boston', '2024-01-10', 'active'),
('EMP005', 'Robert Brown', 'robert.brown@example.com', 'IT', 'Senior Developer', 95000.00, '9876543214', '567 Maple Dr, Seattle', '2024-02-15', 'active'),
('EMP006', 'Lisa Davis', 'lisa.davis@example.com', 'HR', 'Recruiter', 55000.00, '9876543215', '890 Cedar Ln, Denver', '2024-03-01', 'active');

-- Link users to employees
UPDATE users SET employee_id = 4 WHERE username = 'sarah.wilson';
UPDATE users SET employee_id = 5 WHERE username = 'robert.brown';
UPDATE users SET employee_id = 6 WHERE username = 'lisa.davis';

-- Verify
SELECT u.username, e.name, e.salary, e.department
FROM users u
JOIN employees e ON u.employee_id = e.id
WHERE u.username IN ('sarah.wilson', 'robert.brown', 'lisa.davis');

USE ems_db;

-- Add employees if missing
INSERT IGNORE INTO employees (id, employee_code, name, email, department, position, salary, phone, address, hire_date, status) VALUES
(4, 'EMP004', 'Sarah Wilson', 'sarah.wilson@example.com', 'Marketing', 'Marketing Manager', 72000.00, '9876543213', '321 Elm St, Boston', '2024-01-10', 'active'),
(5, 'EMP005', 'Robert Brown', 'robert.brown@example.com', 'IT', 'Senior Developer', 95000.00, '9876543214', '567 Maple Dr, Seattle', '2024-02-15', 'active'),
(6, 'EMP006', 'Lisa Davis', 'lisa.davis@example.com', 'HR', 'Recruiter', 55000.00, '9876543215', '890 Cedar Ln, Denver', '2024-03-01', 'active');

-- Link users to employees
UPDATE users SET employee_id = 4 WHERE username = 'sarah.wilson';
UPDATE users SET employee_id = 5 WHERE username = 'robert.brown';
UPDATE users SET employee_id = 6 WHERE username = 'lisa.davis';

-- Verify everything
SELECT u.username, u.employee_id, e.id, e.name, e.employee_code, e.salary
FROM users u
JOIN employees e ON u.employee_id = e.id
WHERE u.role = 'employee'
ORDER BY u.id;

INSERT IGNORE INTO announcements (title, content, posted_date, status) VALUES
('Holiday Announcement', 'Company will remain closed on June 15th for a public holiday. Plan your work accordingly.', '2026-06-10', 'active'),
('Employee of the Month', 'Congratulations to Sarah Johnson for being awarded Employee of the Month for May 2026!', '2026-06-01', 'active'),
('New HR Portal Launch', 'The new Employee Management System is now live. Please update your profiles.', '2026-05-25', 'active'),
('Training Session', 'Mandatory training session on June 20th at 10 AM in Conference Room A.', '2026-05-20', 'active'),
('Performance Review', 'Annual performance reviews will begin next month. Please prepare your self-assessment.', '2026-05-15', 'active');

SELECT u.id, u.username, u.role, u.employee_id, e.name, e.employee_code
FROM users u
LEFT JOIN employees e ON u.employee_id = e.id
ORDER BY u.id;

USE ems_db;

-- Change specific employee passwords
UPDATE users SET password = 'john123' WHERE username = 'john.doe';
UPDATE users SET password = 'jane123' WHERE username = 'jane.smith';
UPDATE users SET password = 'mike123' WHERE username = 'mike.johnson';
UPDATE users SET password = 'sarah123' WHERE username = 'sarah.wilson';
UPDATE users SET password = 'robert123' WHERE username = 'robert.brown';
UPDATE users SET password = 'lisa123' WHERE username = 'lisa.davis';

SELECT * FROM employees WHERE name LIKE '%Lisa%' OR employee_code = 'EMP006';
SELECT id, username, employee_id FROM users WHERE username = 'lisa.davis';

SELECT u.id, u.username, u.employee_id, e.id, e.name 
FROM users u
LEFT JOIN employees e ON u.employee_id = e.id;

SELECT id, employee_code, name FROM employees;

SELECT u.username, u.employee_id, e.id, e.name, e.salary
FROM users u
LEFT JOIN employees e ON u.employee_id = e.id
WHERE u.username = 'lisa.davis';

SELECT id, employee_code, name FROM employees WHERE id IN (4, 5, 6);

SELECT id, employee_code, name FROM employees

SELECT username, employee_id FROM users WHERE username = 'lisa.davis';

-- Add the missing employees with correct IDs
INSERT INTO employees (id, employee_code, name, email, department, position, salary, phone, address, hire_date, status) VALUES
(4, 'EMP004', 'Sarah Wilson', 'sarah.wilson@example.com', 'Marketing', 'Marketing Manager', 72000.00, '9876543213', '321 Elm St, Boston', '2024-01-10', 'active'),
(5, 'EMP005', 'Robert Brown', 'robert.brown@example.com', 'IT', 'Senior Developer', 95000.00, '9876543214', '567 Maple Dr, Seattle', '2024-02-15', 'active'),
(6, 'EMP006', 'Lisa Davis', 'lisa.davis@example.com', 'HR', 'Recruiter', 55000.00, '9876543215', '890 Cedar Ln, Denver', '2024-03-01', 'active')
ON DUPLICATE KEY UPDATE name = VALUES(name);

UPDATE users SET employee_id = 4 WHERE username = 'sarah.wilson';
UPDATE users SET employee_id = 5 WHERE username = 'robert.brown';
UPDATE users SET employee_id = 6 WHERE username = 'lisa.davis';


SELECT u.username, u.employee_id, e.id, e.name, e.salary
FROM users u
JOIN employees e ON u.employee_id = e.id
WHERE u.username IN ('sarah.wilson', 'robert.brown', 'lisa.davis');

USE ems_db;

-- Update Sarah Wilson with correct information
UPDATE employees 
SET 
    email = 'sarah.wilson@example.com',
    department = 'Marketing',
    position = 'Marketing Manager',
    salary = 72000.00,
    phone = '9876543213',
    address = '321 Elm St, Boston'
WHERE id = 4 AND name = 'Sarah Wilson';

SELECT username, employee_id FROM users WHERE username = 'lisa.davis';

SELECT * FROM employees WHERE id = 6;

INSERT INTO employees (id, employee_code, name, email, department, position, salary, phone, address, hire_date, status) 
VALUES (6, 'EMP006', 'Lisa Davis', 'lisa.davis@example.com', 'HR', 'Recruiter', 55000.00, '9876543215', '890 Cedar Ln, Denver', '2024-03-01', 'active');

SELECT id, employee_code, name FROM employees WHERE employee_code = 'EMP006';

SELECT id, employee_code, name FROM employees ORDER BY id;

UPDATE users SET employee_id = X WHERE username = 'lisa.davis';

SELECT id, employee_code, name FROM employees WHERE employee_code = 'EMP006';
UPDATE users SET employee_id = 7 WHERE username = 'lisa.davis';
SELECT id, employee_code, name FROM employees;

UPDATE users SET employee_id = 7 WHERE username = 'lisa.davis';

SELECT u.username, u.employee_id, e.id, e.name
FROM users u
JOIN employees e ON u.employee_id = e.id
WHERE u.username = 'lisa.davis';

SELECT id, employee_code, name FROM employees WHERE name LIKE '%Lisa%';

UPDATE users SET employee_id = 7 WHERE username = 'lisa.davis';
SELECT * FROM employees WHERE id = 7;
SELECT id, employee_code, name FROM employees;

UPDATE employees SET employee_code = 'EMP004' WHERE id = 4;

UPDATE employees SET employee_code = 'EMP007' WHERE id = 4;
UPDATE employees SET 
    email = 'sarah.wilson@example.com',
    department = 'Marketing',
    position = 'Marketing Manager',
    salary = 72000.00,
    phone = '9876543213',
    address = '321 Elm St, Boston'
WHERE id = 4;
SELECT id, employee_code, name FROM employees ORDER BY id;

UPDATE employees SET 
    employee_code = 'EMP006',
    name = 'Lisa Davis',
    email = 'lisa.davis@example.com',
    department = 'HR',
    position = 'Recruiter',
    salary = 55000.00,
    phone = '9876543215',
    address = '890 Cedar Ln, Denver',
    hire_date = '2024-03-01',
    status = 'active'
WHERE id = 7;

UPDATE users SET employee_id = 7 WHERE username = 'lisa.davis';
SELECT id, employee_code, name FROM employees ORDER BY id;

SELECT id, employee_code, name FROM employees ORDER BY id;
UPDATE employees SET employee_code = 'EMP001' WHERE id = 1;
UPDATE employees SET employee_code = 'EMP002' WHERE id = 2;
UPDATE employees SET employee_code = 'EMP003' WHERE id = 3;
UPDATE employees SET employee_code = 'EMP007', name = 'Sarah Wilson' WHERE id = 4;
UPDATE employees SET employee_code = 'EMP005', name = 'Robert Brown' WHERE id = 6;
UPDATE employees SET employee_code = 'EMP006', name = 'Lisa Davis' WHERE id = 5;

DELETE FROM employees WHERE id = 6 AND employee_code IS NULL;
INSERT INTO employees (id, employee_code, name, email, department, position, salary, phone, address, hire_date, status) 
VALUES (6, 'EMP005', 'Robert Brown', 'robert.brown@example.com', 'IT', 'Senior Developer', 95000.00, '9876543214', '567 Maple Dr, Seattle', '2024-02-15', 'active');

SELECT id, employee_code, name FROM employees WHERE employee_code = 'EMP005';

-- Fix Sarah Wilson (id=4)
UPDATE employees SET 
    employee_code = 'EMP004',
    name = 'Sarah Wilson',
    email = 'sarah.wilson@example.com',
    department = 'Marketing',
    position = 'Marketing Manager',
    salary = 72000.00,
    phone = '9876543213',
    address = '321 Elm St, Boston',
    hire_date = '2024-01-10'
WHERE id = 4;

-- Sarah Wilson - use EMP007
UPDATE employees SET 
    employee_code = 'EMP007',
    name = 'Sarah Wilson',
    email = 'sarah.wilson@example.com',
    department = 'Marketing',
    position = 'Marketing Manager',
    salary = 72000.00,
    phone = '9876543213',
    address = '321 Elm St, Boston',
    hire_date = '2024-01-10'
WHERE id = 4;
-- Lisa Davis - use EMP008
UPDATE employees SET 
    employee_code = 'EMP008',
    name = 'Lisa Davis',
    email = 'lisa.davis@example.com',
    department = 'HR',
    position = 'Recruiter',
    salary = 55000.00,
    phone = '9876543215',
    address = '890 Cedar Ln, Denver',
    hire_date = '2024-03-01'
WHERE id = 5;
-- Robert Brown - use EMP009
UPDATE employees SET 
    employee_code = 'EMP009',
    name = 'Robert Brown',
    email = 'robert.brown@example.com',
    department = 'IT',
    position = 'Senior Developer',
    salary = 95000.00,
    phone = '9876543214',
    address = '567 Maple Dr, Seattle',
    hire_date = '2024-02-15'
WHERE id = 6;

UPDATE users SET employee_id = 4 WHERE username = 'sarah.wilson';
UPDATE users SET employee_id = 5 WHERE username = 'lisa.davis';
UPDATE users SET employee_id = 6 WHERE username = 'robert.brown';

SELECT u.username, e.id, e.employee_code, e.name, e.salary

SELECT u.username, u.employee_id, e.id, e.name, e.salary
UPDATE users SET employee_id = 4 WHERE username = 'sarah.wilson';
UPDATE users SET employee_id = 5 WHERE username = 'lisa.davis';
UPDATE users SET employee_id = 6 WHERE username = 'robert.brown';
FROM users u
LEFT JOIN employees e ON u.employee_id = e.id
WHERE u.username IN ('sarah.wilson', 'lisa.davis', 'robert.brown');
SELECT * FROM employees WHERE id IN (4, 5, 6);
SELECT id, employee_code, name FROM employees;
UPDATE users SET employee_id = 4 WHERE username = 'sarah.wilson';
UPDATE users SET employee_id = 12 WHERE username = 'robert.brown';
UPDATE users SET employee_id = 13 WHERE username = 'lisa.davis';
-- Update Sarah Wilson (id=4)
UPDATE employees SET 
    email = 'sarah.wilson@example.com',
    department = 'Marketing',
    position = 'Marketing Manager',
    salary = 72000.00,
    phone = '9876543213',
    address = '321 Elm St, Boston'
WHERE id = 4;

-- Update Robert Brown (id=12)
UPDATE employees SET 
    email = 'robert.brown@example.com',
    department = 'IT',
    position = 'Senior Developer',
    salary = 95000.00,
    phone = '9876543214',
    address = '567 Maple Dr, Seattle'
WHERE id = 12;

-- Update Lisa Davis (id=13)
UPDATE employees SET 
    email = 'lisa.davis@example.com',
    department = 'HR',
    position = 'Recruiter',
    salary = 55000.00,
    phone = '9876543215',
    address = '890 Cedar Ln, Denver'
WHERE id = 13;

SELECT u.username, e.name, e.department, e.position, e.salary
FROM users u
JOIN employees e ON u.employee_id = e.id
WHERE u.role = 'employee'
ORDER BY u.id;