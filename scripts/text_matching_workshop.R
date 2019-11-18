##### 0: GETTING STARTED
#####
#####

# Welcome to the Text Analysis: Matching and Linking Workshop! Today, we will discuss the use of 
# fuzzy linkage techniques to merge data sets at the research scale (small to medium size data sets). 
# If you have any specific questions following the workshop, please feel free to email me 
# (austinalleman2020\@u.northwestern.edu) or request a consultation with RCS
# (https://www.it.northwestern.edu/service-catalog/research/data-services/data-science.html).

# Installing and loading packages 
install.packages("tidyverse")
install.packages("stringdist")
install.packages("fuzzyjoin")

# Load libraries and functions.
library(tidyverse)
library(stringdist)
library(fuzzyjoin)
source("scripts/user_defined_functions.R")




##### 1: ANALYZING SCRAPED DATA
#####
#####

# Table 2: admission results table
admissions_results <- read_csv("data/gradcafe_cs_results.csv")

admissions_results


# Exercise part 1


# Exercise part 2


# Exercise part 3






##### 2: COMBINING DATA SETS
#####
#####

# Table 1: rankings table
rankings <- read_csv("data/rankings_table.csv") %>%
  mutate(institution = factor(institution, levels = .$institution))

rankings


# INNER JOIN
join_results <- inner_join(rankings, admissions_results, 
                           by = "institution")
join_results


# FIRST GPA PLOT FROM SLIDES
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


# ADD A STANDARDIZED KEY TO BOTH TABLES
rankings_adj <- rankings %>%
  mutate(institution_key = standardize_key(institution))

admissions_results_adj <- admissions_results %>%
  mutate(institution_key = standardize_key(institution))

# INNER JOIN ON STANDARDIZED KEY
join_results_adj <- inner_join(rankings_adj, admissions_results_adj, 
                           by = "institution_key")
join_results_adj

# SECOND GPA PLOT FROM SLIDES
join_results_adj %>%
  filter(degree == "PhD", 
         gpa > 0, 
         gpa <= 4, 
         decision %in% c("Accepted", "Rejected")) %>%
  ggplot() + 
  geom_boxplot(aes(x = decision, y = gpa, fill = institution.x)) +
  coord_cartesian(ylim = c(3,4)) + 
  ggtitle("GPA by Application Decision, USNWR Top 10 (1-10, left to right)")



##### 3: MEASURING CLOSENESS OF STRINGS
#####
#####

stringdist("Northwestern", "Northeastern", method = "lv")

stringdist("Northwestern", "Northeastern", method = "qgram", q = 2)

lvr("Northwestern", "Northeastern")

stringdist("Northwestern", "Northeastern", method = "jaccard", q = 2)

# Exercise Strings:
# "Dartmouth College", "Darmtouth College"
# "University of California", "The University of California" 
# "Stanford University", "University of Stanford" 

# Exercise part a

# Exercise part b





##### 4: COMBINING DATA SETS FUZZILY
#####
#####

# run fuzzy join
fuzzy_join_results <- stringdist_inner_join(rankings_adj,
                                            admissions_results_adj, 
                                            by = c("institution_key" = "institution_key"),
                                            method = "jaccard", q = 2, max_dist = .2,
                                            distance_col = "dist")
fuzzy_join_results

# see most different matches first
fuzzy_join_results %>% 
  filter(dist > 0) %>%
  group_by(institution.x, institution.y) %>% 
  summarize(num_results = n(),
            dist = first(dist)) %>%
  arrange(desc(dist)) %>% 
  View()


# THIRD GPA PLOT FROM SLIDES
fuzzy_join_results %>%
  filter(degree == "PhD", 
         gpa > 0, 
         gpa <= 4, 
         decision %in% c("Accepted", "Rejected")) %>%
  ggplot() + 
  geom_boxplot(aes(x = decision, y = gpa, fill = institution.x)) +
  coord_cartesian(ylim = c(3,4)) + 
  ggtitle("GPA by Application Decision, USNWR Top 10 (1-10, left to right)")
