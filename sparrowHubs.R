#make sparrow hubs and push to table

require(synapseClient)
synapseLogin()

sparrowNetworkQuery <- synQuery('select name,id from file where projectId==\'syn5584871\' and method==\'sparrow\' and disease==\'dermalNeurofibromatosis\' and analysisType==\'statisticalNetworkReconstruction\'')

sparrowNetworkObj <- synGet(sparrowNetworkObj$file.id)

library(data.table)
sparrowNetwork <- fread(sparrowNetworkObj@filePath,stringsAsFactors=F,data.table=F)

sparrowNetwork <- sparrowNetwork[,-1]
rownames(sparrowNetwork) <- colnames(sparrowNetwork)
sparrowNetwork <- data.matrix(sparrowNetwork)
zvals <- sparrowNetwork[which(upper.tri(sparrowNetwork))]
sparrowNetwork <- sparrowNetwork^2
sparrowNetwork <- sparrowNetwork>qchisq(0.05/length(zvals),1,lower.tail=F)
hubs <- rowSums(sparrowNetwork+t(sparrowNetwork))
hubMatrix <- data.frame(geneName=names(hubs),sparrowScore=hubs,stringsAsFactors = F)

library(synapseUtiltiies)
synapseUtilities::makeTable(hubMatrix,projectId = 'syn5584871',tableName = 'dermalNF sparrow scores' )
