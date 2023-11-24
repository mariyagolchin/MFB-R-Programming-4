
################### part B ################################
########## draw plot and save Plot ########################
main_dir=getwd()
library(TCGAbiolinks)
library(TCGAbiolinksGUI.data)
library(maftools)
library(dplyr)

################### Summaryplot ################### 
Summaryplot <- function(laml,output_path){
  pdf_name <- paste0(output_path,"/plotmafSummary.pdf")
  dir.create(dirname(pdf_name))
  png_name= paste0(output_path,"/plotmafSummary.png")
  dir.create(dirname(png_name))
  # === save pdf and png =======
  pdf(pdf_name)
  a<-dev.cur()
  png(png_name)
  dev.control("enable")
  plotmafSummary(maf = laml, rmOutlier = TRUE, addStat = 'median', dashboard = TRUE, titvRaw = FALSE)
  dev.copy(which=a)
  dev.off()
  dev.off()
}

################### Oncoplot ################### 

Oncoplot <- function(laml,output_path){
  pdf_name <- paste0(output_path,"/oncoplot.pdf")
  dir.create(dirname(pdf_name))
  png_name= paste0(output_path,"/oncoplot.png")
  dir.create(dirname(png_name))
  # === save pdf and png =======
  pdf(pdf_name)
  a<-dev.cur()
  png(png_name)
  dev.control("enable")
  oncoplot(maf = laml, top = 10)
  dev.copy(which=a)
  dev.off()
  dev.off()
}

################### RainfallPlot ################### 

RainfallPlot <- function(laml,output_path){
  pdf_name <- paste0(output_path,"/rainfallPlot.pdf")
  dir.create(dirname(pdf_name))
  png_name= paste0(output_path,"/rainfallPlot.png")
  dir.create(dirname(png_name))
  # === save pdf and png =======
  pdf(pdf_name)
  a<-dev.cur()
  png(png_name)
  dev.control("enable")
  rainfallPlot(maf = laml, detectChangePoints = TRUE, pointSize = 0.4)
  dev.copy(which=a)
  dev.off()
  dev.off()
}

############## load TCGA RData and draw plot ################################

Maf_plots <- function(TCGA_project_names){
    dir.create('Outputs')
    for(name in TCGA_project_names ){
    input_name_path=paste0("inputs/maf/",name,"/",name,"_maf.RData")
    output_path =paste0("Outputs/",name)
    load(file.path(input_name_path), RData <- new.env() )
    laml <- read.maf(maf = RData$maf)
    Summaryplot(laml,output_path)
    Oncoplot(laml,output_path)
    RainfallPlot(laml,output_path)
  }  
}

################ main #######################################################
TCGA_project_names<- c("ACC","SARC","BRCA")
Maf_plots(TCGA_project_names)




# ===========================================================
# ======== different plots===================
#   laml.mutload = tcgaCompare(maf = laml, cohortName = 'Example-LAML', logscale = TRUE, capture_size = 50)
# # ================Transition and Transversions=====================
# laml.titv = titv(maf = laml, plot = FALSE, useSyn = TRUE)
# #plot titv summary
# plotTiTv(res = laml.titv)
# 
# # ===================== Somatic Interactions==========================================
# somaticInteractions(maf = laml, top = 25, pvalue = c(0.05, 0.1))
# 
# OncogenicPathways(maf = laml)
# 
# PlotOncogenicPathways(maf = laml, pathways = "RTK-RAS")
# ========================================================