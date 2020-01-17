library(networkSpatial)
#Draw some 2D coordinates
coord<-matrix(runif(400,0,2),nc=2)

#Produce a graph using the attenuated power law
net<-rnspatial(1,coord,c(1,8,3),model="atpowlaw")
