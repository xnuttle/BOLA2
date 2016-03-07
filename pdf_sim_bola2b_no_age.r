#Xander Nuttle
#pdf_sim_bola2b_no_age.r
#This R script should be invoked from a shell script

#LOAD PLOTTING LIBRARY
library(ggplot2)

#SET UP PDF OUTPUT FOR ALL DATA
pdf("sim_bola2b_no_age.pdf",width=12,height=7,useDingbats=FALSE)

#IMPORT DATA
data<-read.table("sim_results_no_age_for_plot.colored.txt",header=T)

#PLOT DATA AND PRINT TO PDF
cs=c("#A91F24","#F16524","#CDAE2C","#119A49","#247DC1","#724C9E","#000000","#666766","#ADADAD")
p<-ggplot(data)+geom_point(aes(y=num_san_haplotypes_with_bola2b,x=num_youban_haplotypes_with_bola2b,color=as.factor(color_to_use),size=2),position=position_jitter(width=0,height=0.2))
p<-p+theme(panel.background=element_rect(fill='white'))
p<-p+theme(panel.grid.major=element_line(colour="#AAAAAA"))
p<-p+theme(panel.grid.minor=element_line(colour="#CCCCCC"))
p<-p+theme(legend.position="none")
p<-p+scale_y_continuous(expression(paste("Number of San haplotypes with ",italic("BOLA2B"))))+scale_x_continuous(expression(paste("Number of Yoruban haplotypes with ",italic("BOLA2B"))))
p<-p+scale_colour_manual(values=cs)
print(p)
dev.off()

