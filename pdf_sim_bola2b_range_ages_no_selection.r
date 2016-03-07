#Xander Nuttle
#pdf_sim_bola2b_range_ages_no_selection.r
#This R script should be invoked from a shell script

#LOAD PLOTTING LIBRARY
library(ggplot2)

#SET UP PDF OUTPUT FOR ALL DATA
pdf("sim_bola2b_range_ages_no_selection.pdf",width=12,height=7,useDingbats=FALSE)

#IMPORT DATA
data<-read.table("age_results.reformatted.txt",header=T)

#PLOT DATA AND PRINT TO PDF
p<-ggplot(data)+geom_point(aes(x=age_in_yrs,y=prob_rel_to_max_prob,size=2),color="#000000")
p<-p+theme(panel.background=element_rect(fill='white'))
p<-p+theme(panel.grid.major=element_line(colour="#AAAAAA"))
p<-p+theme(panel.grid.minor=element_line(colour="#CCCCCC"))
p<-p+theme(legend.position="none")
p<-p+scale_x_continuous(expression(paste("Age of ",italic("BOLA2B"))))+ylab("Probability of simulated data relative to maximum")
p<-p+geom_vline(x=282000,color="#000000")+geom_vline(x=209000,linetype="longdash",color="#000000")+geom_vline(x=361000,linetype="longdash",color="#000000")
p<-p+geom_vline(x=700000,color="#0000FF")
print(p)
dev.off()

