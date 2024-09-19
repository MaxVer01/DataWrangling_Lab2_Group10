/*******************************************************************************
   Assignment 1: Data Extraction & Integration
   DB Server: Sqlite
   Author: Nelson Durañona Sosa, Aaron van Riet, Max Verwijmeren, Lisa Wang
   
**********************************************************************************/

--- Task 1

--- Making the Database

CREATE TABLE Customer (
    customer_id CHAR(5) PRIMARY KEY,
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    date_of_birth DATE,
    email VARCHAR(40),
    phone_number VARCHAR(17),
    street VARCHAR(100),
    house_number VARCHAR(10),
    city VARCHAR(50),
    country VARCHAR(50),
    zipcode VARCHAR(9)
);

CREATE TABLE Branch (
    branch_id CHAR(5) PRIMARY KEY,
    branch_name VARCHAR(100),
    street VARCHAR(100),
    building VARCHAR(50),
    street_number VARCHAR(10),
    city VARCHAR(50),
    country VARCHAR(50),
    zipcode VARCHAR(9)
);
CREATE TABLE Loan (
    loan_number CHAR(5) PRIMARY KEY,
    branch_id CHAR(5),
    amount NUMERIC(10, 2),
    interest_rate NUMERIC(4, 2),
    start_date DATE,
    end_date DATE,
    loan_type VARCHAR(50),
    FOREIGN KEY (branch_id) REFERENCES Branch(branch_id)
);
CREATE TABLE Account (
    account_number VARCHAR(5) PRIMARY KEY,
    customer_id CHAR(5),
    branch_id CHAR(5),
    account_type VARCHAR(50),
    balance NUMERIC(12, 2),
    opening_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (branch_id) REFERENCES Branch(branch_id)
);
CREATE TABLE "Transaction" (
    transaction_id CHAR(5) PRIMARY KEY,
    account_number VARCHAR(5),
    dest_account_number CHAR (5),
    transaction_type VARCHAR(50),
    amount NUMERIC(10, 2),
    transaction_date DATE,
    FOREIGN KEY (account_number) REFERENCES Account(account_number)
);
CREATE TABLE Employee (
    employee_id VARCHAR(5) PRIMARY KEY,
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    branch_id CHAR(5),
    function VARCHAR(50),
    payscale CHAR(2),
    hire_date DATE,
    email VARCHAR(100),
    phone_number VARCHAR(17),
    FOREIGN KEY (branch_id) REFERENCES Branch(branch_id),
    FOREIGN KEY (payscale) REFERENCES Salaryhouse(payscale)
);

CREATE TABLE Salaryhouse (
    payscale CHAR(2),
    amount NUMERIC(10, 2),
    PRIMARY KEY (payscale)
);

CREATE TABLE Borrows (
    customer_id CHAR(5),
    loan_number CHAR(5),
    PRIMARY KEY (customer_id, loan_number),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (loan_number) REFERENCES Loan(loan_number)
);


