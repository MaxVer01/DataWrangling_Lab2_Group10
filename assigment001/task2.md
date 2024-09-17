
## Task 2 

### Task2 - a) Outer join : 
```sql
/* Task2 - a) Outer join : 
 *  The customers who have loans and, as well customers who haven't yet. 
 *  So we can offer them a customized services  
 */

SELECT c.first_name, c.last_name, c.email, c.phone_number, 
    CASE WHEN b.loan_number is NULL 
        THEN 'Offer Loan' 
        ELSE 'Offer other service' 
        END AS action 
    FROM Customer AS c LEFT OUTER JOIN Borrows AS b 
    ON c.customer_id =  b.customer_id ORDER BY c.first_name;

```

### Task2 b) Aggregate function : 

```sql
/* Task2 - b) Aggregate function : 
 *  We want to evaluate branches performance by their number of  
 *  granted loans and the average amounts    
 */


SELECT b.branch_name, b.city, b.country, 
    COUNT(l.loan_number) loan_count, 
    AVG(l.amount) AS average_loan_amount 
  FROM Loan AS l
  INNER JOIN Branch b ON l.branch_id = b.branch_id
  GROUP BY l.branch_id; 
```

### Task2 - c) Nested query  

```sql

/* Task2 - c) Nested query 
 *  Listing employees and their branches they belong 
 * by a particular payscale range  
 */


SELECT e.employee_id, e.first_name, e.last_name, e.payscale,
    b.branch_name from Employee as e
    INNER JOIN Branch b  
    WHERE e.payscale IN (  
        SELECT payscale FROM  Salaryhouse WHERE  amount BETWEEN 30000 AND 60000
    );

```

