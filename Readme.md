# US vs. European Cars Analysis

## Project Overview
This analysis compares performance and fuel efficiency characteristics between US and European cars using a dataset of vehicles driven over 100,000 miles.

## Dataset Information
The dataset contains 100 observations with the following variables:
- `region`: Car origin (USA/Europe/Asia)
- `horsepower`: Engine power measurement
- `mpg_before`: Fuel efficiency before 75,000 miles
- `mpg_after`: Fuel efficiency after 75,000 miles

### Data Cleaning Steps
1. Removed single Asian car observation
2. Excluded outlier (Observation 38 with mpg_before=999)
3. Created calculated variable:
   ```sas
   avg_mpg = (mpg_before + mpg_after)/2

---

## 🔍 Key Findings from SAS Analysis

### 1. Horsepower Comparison
| Region  | Mean Horsepower | 90% Confidence Interval |
|---------|-----------------|-------------------------|
| All     | 245.89          | 232.23 - 259.54         |

- **European cars** dominate the high-end (e.g., 360HP, 405HP entries)
- **US cars** cluster in mid-range (78HP - 342HP)

### 2. Fuel Efficiency (MPG)
| Region  | Avg MPG (Mean) | 95% CI for Avg MPG       | p-value |
|---------|----------------|--------------------------|---------|
| Europe  | 29.43          | 26.39 - 32.48            | 0.0675  |
| USA     | 32.95          | 30.54 - 35.35            |         |

- US cars show **11.9% higher MPG** on average
- Difference approaches significance (p=0.0675)

### 3. MPG Over Time
| Comparison       | Mean Difference | 99% CI               | p-value |
|------------------|-----------------|----------------------|---------|
| After - Before   | +0.0122         | -0.0576 to +0.0821   | 0.6461  |

- **No significant change** in fuel efficiency after 75,000 miles

### 4. Distribution Analysis
| Variable      | Best Fit       | Skewness | Kurtosis | Key Limitation |
|---------------|----------------|----------|----------|----------------|
| Horsepower    | Gamma          | -        | -        | Poor fit for >400HP |
| MPG Before    | Weibull        | -0.3165  | -0.1679  | Left-skew challenges fit |

---

## 📊 Visualization Insights
1. **Horsepower Distribution**
   - Europe: Right-skewed with high-performance outliers
   - USA: More symmetrical distribution

2. **MPG Relationships**
   - Strong negative correlation between horsepower and MPG (r ≈ -0.7)
   - US cars form distinct cluster with higher MPG at lower horsepower

3. **Region Comparison**
   - Europe: 44 cars analyzed (after cleaning)
   - USA: 54 cars analyzed

## ⚙️ Data Cleaning Steps
1. Removed Asia region (1 observation)
2. Excluded outlier (Observation 38: mpg_before=999)
3. Created `avg_mpg` = (mpg_before + mpg_after)/2

## 🛠️ How to Reproduce
1. **Dataset**: `USEuropeCars.csv` (100 obs, cleaned to 98)
2. **SAS Code**:
   ```sas
   /* Key analysis snippet */
   PROC TTEST DATA=cleaned_cars ALPHA=0.01;
     PAIRED mpg_after*mpg_before;
     TITLE "MPG Change Over Mileage";
   RUN;
---

## 👤 Author

**[Sachin Ghogare]**  
Master's in Applied Statistics  
Aspiring Data Analyst | Machine Learning Enthusiast  

🔗 [Connect with me on LinkedIn][([www.linkedin.com/in/sachin-ghogare-325427208](https://www.linkedin.com/in/sachin-ghogare-325427208/))](https://www.linkedin.com/in/sachin-ghogare-325427208/)

---

## 📜 License

This project is intended for educational and demonstration purposes.
