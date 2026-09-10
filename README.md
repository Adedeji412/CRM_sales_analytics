# 📊 B2B Sales Performance & Quota Tracker

Hey there! Welcome to my data analytics portfolio. 

I built this end-to-end project to tackle a very real business problem: understanding how a B2B sales team is performing against their quotas, identifying where deals are falling out of the pipeline, and figuring out which products are actually driving the most revenue. 

If you are a hiring manager, a fellow data enthusiast, or just curious about how raw data translates to actionable business strategy—you are in the right place!

## 🛠️ The Tech Stack
* **Excel:** Initial data cleaning, standardizing null values, and engineering a custom `Sales Quotas` dimension table.
* **MySQL:** Writing DDL scripts to build a relational database schema from scratch and running exploratory business queries.
* **Power BI:** Connecting the data model, writing explicit DAX measures, and designing an interactive dashboard.

## 📉 The Business Problem
Sales managers often have a hard time seeing the "big picture" when data is scattered across different CRM tables. The goal of this project was to unify pipeline data, product details, and team targets to answer three core questions:
1. Who is actually hitting their targets?
2. Which product lines drive our highest margins?
3. Where is our sales funnel leaking?

## 💡 Key Business Insights & Recommendations

After modeling and visualizing the data, here is what the numbers revealed:

### 1. The "Lone Wolf" Quota Problem
* **Observation:** The Quota Attainment data shows a massive disparity. One sales rep (Darcel) is absolutely crushing it, generating over $1M and easily blowing past their target. Meanwhile, almost every other rep on the board is severely missing their quota.
* **Recommendation:** Sales leadership needs to investigate this immediately. We must find out what Darcel is doing differently and turn that strategy into a training playbook for the rest of the team. Alternatively, management needs to review if the current quota targets are unrealistically high for the average rep.

### 2. Product Concentration Risk
* **Observation:** The revenue treemap clearly shows that the *GTXPro* and *GTX Plus Pro* lines are the undisputed heavyweights, driving the vast majority of the $10.01M in total revenue. 
* **Recommendation:** Marketing and sales enablement should ensure all reps have top-tier collateral to sell these winners. However, to prevent over-reliance on just two products, management should consider creating "bundle deals," attaching lower-performing products to GTXPro contracts at a discount to boost their adoption.

### 3. CRM Data Integrity Leak (The Funnel Anomaly)
* **Observation:** The Sales Pipeline Funnel is upside down. The data shows 4K "Won" deals, but only 1K in "Prospecting" and 2K in "Engaging." In a healthy sales cycle, the top of the funnel should be the widest. 
* **Recommendation:** This points to a major process issue. Sales reps are likely not logging their early-stage leads into the CRM, bypassing the system until right before a deal closes just to get commission credit. Operations must enforce strict CRM logging from the "Prospecting" stage onward so leadership can actually forecast future pipeline health accurately.

## 📂 What is in this Repository?
* `CRM_Sales_Analysis.sql`: The complete SQL script containing my database creation structure (DDL) and initial exploratory queries.
* `B2B_Sales_Dashboard.pdf`: A static export of the final Power BI dashboard.
* `Dashboard_Screenshot.png`: A high-resolution look at the visual insights.

---
*Thanks for stopping by! I am always open to chatting about data analytics, business strategy, or this project. Let's connect!*
