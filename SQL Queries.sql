SELECT *
FROM [Bank Loan DB]..financial_loan

--- Total Loan Applications

SELECT COUNT(id) AS Total_Application
FROM [Bank Loan DB]..financial_loan

SELECT COUNT(id) AS MTD_Total_Application 
FROM [Bank Loan DB]..financial_loan
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

SELECT COUNT(id) AS PMTD_Total_Application        --- P : Previous Month to Date
FROM [Bank Loan DB]..financial_loan
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

--- Total Funded Amount

SELECT SUM(loan_amount) as Total_Funded_Amount
FROM [Bank Loan DB]..financial_loan

SELECT SUM(loan_amount) as MTD_Total_Funded_Amount
FROM [Bank Loan DB]..financial_loan
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

SELECT SUM(loan_amount) as PMTD_Total_Funded_Amount
FROM [Bank Loan DB]..financial_loan
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

--- Total Amount Received

SELECT SUM(total_payment) AS Total_Amount_Received
FROM [Bank Loan DB]..financial_loan

SELECT SUM(total_payment) AS MTD_Total_Amount_Received
FROM [Bank Loan DB]..financial_loan
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

SELECT SUM(total_payment) AS PMTD_Total_Amount_Received
FROM [Bank Loan DB]..financial_loan
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

--- Average Interest Rate

SELECT ROUND(AVG(int_rate), 4)*100 AS Avg_int_rate     --- ROUND : How many number i want in the column
FROM [Bank Loan DB]..financial_loan

SELECT ROUND(AVG(int_rate), 4)*100 AS MTD_Avg_int_rate     --- ROUND : How many number i want in the column
FROM [Bank Loan DB]..financial_loan
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

SELECT ROUND(AVG(int_rate), 4)*100 AS PMTD_Avg_int_rate     --- ROUND : How many number i want in the column
FROM [Bank Loan DB]..financial_loan
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

---Average Debt to Income Ratio

SELECT ROUND(AVG(cast(dti as float)), 4)*100 AS Avg_dti
FROM [Bank Loan DB]..financial_loan

SELECT ROUND(AVG(cast(dti as float)), 4)*100 AS MTD_Avg_dti
FROM [Bank Loan DB]..financial_loan
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

SELECT ROUND(AVG(cast(dti as float)), 4)*100 AS PMTD_Avg_dti
FROM [Bank Loan DB]..financial_loan
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

---------- GOOD LOAN ---------------
--- Good Loan Application Percentage

SELECT 
	(COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END)*100)
	/
	COUNT(id) AS Good_Loan_Percentage 
FROM [Bank Loan DB]..financial_loan

--- Good Loan Application

SELECT COUNT(id) AS Good_Loan_Applications
FROM [Bank Loan DB]..financial_loan
WHERE loan_status = 'Fully Paid' or loan_status = 'Current'

--- Good Loan Funded Amount

SELECT SUM(loan_amount) AS Good_Loan_Funded_Amount
FROM [Bank Loan DB]..financial_loan
WHERE loan_status = 'Fully Paid' or loan_status = 'Current'

--- Good Loan Total Received Amount

SELECT SUM(total_payment) AS Good_Loan_Total_Received_Amount
FROM [Bank Loan DB]..financial_loan
WHERE loan_status = 'Fully Paid' or loan_status = 'Current'

---------- BAD LOAN ---------------
--- Bad Loan Percentage

SELECT 
	(COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END)*100)
	/
	COUNT(id) AS Bad_Loan_Percentage 
FROM [Bank Loan DB]..financial_loan

--- Bad Loan Application

SELECT COUNT(id) AS Bad_Loan_Application
FROM [Bank Loan DB]..financial_loan
WHERE loan_status = 'Charged Off'

--- Bad Loan Funded Amount

SELECT SUM(loan_amount) AS Bad_Loan_Funded_Amount
FROM [Bank Loan DB]..financial_loan
WHERE loan_status = 'Charged Off'

--- Bad Loan Total Received Amount

SELECT SUM(total_payment) AS Bad_Received_Amount
FROM [Bank Loan DB]..financial_loan
WHERE loan_status = 'Charged Off'

---------- LOAN STATUS ---------------

SELECT
loan_status,
COUNT(id) AS LoanCount,
SUM(total_payment) AS Total_Amount_Received,
SUM(loan_amount) AS Total_Funded_Amount,
AVG(int_rate*100) AS int_rate,
AVG(cast(dti as float)*100) AS dti
FROM [Bank Loan DB]..financial_loan
GROUP BY loan_status

SELECT
loan_status,
SUM(total_payment) AS MTD_Total_Amount_Received,
SUM(loan_amount) AS MTD_Total_Funded_Amount
FROM [Bank Loan DB]..financial_loan
WHERE MONTH(issue_date) = 12
GROUP BY loan_status


------------------------ DASH 2 -------------------------
--- Monthly Trends by Issue Date

SELECT 
MONTH(issue_date) AS Month_Number,
DATENAME(MONTH, issue_date) AS Month_Name,
COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Received_Amount
FROM [Bank Loan DB]..financial_loan
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date)
ORDER BY MONTH(issue_date)

--- Regeional Analysis by State

SELECT 
address_state,
COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Received_Amount
FROM [Bank Loan DB]..financial_loan
GROUP BY address_state
ORDER BY SUM(loan_amount) DESC

--- Loan Term Analysis

SELECT
term,
COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Received_Amount
FROM [Bank Loan DB]..financial_loan
GROUP BY term
ORDER BY term

--- Employee Lenght Analysis

SELECT
emp_length,
COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Received_Amount
FROM [Bank Loan DB]..financial_loan
GROUP BY emp_length
ORDER BY emp_length

--- Loan Purpose Breakdown

SELECT
purpose,
COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Received_Amount
FROM [Bank Loan DB]..financial_loan
GROUP BY purpose
ORDER BY Total_Loan_Applications DESC

--- Home Ownership Analysis

SELECT
home_ownership,
COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Received_Amount
FROM [Bank Loan DB]..financial_loan
GROUP BY home_ownership
ORDER BY Total_Loan_Applications DESC


select avg(cast(dti as float))
FROM [Bank Loan DB]..financial_loan



