# IDS_09_01_DecisionTrees.R

# ==========================================================
# Install and load packages as needed
# ==========================================================

install.packages("party")  # Install party
library(datasets)          # Load built-in datasets 
library(party)             # Load party

# Using ctree (conditional inference trees) from party

# ==========================================================
# Classification tree
# ==========================================================

# Use "iris" from built-in datasets

head(iris)  # Show first six cases

# Create a tree to predict species by measurements

iris.ct <- ctree(Species ~ ., data = iris)  # Create tree
iris.ct                                     # Tree info
plot(iris.ct)                               # Tree plot
table(predict(iris.ct), iris$Species)       # Pred vs true

# ==========================================================
# Clean up
# ==========================================================

# Clear workspace
rm(list = ls()) 

# Unload packages
detach("package:datasets", unload = TRUE)
detach("package:party", unload = TRUE)

# Clear plots
dev.off()

# Clear console
cat("\014")  # ctrl+L
