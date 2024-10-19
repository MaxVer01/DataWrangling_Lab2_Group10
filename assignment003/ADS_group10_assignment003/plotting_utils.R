
plot_histograms_and_bars <- function(data) {
  numeric_cols <- data %>% select_if(is.numeric) %>% gather(key = "column", value = "value")
  categorical_cols <- data %>% select_if(is.factor) %>% gather(key = "column", value = "value")
  
  #
  # Plot histograms for numeric columns
  numeric_plot <- ggplot(numeric_cols, aes(x = value)) +
    geom_histogram(binwidth = 0.5, fill = "blue", color = "black", alpha = 0.6) +
    facet_wrap(~column, scales = "free_x") +
    labs(title = "Histograms of numeric columns", x = "Values", y = "Freq") +
    theme_minimal()
  
  #bar plots for categorical columns
  categorical_plot <- ggplot(categorical_cols, aes(x = value)) +
    geom_bar(fill = "green", color = "black", alpha = 0.6) +
    facet_wrap(~column, scales = "free_x") +
    labs(title = "Bar Plots of categorical columns", x = "categories", y = "Count") +
    theme_minimal()
  
  list(numeric_plot = numeric_plot, categorical_plot = categorical_plot)
}


