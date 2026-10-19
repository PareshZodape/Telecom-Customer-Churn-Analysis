# Telecom-Customer-Churn-Analysis

**1. Business Problem**
- Problem: Telecom companies lose customers when subscribers discontinue their services, resulting in potential revenue loss.
- Business objective: Understand customer churn patterns, identify customer segments with higher churn rates, and prioritize active customers who may need retention attention.
- Key business question: Which customer segments show higher churn, and which active customers should the retention team prioritize?
- Business tools: Python, MySQL, and Power BI.
2. Project Workflow
1. Python — Clean & Explore
Data validation, cleaning, EDA, feature engineering


**2. MySQL — Analyze & Segment**
Business questions --> churn analysis --> customer risk segmentation


**3. Power BI — Visualize & Communicate**
Interactive dashboards, KPI tracking, retention recommendations


**3. Dataset Understanding**
- Used the IBM Telco Customer Churn dataset.
- Dataset contained 7,043 customer records and 21 original columns.
- Examined customer demographics, tenure, contract types, subscribed services, billing information, and churn status.
- Identified Churn as the target outcome for the descriptive analysis.
- Checked column names, data types, record counts, and missing or invalid values.


**4. Python — Data Cleaning and Exploratory Data Analysis**
- Loaded the dataset into a Pandas DataFrame.
- Inspected the first rows, column names, data types, and dataset structure.
- Checked for missing values, duplicate records, and inconsistent data.
- Investigated blank values in TotalCharges.
- Found 11 blank TotalCharges values and converted the column to numeric format, handling the blanks appropriately.
- Performed exploratory data analysis (EDA) to understand customer distributions and churn patterns.
- Calculated the overall churn rate.
- Created a CustomerValue column based on TotalCharges.
- Created a TenureGroup column to group customers by length of service:
  - 0–6 months
  - 7–12 months
  - 13–24 months
  - 25–48 months
  - 49–72 months
- Exported the cleaned dataset for subsequent analysis and visualization.


**5. MySQL — Business Analysis**
Used SQL queries to answer five business questions.
- Question 1: Which tenure groups have higher churn rates?
  - Grouped customers by tenure category and compared churn rates.
- Question 2: Which contract types have higher churn rates?
  - Compared churn rates across month-to-month, one-year, and two-year contracts.
- Question 3: Is service adoption associated with churn?
  - Compared churn rates by Online Security subscription status.
- Question 4: Does customer value differ between churned and retained customers?
  - Compared historical customer charges across churn status.
- Question 5: Which high-risk, high-value customers should retention focus on?
  - Created a simple rule-based risk segmentation and ranked high-risk customers by customer value.
Risk segmentation logic
- High Risk: Active customers (Churn = No) with a month-to-month contract and tenure of 12 months or less.
- Low Risk: All other customers.
- Sorted high-risk customers by CustomerValue in descending order to help prioritize retention outreach.
This is rule-based segmentation, not a machine-learning churn prediction model.


**6. Power BI — Dashboard Development**
Created a two-page interactive dashboard.
Page 1: Customer Churn Overview
- Added KPI cards for:
  - Total Customers
  - Churn Rate
  - Churned Customers
  - Average Customer Value
  - Total Revenue
- Built a Churn Rate by Tenure Group chart to compare customer lifecycle stages.
- Built a Churn Rate by Contract chart to compare contract types.
- Built a Churn Rate by Online Security chart to examine service adoption.
- Added a Customer Distribution by Risk Segment donut chart.
- Included slicers for Gender, Contract Type, Phone Service, and Payment Method.
- Used visuals to summarize churn patterns and customer characteristics.
Page 2: High-Risk Customer Prioritization
- Created KPI cards for:
  - High-Risk Customers: 970
  - Average Monthly Charges — High Risk: ₹49.26
  - Total Customer Value — High Risk: 258.2K
- Created a High-Risk Customer Priority Table.
- Included customer ID, tenure, contract type, monthly charges, and customer value.
- Filtered the table to display only High Risk customers.
- Ranked customers by customer value to support prioritization.
- Planned a Key Insights & Recommended Actions panel using findings from both dashboard pages.


**7. Key Findings and Insights**
The following findings are supported by the project calculations and current dashboard. Interpret the segment-specific patterns using the actual chart values.
- Overall churn: 1,869 of 7,043 customers churned, giving an overall churn rate of approximately 26.54%.
- Tenure pattern: The dashboard shows the highest churn rate in the 0–6-month group at approximately 53%, followed by 7–12 months at approximately 36%. This suggests early-tenure customers deserve attention.
- Contract pattern: The dashboard shows a churn rate of approximately 43% for month-to-month contracts, compared with 11% for one-year contracts and 3% for two-year contracts.
- Online Security: The displayed churn rates are approximately 31% for customers without Online Security and 15% for customers with it. This is an association, not proof that the service itself reduces churn.
- High-risk segment: 970 active customers meet the selected risk criteria.
- Customer prioritization: Sorting by CustomerValue provides a practical way to identify high-risk customers with higher accumulated historical charges.


**8. Business Recommendations**
- Improve early-tenure retention: Strengthen onboarding, follow up with new customers, and identify service issues during the first year.
- Encourage longer-term contracts: Test suitable loyalty incentives and annual-contract offers for month-to-month customers.
- Review service needs: Investigate whether customers without Online Security experience different support needs or churn patterns before deciding on service-related campaigns.
- Prioritize high-value customers: Contact high-risk customers with higher historical charges first, while considering their needs and the cost of retention.
- Monitor campaign effectiveness: Track churn and retention outcomes after implementing retention activities.


**9. Final Business Outcome**
- Converted raw customer data into a cleaned, analyzed, and visualized dataset.
- Identified customer groups associated with higher churn rates.
- Developed a transparent rule-based method to flag active customers for retention attention.
- Created a customer-level priority table to support targeted outreach.
- Built a two-page Power BI dashboard to communicate findings and proposed business actions.
Project conclusion: This project demonstrates an end-to-end data analytics workflow using Python for data preparation and EDA, MySQL for business analysis and segmentation, and Power BI for communicating findings and supporting customer-retention decisions.
