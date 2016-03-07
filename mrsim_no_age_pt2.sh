#! /bin/bash
#$ -S /bin/bash
#$ -cwd

#Xander Nuttle
#mrsim_no_age_pt2.sh
#Call: qsub /net/gs/vol2/home/xnuttle/bola2_paper/popgen_sims_xn/analysis_programs/mrsim_no_age_pt2.sh
#The script automates the plotting for coalescent simulations for the BOLA2B duplication without incorporating age.
#Before running this script, the data should be examined and used to develop a color scheme for the plot. This scheme
#should be specified in a new file "color_key.txt" with the following tab-delimited format:
#
#colornum min_count max_count
#
#where colornum is a numberical identifier for a particular color group (ranging from 1-9; must have exactly 9 colors; 9 should
#correspond to the least frequent outcomes and 1 to the most frequent outcomes) and where min_count and max_count are the minimum
#and maximum numbers of simulation outcomes to include within each color group

#instruct shell to exit immediately if any step in pipeline fails
set -e

#assign username to variable
user=`whoami`

#set up directory variables
SIMS_DIR=$(pwd)
SIM_OUT_DIR=$SIMS_DIR/simulations_output
LOG_DIR=$SIMS_DIR/log
OUT_DIR=$SIMS_DIR/final_results
TMP_DIR=/var/tmp/$user
PROGRAM_DIR=/net/gs/vol2/home/xnuttle/bola2_paper/popgen_sims_xn/analysis_programs

#add color scheme to final data for plotting
cd $SIM_OUT_DIR
mv $SIMS_DIR/color_key.txt $SIM_OUT_DIR
/net/gs/vol2/home/xnuttle/bola2_paper/popgen_sims_xn/analysis_programs/filter_scenarios_add_colors sim_results_no_age_for_plot.txt color_key.txt
echo "Program to add color scheme to results finished." > $LOG_DIR/plotlog.txt

#generate plot showing frequencies of different bola2b simulation outcomes
module load hdf5/1.8.13
module load netcdf/4.3.2
module load R/3.1.0
Rscript $PROGRAM_DIR/pdf_sim_bola2b_no_age.r

#ensure plot generated successfully
if [ $? -eq 0 ]; then
  echo "PLOT GENERATION GOOD!" >> $LOG_DIR/plotlog.txt
else
  echo "PLOT GENERATION FAILED" >> $LOG_DIR/plotlog.txt
  exit 1
fi
echo "Plotting program finished successfully."

#move plot and data summary to final output directory, report success, and exit pipeline
mv $SIM_OUT_DIR/sim_results_no_age_for_plot.colored.txt $OUT_DIR
mv $SIM_OUT_DIR/sim_bola2b_no_age.pdf $OUT_DIR
mv $SIM_OUT_DIR/color_key.txt $OUT_DIR
echo "PIPELINE COMPLETE FOR mrsim_no_age_pt2.sh: SUCCESS!" >> $LOG_DIR/plotlog.txt
exit 0

