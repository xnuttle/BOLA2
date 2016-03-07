#Xander Nuttle
#analyze_range_mu_broad_scenarios.sh
#Call: bash /net/gs/vol2/home/xnuttle/bola2_paper/popgen_sims_xn/analysis_programs/analyze_range_mu_broad_scenarios.sh
#
#Run from 'simulations output directory' after all 'sim_results.txt' files have been generated.

#initialize file with number of simulation outcomes matching the observed data for each s value's simulation set
echo "mu_value num_sims_matching_data num_sims_matching_data_or_with_higher_freq_in_humans_only num_sims_with_bola2b_in_humans_only num_sims_matching_human_data num_sims_matching_or_with_higher_human_freq num_sims_with_bola2b_in_humans num_sims_with_bola2b"|sed 's/ /\t/g' > mu_results_broad.txt

for i in $(cat /net/eichler/vol18/xander/bola2_popgen_sims/recurrence_rates_to_test.txt);
	do echo "/net/gs/vol2/home/xnuttle/bola2_paper/popgen_sims_xn/analysis_programs/filter_scenarios_broad sim${i}_results.txt >> mu_results_broad.txt"|bash;
done

mv mu_results_broad.txt ../final_results

