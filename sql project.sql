-- 1. Branch Branch_no - Set as PRIMARY KEY Manager_Id Branch_address Contact_no
create database branch;

create table branch(branch_no int primary key,
branch_id int,
branch_address  varchar(20),
contact_no int);

INSERT INTO branch (branch_no, branch_id, branch_address, contact_no) VALUES
(1, 101, '123 Elm St', 1234),
(2, 102, '456 Oak St', 234567),
(3, 103, '789 Pine St', 34567),
(4, 104, '101 Maple St', 45678),
(5, 105, '202 Birch St', 56789);

select * from branch;


-- Employee Emp_Id – Set as PRIMARY KEY Emp_name Position Salary Branch_no - Set as FOREIGN KEY and it refer Branch_no in Branch table
create database employee;

CREATE TABLE Employee (
    Emp_Id INT PRIMARY KEY,
    Emp_name VARCHAR(255) NOT NULL,
    Position VARCHAR(100),
    Salary DECIMAL(10, 2),
    Branch_no INT,
    FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no));
    
    INSERT INTO Employee (Emp_Id, Emp_name, Position, Salary, Branch_no) VALUES
(1, 'Alice Johnson', 'Manager', 75000.00, 1),
(2, 'Bob Smith', 'Developer', 65000.00, 1),
(3, 'Charlie Brown', 'Designer', 60000.00, 2),
(4, 'Diana Prince', 'Analyst', 70000.00, 3),
(5, 'Ethan Hunt', 'Sales', 55000.00, 2);

select * from employee;
    
    
    -- Books ISBN - Set as PRIMARY KEY Book_title Category Rental_Price Status [Give yes if book available and no if book not available] Author Publisher
    create database books;
    
    CREATE TABLE Books (
    ISBN VARCHAR(13) PRIMARY KEY,  
    Book_title VARCHAR(100) NOT NULL,
    Category VARCHAR(100),
    Rental_Price DECIMAL(10, 2),
    Status ENUM('yes', 'no') NOT NULL,  
    Author VARCHAR(100),
    Publisher VARCHAR(100));
    
    INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher) VALUES
('978-3-16', 'The Great Gatsby', 'Fiction', 5.99, 'yes', 'F. Scott Fitzgerald', 'Scribner'),
('978-1-56', '1984', 'Dystopian', 6.99, 'yes', 'George Orwell', 'Secker & Warburg'),
('978-0-45', 'To Kill a Mockingbird', 'Fiction', 7.99, 'no', 'Harper Lee', 'J.B. Lippincott & Co.'),
('978-0-74', 'The Da Vinci Code', 'Mystery', 8.99, 'yes', 'Dan Brown', 'Doubleday'),
('978-0-46', 'Pride and Prejudice', 'Romance', 4.99, 'no', 'Jane Austen', 'T. Egerton');

select * from books;
    
    -- Customer Customer_Id - Set as PRIMARY KEY Customer_name Customer_address Reg_date
    
    create database customer;
    
    CREATE TABLE Customeer (
    Customer_Id INT PRIMARY KEY, 
    Customer_name VARCHAR(255) NOT NULL,  
    Customer_address VARCHAR(255),  
    Reg_date DATE NOT NULL  
);

INSERT INTO Customeer (Customer_Id, Customer_name, Customer_address, Reg_date) VALUES
(1, 'Alice Johnson', '123 Elm St, Springfield', '2024-01-15'),
(2, 'Bob Smith', '456 Oak St, Springfield', '2024-02-20'),
(3, 'Charlie Brown', '789 Pine St, Springfield', '2024-03-10'),
(4, 'Diana Prince', '101 Maple St, Metropolis', '2024-04-05'),
(5, 'Ethan Hunt', '202 Birch St, Gotham', '2024-05-22');

select * from customeer;

-- IssueStatus Issue_Id - Set as PRIMARY KEY Issued_cust – Set as FOREIGN KEY and it refer customer_id in CUSTOMER table Issued_book_name Issue_date Isbn_book – Set as FOREIGN KEY and it should refer isbn in BOOKS table

create database issuestatus;

CREATE TABLE IssueStatus (
    Issue_Id INT PRIMARY KEY,  
    Issued_cust INT,  
    Issued_book_name VARCHAR(100), 
    Issue_date DATE NOT NULL,  
    Isbn_book VARCHAR(13),  
    FOREIGN KEY (Issued_cust) REFERENCES Customeer(Customer_Id),  
    FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)  
);



