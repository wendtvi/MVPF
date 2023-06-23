setwd("C:/Users/vitoria.wendt/Downloads/HISTORICO-1998-2010 (1)/")
dados_98_10=read.csv2("C:/Users/vitoria.wendt/Downloads/HISTORICO-1998-2010 (1)/HISTORICO1.csv",sep=";",header = F)
dados_11_19=read.csv2("C:/Users/vitoria.wendt/Downloads/HISTORICO-1998-2010 (1)/HISTORICO2.csv",sep=";",header = F)
dados_98_10=dados_98_10[-1,]
dados_11_19=dados_11_19[-1,]
dados_11_19=dados_11_19[dados_11_19$V1!=2019,]
dados_98_10=dados_98_10[substr(dados_98_10$V7,1,4)=="dez/",]
dados_98_10=dados_98_10[dados_98_10$V18>0,]
dados_11_19=dados_11_19[substr(dados_11_19$V7,1,4)=="dez/",]
dados_11_19=dados_11_19[dados_11_19$V18>0,]

dados=rbind(dados_98_10,dados_11_19)

vetor_pop=vector()
vetor_anos=seq(1999,2018,1)
for (k in 1:20){
  vetor_pop[k]=sum(as.numeric(dados$V6[dados$V1==vetor_anos[k]]))
}

matrix_net_gov_cost=matrix(NA,nrow = nrow(dados),ncol = 1)
#Custo Hospitalização evitada
vetor_MEH=c(-1.5028,-3.6776,-4.9095,-3.7641,-3.4274,-3.6659,-4.2236,-5.5679,-7.5660,-9.1676,-10.2458,-11.2954,-11.1689,-10.1907,-9.3172,-9.3839,-8.0755,-6.1085,-2.723,1.8654)
DV=213.564
DAYS=5.47
matrix_net_gov_cost[,1]=
for (k in 1:20){
 
  
}
