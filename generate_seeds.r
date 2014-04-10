##
## generate_seeds.R
##
##--------------------------------------------------------------------
## sample command line:
## R --slave --args < generate_seeds.r ncol=3 nrow=10000 > seeds.txt
##--------------------------------------------------------------------

## must initialize command-line variables:
ncol <- 2
nrow <- 10

## structure to hold command line inputs:
cl <- c(ncol, nrow);
cl <- as.list(t(cl));
cl <- as.data.frame(t(cl));
names(cl) <- c("ncol", "nrow");

## get ncol,nrow from command line:
carg <- commandArgs(trailingOnly=TRUE)
for (e in carg) {
  clvar = strsplit(e, "=", fixed = TRUE);
  if(! is.na(clvar[[1]][2])) {
    value = clvar[[1]][2];
    if(substr(clvar[[1]][1], 1, nchar(clvar[[1]][1])) == "ncol") {
      cl$ncol <- as.integer(value);
    } # ncol
    else if(substr(clvar[[1]][1], 1, nchar(clvar[[1]][1])) == "nrow") {
      cl$nrow <- as.integer(value);
    } # nrow
  } else {
    assign(clvar[[1]][1], TRUE);
  }
} # commandArgs()
cl <- as.data.frame(cl);

ncol = cl$ncol
nrow = cl$nrow

## RNG parameters:
maxInt = 2147483647
maxInt = maxInt/100   # <-- maxInt constrained by vector allocatable memory

## generate random seeds:
seeds <- array(0, dim = ncol*nrow)
posint <- seq(0, maxInt, by = 1)
seeds <- sample(posint, ncol*nrow, replace = F)
seeds <- t(seeds);

write(seeds, "", ncolumns=ncol);

