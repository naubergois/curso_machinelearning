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
# Regression tree
# ==========================================================

# Use "mtcars" from built-in datasets

head(mtcars)  # Show first six cases

# Create a tree to predict qsec, quarter-mile time

# First regression tree
car.rt1 <- ctree(qsec ~ ., data = mtcars)  # All variables
car.rt1                                    # Tree info
plot(car.rt1)                              # Plot tree
# vs = cylinders in V (0) or straight (1)
# Not a very helpful variable

# Second regression tree (with selected variables)
car.rt2 <- ctree(qsec ~ cyl + disp + hp + wt + am + gear, 
                 data = mtcars)
car.rt2        # Tree info
plot(car.rt2)  # Plot tree
# hp = horsepower, which makes more sense

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
