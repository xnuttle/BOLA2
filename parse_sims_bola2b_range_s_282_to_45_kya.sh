#Xander Nuttle
#parse_sims_bola2b_range_s_282_to_45_kya.sh

#initialize files with summaries of simulation results
for i in $(seq 0.0010 0.0001 0.0025);
	do echo "echo "num_S num_Y num_N num_D"|sed 's/ /\t/g' > sim${i}_results.txt"|bash;
done

#parse each simulation output and add result to summary file
for i in $(seq 0.0010 0.0001 0.0025);
	do echo "/net/gs/vol2/home/xnuttle/bola2_paper/popgen_sims_xn/analysis_programs/parse_sim_bola2 sim${i}_bola2b.txt >> sim${i}_results.txt"|bash;
done

#initialize file with number of simulation outcomes matching the observed data for each s value's simulation set
echo "s_value num_sims_matching_data num_sims_with_bola2b_in_only_humans"|sed 's/ /\t/g' > s_results.txt

#compute the number of simulation outcomes matching the observed data for each age's simulation set
for i in $(seq 0.0010 0.0001 0.0025);
  do echo "/net/gs/vol2/home/xnuttle/bola2_paper/popgen_sims_xn/analysis_programs/filter_scenarios_exact sim${i}_results.txt >> s_results.txt"|bash;
done

