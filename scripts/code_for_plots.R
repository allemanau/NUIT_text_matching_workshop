# comparison of regular and standardized joins
bind_rows(
  (join_results %>%
     count(institution) %>%
     mutate(join_type = "regular")),
  (join_results_adj %>%
     count(institution.x) %>%
     rename(institution = institution.x) %>%
     mutate(join_type = "standardized"))
) %>%
  mutate(institution = factor(institution, levels = levels(rankings$institution)),
         join_type = factor(join_type, levels = c("regular", "standardized"))) %>%
  ggplot() +
  geom_bar(aes(x = institution, y = n, fill = join_type), position="dodge", stat = "identity") + 
  ggtitle("Number of matches by join type") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


# comparison of regular, standardized, and fuzzy standardized joins
bind_rows(
  (join_results %>%
     count(institution) %>%
     mutate(join_type = "regular")),
  (join_results_adj %>%
     count(institution.x) %>%
     rename(institution = institution.x) %>%
     mutate(join_type = "standardized")),
  (fuzzy_join_results %>%
     count(institution.x) %>%
     rename(institution = institution.x) %>%
     mutate(join_type = "fuzzy standardized")),
) %>%
  mutate(institution = factor(institution, levels = levels(rankings$institution)),
         join_type = factor(join_type, levels = c("regular", "standardized", "fuzzy standardized"))) %>%
  ggplot() +
  geom_bar(aes(x = institution, y = n, fill = join_type), position="dodge", stat = "identity") + 
  ggtitle("Number of matches by join type (fuzzy = Jaccard 2-grams, max_dist 0.4)") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
