# PDF Combining Tool
# A utility script for combining multiple PDF files into a single merged PDF

# Load required libraries
library(pdftools)
library(tidyr)

# Function to combine PDFs in a directory
combine_pdfs <- function(input_dir = ".", output_filename = "merged.pdf") {
  # Set working directory to input directory
  setwd(input_dir)
  
  # Get all PDF files in the directory
  all_pdf <- list.files(pattern = "\\.pdf$", ignore.case = TRUE)
  
  # Check if any PDFs were found
  if (length(all_pdf) == 0) {
    stop("No PDF files found in the specified directory")
  }
  
  # Display found PDFs
  cat("Found", length(all_pdf), "PDF files:\n")
  cat(paste(all_pdf, collapse = "\n"), "\n\n")
  
  # Define the output path for the merged PDF
  pdf_merged <- file.path(input_dir, output_filename)
  
  # Combine the PDFs
  pdf_combine(all_pdf, output = pdf_merged)
  
  cat("PDFs successfully combined into:", pdf_merged, "\n")
  return(pdf_merged)
}

# Example usage:
# combine_pdfs("path/to/your/pdf/directory", "my_merged_file.pdf")
# combine_pdfs()  # Uses current directory, creates "merged.pdf"