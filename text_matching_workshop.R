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

# Check if fuzzyjoin is installed. If not, install it. This package implements the skim function.
if(!require(skimr)){
  install.packages("skimr")
}

# Load libraries.
library(tidyverse)
library(stringdist)
library(fuzzyjoin)
library(skimr)

##### 1.2: Preliminaries

# Creating toy data set
df <- tibble(x = c(1,2,3,4,5,6), 
             y = c("R", "C", "S", "R", "C", "S"))
df

# select example
select(df, x)

# filter example
filter(df, y == "R")

# arrange example
arrange(df, desc(x))

# mutate example
mutate(df, a = 2*x, b = paste0(y, "!"))

# group_by example
group_by(df, y)

# summarize example
summarize(df, x_sum = sum(x))

# View example
df %>% 
  View()

# Begin exercise 1

# End exercise 1

##### 1.3: Loading Data

# Table 1: rankings table

top_20_cs_schools <- c("Carnegie Mellon University", 
                       "Massachusetts Institute of Technology",
                       "Stanford University",
                       "University of California, Berkeley",
                       "University of Illinois, Urbana-Champaign",
                       "Cornell University",
                       "University of Washington",
                       "Georgia Institute of Technology",
                       "Princeton University",
                       "University of Texas, Austin",
                       "California Institute of Technology",
                       "University of Michigan, Ann Arbor",
                       "Columbia University",
                       "University of California, Los Angeles",
                       "University of Wisconsin, Madison",
                       "Harvard University",
                       "University of California, San Diego",
                       "University of Maryland, College Park",
                       "University of Pennsylvania",
                       "Rice University")

unswr_rank = 1:20
csr_rank = c(1,2,4,5,3,7,6,11,20,17,65,8,12,16,13,24,9,10,14,48)
nrc_rank = c(4,2,1,5,6,7,24,12,3,14,63,17,20,10,18,9,16,15,13,47)

institution_tbl <- tibble(institution = factor(top_20_cs_schools, 
                                               levels = top_20_cs_schools), 
                          unswr_rank = unswr_rank,
                          csr_rank = csr_rank,
                          nrc_rank = nrc_rank)

institution_tbl

# Table 2: admission results table

admissions_results <- read_csv("gradcafe_cs_results.csv")
admissions_results %>%
  skim()

admissions_results %>%
  group_by(institution) %>%
  summarize(num_results = n()) %>%
  arrange(desc(num_results)) %>%
  print(n = 50)




