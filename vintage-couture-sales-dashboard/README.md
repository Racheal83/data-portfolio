# 🧾 Vintage Couture Sales Analysis Dashboard

**Project Type:** Data Analytics & Excel Dashboard  
**Tools Used:** Microsoft Excel, Pivot Tables, VLOOKUP, Nested IF, Slicers, Charts  
**Domain:** Retail, Fashion, E-Commerce

## 🧵 Project Overview

This project analyzes sales performance and customer demographics for *Vintage Couture*, a boutique retailer specializing in sustainable and retro fashion. The business operates both online and across multiple cities, offering unique vintage apparel.

The goal of the analysis is to deliver clear, actionable insights through an interactive Excel dashboard to support strategic decisions in inventory planning, customer engagement, and marketing.

---

## 🎯 Objectives
- Calculate total revenue and identify top-performing months
- Classify customers by age group and gender
- Compare performance across product categories and regions
- Analyze differences in sales channels
- Present insights in a dynamic, filterable dashboard

---

## 🧹 Data Preparation
Cleaned raw sales and customer demographic data
- Used `VLOOKUP` to enrich the main sales dataset with:
  - **Gender** and **Payment Method** using `Customer ID` as the lookup key
  - **State** and **Region** using `Location ID` as the lookup key
- Applied `IF` statements to categorize customers into age groups:
  - 18–30: Young Adult
  - 31–40: Adult
  - 41–49: Middle-aged Adult
  - 50+: Senior
- Extracted **month** from `Date` using `=MONTH(Date)` to analyze monthly trends
---

## 🛠️ Excel Features Used
- `VLOOKUP` for dataset joins
- `IF` and `IFS` for conditional grouping
- Pivot Tables for aggregation and cross-tabulation
- Pivot Charts for visualizations
- Slicers to filter by:
  - Payment Method
  - Product Category
  - Sales Channel
- Dynamic KPI cards using formulas
- pie and bar charts for categorical comparisons

---

## 📊 Dashboard Visuals

The interactive Excel dashboard includes:
- Revenue by Gender
- Top Product Categories by Quantity Sold
- Monthly revenue trend chart
- Revenue by Age Group 
- Average revenue per region
- Slicers for Payment Method and Category filtering

---

## 🔍 Key Insights & Recommendations

### 📊 Revenue by Gender
- **Insight:** Female customers contributed ₦11.5M vs ₦6.6M from male customers.
- **Recommendation:** Focus marketing efforts and inventory toward women’s fashion.

### 🧥 Top-Selling Product Categories by Quantity
- **Insight:** *Suit* (10,905 units) and *Denim* (10,389 units) were top-selling.
- **Recommendation:** Promote bundles and upsell campaigns targeting these categories.

### 📆 Monthly Revenue Trends
- **Insight:** March had the highest revenue (₦1.67M).
- **Recommendation:** Investigate March campaigns for replication opportunities.

### 👖 Revenue by Product Category
- **Insight:** *Denim* alone generated over ₦5M.
- **Recommendation:** Prioritize restocking and expand denim offerings.

### 🧑‍🤝‍🧑 Revenue by Age Group
- **Insight:** Young Adults (18–30) led with ₦5.9M in revenue.
- **Recommendation:** Tailor ads and products to this group’s preferences.

### 🌐 Sales Channel Performance
- **Insight:** Online sales dominated with ₦11.5M.
- **Recommendation:** Optimize online store UX and digital campaigns.

### 🗺️ Regional Revenue Performance
- **Insight:** North-East led with average revenue per sale of ₦683.94.
- **Recommendation:** Explore pricing, product mix, and buyer behavior in this region.

---

## 📎 File Contents

- `Revenue trend dashboard.xlsx` – Fully interactive Excel dashboard
- `README.md` – This documentation

---

## 📌 How to Use

1. Open the Excel file
2. Use slicers to filter by Payment Method, Product Category, or channel sales
3. View auto-updating visuals and KPI metrics
4. Explore the pivot tables for drill-down analysis

---

## 🧠 What I Learned

- Applying Excel functions for real-world business questions
- Building dashboards that communicate insights visually and interactively
- Transforming raw data into strategic business recommendations
