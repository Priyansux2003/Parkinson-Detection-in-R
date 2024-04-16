library(ggplot2)
library(corrplot)

# Remove 'name' column from the dataset
parkinsons_data_no_name <- parkinsons_data[, !(names(parkinsons_data) %in% c('name'))]

# Calculate correlation matrix
correlation_matrix <- cor(parkinsons_data_no_name)

# Plot correlation matrix heatmap
corrplot(correlation_matrix, method = "color", type = "upper", 
         tl.col = "black", tl.srt = 45, tl.cex = 0.7, 
         col = colorRampPalette(c("blue", "white", "red"))(200))
