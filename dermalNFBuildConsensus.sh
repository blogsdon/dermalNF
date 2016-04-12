#!/bin/sh
#number of cores to reserve for job
nthreads=8

#full s3 path where networks will go
s3="s3://metanetworks/dermalNF/"

#location of data file
dataFile="/shared/dermalNF/dermalNFRNAseq.csv"

#location of metanetwork synapse scripts
pathv="/shared/metanetworkSynapse/"

#output path for temporary result file prior to pushing to s3/synapse
outputpath="/local/dermalNF/"

#path within s3
s3b="dermalNF"

#id of folder with networks to combine
networkFolderId="syn5813085"

#id of folder on Synapse that file will go to
parentId="syn5813085"

#path to csv file with annotations to add to file on Synapse
annotationFile="/shared/dermalNF/annoFile.txt"

provenanceFile="/shared/dermalNF/provenanceFile.txt"

#path to error output
errorOutput="/shared/dermalNF/Aggregationerror.txt"

#path to out output
outOutput="/shared/dermalNF/Aggregationout.txt"

#job script name
jobname="dermalNFaggregation"

qsub -v s3=$s3,dataFile=$dataFile,pathv=$pathv,outputpath=$outputpath,s3b=$s3b,parentId=$parentId,annotationFile=$annotationFile,provenanceFile=$provenanceFile,networkFolderId=$networkFolderId -pe orte $nthreads -S /bin/bash -V -cwd -N $jobname -e $errorOutput -o $outOutput $pathv/buildConsensus.sh
