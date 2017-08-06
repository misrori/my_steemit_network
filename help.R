library(networkD3)
library(data.table)
library(jsonlite)


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
















MisNodes<- data.frame(id = seq(from= 0,to = (as.numeric(a$`_items`$following_count)-1), by = 1))
MisNodes$Name <- as.character(unlist(a$`_items`$following))
MisNodes$group <-sample(1:10,nrow(MisNodes), replace = T)
MisNodes$size <-sample(1:10,nrow(MisNodes), replace = T)

MisLinks <- data.frame(source=0, target= 1:nrow(MisNodes)-1 )
MisLinks$value <- sample(1:10,nrow(MisNodes), replace = T)


MisLinks<- data.table(MisLinks)
MisNodes <- data.table(MisNodes)
forceNetwork(Links = MisLinks, Nodes = MisNodes,
             Source = "source", Target = "target", zoom = T,
             Value = "value", NodeID = "Name",Nodesize = 'size',fontSize = 15,
             Group = "group", opacity = 1, arrows = F,  bounded = F)




# Plot
forceNetwork(Links = my_df_links, Nodes = my_df,
             Source = "source", Target = "target",
             Group = "group", Value = "value",
             NodeID = "Name",opacity = 0.8)





# Load data
data(MisLinks)
data(MisNodes)

# Plot
forceNetwork(Links = MisLinks, Nodes = MisNodes,
             Source = "source", Target = "target",
             Value = "value", NodeID = "name",
             Group = "group", opacity = 0.8)
