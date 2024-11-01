library(ggplot2)


plot_silhouette_box_plot <- function(silhouette_result, title){
  sil_df <- as.data.frame(silhouette_result[, 1:3])
  sil_df$cluster <- factor(sil_df$cluster) 
  
  
  ggplot(sil_df, aes(x = cluster, y = sil_width)) +
    geom_boxplot(aes(fill = cluster), alpha = 0.6) +
    geom_hline(yintercept = mean(sil_df$sil_width), linetype = "dashed", color = "red") +
    labs(
      title = title,
      x = "Cluster",
      y = "silhouette Width"
    ) +
    theme_minimal() +
    theme(
      text = element_text(size = 12),
      axis.text.x = element_text(angle = 45, hjust = 1)
    ) +
    scale_fill_brewer(palette = "Set3")
  
}