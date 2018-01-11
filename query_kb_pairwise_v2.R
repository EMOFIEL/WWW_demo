#Pairwise Interaction Analysis
library(syuzhet)
#Replacing NaN value from export to previous value

index_replace_export <- which(is.nan(export$anger))
for(h in 1:length(index_replace_export)){
  export$anger[index_replace_export[h]] <- 0
  export$anticipation[index_replace_export[h]] <- 0
  export$disgust[index_replace_export[h]] <- 0
  export$fear[index_replace_export[h]] <- 0
  export$joy[index_replace_export[h]] <- 0
  export$sadness[index_replace_export[h]] <- 0
  export$surprise[index_replace_export[h]] <- 0
  export$trust[index_replace_export[h]] <- 0
}

do_pairwise_interaction_analysis <- function(export, char1, char2){
 
  anger = 1:length(event) #Will be addressed in next function
  anticipation=1:length(event)
  disgust=1:length(event)
  fear=1:length(event)
  joy=1:length(event)
  sadness=1:length(event)
  surprise=1:length(event)
  trust=1:length(event)
  paragraph = 1:length(event)
  nrc_sentiment = 1:length(event)
  no_of_interactions = 1:length(event)
  Valence =  1:length(event)
  Arousal =  1:length(event)
  Dominance =  1:length(event)
  export_pair_emotions = data.frame(paragraph,no_of_interactions,nrc_sentiment,anger,anticipation,disgust,fear,joy,sadness,surprise,trust, Valence, Arousal, Dominance)
  
  for(event_index in 1:length(event)){
  #Selecting all the available information from kb for the current event
  current_event_kb <- kb[event[[event_index]][1]:event[[event_index]][length(event[[event_index]])],c(1,2,3,4,5,7),drop=F]
  #print("lalala")
  #print(current_event_kb$Subject.Characters)
  #Selecting Rows which have Character 1 and Character 2 both
  
  #Condition for no direction between character pairs
  #interaction_in_current_event <- subset(current_event_kb, grepl(char1, dependency_tree) & grepl(char2, dependency_tree))
  #Condition for direction from character 1 to character 2
  interaction_in_current_event <- subset(current_event_kb, (grepl(char1, Subject.Characters) & grepl(char2, Object.Characters)) )
  #Condition for direction from character 2 to character 1
  #interaction_in_current_event <- subset(current_event_kb, grepl(char2, Subject.Characters) & grepl(char1, Object.Characters) & !grepl(char1, Subject.Characters))
  
  #Mapping emotion of character 1 towards character 2
  export_pair_emotions$paragraph[event_index] <- ""
  if(nrow(interaction_in_current_event)==0){
    export_pair_emotions$paragraph[event_index] <- paste(export_pair_emotions$paragraph[event_index],"NA", split = "")
  }
  else if(nrow(interaction_in_current_event)>1){
    
  export_pair_emotions$paragraph[event_index] <- paste(interaction_in_current_event$Sentence[1]:interaction_in_current_event$Sentence[nrow(interaction_in_current_event)],split=" ")
  }
  else if(nrow(interaction_in_current_event)==1){
    export_pair_emotions$paragraph[event_index] <- paste(export_pair_emotions$paragraph[event_index],interaction_in_current_event$Sentence[1], split = "")
  }
  else
    export_pair_emotions$paragraph[event_index] <- paste(export_pair_emotions$paragraph[event_index],"NA", split = "")
  }
  #########################################################
  #Emotion Labeling per event based on the sentences per event for each character pair
  copy_export_pair_emotions <- export_pair_emotions
  for(event_index in 1:length(event)){
  if(export_pair_emotions$paragraph[event_index] != " NA "){
    print(event_index)
    #my_example_text <- export_pair_emotions$paragraph[event_index]
    #s_v <- get_sentences(export_pair_emotions$paragraph[event_index])
    #syuzhet_vector <- get_sentiment(s_v, method="syuzhet")
    #bing_vector <- get_sentiment(s_v, method="bing")
    #afinn_vector <- get_sentiment(s_v, method="afinn")
    #nrc_vector <- get_sentiment(s_v, method="nrc")
    #Because the different methods use different scales, it may be more useful to compare them 
    #using R’s built in sign function. The sign function converts all positive number to 1, all
    #negative numbers to -1 and all zeros remain 0.
    #rbind(
     # sign(head(syuzhet_vector)),
     # sign(head(bing_vector)),
     # sign(head(afinn_vector)),
     # sign(head(nrc_vector))
    #)
    #Emotion Labeling
    #nrc_data <- get_nrc_sentiment(s_v)
    
    #Viewing all emotions and its values in a event
   #pander::pandoc.table(nrc_data[, 1:8], split.table = Inf)
    
    #Plotting all emotions bar-plot per event
    #barplot(
    #  sort(colSums(prop.table(nrc_data[, 1:8]))), 
    #  horiz = TRUE, 
    #  cex.names = 0.7, 
    #  las = 1, 
    #  main = c("Emotions in Event", i) , xlab="Percentage"
    #)
    #export_pair_emotions$anger[event_index] <- colSums(prop.table(nrc_data[, 1:8]))[1]/length(event[[event_index]])
    export_pair_emotions$anger[event_index] <- export$anger[event_index]
    #export_pair_emotions$anticipation[event_index] <- colSums(prop.table(nrc_data[, 1:8]))[2]/length(event[[event_index]])
    export_pair_emotions$anticipation[event_index] <- export$anticipation[event_index]
    #export_pair_emotions$disgust[event_index] <- colSums(prop.table(nrc_data[, 1:8]))[3]/length(event[[event_index]])
    export_pair_emotions$disgust[event_index] <- export$disgust[event_index]
    #export_pair_emotions$fear[event_index] <- colSums(prop.table(nrc_data[, 1:8]))[4]/length(event[[event_index]])
    export_pair_emotions$fear[event_index] <- export$fear[event_index]
    #export_pair_emotions$joy[event_index] <- colSums(prop.table(nrc_data[, 1:8]))[5]/length(event[[event_index]])
    export_pair_emotions$joy[event_index] <- export$joy[event_index]
    #export_pair_emotions$sadness[event_index] <- colSums(prop.table(nrc_data[, 1:8]))[6]/length(event[[event_index]])
    export_pair_emotions$sadness[event_index] <- export$sadness[event_index]
    #export_pair_emotions$surprise[event_index] <- colSums(prop.table(nrc_data[, 1:8]))[7]/length(event[[event_index]])
    export_pair_emotions$surprise[event_index] <- export$surprise[event_index]
    #export_pair_emotions$trust[event_index] <- colSums(prop.table(nrc_data[, 1:8]))[8]/length(event[[event_index]])
    export_pair_emotions$trust[event_index] <- export$trust[event_index]
    
    #Calculating Sentiment Score(Average of all emotions)
    #export_pair_emotions$nrc_sentiment[event_index] = mean(c(as.numeric(export_pair_emotions[event_index,3:10])))
    if(length(get_sentiment(get_sentences(export_pair_emotions$paragraph[event_index])))>1)
      export_pair_emotions$nrc_sentiment[event_index] = mean(get_sentiment(get_sentences(export_pair_emotions$paragraph[event_index])))
    else
    export_pair_emotions$nrc_sentiment[event_index] =  get_sentiment(get_sentences(export_pair_emotions$paragraph[event_index]))
    export_pair_emotions$no_of_interactions[event_index] = length(get_sentiment(get_sentences(export_pair_emotions$paragraph[event_index])))
    #fileConn<-file("input.txt")
    #write(export$paragraph[event_index], fileConn)
    #system("java -jar /home/jhavarharshita/PycharmProjects/MxP/JEmAS-master/JEmAS-v0.2-beta.jar /home/jhavarharshita/PycharmProjects/MxP/input.txt > output.csv", intern=TRUE)
    #close(fileConn)
    #temp_kb <- read.csv("output.csv")
    #temp_kb <- read.csv("output.csv", sep = "\t")
    #export_pair_emotions$Valence[event_index] = temp_kb$Valence[1]/length(event[[event_index]])
    export_pair_emotions$Valence[event_index] = export$Valence[event_index]
    #export_pair_emotions$Arousal[event_index] = temp_kb$Arousal[1]/length(event[[event_index]])
    export_pair_emotions$Arousal[event_index] = export$Arousal[event_index]
    #export_pair_emotions$Dominance[event_index] = temp_kb$Dominance[1]/length(event[[event_index]])
    export_pair_emotions$Dominance[event_index] = export$Dominance[event_index]
  }  
  else{
    if(event_index!=1){
    export_pair_emotions$anger[event_index] <- export_pair_emotions$anger[event_index-1]
    export_pair_emotions$anticipation[event_index] <- export_pair_emotions$anticipation[event_index-1]
    export_pair_emotions$disgust[event_index] <- export_pair_emotions$disgust[event_index-1]
    export_pair_emotions$fear[event_index] <- export_pair_emotions$fear[event_index-1]
    export_pair_emotions$joy[event_index] <-export_pair_emotions$joy[event_index-1] 
    export_pair_emotions$sadness[event_index] <- export_pair_emotions$sadness[event_index-1]
    export_pair_emotions$surprise[event_index] <- export_pair_emotions$surprise[event_index-1]
    export_pair_emotions$trust[event_index] <-  export_pair_emotions$trust[event_index-1]
    export_pair_emotions$nrc_sentiment[event_index] <- export_pair_emotions$nrc_sentiment[event_index-1]
    export_pair_emotions$no_of_interactions[event_index] <- 0
    export_pair_emotions$Valence[event_index] <- export_pair_emotions$Valence[event_index-1]
    export_pair_emotions$Arousal[event_index] <- export_pair_emotions$Arousal[event_index-1]
    export_pair_emotions$Dominance[event_index] <- export_pair_emotions$Dominance[event_index-1]
    }
    else{
      export_pair_emotions$anger[event_index] <- 0
      export_pair_emotions$anticipation[event_index] <- 0
      export_pair_emotions$disgust[event_index] <- 0
      export_pair_emotions$fear[event_index] <- 0
      export_pair_emotions$joy[event_index] <-0
      export_pair_emotions$sadness[event_index] <- 0
      export_pair_emotions$surprise[event_index] <- 0
      export_pair_emotions$trust[event_index] <-  0
      export_pair_emotions$nrc_sentiment[event_index]<- 0
      export_pair_emotions$Valence[event_index]<- 0
      export_pair_emotions$Arousal[event_index]<- 0
      export_pair_emotions$Dominance[event_index]<- 0
  }
  }}
  write.csv(export_pair_emotions, file= "pairwise_emotions.csv", row.names = FALSE)
  
  copy_export_pair_emotions <- export_pair_emotions
  return(export_pair_emotions)
  }

