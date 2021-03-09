shinyServer(function(input, output, session) {
  
  observeEvent(input$bugSubmitBtn, {
    ## Get raw input for bug report
    bugApp <- input$bugMMLApp
    bugDesc <- input$bugDescription
    bugSteps <- input$bugSteps
    
    descChar = nchar(bugDesc)
    stepChar = nchar(bugSteps)
    
    if(nchar(bugDesc) > 500){
      bugDesc <- substr(bugDesc, 1, 500)
    }
    
    if(nchar(bugApp) > 10000){
      bugApp <- substr(bugApp, 1, 10000)
    }
    
    if(descChar > 0 && stepChar > 0){
      
      randomInt = sample(1:99999999, 1)
      currentTime = Sys.time()
      fileName = paste(currentTime, randomInt, sep="-")
      fileName = paste(fileName, ".txt", sep="")
      filePath = paste("./reports/", fileName,  sep="")
      
      bugApp <- paste("Application: \n", bugApp,  sep="")
      bugDesc <- paste("Title: \n", bugDesc,  sep="")
      bugSteps <- paste("Description: \n", bugSteps,  sep="")
      
      bugApp <- paste(bugApp, "\n\n",  sep="")
      bugDesc <- paste(bugDesc, "\n\n",  sep="")
      bugSteps <- paste(bugSteps, "\n",  sep="")
      
      initalConcatenation = paste(bugApp, bugDesc,  sep="")
      finalString = paste(initalConcatenation, bugSteps,  sep="")
      
      fileConn<-file(filePath)
      writeLines(finalString, fileConn)
      close(fileConn)
      
      updateTextInput(session, "bugSteps", value = "")
      updateTextInput(session, "bugDescription", value = "")
    }
    
  })
  
  
})