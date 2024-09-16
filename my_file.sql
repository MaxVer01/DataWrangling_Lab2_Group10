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
    amount NUMERIC(10, 2)
);

CREATE TABLE Borrows (
    customer_id CHAR(5),
    loan_number CHAR(5),
    PRIMARY KEY (customer_id, loan_number),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (loan_number) REFERENCES Loan(loan_number)
);
