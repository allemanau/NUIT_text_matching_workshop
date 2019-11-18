# ADDITIONAL EXERCISE

# Load libraries and functions.
library(tidyverse)
library(stringdist)
library(fuzzyjoin)
source("scripts/user_defined_functions.R")

### READ DATA SETS, STANDARDIZE KEY

# Top 10 Computer Science programs, US News rankings
cs_rankings <- read_csv("data/rankings_table.csv") %>%
  mutate(institution = factor(institution, levels = .$institution),
         institution_key = standardize_key(institution))

cs_admissions_results <- read_csv("data/gradcafe_cs_results.csv") %>%
  mutate(institution_key = standardize_key(institution))

# Top 10 Statistics programs, US News rankings
stats_rankings <- read_csv("data/stats_rankings_table.csv") %>%
  mutate(institution = factor(institution, levels = .$institution),
         institution_key = standardize_key(institution))

stats_admissions_results <- read_csv("data/gradcafe_stats_results.csv") %>%
  mutate(institution_key = standardize_key(institution))

#### RUN FUZZY JOINS FOR EACH OF CS AND STATS. FIND BEST MAX_DIST FOR EACH.

# run fuzzy join for CS
cs_fuzzy_join_results <- stringdist_inner_join(rankings_adj,
                                            admissions_results_adj, 
                                            by = c("institution_key" = "institution_key"),
                                            method = "jaccard", q = 2, max_dist = .2,
                                            distance_col = "dist")
cs_fuzzy_join_results

#### SUMMARIZE TO GET MEAN GPA (ENSURE gpa > 0 AND gpa <= 4 AND degree == "PhD") 



#### INNER JOIN SUMMARY TABLES ON INSTITUTION NAME. ARE YOU BETTER OFF
#### APPLYING TO CS OR STATS PHD PROGRAMS WITH A LOW GPA?

