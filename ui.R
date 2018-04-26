library(shiny)
library(ggplot2)
library(shinysky)
library(Cairo)
library(rAmCharts)
library(shinythemes)
library(shinyjs)

list_of_character <- c('Albus Dumbledore'
                       , 'Arabella Figg'
                       , 'Argus Filch'
                       , 'Armando Dippet'
                       , 'Arthur Weasley'
                       , 'Augusta Longbottom'
                       , 'Bane'
                       , 'Borgin'
                       , 'Charles Weasley'
                       , 'Colin Creevey'
                       , 'Cornelius Fudge'
                       , 'Cuthbert Binns'
                       , 'Dedalus Diggle'
                       , 'Dobby'
                       , 'Doris Crockford'
                       , 'Draco Malfoy'
                       , 'Dudley Dursley'
                       , 'Ernest Macmillan'
                       , 'The Fat Lady'
                       , 'Filius Flitwick'
                       , 'Firenze'
                       , 'Fred Weasley'
                       , 'Garrick Ollivander'
                       , 'George Weasley'
                       , 'Gilderoy Lockhart'
                       , 'Ginevra Potter'
                       , 'Godric Gryffindor'
                       , 'Gregory Goyle'
                       , 'Griphook'
                       , 'Harry Potter'
                       , 'Hermione Granger'
                       , 'Irma Pince'
                       , 'James Potter'
                       , 'Lily Potter'
                       , 'Lucius Malfoy'
                       , 'Malkin'
                       , 'Marcus Flint'
                       , 'Marjorie Dursley'
                       , 'Marvolo Gaunt'
                       , 'Merope Riddle'
                       , 'Millicent Bulstrode'
                       , 'Minerva McGonagall'
                       , 'Molly Weasley'
                       , 'Mr Mason'
                       , 'Mrs Mason'
                       , 'Myrtle Warren'
                       , 'Neville Longbottom'
                       , 'Nicolas Flamel'
                       , 'Oliver Wood'
                       , 'Peeves'
                       , 'Penelope Clearwater'
                       , 'Percy Weasey'
                       , 'Peter Pettigrew'
                       , 'Petunia Dursley'
                       , 'Piers Polkiss'
                       , 'Pomona Sprout'
                       , 'Poppy Pomfrey'
                       , 'Quirinus Quirrell'
                       , 'Remus Lupin'
                       , 'Rolanda Hooch'
                       , 'Ronald Weasley'
                       , 'Ronan'
                       , 'Rubeus Hagrid'
                       , 'Salazar Slytherin'
                       , 'Seamus Finnigan'
                       , 'Severus Snape'
                       , 'Sirius Black'
                       , 'Tom Riddle'
                       , 'Vernon Dursley'
                       , 'Vincent Crabbe'
                       , 'William Weasley')

list_of_character_desc <- c('The kind, wise head of Hogwarts.'
                            , ''
                            , ''
                            , ''
                            , ''
                            , ''
                            , ''
                            , ''
                            , ''
                            , ''
                            , ''
                            , ''
                            , ''
                            , ''
                            , ''
                            , 'An arrogant student and Harry’s nemesis.'
                            , 'Harry’s cousin, a spoiled, fat bully.'
                            , ''
                            , ''
                            , ''
                            , ''
                            , ''
                            , ''
                            , ''
                            , ''
                            , ''
                            , ''
                            , ''
                            , ''
                            , 'The protagonist of the story, who is gradually transformed from timid weakling to powerful hero by the end.'
                            , 'Initially an annoying goody-two-shoes who studies too much and obeys the school rules too zealously.'
                            , ''
                            , ''
                            , ''
                            , ''
                            , ''
                            , ''
                            , ''
                            , ''
                            , ''
                            , ''
                            , 'The head of Gryffindor House at Hogwarts and a high-ranking woman in the wizard world.'
                            , ''
                            , ''
                            , ''
                            , ''
                            , 'A timid Hogwarts classmate of Harry’s.'
                            , ''
                            , ''
                            , ''
                            , ''
                            , ''
                            , ''
                            , 'Harry’s aunt.'
                            , ''
                            , ''
                            , ''
                            , ''
                            , ''
                            , ''
                            , 'A shy, modest boy who comes from an impoverished wizard family'
                            , ''
                            , 'An oafish giant who works as a groundskeeper at Hogwarts.'
                            , ''
                            , ''
                            , 'A professor of Potions at Hogwarts.'
                            , ''
                            , 'A great wizard gone bad.'
                            , 'Harry’s uncle, with whom Harry lives for ten miserable years.'
                            , ''
                            , '')

