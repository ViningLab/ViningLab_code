


line_map <- function(x, alpha = 1, ...){
  my_denom <- 1e6
  plot( x = c(1, ncol(x)),
        y = c(1, max(x, na.rm = TRUE)/my_denom), 
        type = "n",
        xlab = "", 
        #xlab = "Sample", 
        ylab = "Position (Mbp)",
        #ylab = "BUSCO Position (Mbp)",
        xaxt = "n", ...)
  axis( side = 1, at = 1:ncol(x), labels = colnames(x), las = 3 )
  
  my_ymax <- max(x, na.rm = TRUE) / my_denom
  
  palette( viridisLite::magma(n=8, alpha = alpha) )
  for(i in 1:nrow(x)){
    lines( x = 1:ncol(x), 
           #         y = x[i, my_index]/my_denom, 
           y = x[i, ]/my_denom,          
           col = i
    )
    points( x = 1:ncol(x), 
            #         y = x[i, my_index]/my_denom, 
            y = x[i, ]/my_denom,          
            col = i, 
            pch = 20,
            cex = 0.6
    )
  }
  palette( "default" )
}


gg_line_map <- function( busc, 
                         rect = FALSE, 
                         palpha = 1.0, size = 1.0,
                         lalpha = 1.0, linewidth = 1.0,
                         line_na_rm = TRUE ){
  library(tidyr)
  library(dplyr)
  library(ggplot2)
  
  chr_width <- 0.2
  rect_df <- data.frame(xmin = 1:ncol(busc) - chr_width, 
                        xmax = 1:ncol(busc) + chr_width,
                        ymin = apply(busc, MARGIN = 2, FUN = min, na.rm = TRUE),
                        ymax = apply(busc, MARGIN = 2, FUN = max, na.rm = TRUE))
  # rect_df$ymin <- rect_df$ymin * 0.6
  # rect_df$ymax <- rect_df$ymax * 1.01
  rect_df$ymin <- rect_df$ymin - 0.5e6
  rect_df$ymax <- rect_df$ymax + 0.5e6
  
  #aes(xmin = 1, xmax = 3, ymin = 10, ymax = 15)
  busc <- data.frame( Busco_id = rownames(busc), busc)
  vars <- colnames(busc)
  
  data_long <- busc %>%
    select(all_of(vars)) %>% 
    pivot_longer( cols = vars[-1] )
  
  names(data_long)[2:3] <- c("Sample", "POS")
  data_long$Sample <- factor(data_long$Sample , levels = unique(data_long$Sample))
  data_long <- data_long[ !is.na(data_long$POS), ]
  
  p <- ggplot(data_long, aes(x = Sample, y = POS, color = Busco_id, group = Busco_id)) + 
    geom_point( size = size, alpha = palpha ) +
    geom_line( linewidth = linewidth,
               #alpha = 0.1,
               alpha = lalpha,
               na.rm = line_na_rm )
  #  p <- p + geom_rect( data = rect_df, mapping = aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax))
  # p <- p + annotate( geom = "rect",
  #                    xmin = rect_df$xmin, xmax = rect_df$xmax,
  #                    ymin = rect_df$ymin, ymax = rect_df$ymax,
  #                    alpha = .2, fill = "blue")
  #p <- p + scale_color_manual( values = rep(viridisLite::magma( n = 8, alpha = 0.8 ), times = 1e6) )
  p <- p + scale_color_manual( values = rep(viridisLite::magma( n = 8, alpha = 1 ), times = 1e6) )
  p <- p + theme_bw()
  #p <- p + xlab("")
  p <- p + ylab("Position (Mbp)")
  p <- p + theme(legend.position = "none")
  p <- p + theme(axis.title.x = element_blank(), 
                 axis.text.x = element_text(angle = 60, hjust = 1, size = 12))
#  p <- p + scale_y_continuous( breaks = seq(0, 1e9, by = 10e6),
#                               labels = seq(0, 1e9, by = 10e6)/1e6,
#                               minor_breaks = seq(0, 1e9, by = 5e6) )
  p <- p + scale_y_continuous( breaks = seq(-1e9, 1e9, by = 10e6),
                               labels = seq(-1e9, 1e9, by = 10e6)/1e6,
                               minor_breaks = seq(-1e9, 1e9, by = 5e6) )
  if(rect == TRUE){
    p <- p + annotate( geom = "rect",
                       xmin = rect_df$xmin, xmax = rect_df$xmax,
                       ymin = rect_df$ymin, ymax = rect_df$ymax,
                       fill = "#0000ff22", color = "#00000088", linewidth = 0.5)
  }
  
  return(p)
}





