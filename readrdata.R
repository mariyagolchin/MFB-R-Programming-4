
input_name_path= "inputs/maf/ACC/ACC_maf.RData"
data=load(file.path(input_name_path), RData <- new.env() )
laml <- read.maf(maf = RData$maf)
rainfallPlot(maf = laml, detectChangePoints = TRUE, pointSize = 0.4)
