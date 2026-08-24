# Degrees of Conviction: The Intersection of Education and Crime in India

A reproducible R analysis examining the relationship between **state-level education expenditure and violent crime in India**.

This project was completed as part of the **Data, Democracy and Development (DDD)** course, *Introduction to Programming and Basic Data Analysis*, at **Azim Premji University, Bengaluru**.

The analysis examines 18 Indian states over approximately 2000–2019, asking whether states that allocate a larger share of their Gross State Domestic Product (GSDP) to education experience lower rates of violent crime.

---

## Problem statement

A considerable body of scholarship examines the relationship between education and crime. A common assumption is that crime is more prevalent among populations with lower levels of educational attainment, while investments in education may reduce the social costs associated with crime.

However, the relationship is not necessarily linear. Existing research has found, for example, that tertiary education may have a positive association with economic crime in Indian states (Rakshit & Neog, 2020). There remains comparatively limited evidence examining the relationship between educational investment and violent crime in particular.

Indian law categorises offences including murder, attempted murder, culpable homicide, grievous hurt, kidnapping and abduction, dacoity, robbery, riots, dowry deaths, rape, attempted rape, and arson as violent crimes.

In the post-reform decades, Indian states have allocated different amounts of expenditure to different levels of education. Understanding the relationship between educational investment and violent crime is relevant for policymakers seeking to develop informed strategies for crime reduction.

This project therefore examines whether differences in state investment in education are associated with differences in violent crime rates across Indian states.

---

## Objectives

The analysis focuses on the following 18 states:

- Andhra Pradesh
- Assam
- Bihar
- Gujarat
- Haryana
- Himachal Pradesh
- Jammu and Kashmir
- Jharkhand
- Karnataka
- Kerala
- Madhya Pradesh
- Maharashtra
- Odisha
- Punjab
- Rajasthan
- Tamil Nadu
- Uttar Pradesh
- West Bengal

The project has four main objectives:

1. **Trace the patterns of total GSDP each state spent on education from approximately 2000 to 2019.**
2. **Trace the patterns of violent crime in each state over the same period.**
3. **Investigate whether higher levels of educational investment correlate with lower violent crime rates at the state level.**
4. **Run a regression to determine the statistical significance of the relationship between education expenditure and violent crime.**

Through this study, we seek to answer the following questions:

- Is violent crime more common among states that spend less on education?
- Do state investments in education correspond with lower levels of violence in society?
- Can this relationship be understood by comparing the incidence of violent crimes with state-level educational investment?
- Do different levels of education have different relationships with violent crime?

---

## Data & methodology

### Data sources

The analysis uses three main prepared datasets:

1. **2011 District Census data**
   - District-level population and educational attainment.
   - Used to construct state-level measures of educational attainment.

2. **State education expenditure data**
   - State-wise education expenditure as a percentage of GSDP.
   - Covers approximately 2000–2019.
   - Used to examine trends in state-level educational investment.

3. **State-level violent crime data**
   - State- and year-level counts of violent crimes.
   - Used to construct the violent-crime measures and conduct the correlation, regression, and visual analyses.

A GeoJSON file containing Indian state boundaries is additionally used for the expenditure maps.

### Important note on data cleaning

**The original data-cleaning process is not provided in this repository.**

The analysis begins with datasets that had already been prepared and structured for analysis. This repository therefore documents the **analysis and visualisation workflow**, rather than providing a complete end-to-end raw-data cleaning pipeline.

The original data-cleaning work was undertaken separately and is not reproduced here. As a result, the repository reproduces the analysis **from the prepared input datasets**, but does not reproduce every step through which the original source files were downloaded, cleaned, reconciled, or transformed.

This is particularly relevant to the violent-crime data, for which the repository uses the prepared `final.csv` rather than providing the original crime-data cleaning workflow.

---

## Structure of the input data

The repository expects the prepared datasets to be placed in:

```text
data/
└── raw/
    ├── india-districts-census-2011_rev.csv
    ├── pct_gsdp.xlsx
    ├── final.csv
    └── india.geojson
```

### `india-districts-census-2011_rev.csv`

The Census dataset is structured at the **district level**.

Relevant variables include:

- state name
- district
- population
- primary education
- middle education
- secondary education
- higher education
- graduate education
- total education

The analysis aggregates these observations to the state level.