dist_fingerprint <- function(x, perc_comp = 0.2){
  if( ncol(x) == 1 ){
    return(0)
  }
  
  samp_l <- vector(mode = "list", length = ncol(x))
  names(samp_l) <- colnames(x)
  
  for(i in 1:ncol(x)){
    samp_l[[i]] <- dist(x[, i, drop = FALSE])
  }
  #as.matrix(samp_l[[1]])[1:6, 1:4]
  
  # Create dist
  samp_dm <- matrix(ncol = ncol(x), nrow = ncol(x))
  colnames(samp_dm) <- colnames(x)
  rownames(samp_dm) <- colnames(x)
  #samp_dm[1:3, 1:3]
  
  for(i in 2:length(samp_l)){
    for(j in 1:(i-1)){
      my_weights <- 1:round(length(samp_l[[i]]) * perc_comp)
      samp_dm[ names(samp_l)[i], names(samp_l)[j] ] <- sum( sort(abs(samp_l[[i]] - samp_l[[j]]), decreasing = TRUE)[my_weights] , na.rm = TRUE)
#      samp_dm[ names(samp_l)[i], names(samp_l)[j] ] <- sum( sort(abs(samp_l[[i]] - samp_l[[j]]), decreasing = TRUE)[1:50] , na.rm = TRUE)
      samp_dm[ names(samp_l)[j], names(samp_l)[i] ] <- samp_dm[ names(samp_l)[i], names(samp_l)[j] ]
      # samp_dm[ names(samp_l)[i], names(samp_l)[j] ] <- sum(abs(samp_l[[i]] - samp_l[[j]]), na.rm = TRUE)
      # samp_dm[ names(samp_l)[j], names(samp_l)[i] ] <- samp_dm[ names(samp_l)[i], names(samp_l)[j] ]
    }
  }
  diag(samp_dm) <- 0
  #samp_dm[1:5, 1:5]
  
  return(samp_dm)
}



busco_bar <- function(x, max_copy = NULL){
  my_df <- as.data.frame( table( table( x$Busco_id[ x$Status %in% c("Complete", "Duplicated") ] ) ) )
  names(my_df) <- c("Copies", "Count")

  if( !is.null(max_copy) ){
    my_df$Count[ max_copy ] <- sum( my_df$Count[ as.numeric(as.character(my_df$Copies)) >= max_copy ] )
    my_df <- my_df[ 1:max_copy, ]
    my_df$Copies <- as.character(my_df$Copies)
    #my_df$Copies[ max_copy ] <- paste(">=", max_copy, sep = "")
    my_df$Copies[ max_copy ] <- paste(max_copy, "=<", sep = "")
  }
  
  my_df <- rbind(
    data.frame(
    Copies = c(0, "Fragmented"), 
    Count = c(sum(x$Status == "Missing"), sum(x$Status == "Fragmented"))
  ),
  my_df
  )
  my_df$Percent <- my_df$Count/sum(my_df$Count) * 100
  my_df$Copies <- factor(my_df$Copies, levels = my_df$Copies)
  
  library(ggplot2)
  p <- ggplot(data = my_df, mapping = aes( x = Copies, y = Percent ) )
  #p <- ggplot(data = my_df, mapping = aes( x = Copies, y = Count ) )
  p <- p + geom_bar(stat="identity", color="#000000", fill="#1E90FF")
  p <- p + theme_bw()
  #p <- p + ggtitle("BUSCO: DM6")
  return(p)
}




make_known <- function(x){
  x <- x[ x$Status == "Complete", , drop = FALSE]
  busco_l <- vector( mode = "list", length = length( unique(x$Sequence) ) )
  names(busco_l) <- sort(unique(x$Sequence), decreasing = FALSE)

  for( i in 1:length(busco_l) ){
    busco_l[[i]] <- x[ x$Sequence == names(busco_l)[i], ]
  }  
  return(busco_l)
}




add_unknown <- function(known_list, unknown_df){
  for(i in 1:length(known_list)){
    tmp <- unknown_df[ unknown_df$Busco_id %in% known_list[[i]]$Busco_id, ]
    #tmp[1:3, ]
    tmp <- tmp[ !duplicated(tmp$Busco_id), ]
    tmp <- tmp[ tmp$Sequence != "Unplaced", ]
    tmp <- tmp[ tmp$Sequence != "", ]
    #table(tmp$Sequence)
    #nrow(tmp)
  
    busco_chroms <- matrix(nrow = nrow(tmp), ncol = length(unique(tmp$Sequence)))
    busco_chroms <- as.data.frame(busco_chroms)
    rownames(busco_chroms) <- tmp$Busco_id
    colnames(busco_chroms) <- unique(tmp$Sequence)
    #busco_chroms[1:3, ]
  
    for(j in 1:ncol(busco_chroms)){
      busco_chroms[ tmp$Busco_id[ tmp$Sequence == colnames(busco_chroms)[j] ], j] <- tmp$Gene_Start[ tmp$Sequence == colnames(busco_chroms)[j] ]
    }
    known_list[[i]] <- cbind(
      known_list[[i]],
      busco_chroms[ known_list[[i]]$Busco_id, ]
      )
  }

  return(known_list)
}






