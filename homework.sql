--EX1
CREATE TABLE users (
    user_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE passwords (
    user_id INTEGER UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    FOREIGN KEY(user_id) REFERENCES users(user_id)
);

INSERT INTO users (user_id, name) VALUES
(1, 'Lior'), (2, 'Tamar'), (3, 'Erez'), (4, 'Dana'),
(5, 'Amit'), (6, 'Yael'), (7, 'Noam'), (8, 'Hila'),
(9, 'Aviad'), (10, 'Shani');

INSERT INTO passwords (user_id, password_hash) VALUES
(1, 'abc123'), (2, 'pass456'), (3, 'hello789'), (4, 'secure321'),
(5, 'qwerty12'), (6, 'secret99');

הצג את כל המשתמשים עם הסיסמה שלהם (INNER JOIN)
הצג את כל המשתמשים, גם כאלה שאין להם סיסמה (LEFT JOIN)
הצג את המשתמשים שאין להם סיסמה כלל

--EX1-q1
SELECT u.name, p.password_hash FROM users u
INNER JOIN passwords p on u.user_id = p.user_id;

--EX1-q2
SELECT u.name, p.password_hash FROM users u
LEFT JOIN passwords p on u.user_id = p.user_id;

--EX1-q3
SELECT u.name, p.password_hash FROM users u
LEFT JOIN passwords p on u.user_id = p.user_id
WHERE p.password_hash IS NULL;

--EX2
CREATE TABLE departments (
    department_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE employees (
    employee_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    department_id INTEGER,
    FOREIGN KEY(department_id) REFERENCES departments(department_id)
);

INSERT INTO departments (department_id, name) VALUES
(1, 'Finance'), (2, 'IT'), (3, 'HR'), (4, 'Marketing');

INSERT INTO employees (employee_id, name, department_id) VALUES
(1, 'Shira', 1), (2, 'Doron', 2), (3, 'Tal', 2), (4, 'Adi', 3),
(5, 'Omer', NULL), (6, 'Yoni', 1), (7, 'Michal', NULL),
(8, 'Liad', 4), (9, 'Noga', 2), (10, 'Rami', 1);

הצג את כל העובדים עם שם המחלקה שלהם
הצג את כל המחלקות וספור כמה עובדים יש לכל מחלקה
הצג את כל העובדים כולל כאלה שלא שויכו למחלקה
הצג מחלקות שאין בהן אף עובד

--EX2-q1
SELECT e.name, d.name AS department_name FROM employees e
INNER JOIN departments d ON d.department_id = e.department_id;

--EX2-q2
SELECT d.name AS department_name, count(e.name)  FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY d.name;

--EX2-q3
SELECT e.name, d.name AS department_name FROM employees e
LEFT JOIN departments d ON d.department_id = e.department_id;

--EX2-q4 (אין מחלקות כאלה)
SELECT d.name AS department_name, e.name FROM employees e
LEFT JOIN departments d ON d.department_id = e.department_id
WHERE e.name IS NULL;

--EX3
CREATE TABLE citizens (
    citizen_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE cable_tv (
    company_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE subscriptions (
    citizen_id INTEGER,
    company_id INTEGER,
    PRIMARY KEY (citizen_id, company_id),
    FOREIGN KEY(citizen_id) REFERENCES citizens(citizen_id),
    FOREIGN KEY(company_id) REFERENCES cable_tv(company_id)
);

INSERT INTO citizens (citizen_id, name) VALUES
(1, 'Rina'), (2, 'Avi'), (3, 'Lea'), (4, 'Moshe'),
(5, 'Gali'), (6, 'Bar'), (7, 'Itai'), (8, 'Sivan'),
(9, 'Elior'), (10, 'Hodaya');

INSERT INTO cable_tv (company_id, name) VALUES
(1, 'HOT'), (2, 'YES'), (3, 'Partner TV');

INSERT INTO subscriptions (citizen_id, company_id) VALUES
(1, 1), (1, 2),
(2, 2), (2, 3),
(3, 1), (4, 1),
(5, 3), (6, 3), (6, 1),
(7, 2);

הצג את כל המנויים עם שם האזרח ושם החברה
הצג את כל האזרחים וכמה חברות הם מנויים אליהן
הצג את כל חברות הכבלים וכמה מנויים יש להן
הצג אזרחים שלא מנויים לאף חברה
הצג חברות שאין להן אף מנוי

--EX3-q1
SELECT s.*, ci.name as citizen_name, ca.name as company_name
FROM subscriptions s
INNER JOIN cable_tv ca on s.company_id = ca.company_id
INNER JOIN citizens ci on s.citizen_id = ci.citizen_id;

--EX3-q2
SELECT ci.name AS citizen_name, COUNT(s.company_id) AS company_count
FROM citizens ci
LEFT JOIN subscriptions s ON ci.citizen_id = s.citizen_id
GROUP BY ci.citizen_id, ci.name;

--EX3-q3
SELECT ca.name AS company_name, COUNT(s.citizen_id) AS citizen_count
FROM cable_tv ca
LEFT JOIN subscriptions s ON ca.company_id = s.company_id
GROUP BY ca.company_id, ca.name;

--EX3-q4
SELECT ci.name AS citizen_name, s.company_id FROM citizens ci
LEFT JOIN subscriptions s ON ci.citizen_id = s.citizen_id
WHERE s.company_id IS NULL;

--EX3-q5 (אין כאלה חברות)
SELECT ca.name AS company_name, s.citizen_id FROM cable_tv ca
LEFT JOIN subscriptions s ON ca.company_id = s.company_id
WHERE s.citizen_id IS NULL;

Thank you Itay

