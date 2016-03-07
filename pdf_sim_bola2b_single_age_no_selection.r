#Xander Nuttle
#pdf_sim_bola2b_single_age_no_selection.r
#This R script should be invoked from a shell script

#LOAD PLOTTING LIBRARY
library(ggplot2)

#SET UP PDF OUTPUT FOR ALL DATA
pdf("sim_bola2b_single_age_no_selection.pdf",width=12,height=7,useDingbats=FALSE)

#IMPORT DATA
data<-read.table("sim_results.reformatted.txt",header=T)

#PLOT DATA AND PRINT TO PDF
cs=c("#FF0000","#000000")
p<-ggplot(data)+geom_point(aes(y=num_san_haplotypes_with_bola2b,x=num_youban_haplotypes_with_bola2b,color=experiment_type,size=2),position=position_jitter(width=0,height=0.2),alpha=0.4)
p<-p+theme(panel.background=element_rect(fill='white'))
p<-p+theme(panel.grid.major=element_line(colour="#AAAAAA"))
p<-p+theme(panel.grid.minor=element_line(colour="#CCCCCC"))
p<-p+theme(legend.position="none")
p<-p+scale_y_continuous(expression(paste("Number of San haplotypes with ",italic("BOLA2B"))))+scale_x_continuous(expression(paste("Number of Yoruban haplotypes with ",italic("BOLA2B"))))
p<-p+scale_colour_manual(values=cs)
print(p)
dev.off()