read_busco <- function(x){
  busc <- read.table(x, header = FALSE, sep = "\t", fill = TRUE)
  names(busc) <- c("Busco_id", "Status", "Sequence", "Gene_Start",
                   "Gene_End", "Strand", "Score", "Length")
  busc$Sequence[busc$Sequence == ""] <- "Unplaced"
  return(busc)
}




position_BUSCOS <- function(x, min_BUSCO = 0, sort_by = c("max_pos", "max_busco")){
  if( length(sort_by) > 1 ){
    sort_by <- sort_by[1]
  }
  for(i in 1:length(x)){
    tmp <- x[[i]]
    tmp <- tmp[, apply(tmp, MARGIN = 2, function(x){ sum(!is.na(x)) }) > min_BUSCO]
    tmp <- nudge_seqs(tmp, seed_col = 4, test_col = 9:ncol(tmp))
    tmp <- flip_seqs(tmp, seed_col = 4, test_col = 9:ncol(tmp))
    if( sort_by == "max_pos" ){
      tmp[ , 9:ncol(tmp)] <- tmp[ , sort.int( apply(tmp[ , 9:ncol(tmp)], MARGIN = 2, max, na.rm = TRUE), decreasing = TRUE, index.return = TRUE)$ix + 8]
    }
    if( sort_by == "max_busco" ){
      tmp[ , 9:ncol(tmp)] <- tmp[ , sort.int( apply(tmp[ , 9:ncol(tmp)], MARGIN = 2, function(x){ sum(!is.na(x)) }), decreasing = TRUE, index.return = TRUE)$ix + 8]
    }
    #tmp[1:3, ]
    x[[i]] <- tmp
  }
  return(x)
}


flip_seqs <- function(x, seed_col = 1, test_col = 2:ncol(x)){
  #  for( i in 1:length(test_col) ){
  for( i in test_col ){
    x2 <- x[ , c(seed_col, i)]
    d1 <- sum(apply(x2, MARGIN = 1, function(x){ abs(x[1] - x[2]) }), na.rm = TRUE)
    #x2[, 2] <- max(x2[, 2], na.rm = TRUE) - x2[, 2]
    tmp <- x[, i]
    my_min <- min( tmp, na.rm = TRUE )
    tmp <- tmp - my_min
    tmp <- max(tmp, na.rm = TRUE) - tmp
    tmp <- tmp + my_min    
    d2 <- sum(apply(cbind(x2[, 1], tmp), MARGIN = 1, function(x){ abs(x[1] - x[2]) }), na.rm = TRUE)
    if( d2 < d1 ){
      # Flip
      #      tmp <- x[, i]
      #      my_min <- min( tmp, na.rm = TRUE )
      #      tmp <- tmp - my_min
      #      tmp <- max(tmp, na.rm = TRUE) - tmp
      #      tmp <- tmp + my_min
      x[, i] <- tmp
      colnames(x)[i] <- paste( colnames(x)[i], "_rev", sep = "")
      #x[, test_col] <-x2[ , 2]
    }
  }
  return(x)
}


nudge_seqs <- function(x, seed_col = 1, test_col = 2:ncol(x)){
  for( i in test_col ){
    x2 <- x[, c( seed_col, i )]
    d1 <- sum(apply(x2, MARGIN = 1, function(x){ abs(x[1] - x[2]) }), na.rm = TRUE)
    nudge_size <- 0.5e6
    x2[, 2] <- x2[ , 2] + nudge_size
    d2 <- sum(apply(x2, MARGIN = 1, function(x){ abs(x[1] - x[2]) }), na.rm = TRUE)
    while( d2 < d1 ){
      d1 <- d2
      x2[, 2] <- x2[, 2] + nudge_size
      d2 <- sum(apply(x2, MARGIN = 1, function(x){ abs(x[1] - x[2]) }), na.rm = TRUE)
    }
    x[ , i] <- x2[, 2] - nudge_size
  }
  return(x)
}





