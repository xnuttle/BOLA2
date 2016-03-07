#Xander Nuttle
#sim_bola2b_single_age_with_selection_282_to_45_kya.sh

#check command line call for correct number of arguments
if [[ "$#" -ne "2" ]]
then
    echo "Usage: $0 <(long)number_of_simulation_replicates_per_s_value> <path_to_simulations_output_directory>"
    exit 1
fi

#set up directories
TMP_DIR=/var/tmp/`whoami`/
SIM_OUT_DIR=$2
CURRENT_DIR=$(pwd)

#make commands file
for i in $(seq 0.0010 0.0001 0.0025);
	do tnano=$(date +%N); tmicro=$(echo "$tnano/1000"|bc -l); t10th_micro=$(echo "$tnano/100"|bc -l); cmd=$(echo "/net/gs/vol2/home/xnuttle/bola2_paper/popgen_sims_xn/analysis_programs/make_command_sim_bola2b_single_age_with_selection_282_to_45_kya $1 237000 $i"|bash); usleep $tmicro;
		echo "mkdir -p $TMP_DIR;
    chgrp -R eichlerlab $TMP_DIR;
    chmod -R g+wx $TMP_DIR;
		cd $TMP_DIR;
		usleep $t10th_micro;
		$cmd > sim${i}_bola2b.txt;
		mv sim${i}_bola2b.txt $2;"|tr '\n' ' '
	echo
done > sim_bola2b_single_age_with_selection_282_to_45_kya_commands.txt

qsub -q all.q -N sim_bola2b_single_age_with_selection_282_to_45_kya -pe orte 50-100 /net/eichler/vol18/xander/MIPs/analysis_programs/commands_to_cluster.sh ${CURRENT_DIR}/sim_bola2b_single_age_with_selection_282_to_45_kya_commands.txt

