setwd("C:/Users/vitoria.wendt/Downloads/HISTORICO-1998-2010 (1)/")
dados_98_10=read.csv2("C:/Users/vitoria.wendt/Downloads/HISTORICO-1998-2010 (1)/HISTORICO1.csv",sep=";",header = F)
dados_11_19=read.csv2("C:/Users/vitoria.wendt/Downloads/HISTORICO-1998-2010 (1)/HISTORICO2.csv",sep=";",header = F)
dados_98_10=dados_98_10[-1,]
dados_11_19=dados_11_19[-1,]
dados_98_10=dados_98_10[dados_98_10$V1!=1998,]
dados_11_19=dados_11_19[dados_11_19$V1!=2019,]
dados_98_10=dados_98_10[substr(dados_98_10$V7,1,4)=="dez/",]
dados_98_10=dados_98_10[dados_98_10$V18>0,]
dados_11_19=dados_11_19[substr(dados_11_19$V7,1,4)=="dez/",]
dados_11_19=dados_11_19[dados_11_19$V18>0,]

dados=rbind(dados_98_10,dados_11_19)
dados[,ncol(dados)+1]=as.numeric(dados$V1)-1998

vetor_pop=vector()
vetor_anos=seq(1,20,1)
for (k in 1:20){
  vetor_pop[k]=sum(as.numeric(dados$V6[dados$V49==vetor_anos[k]]))
}

matrix_net_gov_cost=matrix(NA,nrow = 20,ncol = 3)
matrix_wtp=matrix(NA,nrow = 20,ncol = 2)
#Valor de Hospitalização evitada no orçamento do Gov
vetor_MEH=c(-1.5028,-3.6776,-4.9095,-3.7641,-3.4274,-3.6659,-4.2236,-5.5679,-7.5660,-9.1676,-10.2458,-11.2954,-11.1689,-10.1907,-9.3172,-9.3839,-8.0755,-6.1085,-2.723,1.8654)
DV=213.564
DAYS=5.47
matrix_net_gov_cost[,1]=vetor_pop/10000*(vetor_MEH)*DV*DAYS
plot(matrix_net_gov_cost[,1],type = 'l')


#Valor de Morte evitada no orçamento do Gov (valor presente)
#supõe que uma pessoa pague em méd 10% de imposto anual
vetor_MEM=c(-0.0867,	-0.1605,	-0.2497,	-0.3339,	-0.4371,	-0.5318,	-0.6422,	-0.8113,	-0.9018,	-1.0672,	-1.0317,	-1.3889,-1.5534,	-1.741,	-1.9042,	-2.1232,	-2.2711,	-2.5095,	-2.7329,	-2.9664)
wh=11.93
h_anos=8*5*4*12*30
matrix_net_gov_cost[,2]=vetor_pop/10000*(vetor_MEM)*wh*h_anos*0.1*(1+0.1375)^20

#Custo de uma equipe ESF no orçamento do Gov
anual_cost= 700932
esf_teams=43705
matrix_net_gov_cost[,3]=anual_cost*esf_teams
plot(-matrix_net_gov_cost[,3],type = 'l')





#WTP de Morte evitada
vetor_MEM=c(-0.0867,	-0.1605,	-0.2497,	-0.3339,	-0.4371,	-0.5318,	-0.6422,	-0.8113,	-0.9018,	-1.0672,	-1.0317,	-1.3889,-1.5534,	-1.741,	-1.9042,	-2.1232,	-2.2711,	-2.5095,	-2.7329,	-2.9664)
VSL=3294000
matrix_wtp[,1]=vetor_pop/10000*(-vetor_MEM)*VSL
plot(-matrix_wtp[,1],type = 'l')

#WTP de hospitalização evitada
vetor_MEH=c(-1.5028,-3.6776,-4.9095,-3.7641,-3.4274,-3.6659,-4.2236,-5.5679,-7.5660,-9.1676,-10.2458,-11.2954,-11.1689,-10.1907,-9.3172,-9.3839,-8.0755,-6.1085,-2.723,1.8654)
VS_lesao=139000
matrix_wtp[,2]=vetor_pop/10000*(-vetor_MEH)*(VS_lesao)


####################################################
#################MVPF###############################
####################################################
vetor_MVPF=vector()
vetor_MVPF=(matrix_wtp[,1]+matrix_wtp[,2])/(matrix_net_gov_cost[,1]+matrix_net_gov_cost[,2]+matrix_net_gov_cost[,3])
plot((matrix_wtp[,1]+matrix_wtp[,2]),type = "l", xlab = "Anos de exposição ao programa ESF")
plot((matrix_net_gov_cost[,1]+matrix_net_gov_cost[,2]+matrix_net_gov_cost[,3]),type = "l", xlab = "Anos de exposição ao programa ESF")
plot(vetor_MVPF[1:14],type = "l", xlab = "Anos de exposição ao programa ESF")


####################################################
#################BOOTSTRAPPING######################
####################################################

