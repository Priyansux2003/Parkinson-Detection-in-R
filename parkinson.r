library(caret)

# Load the Parkinson's dataset (replace with your actual data path)
parkinsons_data <- read.csv("D:/Parkinsons project/parkinsons.csv")

# Convert the column "MDVP:Fo(Hz)" to numeric, handling any non-numeric values

# Separate features (X) and target (Y)
X <- parkinsons_data[, !(names(parkinsons_data) %in% c('name', 'status'))]
Y <- parkinsons_data$status

# Split data into training and test sets
set.seed(2)  # for reproducibility
train_index <- createDataPartition(Y, p = 0.8, list = FALSE)
X_train <- X[train_index, ]
Y_train <- Y[train_index]
X_test <- X[-train_index, ]
Y_test <- Y[-train_index]

# Convert Y_train and Y_test to factors with the same levels
Y_train <- factor(Y_train, levels = c(0, 1))
Y_test <- factor(Y_test, levels = c(0, 1))

# Standardize features
preProcess_params <- preProcess(X_train, method = c('center', 'scale'))
X_train <- predict(preProcess_params, X_train)
X_test <- predict(preProcess_params, X_test)

# Train the model with svmLinear
model <- train(
  x = X_train,
  y = Y_train,
  method = "svmLinear"
)

# Make predictions on the training data
train_predictions <- predict(model, newdata = X_train)

# Calculate training accuracy
train_accuracy <- mean(train_predictions == Y_train)
print(paste("Training accuracy:", train_accuracy))

# Make predictions on the test data
predictions <- predict(model, newdata = X_test)

# Calculate test accuracy
accuracy <- mean(predictions == Y_test)
print(paste("Test accuracy:", accuracy))

# Generate confusion matrix
confusion_matrix <- confusionMatrix(data = predictions, reference = Y_test)

# Output the confusion matrix
print(confusion_matrix)

# Extract and output precision, recall, and f1-score
precision <- confusion_matrix$overall['Precision']
recall <- confusion_matrix$overall['Recall']
f1_score <- confusion_matrix$overall['F1']
support <- confusion_matrix$overall['Support']

# Output classification report
cat("\nClassification Report:\n")
cat(sprintf("\n%-10s %-10s %-10s %-10s %-10s\n", "Class", "Precision", "Recall", "F1-Score", "Support"))
cat(sprintf("\n%-10s %-10.2f %-10.2f %-10.2f %-10.2f\n", "0", precision, recall, f1_score, support))

# Example input data for prediction
input_data <- c(203.18400, 211.52600, 196.16000, 0.00178, 0.000009, 0.00094, 0.00106, 0.00283, 0.00958, 0.08500, 0.00468, 0.00610, 0.00726, 0.01403, 0.00065, 33.04700, 0.340068, 0.741899, -7.964984, 0.163519, 1.423287, 0.044539)

# Convert input data to data frame with appropriate column names
input_data_df <- data.frame(t(input_data))
colnames(input_data_df) <- colnames(X_train)

# Standardize the input data using the same pre-processing parameters
input_data_std <- predict(preProcess_params, input_data_df)

# Make predictions
prediction <- predict(model, newdata = input_data_std)

# Output prediction result
if (prediction == 0) {
  print("The person does not have Parkinson's disease.")
} else {
  print("The person has Parkinson's disease.")
}