fluidPage(
  useShinyjs(),
  theme = shinytheme("yeti"),
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "emofiel.css")
  ),
  
  div(class='jumbotron'
      , style="
      text-align:center;
      display: inline-block;
      vertical-align: top;
      width: 100%;
      color: #008cba;
      "
      , div (
        style="text-align: right;"
        , actionButton("goButtonAbout", "About EMoFiel", styleclass = 'primary')
        , actionButton("goButtonArch", "System Architecture", styleclass = 'primary')
      )
      , titlePanel(h2(
        span (style="color: orange; margin: 0px;", "EMoFiel"),
        span (style="margin-left: -7px;", ": "), 
        span (style="color: orange; margin: 0px;", "E"),
        span (style="margin-left: -7px;", "motion "),
        span (style="color: orange; margin: 0px;", "M"),
        span (style="margin-left: -7px;", "apping "),
        span (style="color: orange; margin: 0px;", "o"),
        span (style="margin-left: -7px;", "f  "),
        span (style="color: orange; margin: 0px;", "Fi"),
        span (style="margin-left: -7px;", "ctional R"),
        span (style="color: orange; margin: -7px;", "el"),
        span (style="margin-left: 0px;", "ationship")
        ), 
        windowTitle = "EMoFiel: Emotion Mapping of Fictional Relationship"
      )
  ),
  div(
    style="
      text-align:center;
      "
    ,
    div(
      span(style="
           display: inline-block;
           text-align:left;
           vertical-align: top;
           "
           , selectInput('x', label = 'Which story?' 
                         , choices = c('Harry Potter and the Philosopher\'s Stone',
                                       'Harry Potter and the Chamber of Secrets',
                                       'Harry Potter and the Prisoner of Azkaban',
                                       'Harry Potter and the Goblet of Fire',
                                       'Harry Potter and the Order of the Phoenix',
                                       'Harry Potter and the Half-Blood Prince',
                                       'Harry Potter and the Deathly Hallows')
                         , selected = 'Harry Potter and the Philosopher\'s Stone'
                         , width = '350px')
      ),
      
      span(style="
           display: inline-block;
           vertical-align: middle;
           align: right;
           text-align: left;
           margin-top: 5px;
           margin-left: 20px;
           "
           , span(style="font-size: 12px; ", "Type the first character name")
           , br()
           , textInput.typeahead(
             id="user_char1input"
             ,placeholder="e.g., Harry Potter"
             ,local=data.frame(name=c(list_of_character),info=c(list_of_character_desc))
             ,valueKey = "name"
             ,tokens=c(1:length(list_of_character))
             ,template = HTML("<p style='font-size: 16px;'><b>{{name}}</b></p> <p style='font-size: 13px;'>{{info}}</p>")
           )
      ),
      span(
        style="
        display: inline-block;
        vertical-align: middle;
        align: left;
        margin-top: 25px;
        margin-left: 10px;
        "
        , 'and'
      ),
      span(style="
           display: inline-block;
           vertical-align: middle;
           align: left;
           text-align: left;
           margin-top: 5px;
           margin-left: 20px;
           "
           , span(style="font-size: 12px; ", "Type the second character name")
           , br()
           , textInput.typeahead(
             id="user_char2input"
             ,placeholder="e.g., Severus Snape"
             ,local=data.frame(name=c(list_of_character),info=c(list_of_character_desc))
             ,valueKey = "name"
             ,tokens=c(1:length(list_of_character))
             ,template = HTML("<p style='font-size: 16px;'><b>{{name}}</b></p> <p style='font-size: 13px;'>{{info}}</p>")
           )
      )
    ),
    div(
      style="
        display: inline-block;
        vertical-align: top;
        margin: auto;
        margin-top: 10px;
        margin-bottom: 20px;
        
        "
      , actionButton("goButton0", "Analyze their relationship!", styleclass = 'primary')
    )
  ),
  
  fluidRow(
    hidden(
      div(id="plots",
          style="display: inline-block;
          vertical-align:top; width: 100%;"
          , class = "well",
          
          tabsetPanel(
            tabPanel("Categorical Emotion", 
                div(
                  style="
                      width:100%;
                      padding-top:20px;
                    ",
                  plotOutput("Emotion Mapping1", height = 250,
                             dblclick = "plot1_dblclick",
                             click="plot_click1",
                             brush = brushOpts(
                             id = "plot1_brush",
                             resetOnNew = TRUE
                             )
                  )
                ),
                hidden(
                  div(id="desc1",
                    style="
                      border:1;
                      background-color:#eee;
                      width:100%;
                      padding:10px;
                    ",
                    h4(
                      "Scene Description"
                    ),
                    p(
                      class="text-muted",
                      style="
                        font-style:italic;
                      ",
                      "Click on any point in the plot for a specific scene in the story timeline."
                    ),
                    hidden(
                      fluidRow(id="desc-detail1",
                        column(4,
                            #plotOutput("Dimensional Mapping", height = 200)
                            amChartsOutput(outputId = "Dimensional Mapping", height = 200)
                        ),
                        column(8,
                            #  sidebarPanel(
                            #textOutput("Heading for Scene Info"),
                            #, textOutput("Total Number of Scenes in the Story")
                            h5(textOutput("Selected Scene ID"))
                            , span(
                              style="font-style: italic; "
                              , htmlOutput("Selected Scene Description")
                              )
                            #, textOutput("Selected Scene Agents and Actions")
                            #, textOutput("Selected Scene Objects and Actions")
                            #, textOutput("Selected Scene Emotion Analysis")
                        )
                      )
                    )
                  )
                ),
                
                div(
                  style="
                      width:100%;
                      padding-top:20px;
                    ",
                  plotOutput("Emotion Mapping3", height = 250,
                             click="plot_click3",
                             dblclick = "plot3_dblclick",
                             brush = brushOpts(
                               id = "plot3_brush",
                               resetOnNew = TRUE
                             )
                  )
                ),  
                hidden(
                  div(id="desc3",
                      style="
                      border:1;
                      background-color:#eee;
                      width:100%;
                      padding:10px;
                      ",
                    h4(
                      "Scene Description"
                    ),
                    p(
                      class="text-muted",
                      style="
                      font-style:italic;
                      ",
                      "Click on any point in the plot for a specific scene in the story timeline."
                    ),
                    hidden(
                      fluidRow(id="desc-detail3",
                         column(4,
                                #plotOutput("Dimensional Mapping3", height = 200)
                                amChartsOutput(outputId = "Dimensional Mapping3", height = 200)
                         ),
                         column(8,
                                #  sidebarPanel(
                                #textOutput("Heading for Scene Info3"),
                                #, textOutput("Total Number of Scenes in the Story3")
                                h5(textOutput("Selected Scene ID3"))
                                , span(
                                  style="font-style: italic; "
                                  , htmlOutput("Selected Scene Description3")
                                )
                                #, textOutput("Selected Scene Agents and Actions3")
                                #, textOutput("Selected Scene Objects and Actions3")
                                #, textOutput("Selected Scene Emotion Analysis3")
                         )
                      )
                    )
                  )
                )
            ),
            
            tabPanel("Dimensional Emotion", 
                 div(
                   style="
                      width:100%;
                      padding-top:20px;
                    ",
                   plotOutput("Emotion Mapping2", height = 250,
                              click="plot_click2",
                              dblclick = "plot2_dblclick",
                              brush = brushOpts(
                                id = "plot2_brush",
                                resetOnNew = TRUE
                              )
                   )  
                 ),
                 hidden(
                   div(id="desc2",
                       style="
                       border:1;
                       background-color:#eee;
                       width:100%;
                       padding:10px;
                       ",
                    h4(
                      "Scene Description"
                    ),
                    p(
                      class="text-muted",
                      style="
                      font-style:italic;
                      ",
                      "Click on any point in the plot for a specific scene in the story timeline."
                    ),
                    hidden(
                      fluidRow(id="desc-detail2",
                         column(4,
                                #plotOutput("Dimensional Mapping2", height = 200)
                                amChartsOutput(outputId = "Dimensional Mapping2", height = 200)
                         ),
                         column(8,
                                #  sidebarPanel(
                                #textOutput("Heading for Scene Info2"),
                                #, textOutput("Total Number of Scenes in the Story2")
                                h5(textOutput("Selected Scene ID2"))
                                , span(
                                  style="font-style: italic; "
                                  , htmlOutput("Selected Scene Description2")
                                )
                                #, textOutput("Selected Scene Agents and Actions2")
                                #, textOutput("Selected Scene Objects and Actions2")
                                #, textOutput("Selected Scene Emotion Analysis2")
                         )
                      )
                    )
                  )
                ),
                div(
                  style="
                      width:100%;
                      padding-top:20px;
                    ",
                 plotOutput("Emotion Mapping4", height = 250,
                            click="plot_click4",
                            dblclick = "plot4_dblclick",
                            brush = brushOpts(
                              id = "plot4_brush",
                              resetOnNew = TRUE
                            )
                 )
                ),
                hidden(
                  div(id="desc4",
                      style="
                      border:1;
                      background-color:#eee;
                      width:100%;
                      padding:10px;
                      ",
                    h4(
                      "Scene Description"
                    ),
                    p(
                      class="text-muted",
                      style="
                      font-style:italic;
                      ",
                      "Click on any point in the plot for a specific scene in the story timeline."
                    ),
                    hidden(
                      fluidRow(id="desc-detail4",
                         column(4,
                                #plotOutput("Dimensional Mapping4", height = 200)
                                amChartsOutput(outputId = "Dimensional Mapping4", height = 200)
                         ),
                         column(8,
                                #  sidebarPanel(
                                #textOutput("Heading for Scene Info4"),
                                #, textOutput("Total Number of Scenes in the Story4")
                                h5(textOutput("Selected Scene ID4"))
                                , span(
                                  style="font-style: italic; "
                                  , htmlOutput("Selected Scene Description4")
                                )
                                #, textOutput("Selected Scene Agents and Actions4")
                                #, textOutput("Selected Scene Objects and Actions4")
                                #, textOutput("Selected Scene Emotion Analysis4")
                         )
                      )
                    )
                  )
                )
            ),
            
            tabPanel("Summary Text",
                #tableOutput(outputId = 'table.summary')
                htmlOutput("table.summary")
            ),
            
            tabPanel("Story Characters",
                     #tableOutput(outputId = 'table.characters')
                     htmlOutput("table.characters")
            )
            
          )
          
          
      )
    )
  )
)
