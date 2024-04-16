library(ggplot2)
library(reshape2)

# Remove 'name' column from the dataset
parkinsons_data <- read.csv("D:/Parkinsons project/parkinsons.csv")
parkinsons_data_no_name <- parkinsons_data[, !(names(parkinsons_data) %in% c('name'))]

# Calculate correlation matrix
correlation_matrix <- cor(parkinsons_data_no_name)

# Melt correlation matrix for visualization
correlation_melted <- melt(correlation_matrix)

# Plot heatmap
print(ggplot(data = correlation_melted, aes(x = Var1, y = Var2, fill = value)) +
        geom_tile() +
        scale_fill_gradient2(low = "blue", mid = "white", high = "red", 
                             midpoint = 0, limits = c(-1, 1), na.value = "grey50") +
        theme_minimal() +
        theme(axis.text.x = element_text(angle = 45, hjust = 1),
              plot.title = element_text(hjust = 0.5),
              plot.margin = unit(c(.1, .1, .1, .1), "cm")) +  # Adjust margins for better clarity
        labs(title = "Correlation Matrix Heatmap") +
        coord_fixed(ratio = .8))  # Keep aspect ratio for better visualization
