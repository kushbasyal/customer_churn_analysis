# Customer Churn Analysis & Prediction

## Overview

This repository contains an end-to-end data analytics project focused on analysing customer churn patterns, segmenting customers, and building machine learning models to predict churn.

The project combines Python, SQL, machine learning, and Power BI to analyse customer behaviour and communicate business-focused insights.

---

## Project Structure

```text
customer-churn-analysis/
│
├── data/
│   ├── raw/                  # Original source data
│   └── processed/            # Cleaned data ready for analysis
│
├── notebooks/                # Analysis and experimentation
│   ├── data_preprocessing.ipynb
│   ├── clustering.ipynb
│   ├── modeling.ipynb
│   └── load_to_database.ipynb
│
├── scripts/                  # Reusable Python code
│   ├── paths.py
│   ├── preprocessing.py
│   └── main.py
│
├── docs/                     # Detailed project documentation
│   ├── preprocessing.md
│   ├── clustering.md
│   └── modeling.md
│
├── visualizations/           # Saved analysis and model visualizations
│   ├── preprocessing/
│   ├── clustering/
│   └── modeling/
│
├── .env                      # Local environment variables
├── .gitignore
├── config.json
├── requirements.txt
└── README.md
```

---

## Tools & Technologies

* **Language:** Python 
* **Data Processing:** Pandas, NumPy
* **Machine Learning:** Scikit-learn
* **Data Visualization:** Matplotlib, Seaborn
* **Database & SQL:** PostgreSQL
* **Dashboard:** Power BI
* **Development:** Visual Studio Code, Jupyter Notebook, Git & GitHub

---

## Quickstart

Install the required dependencies:

```bash
pip install -r requirements.txt
```

---

## Project Workflow & Analysis

### 1. Data Preprocessing & EDA

The raw customer data is inspected, cleaned, and prepared for analysis. Data quality, missing values, duplicates, data types, and relevant customer attributes are explored.

[Read the preprocessing documentation](docs/preprocessing.md)

### 2. Customer Segmentation

K-Means clustering is used to identify groups of customers with similar characteristics and behaviours.

[Read the clustering documentation](docs/clustering.md)

### 3. Churn Prediction

Machine learning models are trained and evaluated to identify customer characteristics associated with churn and predict customers more likely to churn.

[Read the modeling documentation](docs/modeling.md)

### 4. SQL Analysis

The processed dataset is loaded into PostgreSQL and analysed using SQL to answer business-focused questions.

### 5. Power BI Dashboard

Key metrics, churn patterns, customer segments, and other findings are presented through an interactive Power BI dashboard.

---

## Power BI Dashboard

![Power BI Dashboard](/powerbi/dashboard.png)

---

## Project Outcome

The project brings together data preprocessing, exploratory analysis, customer segmentation, machine learning, SQL, and Power BI to provide a complete view of customer churn.
