library(jsonlite)
library(networkD3)

#####################################################
###  my followers network  ######

get_network <- function(name){

  
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
  
  net<- forceNetwork(Links = my_links, Nodes = my_names,
               Source = "source", Target = "target", zoom = T,
               Value = "value", NodeID = "Name",Nodesize = 'size',fontSize = 15,
               Group = "group", opacity = 1, arrows = F,  bounded = F)
  return(net)
}

