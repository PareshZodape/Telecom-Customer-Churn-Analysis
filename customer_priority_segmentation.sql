CREATE DATABASE telecom_churn;
USE telecom_churn;

CREATE TABLE telecom_customers (
    customerID VARCHAR(50),
    gender VARCHAR(20),
    SeniorCitizen INT,
    Partner VARCHAR(10),
    Dependents VARCHAR(10),
    tenure INT,
    PhoneService VARCHAR(20),
    MultipleLines VARCHAR(30),
    InternetService VARCHAR(30),
    OnlineSecurity VARCHAR(30),
    OnlineBackup VARCHAR(30),
    DeviceProtection VARCHAR(30),
    TechSupport VARCHAR(30),
    StreamingTV VARCHAR(30),
    StreamingMovies VARCHAR(30),
    Contract VARCHAR(30),
    PaperlessBilling VARCHAR(10),
    PaymentMethod VARCHAR(50),
    MonthlyCharges DECIMAL(10,2),
    TotalCharges DECIMAL(10,2),
    Churn VARCHAR(10),
    CustomerValue DECIMAL(10,2),
    TenureGroup VARCHAR(20)
);


SELECT COUNT(*) AS total_customers
FROM telecom_customers;

SELECT *
FROM telecom_customers
LIMIT 10;

-- Q.1 Which customer segments show early signs of churn?
SELECT
    TenureGroup,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS churn_rate
FROM telecom_customers
GROUP BY TenureGroup
ORDER BY churn_rate DESC;


-- Q. 2 Churn by Senior Citizen Status
SELECT
    CASE
        WHEN SeniorCitizen = 1 THEN 'Senior Citizen'
        ELSE 'Non-Senior Citizen'
    END AS customer_age_group,
    
    COUNT(*) AS total_customers,
    
    SUM(
        CASE 
            WHEN Churn = 'Yes' THEN 1 
            ELSE 0 
        END
    ) AS churned_customers,
    
    ROUND(100.0 * SUM(
            CASE 
                WHEN Churn = 'Yes' THEN 1 
                ELSE 0 
            END
        ) / COUNT(*),
        2
    ) AS churn_rate

FROM telecom_customers

GROUP BY SeniorCitizen
ORDER BY churn_rate DESC;


-- Q.3 How many services does each customer currently use?
SELECT customerID,
    (
        CASE WHEN PhoneService = 'Yes' THEN 1 ELSE 0 END +
        CASE WHEN MultipleLines = 'Yes' THEN 1 ELSE 0 END +
        CASE WHEN OnlineSecurity = 'Yes' THEN 1 ELSE 0 END +
        CASE WHEN OnlineBackup = 'Yes' THEN 1 ELSE 0 END +
        CASE WHEN DeviceProtection = 'Yes' THEN 1 ELSE 0 END +
        CASE WHEN TechSupport = 'Yes' THEN 1 ELSE 0 END +
        CASE WHEN StreamingTV = 'Yes' THEN 1 ELSE 0 END +
        CASE WHEN StreamingMovies = 'Yes' THEN 1 ELSE 0 END
    ) AS product_count
FROM telecom_customers
LIMIT 10;

-- Q.4 OnlineSecurity VS Churn
SELECT
    OnlineSecurity,
    COUNT(*) AS total_customers,
    SUM(Churn = 'Yes') AS churned_customers,
    ROUND(SUM(Churn = 'Yes') * 100.0 / COUNT(*), 2) AS churn_rate
FROM telecom_customers
GROUP BY OnlineSecurity;

-- Q.5 Which contract types have the highest churn?  
SELECT
    Contract,
    COUNT(*) AS total_customers,
    SUM(Churn = 'Yes') AS churned_customers,
    ROUND(SUM(Churn = 'Yes') * 100.0 / COUNT(*), 2) AS churn_rate
FROM telecom_customers
GROUP BY Contract
ORDER BY churn_rate DESC;


-- Q.6 Which high-risk, high-value customers should retention focus on?
SELECT
    ROUND(AVG(CustomerValue), 2) AS average_customer_value
FROM telecom_customers;

SELECT customerID, tenure, Contract, MonthlyCharges, CustomerValue, Churn
FROM telecom_customers
WHERE Contract = 'Month-to-month'
AND tenure <= 12
AND CustomerValue > (
      SELECT AVG(CustomerValue)
      FROM telecom_customers
  )
  AND Churn = 'No'
ORDER BY CustomerValue DESC;



-- Create Risk Segment --

SELECT
    customerID,
    tenure,
    TenureGroup,
    SeniorCitizen,
    Contract,
    OnlineSecurity,
    TechSupport,
    MonthlyCharges,
    CustomerValue,
    Churn,

    CASE
        WHEN Contract = 'Month-to-month'
             AND tenure <= 12
             AND Churn = 'No'
        THEN 'High Risk'

        ELSE 'Low Risk'
    END AS RiskSegment

FROM telecom_customers;


-- Count customers in each segment-- 
SELECT
    RiskSegment,
    COUNT(*) AS total_customers
FROM (
    SELECT
        customerID,

        CASE
            WHEN Contract = 'Month-to-month'
                 AND tenure <= 12
                 AND Churn = 'No'
            THEN 'High Risk'
            ELSE 'Low Risk'
        END AS RiskSegment

    FROM telecom_customers
) AS risk_data

GROUP BY RiskSegment;


-- See the actual retention-priority customers --
SELECT
    customerID,
    tenure,
    Contract,
    MonthlyCharges,
    CustomerValue
FROM telecom_customers
WHERE Contract = 'Month-to-month'
  AND tenure <= 12
  AND Churn = 'No'
ORDER BY CustomerValue DESC;


-- We want Power BI to receive one clean table containing the original customer information plus our calculated RiskSegment. --

CREATE TABLE churn_analysis_final AS
SELECT
    customerID,
    gender,
    SeniorCitizen,
    Partner,
    Dependents,
    tenure,
    TenureGroup,
    PhoneService,
    MultipleLines,
    InternetService,
    OnlineSecurity,
    OnlineBackup,
    DeviceProtection,
    TechSupport,
    StreamingTV,
    StreamingMovies,
    Contract,
    PaperlessBilling,
    PaymentMethod,
    MonthlyCharges,
    TotalCharges,
    CustomerValue,
    Churn,

    CASE
        WHEN Contract = 'Month-to-month'
             AND tenure <= 12
             AND Churn = 'No'
        THEN 'High Risk'
        ELSE 'Low Risk'
    END AS RiskSegment

FROM telecom_customers;

-- Verify the data
SELECT *
FROM churn_analysis_final
LIMIT 10;

-- check the distribution
SELECT
    RiskSegment,
    COUNT(*) AS total_customers
FROM churn_analysis_final
GROUP BY RiskSegment;

