rm(list=ls())

# installing tidyverse as of 10 February 2021: https://www.tidyverse.org/
install.packages("tidyverse")

library(tidyverse)

md_scs <- read_csv("data/2019_Accountability_Schools(1).csv")

## Base R
# keep variables

# Add a variable
md_scs$state_id <- sprintf("%02d", md_scs$`LSS Number`)
md_scs$school_id <- sprintf("%04d", md_scs$`School Number`)

#This works for six string id
md_scs$state_id <- paste0(
  sprintf("%02d", md_scs$`LSS Number`),
  sprintf("%04d", md_scs$`School Number`) 
)


md_scs$`LSS Name` <- tolower(md_scs$`LSS Name`)

# change variable names (by column)
colnames(md_scs) <- c(1:10)

# keep or drop variables
md_scs[,c("school.name", "star.rating", "state.id")]
setdiff()

md_scs[, setdiff(colnames(md_scs), c("year"))] # drop

## Dplyr - Tidyverse Library ##
# keep variables
select(md_scs, 'LSS Number', "School Name", "Star Rating", state_id, school_id)

# drop variables
analytic <- select(md_scs, -year)

# mutate
analytic <- mutate(md_scs,
    state_id = paste0(
      sprintf("%02d", 'LSS Number'),
      sprintf("%04d", 'School Number')
    ),  
      lss.name = tolower(lss.name))

# RENAME #

analytic <- rename(md_scs, year = Year, lss.name = 'LSS Name')
colnames(md_scs) <- gsub(" ", ".", tolower(colnames(md_scs)))

analytic <- rename(md_scs, year = Year)
analytic <- filter(md_scs, lss.number == 30, star.rating > 2)

#### EXAMPLE ####
rm(list=ls())
library(tidyverse)

analytic_raw <- read_csv("data/2019_Accountability_Schools(1).csv")
# - schid : School Number
# - schname : School Name
# - rating : Star Rating
# - totalpts : Total Points Earned Percentage
# observations : Baltimore City Schools and Baltimore County Schools

## Select the desired variables

analytic <- select(analytic_raw, 'School Number', 'School Name', 'LSS Number', 'Star Rating', 'Total Points Earned Percentage')

## Rename the variables

colnames(analytic) <- c("school_id", "school_name", "lss_id", "totalpts", "rating")

## Select the desired observations

analytic <- filter(analytic, lss_id == 30 | lss_id == 3)
analytic <- select(analytic, -lss_id)

## Recode Variables 
analytic <- mutate(analytic, totalpts = totalpts/100)

## Analyses or SAVE

save(analytic, analytic_raw, file = "data/analytic.Rdata")
load(data/analytic.Rdata)

#Piping

view(filter(analytic, rating > 2))
%>%
  
# Missing Data
analytic_raw %>% filter(., complete.cases(.))
analytic_raw <- mutate_all(analytic_raw, function(x) { ifelse(x == "na", NA, x)})