### `pct_gsdp.xlsx`

The education-expenditure dataset contains **state-wise education expenditure as a percentage of GSDP**.

The original structure represents years and states in a wide format. The analysis reshapes the dataset into a long state-year format for visualisation and subsequent analysis.

### `final.csv`

`final.csv` is the **prepared state-year analysis dataset** used for the principal crime analysis.

It contains observations organised approximately as:

```text
State × Year
```

with variables including:

- `state`
- `year`
- `expenditure`
- `total_violent_crimes`

The dataset is used for the main correlation, regression, and scatterplot analyses.

### `india.geojson`

The GeoJSON file contains Indian state boundaries and state identifiers.

It is used to produce maps showing state-wise education expenditure.

---

## Key variables

### Education expenditure

Education expenditure is measured as:

**Education expenditure (% of GSDP)**

Education expenditure is expressed as a percentage of GSDP rather than as an absolute monetary amount. This provides a relative measure of the importance of education expenditure within each state's economy and avoids directly comparing states with substantially different economic sizes.

### Educational attainment

The Census data are used to calculate the percentage of the state population represented by:

- Primary education
- Secondary education
- Higher education
- Total education

### Violent crime

The principal crime variable is the total number of violent crimes recorded for each state-year observation.

A population-adjusted measure is also constructed:

```text
Violent crimes per thousand =
(Total violent crimes / State population) × 1,000
```

The population adjustment allows comparisons between states with substantially different population sizes.

---

## Methods

### Educational attainment analysis

The 2011 Census data are aggregated from the district level to the state level.

Educational categories are then used to calculate the percentage of each state's population represented by primary, secondary, and higher education.

The analysis produces:

- total educational attainment by state;
- educational composition by state; and
- comparisons of educational attainment across the 18 states.

### Education expenditure analysis

State education expenditure is reshaped from its original format into a state-year panel.

The analysis examines:

- changes in expenditure over time;
- differences between states;
- state-wise expenditure trends; and
- geographical variation in expenditure.

### Crime-rate analysis

State population data from the 2011 Census are used to calculate violent crimes per thousand.

This measure is used to account for differences in population size between states.

### Correlation

Pearson's correlation coefficient is used to examine the association between education expenditure and violent crime.

The original analysis produced:

**r = 0.3231131**

with a **p-value below 0.001**.

This represents a statistically significant but weak positive association between education expenditure and violent crime in the analysed data.

### Regression

A simple linear regression is estimated:

```text
Violent crimes per thousand = β₀ + β₁ Education expenditure + ε
```

The original analysis estimated:

```text
Crimesᵢ = 0.12003 + 0.03512 expenditureᵢ + uᵢ
```

The coefficient on education expenditure was positive and statistically significant.

The model reported:

- **R² = 0.1044**
- **Adjusted R² = 0.1015**
- **Residual standard error = 0.1072**
- **F-statistic = 35.55**
- **p < 0.001**

The coefficient should be interpreted as an **association rather than a causal effect**.

A one-unit increase in education expenditure as a percentage of GSDP is associated with an estimated 0.03512-unit increase in violent crimes per thousand in the simple regression.

---

## Key findings

### Educational attainment

Among the 18 states examined, **Kerala** stands out with the highest overall educational attainment in the Census data, followed by **Himachal Pradesh, Tamil Nadu, and Karnataka**.

At the lower end are states such as **Bihar, Madhya Pradesh, and Rajasthan**, which show comparatively lower overall educational attainment.

Most states show relatively similar levels of primary education, while larger state-level differences emerge at the secondary and higher levels.

**Assam** also performs comparatively strongly in terms of educational attainment.

### Education expenditure

**Bihar, Jammu and Kashmir, and Assam** maintain relatively high education expenditure levels, exceeding 5% of GSDP in many years.

**Himachal Pradesh** shows expenditure increases towards the latter part of the period.

**Kerala, Odisha, and Jharkhand** generally remain in the middle range, while **Maharashtra, Tamil Nadu, Punjab, and Haryana** tend to allocate a comparatively smaller share of GSDP to education.

Several states experience a decline in education expenditure as a percentage of GSDP during the mid-2000s, followed by increases or stabilisation from approximately 2010–11 onwards.

### Education expenditure and violent crime

