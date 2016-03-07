#Xander Nuttle
#parse_sims_bola2b_range_mu.sh

#initialize files with summaries of simulation results
#for j in $(seq -12 1 -3);
#	do i=$(echo "1e$j"); echo "echo "num_S num_Y num_N num_D"|sed 's/ /\t/g' > sim${i}_results.txt"|bash;
#done

for i in $(cat /net/eichler/vol18/xander/bola2_popgen_sims/recurrence_rates_to_test.txt);
  do echo "echo "num_S num_Y num_N num_D"|sed 's/ /\t/g' > sim${i}_results.txt"|bash;
done

#parse each simulation output and add result to summary file
#for j in $(seq -12 1 -3);
#	do i=$(echo "1e$j"); echo "/net/gs/vol2/home/xnuttle/bola2_paper/popgen_sims_xn/analysis_programs/parse_sim_bola2_recurrent sim${i}_bola2b.txt >> sim${i}_results.txt"|bash;
#done

for i in $(cat /net/eichler/vol18/xander/bola2_popgen_sims/recurrence_rates_to_test.txt);
	do echo "/net/gs/vol2/home/xnuttle/bola2_paper/popgen_sims_xn/analysis_programs/parse_sim_bola2_recurrent sim${i}_bola2b.txt >> sim${i}_results.txt"|bash;
done

#initialize file with number of simulation outcomes matching the observed data for each s value's simulation set
echo "mu_value num_sims_matching_data num_sims_with_bola2b_in_only_humans"|sed 's/ /\t/g' > mu_results.txt

#compute the number of simulation outcomes matching the observed data for each age's simulation set
#for j in $(seq -12 1 -3);
#	do i=$(echo "1e$j"); echo "/net/gs/vol2/home/xnuttle/bola2_paper/popgen_sims_xn/analysis_programs/filter_scenarios_exact sim${i}_results.txt >> mu_results.txt"|bash;
#done

for i in $(cat /net/eichler/vol18/xander/bola2_popgen_sims/recurrence_rates_to_test.txt);
	do echo "/net/gs/vol2/home/xnuttle/bola2_paper/popgen_sims_xn/analysis_programs/filter_scenarios_exact sim${i}_results.txt >> mu_results.txt"|bash;
done

