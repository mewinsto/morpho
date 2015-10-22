##GM_replicates
#Error analysis of mounting and imaging GM specimens
library(geomorph)
library(shapes)

#Load in paired data TPS file
TPS_all = readland.tps(file="TEST.tps")
N_tot = dim(TPS_all)[3]
N = N_tot/2

#Split TPS file into rep1 and rep2
TPS_r1 = TPS_all[,,seq(1,N_tot,2)]
TPS_r2 = TPS_all[,,seq(2,N_tot,2)]
  
#Run Procrustes on all sample pairs
error_array = array(data = NA, dim = c(14,2,N))
for (i in 1:N){
  temp = rbind(TPS_r1[,,i],TPS_r2[,,i])
  A = arrayspecs(temp,14,2)
  A_gen = gpagen(A)
  error = A_gen$coords[,,1] - A_gen$coords[,,2]
  error_array[,,i] = error
}

error_array = abs(error_array)
mean_error = array(data = NA, dim = c(14,2))
sd_error = array(data = NA, dim = c(14,2))
for (i in 1:14){
  for (j in 1:2){
    mean_error[i,j] = mean(error_array[i,j,])
    sd_error[i,j] = sd(error_array[i,j,])
  }
}

error_dist_array = array(data = NA, dim=c(14,N))
for (i in 1:14){
  for (j in 1:N){
    error_dist_array[i,j] = sqrt(error_array[i,1,j]^2 + error_array[i,2,j]^2)
  }
}


#PLOT DENSITY DISTRIBUTIONS FOR EACH LANDMARK (BY DIMENSION)
plot(density(error_array[1,1,]),xlim=c(-.003,.02),ylim=c(0,630),main="Density Distributions of Deviation by Landmark", sub="Color Indicates Landmark, Solid = X, Dotted = Y")
for (i in 1:14){
  for (j in 1:2){
    lines(density(error_array[i,j,]),col=i,lty=j)
  }
}

#PLOT DENSITY DISTRIBUTIONS OF TOTAL DEVIATION
plot(density(error_dist_array[1,]),xlim=c(-.003,.023),ylim=c(0,630),main="Density Distributions of Deviation by Landmark")
for (i in 1:14){
  lines(density(error_dist_array[i,]),col=i)
}


##DEMONSTRATE ON PLOT
normal = A_gen$coords[,,1]
ME = A_gen$coords[,,1] + mean_error
MHS = A_gen$coords[,,1]
MHS[9:10,2] = MHS[9:10,2] + c(.01,.01)
plot(normal)
points(ME)
points(MHS, col=2, pch=3)
