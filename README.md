# Data-Science-black-hates-
Interactive R Shiny dashboard for analyzing customer data, clustering users, and discovering product associations using Apriori algorithm
🕵️‍♂️ Black Hats Project: Customer Data Analysis Dashboard

An interactive R Shiny dashboard for exploratory data analysis, customer segmentation, and association rule mining. Upload your own customer CSV data and gain actionable insights with a few clicks.

🚀 Features

The Black Hats Project helps businesses make data-driven decisions using visualizations and machine learning techniques. Main features include:

📊 Data Visualization

Visualize your customer data with dynamic and interactive charts:

Pie Chart: Distribution of payment methods (Cash vs Credit)

Bar Charts: Age vs Spending, City-wise totals

Histograms: Distribution of total spending

Multi-panel Visualization: All graphs in one dashboard (via patchwork)

📈 K-Means Clustering

Segment your customers into clusters based on:

Age

Total Spending

Adjust the number of clusters (2 to 4) and view detailed cluster results in an interactive table.

🔍 Market Basket Analysis (Apriori)

Discover frequently purchased item combinations using the Apriori Algorithm:

Adjustable support and confidence sliders

Filters rules with lift > 1.5 for meaningful associations

Outputs association rules in a readable table

🧑‍💼 Use Case

Ideal for:

Small businesses analyzing customer transactions

Marketing teams looking to create targeted campaigns

Data analysts wanting an interactive EDA tool

Retailers building product bundles or promotions

🛠️ Technologies Used

R Shiny: Interactive web app framework

ggplot2 + patchwork: Advanced visualizations

arules + arulesViz: Market basket analysis

dplyr + tidyverse: Data manipulation

DT: Interactive data tables

shinythemes: Custom UI theme (cyborg)

📂 File Upload Format

Upload your CSV with the following expected columns:

Column Name	Description
customer	Unique customer ID
age	Customer age
city	Customer city
total	Total amount spent
paymentType	Payment method (e.g., Cash, Credit)
count	Number of transactions
items	Purchased items (comma-separated)
rnd	Random or time-related grouping column

⚠️ The app performs automatic data cleaning, including removing missing values and filtering out outliers in age, count, and total.

🌐 App Structure

The app is organized into four main tabs:

Visualization
Upload CSV and choose from different graph types.

K-means Clustering
Enter cluster count (2–4) and view grouped customers.

Apriori
Set support and confidence thresholds to generate rules.

About
Learn more about the app, goals, and team (Arabic description).

🌍 About the Project (بالعربي)

تم تطوير المشروع لتحليل بيانات العملاء بشكل تفاعلي وسهل باستخدام R Shiny. يوفر أدوات لفهم سلوك العملاء، توزيعهم حسب العمر أو المدينة، وتحليل سلة المشتريات باستخدام خوارزميات ذكية.

📸 Sample Screenshots (Add screenshots if available)

Dashboard Overview

Clustered Customer Table

Market Basket Rules Output

🧪 Getting Started Locally

To run the app locally:

Clone the repo:

git clone https://github.com/YOUR_USERNAME/black-hats-project.git
cd black-hats-project


Open the app.R in RStudio

Install required packages if not installed:

install.packages(c(
  "shiny", "shinythemes", "ggplot2", "patchwork", "DT", "dplyr",
  "readr", "arules", "arulesViz", "tidyverse", "tidyquant", "DataEditR", "gridExtra"
))


Run the app:

shiny::runApp("app.R")

👨‍💻 Developed By

BLACK HATS TEAM

Have a feature request or found a bug? Open an issue