The descriptive analysis does not reveal the expected negative relationship between educational investment and violent crime.

Some states with comparatively high education expenditure also have relatively high violent-crime rates.

Conversely, states such as **Maharashtra, Gujarat, and Tamil Nadu** combine comparatively lower education expenditure shares with relatively low violent-crime levels.

The overall relationship between expenditure and violent crime is positive:

**r = 0.3231131, p < 0.001**

The regression similarly produces a positive and statistically significant coefficient.

However, this finding **does not mean that increasing education expenditure causes violent crime to increase**.

Possible explanations include reverse causality, omitted variables, differences in crime reporting, and differences in state socioeconomic conditions.

---

## Visual analysis

The repository produces several categories of visualisations.

### Figure 1 — Educational attainment

The educational-attainment visualisations compare total education and the composition of educational attainment across the 18 states using 2011 Census data.

### Education expenditure trends

State-wise expenditure visualisations trace education expenditure as a percentage of GSDP over time.

The state-level facet plots make it possible to compare expenditure trajectories across individual states.

### Education expenditure maps

State-level maps visualise geographical variation in education expenditure across the study period.

### Violent crime and education expenditure

Scatterplots examine the relationship between education expenditure and violent crime.

The repository includes:

- an overall scatterplot;
- year-wise scatterplots;
- state-wise scatterplots; and
- state-level violent-crime bar charts.

The overall trend line is positively sloped, consistent with the correlation and regression results.

However, the substantial dispersion around the trend line demonstrates that education expenditure alone explains only a limited proportion of variation in violent crime.

---

## Discussion

The results differ from the initial expectation that greater educational investment would correspond with lower violent crime.

The data instead show a weak positive association between education expenditure and violent crime.

One possible interpretation is that governments may increase educational expenditure in response to broader social problems. If states experiencing greater social problems also invest more heavily in education, the resulting correlation could be positive even if education itself has a crime-reducing effect.

Another possibility is that education expenditure is correlated with other state-level characteristics that influence crime.

For example, states differ substantially in:

- poverty;
- unemployment;
- income;
- inequality;
- political conditions;
- policing;
- reporting practices;
- socioeconomic development; and
- educational infrastructure.

These factors are not incorporated into the simple regression.

The results should therefore be interpreted as evidence of an **observed statistical association**, rather than evidence that educational investment produces higher violent crime.

---

## Limitations

### Data limitations

The original project encountered difficulties including:

- discrepancies between sources;
- missing observations;
- inaccessible data; and
- differences in how information was reported.

The original data-cleaning workflow is not included in this repository.

### Population and expenditure

Although violent crime is population-adjusted, education expenditure is measured as a percentage of GSDP.

This does not capture differences in:

- expenditure per student;
- absolute expenditure;
- population size;
- educational infrastructure; or
- efficiency of expenditure.

### Crime reporting

Reported violent crime is not necessarily equivalent to the true incidence of violent crime.

Differences in reporting, registration, policing, and institutional capacity between states may affect observed crime rates.

### Omitted variables

The regression does not control for factors that may influence both education expenditure and violent crime, including:

- poverty;
- unemployment;
- income inequality;
- gender;
- family background;
- political conditions;
- law enforcement;
- standard of living; and
- broader socioeconomic conditions.

### Causality

The analysis uses correlation and a simple linear regression.

It therefore cannot establish causality.

In particular, reverse causality is possible: states experiencing higher levels of social or criminal problems may respond by increasing educational expenditure.

### Lag effects

The effects of educational investment may take many years to materialise.

The approximately two-decade period examined here may therefore be insufficient to capture the full long-term relationship between educational investment and crime.

---

## Future directions

Future research could strengthen the analysis by:

- extending the time period to 50 years or more;
- incorporating unemployment rates;
- incorporating poverty measures;
- including income inequality;
- incorporating law-enforcement variables;
- measuring education expenditure per student;
- examining expenditure at different educational levels;
- incorporating educational quality measures;
- accounting for lagged effects;
- using state and year fixed effects; and
- examining within-state changes over time.

A richer panel-data approach could help distinguish changes occurring **within states** from persistent differences **between states**.

Including additional socioeconomic and institutional controls would also provide a stronger basis for understanding the mechanisms underlying the observed relationship.

---

## Repository structure

