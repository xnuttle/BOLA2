//Xander Nuttle
//counts_to_rel_probs.c
//Call: ./counts_to_rel_probs text_file_with_counts_of_sim_outcomes_matching_data

#include<stdio.h>
#include<stdlib.h>
#include<string.h>

int main(int argc,char*argv[])
{
	//read in input file and determine the number of different simulation scenarios
	FILE*in;
	fpos_t start;
	long num_sims=-1; //start counting at -1 due to header line
	char dummy[101];
	in=fopen(*(argv+1),"r");
	fgetpos(in,&start);
	while(fscanf(in,"%s %s %s",dummy,dummy,dummy)==3)
	{
		num_sims++;
	}
	fsetpos(in,&start);

	//get header for first column
	char col1[101];
	long i,j;
	for(i=0;i<101;i++)
	{
		col1[i]='\0';
	}
	fscanf(in,"%s %*s %*s",col1);

	//get simulation identifiers and counts of simulation outcomes matching observed data; track maximum prob
	double maxprob=0;
	char sim_id[num_sims][101];
	for(i=0;i<num_sims;i++)
  {
    for(j=0;j<101;j++)
		{
			sim_id[i][j]='\0';
		}
  }	
	long counts[num_sims];
	long counts2[num_sims];
	double probs[num_sims];
	i=0;
	while(fscanf(in,"%s %ld %ld",sim_id[i],&(counts[i]),&(counts2[i]))==3)
  {
		probs[i]=(double)counts[i]/(double)counts2[i];
		if(probs[i]>maxprob)
		{
			maxprob=probs[i];
		}
		i++;
  }

	//set up output file
	FILE*out;
  char output_base_name[101];
  int a;
  for(a=0;a<100;a++)
  {
    output_base_name[a]='\0';
  }
  char output_file_extension[17]=".reformatted.txt";
  strncpy(output_base_name,*(argv+1),strrchr(*(argv+1),'.')-(*(argv+1)));
  strcat(output_base_name,output_file_extension);
  out=fopen(output_base_name,"w");
	fprintf(out,"%s\tprob_rel_to_max_prob\n",col1);

	//compute relative probabilities and print output
	double relprobs[num_sims];
	for(i=0;i<num_sims;i++)
	{
		relprobs[i]=probs[i]/maxprob;
		fprintf(out,"%s\t%.9g\n",sim_id[i],relprobs[i]);
	}	

	//clean up and exit
	fclose(in);
	fclose(out);
	return 0;
}