--- Task 2
--- Adding records
INSERT INTO Customer (customer_id, first_name, last_name, date_of_birth, email, phone_number, street, house_number, city, country, zipcode) VALUES
('C001', 'John', 'Doe', '1985-03-15', 'john.doe@email.com', '+12345678901', 'Maple Street', '123', 'New York', 'USA', '10001'),
('C002', 'Jane', 'Smith', '1990-07-22', 'jane.smith@email.com', '+12345678902', 'Oak Avenue', '456', 'Los Angeles', 'USA', '90001'),
('C003', 'Michael', 'Johnson', '1978-11-09', 'michael.johnson@email.com', '+12345678903', 'Pine Road', '789', 'Chicago', 'USA', '60601'),
('C004', 'Emily', 'Williams', '1995-02-28', 'emily.williams@email.com', '+12345678904', 'Elm Street', '101', 'Houston', 'USA', '77001'),
('C005', 'David', 'Brown', '1982-08-17', 'david.brown@email.com', '+12345678905', 'Birch Lane', '202', 'Phoenix', 'USA', '85001'),
('C006', 'Sarah', 'Jones', '1998-12-05', 'sarah.jones@email.com', '+12345678906', 'Cedar Court', '303', 'Philadelphia', 'USA', '19101'),
('C007', 'Chris', 'Miller', '1972-04-14', 'chris.miller@email.com', '+12345678907', 'Maple Street', '404', 'San Antonio', 'USA', '78201'),
('C008', 'Jessica', 'Garcia', '1989-09-10', 'jessica.garcia@email.com', '+12345678908', 'Oak Avenue', '505', 'San Diego', 'USA', '92101'),
('C009', 'Daniel', 'Martinez', '1981-06-25', 'daniel.martinez@email.com', '+12345678909', 'Pine Road', '606', 'Dallas', 'USA', '75201'),
('C010', 'Ashley', 'Rodriguez', '1994-01-18', 'ashley.rodriguez@email.com', '+12345678910', 'Elm Street', '707', 'San Jose', 'USA', '95101'),
('C011', 'Robert', 'Hernandez', '1986-05-20', 'robert.hernandez@email.com', '+12345678911', 'Birch Lane', '808', 'Austin', 'USA', '73301'),
('C012', 'Sophia', 'Lopez', '1993-10-30', 'sophia.lopez@email.com', '+12345678912', 'Cedar Court', '909', 'Fort Worth', 'USA', '76101'),
('C013', 'James', 'Gonzalez', '1979-12-11', 'james.gonzalez@email.com', '+12345678913', 'Maple Street', '111', 'Jacksonville', 'USA', '32201'),
('C014', 'Olivia', 'Perez', '1992-03-06', 'olivia.perez@email.com', '+12345678914', 'Oak Avenue', '222', 'Columbus', 'USA', '43004'),
('C015', 'Matthew', 'Davis', '1983-07-24', 'matthew.davis@email.com', '+12345678915', 'Pine Road', '333', 'Charlotte', 'USA', '28201'),
('C016', 'John', 'Doe', '1985-03-15', 'john.doe@email.com', '+12345678901', 'Maple Street', '124', 'New York', 'USA', '10001')

INSERT INTO Branch (branch_id, branch_name, street, building, street_number, city, country, zipcode) VALUES
('BR001', 'London Central', 'Oxford Street', 'Building A', '10', 'London', 'United Kingdom', 'W1D 1NN'),
('BR002', 'Paris Champs-Elysees', 'Avenue des Champs-Élysées', 'Building B', '21', 'Paris', 'France', '75008'),
('BR003', 'Berlin Mitte', 'Unter den Linden', 'Building C', '15', 'Berlin', 'Germany', '10117'),
('BR004', 'Madrid Gran Via', 'Calle Gran Vía', 'Building D', '34', 'Madrid', 'Spain', '28013'),
('BR005', 'Rome Termini', 'Via Marsala', 'Building E', '29', 'Rome', 'Italy', '00185'),
('BR006', 'Amsterdam Centrum', 'Damrak', 'Building F', '6', 'Amsterdam', 'Netherlands', '1012 LG'),
('BR007', 'Copenhagen Central', 'Vesterbrogade', 'Building G', '14', 'Copenhagen', 'Denmark', '1620'),
('BR008', 'Vienna Innere Stadt', 'Graben', 'Building H', '22', 'Vienna', 'Austria', '1010'),
('BR009', 'Zurich Bahnhofstrasse', 'Bahnhofstrasse', 'Building I', '7', 'Zurich', 'Switzerland', '8001'),
('BR010', 'Stockholm Central', 'Drottninggatan', 'Building J', '12', 'Stockholm', 'Sweden', '11151');

INSERT INTO Loan (loan_number, branch_id, amount, interest_rate, start_date, end_date, loan_type) VALUES
('LN001', 'BR001', 50000.00, 3.50, '2023-01-15', '2028-01-15', 'Home'),
('LN002', 'BR001', 80000.00, 3.50, '2023-01-17', '2028-01-15', 'Home'),
('LN003', 'BR002', 75000.00, 2.75, '2022-03-10', '2027-03-10', 'Business'),
('LN004', 'BR003', 30000.00, 4.00, '2021-06-25', '2026-06-25', 'Car'),
('LN005', 'BR004', 120000.00, 3.20, '2020-09-12', '2030-09-12', 'Home'),
('LN006', 'BR005', 45000.00, 3.80, '2023-05-05', '2028-05-05', 'Education'),
('LN007', 'BR006', 80000.00, 2.90, '2022-11-20', '2027-11-20', 'Business'),
('LN008', 'BR007', 60000.00, 3.25, '2021-08-18', '2026-08-18', 'Car'),
('LN009', 'BR008', 95000.00, 3.10, '2020-02-14', '2030-02-14', 'Home'),
('LN010', 'BR009', 35000.00, 3.65, '2023-07-01', '2028-07-01', 'Personal'),
('LN011', 'BR009', 35000.00, 3.60, '2023-07-04', '2028-07-01', 'Personal'),
('LN012', 'BR010', 70000.00, 2.10, '2021-12-22', '2026-12-22', 'Education'),
('LN013', 'BR010', 70000.00, 2.40, '2021-12-22', '2026-12-22', 'Education'),
('LN014', 'BR008', 56000.00, 9.10, '2024-09-12', '2025-03-22', 'Car');

