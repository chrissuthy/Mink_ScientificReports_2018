#This script can be used to reporduce the analyses presented in Sutherland et al 2018 (Scientific Reports)
#Libraries
library(gdistance)
library(raster)
library(rgdal)
library(rgeos)
library(sp)

#Load data object
load("Data/Sutherland_etal_MinkData.Rdata")
source("code/oSCR.fit.R")
source("code/utils.R")
sf <- minkData[["sf"]]
ss <- minkData[["ss"]]
cs <- minkData[["cs"]]

#All univariate density models
# - can fit any model form Sutherland et al using 
# - combinations of the below

Dmods <- c( ~1,
            ~session,
            ~river,
            ~year,
            ~d2urban,
            ~cover,
            ~d2Stem,
            ~d2Stem:river)

#AIC-best p0, sigma and cost models
Smods <- c(~sex)
Cmods <- c(~riparian-1)
Pmods <- c(~visit + session,
           ~visit + session + sex)

#Select model to fit:
# D = river, p0 = visit + session + sex, sigma = sex, asu = riparian

mod <- list(Dmods[[3]], Pmods[[2]], Smods[[1]], Cmods[[1]]) 


fm <- oSCR.fit(model = mod,
               scrFrame = sf, 
               ssDF = ss, 
               costDF = cs, 
               trimS = 4.5,
               distmet="ecol")

