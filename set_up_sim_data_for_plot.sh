#Xander Nuttle
#setup_sim_data_for_plot.sh
#Call: bash setup_sim_data_for_plot.sh

echo "num_sims_with_outcome" > column1x
echo "num_san_haplotypes_with_bola2b" > column2x
echo "num_youban_haplotypes_with_bola2b" > column3x
echo "num_neanderthal_haplotypes_with_bola2b" > column4x
echo "num_denisovan_haplotypes_with_bola2b" > column5x
tail -n +2 sim_results.txt|sort|uniq -c|awk '{print $1}' >> column1x
tail -n +2 sim_results.txt|sort|uniq -c|awk '{print $2}' >> column2x
tail -n +2 sim_results.txt|sort|uniq -c|awk '{print $3}' >> column3x
tail -n +2 sim_results.txt|sort|uniq -c|awk '{print $4}' >> column4x
tail -n +2 sim_results.txt|sort|uniq -c|awk '{print $5}' >> column5x
paste column1x column2x column3x column4x column5x|sort -k1n,1 > sim_results_for_plot.txt
rm column1x
rm column2x
rm column3x
rm column4x
rm column5x

