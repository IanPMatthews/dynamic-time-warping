#The following code correlates two multivariate time series of different lengths using dynamic time warping (DTW). This example uses xrf data from two cores taken from the Tiefer See Lake in Northern Germany
library(dplyr)
library(dtw)
library(zoo)
library(compositions)
library(tseries)
library(lubridate)
library(FreqProf)
library(DescTools)
library(readxl)

bal_up <- read_excel("bal_8.5_9.5.xlsx")
bal_down <- read_excel("bal_9_10.xlsx")

bal_upf <- bal_up[c('Depth', 'l_star','a_star','b_star')]
bal_downf <- bal_down[c('Depth', 'l_star','a_star','b_star')]

#bal_upf[2:4]<-clr(bal_upf[2:4]) #standardise the image analysis values using a centred log ratio transform
#bal_downf[2:4]<-clr(bal_downf[2:4]) #standardise the image analysis values using a centred log ratio transform

#bal_upz_b <- (bal_upf-mean(bal_upf$b_star))/sd(bal_upf$b_star)
#bal_downz_b <- (bal_downf-mean(bal_downf$b_star))/sd(bal_downf$b_star)


bal_upf_b_star <- bal_upf['b_star']
bal_downf_b_star <- bal_downf['b_star']

#buz_bstar <- bal_upz_b['b_star']
#bdz_bstar <- bal_downz_b['b_star']

dtw_alignment_bstar<-dtw(bal_upf_b_star, bal_downf_b_star, keep.internals = T, open.start = TRUE, step=asymmetric, open.end = TRUE) #run the dynamic time warp with open ended starts and ends
dtwPlotTwoWay(dtw_alignment_bstar, offset = 6, match.indices = 50) #plot the correaltion of the time series, match indices here are limited to 200 to prevetn overcrowding
dtwPlotThreeWay(dtw_alignment_bstar)


## multivariate
dtw_alignment_multi<-dtw(bal_upf[2:4], bal_downf[2:4], keep.internals = F,dist.method="Manhattan", open.start = TRUE, step=asymmetric, open.end = TRUE) 
plot(dtw_alignment_multi$index1,dtw_alignment_multi$index2,main="Warping function")