```text
degrees-of-conviction
│
├── run_analysis.R
│
├── scripts/
│   ├── 01_setup.R
│   ├── 02_education_attainment.R
│   ├── 03_education_expenditure.R
│   ├── 04_crime_analysis.R
│   ├── 05_correlation_regression.R
│   ├── 06_visualizations.R
│   └── 07_outputs.R
│
├── data/
│   ├── raw/
│   │   ├── india-districts-census-2011_rev.csv
│   │   ├── pct_gsdp.xlsx
│   │   ├── final.csv
│   │   └── india.geojson
│   │
│   └── processed/
│       └── [generated analysis datasets]
│
├── output/
│   ├── figures/
│   │   └── [generated figures]
│   │
│   └── tables/
│       └── [generated statistical outputs]
│
├── .gitignore
├── LICENSE
├── README.md
└── degrees-of-conviction.Rproj
```

---

## How to run it

### 1. Install R

The analysis was developed in **R/RStudio**.

R 4.2 or newer is recommended.

### 2. Install the required packages

```r
install.packages(c(
  "here",
  "dplyr",
  "ggplot2",
  "zoo",
  "tidyverse",
  "readxl",
  "rvest",
  "janitor",
  "sf",
  "geojsonsf",
  "stargazer"
))
```

### 3. Add the prepared data

Place the prepared input datasets in:

```text
data/raw/
```

The repository does **not** include the original data-cleaning workflow.

The input files must therefore already be in the structures described in the **Data & methodology** section.

### 4. Run the analysis

From the project root, run:

```r
source("run_analysis.R")
```

The scripts can also be run individually in sequence from the `scripts/` directory.

All paths are constructed relative to the project root using `here()`.

No machine-specific absolute paths are required.

---

## Outputs

Running the analysis generates files in:

```text
output/
├── figures/
└── tables/
```

### Figures

`output/figures/` contains the generated visualisations, including:

- educational attainment figures;
- education composition figures;
- state-wise expenditure trends;
- education expenditure maps;
- crime and expenditure scatterplots;
- year-wise scatterplots;
- state-wise scatterplots; and
- violent-crime bar charts.

### Tables

`output/tables/` contains statistical and summary outputs, including correlation and regression results where applicable.

### Processed data

Intermediate datasets generated during the analysis are stored in:

```text
data/processed/
```

This keeps generated data separate from the prepared input datasets in `data/raw/`.

---

## Requirements

- **R:** 4.2 or newer
- **RStudio:** recommended

### R packages

- `here`
- `dplyr`
- `ggplot2`
- `zoo`
- `tidyverse`
- `readxl`
- `rvest`
- `janitor`
- `sf`
- `geojsonsf`
- `stargazer`

---

## Course

This project was completed for:

**Data, Democracy and Development (DDD)**  
**Introduction to Programming and Basic Data Analysis**  
**Azim Premji University, Bengaluru**

---

## Individual contributions

- **Dhayashri R.K.:** Empirical Analysis — correlation and regression
- **Leina Louis:** Visualisations
- **Swetha R.:** Data Cleaning

The present repository focuses on the **analysis and visualisation components** of the project. The original data-cleaning workflow is not included.

---

## References

Asokan, T., & Kasinathan, O. (2021). Tracing the historical developments in higher education: The transformative journey of Tamil Nadu. *Webology, 18*(4), 2990–2992.

Groot, W., & van den Brink, H. M. (2010). The effects of education on crime.

Rakshit, B., & Neog, Y. (2020). Does higher educational attainment imply less crime? Evidence from the Indian states. *Journal of Economic Studies, 48*(1), 133–165. https://doi.org/10.1108/JES-05-2019-0218

Shrivastava, A. (2015). Economic development and Maoist insurgency. *Ideas for India*.

Taskin, B. (2024). Highest IPC crime rate among states, most IPC chargesheets filed — what NCRB data says about Kerala. *ThePrint*.

Additional data sources include **IndiaStat** and the datasets used for the project analysis.

---

## Citation

If you use or adapt this analysis, please cite:

> Louis, L., Dhayashri R.K., & Swetha R. (2026). *Degrees of Conviction: The Intersection of Education and Crime in India* [R analysis]. Azim Premji University.

---

## Authors

**Leina Louis, Dhayashri R.K., & Swetha R.**

**Azim Premji University, Bengaluru**
