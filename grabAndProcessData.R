#get data
require(synapseClient)
synapseLogin()

voomExprObj <- synGet('syn5812605')
voomExpr <- read.delim(voomExprObj@filePath,stringsAsFactors=F,sep='\t')
voomExpr <- data.matrix(voomExpr)
library(dplyr)
library(utilityFunctions)
voomExpr3 <- voomExpr %>%
             t %>%
             apply(2,winsorize) %>%
             scale

write.csv(voomExpr3,file='dermalNFRNAseq.csv',quote=F)
