#App to test students on the concept of transcription and translation

library(BiocManager)
getOption("repos")
library(shiny)
library(Biostrings)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel(strong("Lost in expression"),br()),

    # Sidebar with input and output 
    sidebarLayout(
        sidebarPanel(
            #Output DNA
           htmlOutput("DNA"),
           #Input reverse complement
           textInput(inputId = "rc", label = "Enter the reverse complement 
                     nucleotide sequnce", value = ""),
           #Check the reverse complement
           htmlOutput("rc_check"),
           #tell which strand is mRNA
           htmlOutput("mRNA"),
           textInput(inputId = "rna", label = "Enter the sequence of the mRNA", 
                     value = ""),
           #Check the mRNA input
           htmlOutput("m_check"),
           #Input the AA sequence
           textInput(inputId = "prot", label = "Enter the amino acid sequence 
                     coded by the mRNA sequence you found. Use one letter codes 
                     and a dot to indicate a stop codon."
                     ,value = ""),
           #Check the AA sequence
           htmlOutput("aa_check")
        ),

        # show a figure of the genetic code
        mainPanel(
            h1("The standard genetic code", align = "left"),
            #image of the genetic code
            imageOutput("code")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output,session) {
    
    #generate random DNA sequence
    seq_f <- DNAString(paste0(sample(
        Biostrings::DNA_BASES, size = 12, replace = T), collapse = ""))
    
    #get the reverse complement
    seq_rc <- reverseComplement(seq_f)
    
    #get the RNA sequence
    seq_rna <- Biostrings::RNAString(seq_f)
    seq_rna_rc <- Biostrings::RNAString(seq_rc)
    
    #get the AA seq
    seq_aa <- Biostrings::translate(seq_rna)
    seq_aa_rc <- Biostrings::translate(seq_rna_rc)
    
    fr <- sample(c(1,2),size = 1)
    
    #output the DNA seq
    output$DNA <- renderText({
        paste0("<b>Consider the following nucleotide sequence ", "5'",
              seq_f,"3'</b>","<br>","<br>",sep = "")
    })
    #Check the rc seq
    output$rc_check <- renderText({
        if(input$rc == ""){
            print("")
        }else{
            if(paste(input$rc)==paste(seq_rc)){
                paste0("<br>","<br>",
                       "<b>Your reverse complement sequence is correct</b>",
                       "<br>","<br>")
            }else{
                paste0("<br>","<br>",
                       "<b>Your reverse complement sequence is incorrect</b>",
                       "<br>","<br>")
            }
        }
    })
    
    #decide which is the coding strand
    output$mRNA <- renderText({
        if(fr == 1){
            
            base::paste("<b>Assuming the original sequence is the 
                        coding strand</b>","<br>", "<br>")
            
        }else{
            base::paste("<b>Assuming the reverse complement strand you enterd 
            is the coding strand</b>", "<br>", "<br>")
        }
        
    })
    
    #Check the mRNA sequence
    
    output$m_check <- renderText({
        if(input$rna == ""){
            paste0("")
        }else{
            if(fr ==1 & input$rna == paste(seq_rna)){
                paste0("<br>","<br>","<b>Your mRNA sequence is correct</b>",
                       "<br>","<br>")
            }else{
                if(fr == 2 & input$rna == paste(seq_rna_rc)){
                    paste0("<br>","<br>",
                           "<b>Your mRNA sequence is correct</b>",
                           "<br>","<br>")
                }else{
                    paste0("<br>","<br>",
                           "<b>Your mRNA sequence is incorrect</b>",
                           "<br>","<br>")
                }
            }
        }
    })
    
    #Check the AA sequence
    
    output$aa_check <- renderText({
        if(input$prot == ""){
            paste0("")
        }else{
            if(fr == 1 & input$prot == paste(seq_aa)){
                paste0("<br>","<br>",
                       "<b>Your amino acid sequence is correct</b>",
                       "<br>","<br>")
            }else{
                if(fr == 2 & input$prot == paste(seq_aa_rc)){
                    paste0("<br>","<br>",
                           "<b>Your amino acid sequence is correct</b>",
                           "<br>","<br>")
                }else{
                    paste0("<br>","<br>",
                           "Your amino acid sequence is incorrect</b>",
                           "<br>","<br>")
                }
            }
        }
    })
    
    #Output the genetice table code
    output$code <- renderImage({
        width  <- session$clientData$output_code_width
        height <- session$clientData$output_code_height
        list(
            src = file.path("genetic_code.png"),
            contentType = "image/png",
            width = if(as.numeric(width)<720){width}else{paste0("720")},
            height = if(as.numeric(height)<708){height}else{paste0("708")},
            alt = "A table showing the standard genetic code"
        )
    }, deleteFile = F)

    
}

# Run the application 
shinyApp(ui = ui, server = server)
