#Xander Nuttle
#pdf_sim_bola2b_single_age_no_selection_with_recurrence.r
#This R script should be invoked from a shell script

#LOAD PLOTTING LIBRARY
library(ggplot2)

#SET UP PDF OUTPUT FOR ALL DATA
#pdf("sim_bola2b_single_age_no_selection_with_recurrence.pdf",width=7,height=7,useDingbats=FALSE)
pdf("sim_bola2b_single_age_no_selection_with_recurrence.pdf",width=12,height=7,useDingbats=FALSE)

#IMPORT DATA
data<-read.table("mu_results.reformatted.txt",header=T)

#PLOT DATA AND PRINT TO PDF
p<-ggplot(data)+geom_point(aes(x=mu_value,y=prob_rel_to_max_prob,size=2),color="#000000")
p<-p+theme(panel.background=element_rect(fill='white'))
p<-p+theme(panel.grid.major=element_line(colour="#F3F3F3"))
p<-p+theme(panel.grid.minor=element_line(colour="#F3F3F3"))
#p<-p+theme(legend.position="none")+scale_x_log10()
p<-p+theme(legend.position="none")
p<-p+xlab("Recurrence mutation rate")+ylab("Probability of simulated data relative to maximum")
print(p)
dev.off()

