###### 1: Getting Started

# Welcome to the Text Analysis: Matching and Linking Workshop! Today, we will discuss the use of 
# fuzzy linkage techniques to merge data sets at the research scale (small to medium size data sets). 
# If you have any specific questions following the workshop, please feel free to email me 
# (austinalleman2020\@u.northwestern.edu) or request a consultation with RCS
# (https://www.it.northwestern.edu/service-catalog/research/data-services/data-science.html).

##### 1.1: Installing and Loading Packages

# Check if tidyverse is installed. If not, install it. This package standardizes a wide variety of data manipulation and modeling packages.
if(!require(tidyverse)){
  install.packages("tidyverse")
}

# Check if stringdist is installed. If not, install it. This package implements string distance/similarity metrics.
if(!require(stringdist)){
  install.packages("stringdist")
}

# Check if fuzzyjoin is installed. If not, install it. This package implements joins based on string distances.
if(!require(fuzzyjoin)){
  install.packages("fuzzyjoin")
}

# Load libraries.
library(tidyverse)
library(stringdist)
library(fuzzyjoin)

##### 1: Analyzing Scraped Data
#####
#####

# Table 2: admission results table
admissions_results <- read_csv("data/gradcafe_cs_results.csv")

admissions_results

# Exercise part 1
admissions_results %>%
  select(degree, gpa) %>%
  filter(degree == "PhD", gpa > 0, gpa <= 4) %>%
  summarize(avg_gpa = mean(gpa, na.rm = TRUE))

# Exercise part 2
admissions_results %>%
  filter(degree == "PhD", gre_verbal > 130, gre_verbal <= 170, gre_quant > 130, gre_quant <= 170) %>%
  mutate(gre_total = gre_verbal + gre_quant) %>%
  summarize(avg_gre = mean(gre_total, na.rm = TRUE))

# Exercise part 3
admissions_results %>%
  group_by(institution) %>%
  summarize(num_results = n()) %>%
  arrange(desc(num_results)) %>%
  print(n = 50)

##### 2: Combining Data Sets
#####
#####

# Table 1: rankings table
rankings <- read_csv("data/rankings_table.csv")

rankings

join_results <- inner_join(rankings, admissions_results, 
                           by = "institution")
join_results

# Plot from slide
join_results %>%
  filter(degree == "PhD", 
         gpa > 0, 
         gpa <= 4, 
         decision %in% c("Accepted", "Rejected")) %>%
  ggplot() + 
  geom_boxplot(aes(x = decision, y = gpa, fill = institution)) +
  coord_cartesian(ylim = c(3,4)) + 
  ggtitle("GPA by Application Decision, USNWR Top 10 (1-10, left to right)")

# Print all institutions in admission_results with substring "Berkeley"
admissions_results %>%
  filter(str_detect(institution, "Berkeley")) %>%
  distinct(institution) %>%
  print(n = nrow(.))

##### 3: String Distances
#####
#####

stringdist("Northwestern", "Northeastern", method = "lv")

stringdist("Northwestern", "Northeastern", method = "qgram", q = 2)

lvr <- function(str_a, str_b){
  if(max(str_length(c(str_a, str_a))) == 0){return(0)}
  stringdist(str_a, str_b, method = "lv")/
    max(str_length(c(str_a, str_a)))
}

lvr("Northwestern", "Northeastern")

stringdist("Northwestern", "Northeastern", method = "jaccard", q = 2)


