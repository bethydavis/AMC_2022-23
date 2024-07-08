# make some fake data in the shape of OTU tables ----
set.seed(123)

# `se_matrix` is an otu style table for the SE data
se_matrix <- matrix(rpois(5 * 16, 5), nrow = 5, ncol = 16)

rownames(se_matrix) <- paste("site", 1:5, sep = "_")
colnames(se_matrix) <- paste("family", 1:16, sep = "_")

# `asv_matrix` is the output of dada2/phyloseq for the metabarcoding data
asv_matrix <- se_matrix + rbinom(5 * 16, 8, 0.5) - 4
asv_matrix[asv_matrix < 0] <- 0
asv_matrix <- asv_matrix[-2, ]

# everything below would be the actual analysis you would run

library(vegan)
library(dplyr)
library(tidyr)
library(ggplot2)

# make sure to use the same index (e.g. jaccard) for both data sets
se_jacc <- vegdist(se_matrix, method = "jaccard")
asv_jacc <- vegdist(asv_matrix, method = "jaccard")

# AND MAKE SURE THE SITE NAMES ARE THE SAME BETWEEN DATA SETS!!!!!

# now wrangle the dissimilarity data to use in ggplot

se_jacc_df <- se_jacc |>
  as.matrix() |>
  as.data.frame() |>
  mutate(from = labels(se_jacc)) |>
  pivot_longer(-from, names_to = "to", values_to = "diss_se") |>
  filter(from < to) |>
  mutate(comparison = paste(from, to, sep = ":")) |>
  select(-to, -from)

asv_jacc_df <- asv_jacc |>
  as.matrix() |>
  as.data.frame() |>
  mutate(from = labels(asv_jacc)) |>
  pivot_longer(-from, names_to = "to", values_to = "diss_asv") |>
  filter(from < to) |>
  mutate(comparison = paste(from, to, sep = ":")) |>
  select(-to, -from)

# use inner_join because there might not be full overlap in sites 
# between data sets
jacc_df <- inner_join(asv_jacc_df, se_jacc_df)

# finally plot it
ggplot(jacc_df, aes(x = diss_asv, y = diss_se)) +
  geom_point()

# we can also do a correlation test
cor.test(jacc_df$diss_asv, jacc_df$diss_se)
