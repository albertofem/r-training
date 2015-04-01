mtcars2 <- mtcars

mtcars2$hp_cat <- "High"
mtcars2[mtcars2$hp < mean(mtcars2$hp),]$hp_cat <- "Low"

View(mtcars2)