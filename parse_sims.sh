#Xander Nuttle
#parse_sims.sh

#initialize file with summary of simulation results
echo "num_S num_Y num_N num_D"|sed 's/ /\t/g' > sim_results.txt

#parse each simulation output and add result to summary file
for i in $(seq 1 1 100);
	do echo "/net/gs/vol2/home/xnuttle/bola2_paper/popgen_sims_xn/analysis_programs/parse_sim_bola2 sim${i}_bola2b.txt >> sim_results.txt"|bash;
done