INSERT INTO Borrows (customer_id, loan_number) VALUES
('C001', 'LN001'),
('C002', 'LN002'),
('C003', 'LN003'),
('C004', 'LN004'),
('C005', 'LN005'),
('C006', 'LN006'),
('C007', 'LN007'),
('C008', 'LN008'),
('C009', 'LN009'),
('C010', 'LN010'),
('C002', 'LN014'),
('C003', 'LN013');

INSERT INTO Salaryhouse (payscale ,amount) VALUES 
('A1', 30000),
('A2', 35000),
('A3', 40000),
('B1', 45000),
('B2', 55000),
('B3', 65000),
('C1', 75000),
('C2', 85000),
('C3', 100000);

INSERT INTO Employee (employee_id, first_name, last_name, branch_id, function, payscale, hire_date, email, phone_number) VALUES
('EMP01', 'John', 'Smith', 'BR001', 'Branch Manager', 'A1', '2018-06-15', 'john.smith@yourbank.com', '+44 20 7946 0958'),
('EMP02', 'Sophie', 'Martin', 'BR002', 'Loan Officer', 'B2', '2020-01-23', 'sophie.martin@yourbank.com', '+33 1 4042 6700'),
('EMP03', 'Lukas', 'Muller', 'BR003', 'Customer Service', 'C1', '2019-11-11', 'lukas.mueller@yourbank.com', '+49 30 2020 3333'),
('EMP04', 'Maria', 'González', 'BR004', 'Financial Analyst', 'B3', '2021-03-30', 'maria.gonzalez@yourbank.com', '+34 91 555 1212'),
('EMP05', 'Francesco', 'Rossi', 'BR005', 'Accountant', 'C2', '2017-09-19', 'francesco.rossi@yourbank.com', '+39 06 4745 6789'),
('EMP06', 'Emma', 'De Vries', 'BR006', 'Loan Officer', 'B2', '2022-02-01', 'emma.devries@yourbank.com', '+31 20 555 6789'),
('EMP07', 'Anders', 'Hansen', 'BR007', 'Customer Service', 'C1', '2020-07-10', 'anders.hansen@yourbank.com', '+45 33 123 456'),
('EMP08', 'Anna', 'Schmidt', 'BR008', 'Branch Manager', 'A1', '2016-12-05', 'anna.schmidt@yourbank.com', '+43 1 505 7766'),
('EMP09', 'Lea', 'Dubois', 'BR009', 'Financial Analyst', 'B3', '2021-08-18', 'lea.dubois@yourbank.com', '+41 44 214 5555'),
('EMP10', 'Oskar', 'Johansson', 'BR010', 'Accountant', 'C2', '2019-05-27', 'oskar.johansson@yourbank.com', '+46 8 555 9100');

--- write queries in natural language, relational algebra and SQL that contains:
--- Left outer join
--- Aggregate function
--- Nested query

--- Left outer join
SELECT c.first_name, c.last_name, c.email, c.phone_number, 
    CASE WHEN b.loan_number is NULL 
        THEN 'Offer Loan' 
        ELSE 'Offer other service' 
        END AS action 
    FROM Customer AS c LEFT OUTER JOIN Borrows AS b 
    ON c.customer_id =  b.customer_id ORDER BY c.first_name;

--- Aggregate function
SELECT b.branch_name, b.city, b.country, 
    COUNT(l.loan_number) loan_count, 
    AVG(l.amount) AS average_loan_amount 
  FROM Loan AS l
  INNER JOIN Branch b ON l.branch_id = b.branch_id
  GROUP BY l.branch_id; 

--- Nested query
SELECT e.employee_id, e.first_name, e.last_name, e.payscale,
    b.branch_name from Employee as e
    INNER JOIN Branch b  
    WHERE e.payscale IN (  
        SELECT payscale FROM  Salaryhouse WHERE  amount BETWEEN 30000 AND 60000
    );