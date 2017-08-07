library(networkD3)
library(data.table)
library(jsonlite)

#####################################################################################################
###############################  One account     ###################################################

name <- "misrori"

a <- fromJSON(paste('https://webapi.steemdata.com/Accounts?where=name==',name,sep = ""))

my_names<- data.frame(id = seq(from= 1,to = (as.numeric(a$`_items`$following_count)), by = 1))
my_names$Name <- as.character(unlist(a$`_items`$following))
data.frame(id=0, Name = name)
my_names <- rbind(data.frame(id=0, Name = name),my_names)
my_names$group <-1
my_names$size <-1

my_links <- data.frame(source=0, target= 1:nrow(my_names)-1)
my_links <- my_links[2:nrow(my_links),]
my_links$value <- 1

forceNetwork(Links = my_links, Nodes = my_names,
             Source = "source", Target = "target", zoom = T,
             Value = "value", NodeID = "Name",Nodesize = 'size',fontSize = 15,
             Group = "group", opacity = 1, arrows = F,  bounded = F)

#####################################################################################################




#####################################################################################################
###############################  list of account     ###################################################
get_group_network_data <- function(my_names){
  my_names <- c("misrori", "cuttie1979")
  
  my_df <- data.frame()
  for (i in my_names){
    my_df <- rbind(my_df, get_source_target(i))
  } 
  nevek_list <- data.frame(nevek = unique(c(unique(my_df$source), unique(my_df$target))))
  nevek_list$nevek <- as.character(nevek_list$nevek)
  nevek_list$id <- 0:(nrow(nevek_list)-1)
  
  nevek_list <- data.table(nevek_list)
  my_df <- data.table(my_df )
  setkey(nevek_list, nevek)
  setkey(my_df, source)
  
  my_df$source_id <- nevek_list[my_df][,id]
  
  setkey(my_df, target)
  
  my_df$target_id <- nevek_list[my_df][,id]
  my_df$value <- 1
  nevek_list$group <-1
  nevek_list$size <-1
  setorder(nevek_list,id)
  
  my_df_list <- list(node = nevek_list,edge=my_df)

 
  return(my_df_list)
}



