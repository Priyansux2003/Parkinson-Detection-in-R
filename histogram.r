library(ggplot2)

# Load the Parkinson's dataset
parkinsons_data <- read.csv("D:/Parkinsons project/parkinsons.csv")

# Plot histogram
ggplot(parkinsons_data, aes(x = PPE)) +
  geom_histogram(binwidth = 0.05, fill = "blue", color = "black", alpha = 0.7) +
  geom_density(alpha = 0.2, fill = "red") +
  labs(title = "Histogram of PPE",
       x = "PPE",
       y = "Frequency")

# To display the graph, use the print() function
print(ggplot(parkinsons_data, aes(x = PPE)) +
        geom_histogram(binwidth = 0.05, fill = "blue", color = "black", alpha = 0.7) +
        geom_density(alpha = 0.2, fill = "red") +
        labs(title = "Histogram of PPE",
             x = "PPE",
             y = "Frequency"))
