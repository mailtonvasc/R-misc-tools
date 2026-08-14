# =============================================================================
# PDF Combining Tool
# A utility script for combining multiple PDF files into a single merged PDF
# =============================================================================
# REQUIREMENTS:
# Install required packages if not already installed by running:
#   install.packages("pdftools")
#   install.packages("tidyr")
# -----------------------------------------------------------------------------

# Load required libraries
library(pdftools)
library(tidyr)

  # Set working directory to input directory usually from path created with getwd()
  setwd(input_dir)

  # Get all PDF files in the directory (sorted alphanumerically)
  # TIP: Name your files with a numeric prefix to control merge order
  #      e.g. 01_intro.pdf, 02_methods.pdf, 03_results.pdf
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
  pdf_combine(all_pdf, output = pdf_merged.pdf)

  cat("PDFs successfully combined into:", pdf_merged, "\n")
  return(pdf_merged)

# =============================================================================
# ████  HOW TO USE — SET YOUR PLACEHOLDERS BELOW  ████
# =============================================================================

combine_pdfs(

  # PLACEHOLDER 1 — INPUT DIRECTORY
  # Replace with the full path to the folder containing your PDF files.
  # All PDF files in this folder will be merged, in alphanumeric order.
  #
  # Windows example:  "C:/Users/YourName/Documents/my_pdfs"
  # Mac/Linux example: "/Users/YourName/Documents/my_pdfs"
  #
  input_dir = "PATH/TO/YOUR/PDF/FOLDER",    # <-- CHANGE THIS

  # PLACEHOLDER 2 — OUTPUT FILE NAME
  # Replace with your desired name for the merged PDF.
  # The file will be saved inside the folder specified above.
  # Must end in .pdf
  #
  output_filename = "my_merged_output.pdf"  # <-- CHANGE THIS

)

# =============================================================================
# QUICK CHECKLIST BEFORE RUNNING:
#   [ ] All PDFs to merge are in the folder set as input_dir
#   [ ] PDF files are numbered/named in the order you want them merged
#       (e.g. 01_cover.pdf, 02_chapter.pdf, 03_appendix.pdf)
#   [ ] output_filename ends in .pdf
#   [ ] The output filename is NOT the same as any existing file you want to keep
# =============================================================================

# =============================================================================
# PDF Page Removal Tool
# Removes specified pages from a PDF file
# =============================================================================
library(pdftools)

remove_pages <- function(input_pdf, pages_to_remove, output_pdf) {
  
  # Get total number of pages in the PDF
  total_pages <- pdf_info(input_pdf)$pages
  
  # Validate requested pages exist
  invalid_pages <- pages_to_remove[!pages_to_remove %in% seq_len(total_pages)]
  if (length(invalid_pages) > 0) {
    stop("These pages don't exist in the PDF: ", paste(invalid_pages, collapse = ", "),
         "\nThe PDF has ", total_pages, " pages.")
  }
  
  # Work out which pages to KEEP
  pages_to_keep <- setdiff(seq_len(total_pages), pages_to_remove)
  
  if (length(pages_to_keep) == 0) {
    stop("Cannot remove all pages — the output PDF would be empty.")
  }
  
  # Write the subset to the output file
  pdf_subset(input_pdf, pages = pages_to_keep, output = output_pdf)
  
  cat("Removed page(s)", paste(pages_to_remove, collapse = ", "),
      "-- output has", length(pages_to_keep), "pages\n")
  cat("Saved to:", output_pdf, "\n")
  
  return(output_pdf)
}

# =============================================================================
# HOW TO USE
# =============================================================================
remove_pages(
  input_pdf = "PATH/TO/YOUR/FILE.pdf",     # <-- CHANGE THIS
  pages_to_remove = c(2, 5),               # <-- CHANGE THIS (page numbers to drop)
  output_pdf = "PATH/TO/OUTPUT.pdf"        # <-- CHANGE THIS
)
