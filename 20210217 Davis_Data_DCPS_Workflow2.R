### 20210210 Data Workflow Project ###
# Author: Avery M.D. Davis
# Purposes: Homework
# 1) Donload and import DCPS data
# 2) Locate outcome/dependent variable of interest
###

library(tidyverse)

### Setup Environment
## 1) website for retrieval as of 7 February 2021:
# https://opendata.dc.gov/datasets/4ac321b2d409438ebd76a6569ad94034_5/data

library(readr)
dcps_public_schools <- read_csv("dcps_public_schools.csv")
View(dcps_public_schools)

library(readxl)
DCPS_SY19_20_Enrollment_Audit <- read_excel("DCPS-SY19-20-Enrollment-Audit.xlsx")
View(DCPS_SY19_20_Enrollment_Audit)

## 2) website for retrieval of SAT Scores 7 February 2021:
# https://dcps.dc.gov/node/1018312

library(readxl)
School_Year_2019_2020_SAT_Scores <- read_excel("School-Year-2019-2020-SAT-Scores.xlsx", range = "A6:F27")
View(School_Year_2019_2020_SAT_Scores)

## rename row

colnames(School_Year_2019_2020_SAT_Scores) <- c("GIS_ID", "NAME", "NUM_TEST", "READ_AVG", "MATH_AVG", "TOTAL_AVG")

## change var

# %>% View - this allows for a preview of an expression

School_Year_2019_2020_SAT_Scores <- mutate(School_Year_2019_2020_SAT_Scores, GIS_ID = paste0("dcps_", GIS_ID)) 