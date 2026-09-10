CREATE DATABASE crm_sales_analytics;
USE crm_sales_analytics;

CREATE TABLE tbl_Accounts (
account VARCHAR(100) PRIMARY KEY,
sector VARCHAR(50),
year_estabilished INT,
revenue DECIMAL(15,2),
employees INT,
office_location VARCHAR(50),
subsidiary_of VARCHAR(50)
) ENGINE=InnoDB;

CREATE TABLE tbl_Products (
product VARCHAR(100) PRIMARY KEY,
series VARCHAR(50),
sales_price DECIMAL(15,2)
) ENGINE=InnoDB;

CREATE TABLE tbl_Teams (
sales_agent VARCHAR(100) PRIMARY KEY,
manager VARCHAR(50),
regional_office VARCHAR(50)
) ENGINE=InnoDB;

CREATE TABLE tbl_Quotas (
sales_agent VARCHAR(100),
quarter VARCHAR(10),
quarterly_quota DECIMAL(15,2),
PRIMARY KEY (sales_agent, quarter),
CONSTRAINT fk_quota_agent FOREIGN KEY (sales_agent) REFERENCES tbl_Teams(sales_agent)
) ENGINE=InnoDB;

CREATE TABLE tbl_Pipeline (
opportunity_id VARCHAR(50) PRIMARY KEY,
sales_agent VARCHAR(100),
product VARCHAR(100),
account VARCHAR(100),
deal_stage VARCHAR(50),
engage_date DATE NULL,
close_date DATE NULL,
close_value DECIMAL(15,2) NULL,
sales_cycle_days INT NULL,
deal_status VARCHAR(50),
CONSTRAINT fk_agent FOREIGN KEY (sales_agent) REFERENCES tbl_Teams(sales_agent),
CONSTRAINT fk_product FOREIGN KEY (product) REFERENCES tbl_Products(product),
CONSTRAINT fk_account FOREIGN KEY (account) REFERENCES tbl_Accounts(account)
) ENGINE=InnoDB;


SELECT * FROM tbl_accounts;
SELECT * FROM tbl_pipeline;
SELECT * FROM tbl_products;
SELECT * FROM tbl_quotas;
SELECT * FROM tbl_teams;

-- What is our overall deal volume by stage, and how many of those actually turned into closed-won revenue?
SELECT 
deal_stage, 
COUNT(opportunity_id) AS total_deals,
SUM(CASE WHEN deal_status="Closed Won" THEN 1 ELSE 0 END) AS won_deals,
ROUND((SUM(CASE WHEN deal_status="Closed Won" THEN 1 ELSE 0 END) / COUNT(opportunity_id)) * 100, 2) 
AS win_rate_percentage
FROM tbl_pipeline
GROUP BY deal_stage
ORDER BY total_deals DESC;


-- Which Sales Rep are driving the most revenue, and who are their managers?
SELECT 
p.sales_agent,
t.manager,
COUNT(p.opportunity_id) AS total_deals_won,
SUM(p.close_value) AS total_revenue
FROM tbl_pipeline p
JOIN tbl_teams t
ON p.sales_agent = t.sales_agent
WHERE p.deal_status = "Closed Won"
GROUP BY p.sales_agent, t.manager
ORDER BY total_revenue DESC;

-- Which specific product lines and geographic territories generate the most revenue, and how long does to close these deals?
SELECT p.product,
t.regional_office,
COUNT(p.opportunity_id) AS total_deals_won,
SUM(p.close_value) AS total_revenue,
ROUND(AVG(p.sales_cycle_days), 1) avg_sales_cycle_days
FROM tbl_pipeline P
JOIN tbl_teams t
ON p.sales_agent = t.sales_agent
WHERE p.deal_status = "Closed Won"
GROUP BY p.product, t.regional_office
ORDER BY total_revenue DESC;

-- Which sales reps are exceeding their quarterly targets, amd who is falling behind?
WITH RevenueByQuarter AS (
SELECT sales_agent, 
CONCAT(YEAR(close_date), '-Q', QUARTER(close_date)) AS sales_quarter,
SUM(close_value) AS actual_revenue
FROM tbl_pipeline
WHERE deal_status = 'Closed Won' AND close_date IS NOT NULL 
GROUP BY sales_agent, CONCAT(YEAR(close_date), '-Q', QUARTER(close_date)))
SELECT q.sales_agent, q.quarter, q.quarterly_quota,
COALESCE(r.actual_revenue, 0) AS total_revenue,
ROUND((COALESCE(r.actual_revenue, 0) / q.quarterly_quota) * 100, 2) AS attainment_percentage
FROM tbl_quotas q 
LEFT JOIN RevenueByQuarter r
ON q.sales_agent = r.sales_agent AND q.quarter = r.sales_quarter
ORDER BY attainment_percentage DESC;






