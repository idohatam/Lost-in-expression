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
