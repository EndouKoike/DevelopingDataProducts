library(leaflet)
library(rCharts)
library(shiny)

shinyServer(function(input, output) {

        output$map <- renderLeaflet({
                if(input$selectYear == 'All' & input$selectRegion == 'All'){
                        m <- leaflet()
                        m <- addTiles(m)
                        m <- addMarkers(m, lng = data$LONGITUDE,
                                        lat = data$LATITUDE,
                                        popup = data$PRELEV,
                                        group = data$YEAR,
                                        clusterOptions = markerClusterOptions())
                        
                        }else if(input$selectYear == 'All' & !input$selectRegion == 'All'){
                                        data <- subset(data, REGION == input$selectRegion)
                                        m <- leaflet()
                                        m <- addTiles(m)
                                        m <- addMarkers(m, lng = data$LONGITUDE, 
                                                        lat = data$LATITUDE, 
                                                        popup = data$PRELEV, 
                                                        clusterOptions = markerClusterOptions())
                 
                                }else if(!input$selectYear == 'All' & input$selectRegion == 'All'){
                                                data <- subset(data, YEAR == input$selectYear)
                                                m <- leaflet()
                                                m <- addTiles(m)
                                                m <- addMarkers(m, lng = data$LONGITUDE, 
                                                                lat = data$LATITUDE, 
                                                                popup = data$PRELEV, 
                                                                clusterOptions = markerClusterOptions())  
                                                
                }else{
                        data <- subset(data, YEAR == input$selectYear & REGION == input$selectRegion)
                        m <- leaflet()
                        m <- addTiles(m)
                        m <- addMarkers(m, lng = data$LONGITUDE, 
                                        lat = data$LATITUDE, 
                                        popup = data$PRELEV, 
                                        clusterOptions = markerClusterOptions())   
                }       
        })
        
        output$chart1 <- renderChart({
                if(input$selectRegion == 'All'){
                        dataset <- aggregate(C_EDPP~ YEAR + REGION, FUN=length, data=data)
                        colnames(dataset) <- c('YEAR', 'REGION', 'nFLAGS')
                        n1 <- nPlot(nFLAGS ~ REGION, group = 'YEAR', data = dataset, type = 'multiBarChart')
                        n1$set(dom = 'chart1')
                        return(n1)
                        
                }else{
                        data <- subset(data, REGION == input$selectRegion)
                        dataset <- aggregate(C_EDPP~ YEAR + REGION, FUN=length, data=data)
                        colnames(dataset) <- c('YEAR', 'REGION', 'nFLAGS')
                        n1 <- nPlot(nFLAGS ~ REGION, group = 'YEAR', data = dataset, type = 'multiBarChart')
                        n1$set(dom = 'chart1')
                        return(n1)
                }
                
        })

        output$chart2 <- renderChart({
                 if(input$selectRegion == 'All'){
                         dataset <- head(aggregate(C_EDPP~ YEAR + REGION + PROVINCE, FUN=length, data=data),30)
                         colnames(dataset) <- c('YEAR','REGION', 'PROVINCE', 'nFLAGS')
                         n1 <- nPlot(nFLAGS ~ PROVINCE, group = 'YEAR', data = dataset, type = 'multiBarHorizontalChart')
                         n1$set(dom = 'chart2')
                         return(n1)

                 }else{
                         data <- subset(data, REGION == input$selectRegion)
                         dataset <- aggregate(C_EDPP~ YEAR + REGION + PROVINCE, FUN=length, data=data)
                         colnames(dataset) <- c('YEAR','REGION', 'PROVINCE', 'nFLAGS')
                         n2 <- nPlot(nFLAGS ~ PROVINCE, group = 'YEAR', data = dataset, type = 'multiBarHorizontalChart')
                         n2$set(dom = 'chart2')
                         return(n2)
                 }
        })

        output$table <- DT::renderDataTable({
                if(input$selectYear == 'All' & input$selectRegion == 'All'){
                        DT::datatable(data)
                        }else if(input$selectYear == 'All' & !input$selectRegion == 'All'){
                                data <- subset(data, REGION == input$selectRegion)
                                DT::datatable(data)
                        
                                }else if(!input$selectYear == 'All' & input$selectRegion == 'All'){
                                        data <- subset(data, YEAR == input$selectYear)
                                        DT::datatable(data)
                }else{
                        data <- subset(data, YEAR == input$selectYear & REGION == input$selectRegion)
                        DT::datatable(data)  
                }       
        })
        
})