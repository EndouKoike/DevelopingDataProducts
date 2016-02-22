library(leaflet)
library(rCharts)
library(shiny)

source('LoadData.R')

shinyUI(navbarPage('App Menu',
                   
                   tabPanel('About',
                            sidebarPanel(
                                    h2('Information'),
                                    p(h5('This application is part of final course project of Developing Data Products 
                                        provided by Johns Hopkins University /coursera for Data Science Specialization.')),
                                    br(),
                                    img(src = 'jhu-logo-thumb.png', height = 125, width = 220),
                                    br(),
                                    a('Data Science Specialization Info', href = 'https://www.coursera.org/specializations/jhu-data-science', 
                                      target = '_blanck')
                            ), 
                            
                            mainPanel( 
                                    titlePanel('Blue Flag Beaches in Greece'),
                                    img(src = 'Blue_Flag_Logo.png', height = 99, width = 94, align = "right"),
                                    br(),
                                    p(h4('The scope of application is to presents the Blue Flag Beaches in Greece for the years of',
                                        span('2008,', '2009,', '2010', style = "color:blue")),
                                        h5('Information about Blue Flags', a('here', href = 'http://www.fee.global/blue-flag/', target = '_blanck'))),
                                    br(),
                                    p(h4('Datasets are taken by Geoadata.gov.gr that is providing 
                                         open geospatial data and services for Greece, serving as a national open data catalogue, 
                                         an INSPIRE-conformant Spatial Data Infrastructure, as well as a powerful foundation for enabling 
                                         value added services from open data. -', 
                                         a('more info', href = 'http://geodata.gov.gr/content/about-en/', target = '_blanck'))),
                                    br(),
                                    h2('Features'),
                                    br(),
                                    h4('The application consists of a basic horizontal App Menu with three options:'),
                                    br(),
                                    p(h4(strong('About'),
                                         br(),
                                         p('Current page with user documentation for application.')),
                                      h4(strong('Summary'),
                                         br(),
                                         p('Page with graphical presentation and basic statistics of Blue Flag Beaches in Greece separated in two side view, 
                                         left (input) and right (output).'),
                                         p('* The',
                                                span('left side', style = "color:blue"),
                                                'of screen is the "input" side that has two selection boxes,
                                                one for', em('Year of Reference'), 'and the other for', em('Region.')),
                                         p('* The',
                                              span('right side', style = "color:blue"),
                                              'of screen is the "output" side that has one map and two charts -each chart for different level of analysis.'),
                                          p('Both sides are interactive, each selection of the left side has a different output on right side (different results).',
                                           br(),
                                           p(' -Map influenced by selections of', em('Year of Reference'), 'and', em('Region.')),
                                           p(' -Charts influenced by selections of', em('Region.'))
                                         )
                                      ),
                                      h4(strong('Table'),
                                         br(),
                                         p('Page with a table of all data from dataset.'),
                                         p(' -Data of table are influenced by selections of', em('Year of Reference'), 'and', em('Region'), 'from "Summary" App Menu.')
                                      )
                                    )
                            )
                   ),
                   
                   
                   tabPanel('Summary', fluidPage(
                           
                           titlePanel('Blue Flag Beaches in Greece'),
                           sidebarLayout(
                                   sidebarPanel(
                                           selectInput('selectYear', label = h4('Select Year of Reference'), 
                                                       choices =  AvYears$Year,
                                                       selected = AvYears$Year[nrow(AvYears)]),
                                           
                                           selectInput('selectRegion', label = h4('Select Region'), 
                                                       choices =  AvRegions$Region,
                                                       selected = AvRegions$Region[nrow(AvRegions)])
                                           
                                   ),
                                   
                                   
                                   mainPanel( 
                                           leafletOutput('map'),
                                           h3('Blue Flags by Year (Region)'),
                                           showOutput('chart1', 'nvd3'),
                                           h3('Blue Flags by Year (Province)'),
                                           showOutput('chart2', 'nvd3')
                                   )
                           )
                   )),
                   
                   tabPanel('Table',
                            titlePanel('Blue Flag Beaches in Greece'),
                            DT::dataTableOutput('table')
                   )
                            )
)