#Read the characters
#char1 <- readline(prompt="Enter the first character name: ")
#char2 <-  readline(prompt="Enter the second character name: ")
char1 <- as.character('Ron|Ronald|RON|RONALD|Weasley')
char2 <- as.character('Hermione|Granger|HERMIONE|GRANGER')
#export_backup <- export
kb_pairwise_emotions = do_pairwise_interaction_analysis(export, char1, char2)
###############################################################################
#Valence Plotting
plot(kb_pairwise_emotions$nrc_sentiment,xlab = "Event Indexes", ylab = "Emotion Valence between the pair", main = c("Emotion valence progress of ", char1, "towards ", char2),type = "l")
#Emotions Plotting along different events for the character pairs

library(ggplot2)
library(reshape2)
df_categorical <- data.frame(Scenes = 1:length(event),
                 anger = kb_pairwise_emotions$anger,
                 anticipation = kb_pairwise_emotions$anticipation,
                 disgust = kb_pairwise_emotions$disgust,
                 fear = kb_pairwise_emotions$fear,
                 joy = kb_pairwise_emotions$joy,
                 sadness = kb_pairwise_emotions$sadness,
                 surprise = kb_pairwise_emotions$surprise,
                 trust = kb_pairwise_emotions$trust)
df_dimensional <- data.frame(Scenes = 1:length(event),
                             valence = kb_pairwise_emotions$Valence,
                             arousal = kb_pairwise_emotions$Arousal,
                             dominance = kb_pairwise_emotions$Dominance)
