
## Task 2 



### a) Outer join : 

**Natural language**: The customers who have loans and, as well customers who haven't yet. 
   So we can offer them a customized services  

**Relational Algebra**:

Π <sub> first_name, last_name, email, phone_number, loan_number? 'Offer Loan' else 'Offer other service' </sub>(Customer ⟕  Borrows)  
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




### b) Aggregate function : 

**Natural language**:  We want to evaluate branches performance by their number of granted loans and the average amounts.

**Relational Algebra**: 

Π <sub>branch_name, city, country, loan_count</sub>,
 ρ<sub>loan_count</sub> (<sub>Loan.branch_id</sub> γ <sub>count(loan_number)</sub>,
 ρ<sub>average_loan_amount</sub> (<sub>Loan.branch_id</sub> γ <sub>average(amount)</sub>
   (Loan ⋈ Branch)



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

### c) Nested query  

**Natural language**:  Listing employees and their branches they belong by a particular payscale range. 

**Relational Algebra**:

 filteredPayscales ← Π <sub>payscale</sub>  (σ <sub>amout >= 30000 and amout <= 60000</sub> (Salaryhouse))

 Π <sub> employee_id, first_name, last_name, payscale, branch_name </sub> ( σ <sub>payscale ⊂ filteredPayscales </sub>  (Employee ⋈ Branch) )


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

