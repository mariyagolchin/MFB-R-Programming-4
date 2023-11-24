main_dir=getwd()
library(TCGAbiolinks)
library(TCGAbiolinksGUI.data)
library(maftools)
library(dplyr)

################# part A ######## Get RData ########
Get_TCGA_RData <- function(TCGA_project_names)
{for (name in TCGA_project_names)
{
  path_name=paste0("inputs/maf/",name)
  query <- GDCquery(
    project = paste0("TCGA-", name),
    data.category = "Simple Nucleotide Variation", 
    access = "open", 
    legacy = FALSE, 
    data.type = "Masked Somatic Mutation", 
    workflow.type = "Aliquot Ensemble Somatic Variant Merging and Masking"
  )
  GDCdownload(query, method = "api", directory = path_name)
  maf <- GDCprepare(query, directory = path_name)
  save(maf, file = paste0(path_name ,"/",name,"_maf.RData")) 
}
}

######### main ############
TCGA_project_names<- c("ACC","SARC","BRCA")
Get_TCGA_RData(TCGA_project_names)

