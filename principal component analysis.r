library(FactoMineR)
library(factoextra)
library(ggplot2)
library(nnet)

# Use the iris dataset
data <- iris
df <- as.data.frame(data)

# Assume the last column is the target variable
target <- df[,ncol(df)]
features <- df[,-ncol(df)]

# Train a multinomial model on raw data
# multinomial is used to predict diffrent categorical var using multiple datas
model_raw <- multinom(target ~ ., data = features)

# Get predictions
predictions_raw <- predict(model_raw, newdata = features)

# Perform PCA on the features
pca <- PCA(features, graph = TRUE, scale.unit = TRUE)
fviz_eig(pca,addlabels = TRUE)

# Get the PCA scores
#pca scores are score given to each data pt 
scores <- get_pca_ind(pca)$coord

# Train a multinomial model on PCA data
model_pca <- multinom(target ~ ., data = as.data.frame(scores))

# Get predictions
predictions_pca <- predict(model_pca, newdata = as.data.frame(scores))

# Create a data frame for plotting
plot_data <- data.frame(
  Target = rep(target, 2),
  Predictions = c(predictions_raw, predictions_pca),
  Data = rep(c("Raw", "PCA"), each = length(target))
)


# Plot the predictions
ggplot(plot_data, aes(x = Target, y = Predictions, color = Data)) +
  geom_jitter(width = 0.2, height = 0.2) +  # Add some jitter to the points
  geom_smooth(method = "lm") +
  labs(title = "Predictions on Raw Data vs PCA Data", x = "Target", y = "Predictions") +
  theme_minimal()