df_categorical <- melt(df_categorical ,  id.vars = 'Scenes', variable.name = 'Categorical_Emotions')
df_dimensional <- melt(df_dimensional ,  id.vars = 'Scenes', variable.name = 'Dimensional_Emotions')
# plot on same grid, each series colored differently -- 
plot_c<-ggplot(df_categorical, aes(Scenes,value))+ geom_line(aes(colour = Categorical_Emotions),size=1) + scale_x_continuous(breaks=seq(1, length(event), 1))+
labs(title=paste("Categorical emotions trajectory for", char1, "towards",char2), x = "Scene Indexes", y= "Dominance of emotions in each event")
plot_d<-ggplot(df_dimensional, aes(Scenes,value))+ geom_line(aes(colour = Dimensional_Emotions),size=1) + scale_x_continuous(breaks=seq(1, length(event), 1))+
labs(title=paste("Dimensional emotions trajectory for", char1, "towards", char2),x = "Scene Indexes", y = "Dominance of emotions in each event") 


multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
  library(grid)
  
  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)
  
  numPlots = length(plots)
  
  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                     ncol = cols, nrow = ceiling(numPlots/cols))
  }
  
  if (numPlots==1) {
    print(plots[[1]])
    
  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
    
    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
      
      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}
multiplot(plot_c, plot_d)


# plot on different plots
#group.colors <- c(A = "#333BFF", B = "#CC6600", C ="#9633FF", D = "#E2FF33", E = "#E3DB71", F = "#ECD954", G="#A1C4E1", H="#C18EBC")

#ggplot(df, aes(event_index,value)) +geom_line(aes(colour = Emotions),size=1) + facet_grid(Emotions ~ .) +scale_x_continuous(breaks=seq(1, length(event), 1))
#title(main = c("Emotion trajectory throughout the story for ", char1, char2),xlab = "Event Indexes", ylab= "Dominance of emotions in each event") 
#############################################################################














