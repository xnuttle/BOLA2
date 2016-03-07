#! /bin/bash
#$ -S /bin/bash
#$ -cwd

#Xander Nuttle
#mrsim_single_age_no_selection_with_recurrence.sh
#Call: qsub /net/gs/vol2/home/xnuttle/bola2_paper/popgen_sims_xn/analysis_programs/mrsim_single_age_no_selection_with_recurrence.sh number_of_replicates_per_mu_value
#The script automates running simulations for the evolution of the BOLA2B duplication incorporating its age and the possibility of recurrent mutation.

#instruct shell to exit immediately if any step in pipeline fails
set -e

#assign username to variable
user=`whoami`

#set up directory variables
EXP_DIR=$(pwd)
SIMS_DIR=$EXP_DIR/sims_single_age_no_selection_with_recurrence
SIM_OUT_DIR=$SIMS_DIR/simulations_output
LOG_DIR=$SIMS_DIR/log
OUT_DIR=$SIMS_DIR/final_results
PROGRAM_DIR=/net/gs/vol2/home/xnuttle/bola2_paper/popgen_sims_xn/analysis_programs

#make directories
mkdir -p $SIMS_DIR $SIM_OUT_DIR $LOG_DIR $OUT_DIR
echo "Made directory 'sims_single_age_no_selection_with_recurrence' and subdirectories 'simulations_output', 'log', and 'final_results'" > $LOG_DIR/mrsim_single_age_no_selection_with_recurrence.log

#run simulations
cd $SIMS_DIR
NREPS=$1
bash $PROGRAM_DIR/sim_bola2b_single_age_no_selection_with_recurrence.sh $NREPS $SIM_OUT_DIR
echo "Cluster simulation job submitted." >> $LOG_DIR/mrsim_single_age_no_selection_with_recurrence.log

#monitor status of cluster simulation job periodically and do not proceed until it finishes
simjob=$(qstat -u $user|grep sim_|grep -v mr|awk '{print $1}')
simulating=$(qstat -u $user|grep sim_|grep -v mr|wc -l)
while [ $simulating -eq 1 ]; do
  echo "Cluster simulation job not complete, waiting..." >> $LOG_DIR/mrsim_single_age_no_selection_with_recurrence.log
  sleep 5m
  simulating=$(qstat -u $user|grep sim_|grep -v mr|wc -l)
done
echo "Cluster simulation job complete." >> $LOG_DIR/mrsim_single_age_no_selection_with_recurrence.log

#wait for cluster simulation job report to be generated
sleep 5m

#ensure cluster simulation job exited successfully
simexit=$(qacct -j $simjob|grep exit_status|cut -f3 -d ' '|paste -sd+|bc)
if [ $simexit -eq 0 ]; then
  echo "CLUSTER SIMULATIONS SUCCESSFUL!" >> $LOG_DIR/mrsim_single_age_no_selection_with_recurrence.log
else
  echo "CLUSTER SIMULATIONS FAILED" >> $LOG_DIR/mrsim_single_age_no_selection_with_recurrence.log
  exit 1
fi
echo "Cluster simulation job exited successfully." >> $LOG_DIR/mrsim_single_age_no_selection_with_recurrence.log

#parse simulation output
cd $SIM_OUT_DIR
bash $PROGRAM_DIR/parse_sims_bola2b_range_mu.sh
echo "Program to parse simulation results finished." >> $LOG_DIR/mrsim_single_age_no_selection_with_recurrence.log

#put results in a good format for plotting
$PROGRAM_DIR/counts_to_rel_probs mu_results.txt
echo "Program to summarize simulation results for plotting finished." >> $LOG_DIR/mrsim_single_age_no_selection_with_recurrence.log

#generate plot showing frequencies of different bola2b simulation outcomes
module load hdf5/1.8.13
module load netcdf/4.3.2
module load R/3.1.0
Rscript $PROGRAM_DIR/pdf_sim_bola2b_single_age_no_selection_with_recurrence.r

#move plot and data summary to final output directory, report success, and exit pipeline
mv $SIM_OUT_DIR/mu_results.txt $OUT_DIR
mv $SIM_OUT_DIR/mu_results.reformatted.txt $OUT_DIR
mv $SIM_OUT_DIR/sim_bola2b_single_age_no_selection_with_recurrence.pdf $OUT_DIR
echo "PIPELINE COMPLETE FOR mrsim_single_age_no_selection_with_recurrence.sh: SUCCESS!" >> $LOG_DIR/mrsim_single_age_no_selection_with_recurrence.log
exit 0