INSERT INTO IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book) VALUES
(1, 1, 'The Great Gatsby', '2024-06-01', '978-3-16'),
(2, 2, 'game of thrones', '2024-06-05', '978-1-56'),
(3, 3, 'To Kill a Mockingbird', '2024-06-10', '978-0-45'),
(4, 4, 'The Da Vinci Code', '2024-06-15', '978-0-74'),
(5, 5, 'Pride and Prejudice', '2024-06-20', '978-0-45');

select * from issuestatus;

-- ReturnStatus Return_Id - Set as PRIMARY KEY Return_cust Return_book_name Return_date Isbn_book2 - Set as FOREIGN KEY and it should refer isbn in BOOKS

create database returnstatus;

CREATE TABLE ReturnStatus (
    Return_Id INT PRIMARY KEY,  
    Return_cust INT,  
    Return_book_name VARCHAR(100),  
    Return_date DATE NOT NULL,  
    Isbn_book2 VARCHAR(13),  
    FOREIGN KEY (Return_cust) REFERENCES Customeer(Customer_Id),  
    FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN));
    
INSERT INTO ReturnStatus (Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2) VALUES
(1, 1, 'The Great Gatsby', '2024-06-01', '978-3-16'),
(2, 2, 'game of thrones', '2024-06-05', '978-1-56'),
(3, 3, 'To Kill a Mockingbird', '2024-06-10', '978-0-45'),
(4, 4, 'The Da Vinci Code', '2024-06-15', '978-0-74'),
(5, 5, 'Pride and Prejudice', '2024-06-20', '978-0-45');

select  * from returnstatus;

-- 1.  Retrieve the book title, category, and rental price of all available books

SELECT Book_title, Category, Rental_Price
FROM Books
WHERE Status = 'yes';

-- 2. List the employee names and their respective salaries in descending order of salary.

SELECT Emp_name, Salary
FROM Employee
ORDER BY Salary DESC;

-- 3. Retrieve the book titles and the corresponding customers who have issued those books.
SELECT 
    Issue_Id,
    (SELECT Book_title FROM Books WHERE ISBN = Isbn_book) AS Book_Title,
    (SELECT Customer_name FROM customeer WHERE Customer_Id = Issued_cust) AS Customer_Name
FROM 
    IssueStatus;
    
    
-- 4.Display the total count of books in each category.

SELECT Category, COUNT(*) AS Total_Books
FROM Books
GROUP BY Category;

-- 5. Retrieve the employee names and their positions for the employees whose salaries are above Rs. 50,000.

SELECT Emp_name, Position
FROM Employee
WHERE Salary > 50000;

-- 6. List the customer names who registered before 2022-01-01 and have not issued any books yet.

SELECT C.Customer_name
FROM Customeer C
LEFT JOIN IssueStatus I ON C.Customer_Id = I.Issued_cust
WHERE C.Reg_date < '2022-01-01' AND I.Issued_cust IS NULL;

-- 7. Display the branch numbers and the total count of employees in each branch.

SELECT Branch_no, COUNT(*) AS Total_Employees
FROM Employee
GROUP BY Branch_no;

-- 8. Display the names of customers who have issued books in the month of June 2023.

SELECT DISTINCT C.Customer_name
FROM customeer C
JOIN IssueStatus ON C.Customer_Id = Issued_cust
WHERE MONTH(Issue_date) = 6 AND YEAR(Issue_date) = 2023;

-- 9. Retrieve book_title from the Books table containing the word "history".

SELECT Book_title
FROM Books
WHERE Book_title LIKE '%history%';

-- 10.Retrieve the branch numbers along with the count of employees for branches having more than 5 employees.

SELECT Branch_no, COUNT(*) AS Employee_Count
FROM Employee
GROUP BY Branch_no
HAVING COUNT(*) > 5;

-- 11. Retrieve the names of employees who manage branches and their respective branch addresses.

SELECT E.Emp_name, B.Branch_address
FROM Employee E
JOIN Branch B ON E.Emp_Id;

-- 12. Display the names of customers who have issued books with a rental price higher than Rs.25


SELECT DISTINCT c.customer_name
FROM customeer c
JOIN rental_price into books 
WHERE rental_price > 25; 


    
    
    