#Xander Nuttle
#pdf_sim_bola2b_single_age_with_selection.r
#This R script should be invoked from a shell script

#LOAD PLOTTING LIBRARY
library(ggplot2)

#SET UP PDF OUTPUT FOR ALL DATA
pdf("sim_bola2b_single_age_with_selection.pdf",width=7,height=7,useDingbats=FALSE)

#IMPORT DATA
data<-read.table("s_results.reformatted.txt",header=T)

#PLOT DATA AND PRINT TO PDF
p<-ggplot(data)+geom_point(aes(x=s_value,y=prob_rel_to_max_prob,size=2),color="#000000")+stat_smooth(aes(x=s_value,y=prob_rel_to_max_prob),method="loess",formula=y~x,se=FALSE,colour="#000000")
p<-p+theme(panel.background=element_rect(fill='white'))
p<-p+theme(panel.grid.major=element_line(colour="#F3F3F3"))
p<-p+theme(panel.grid.minor=element_line(colour="#F3F3F3"))
p<-p+theme(legend.position="none")
p<-p+xlab("Selection coefficient")+ylab("Probability of simulated data relative to maximum")
print(p)
dev.off()

