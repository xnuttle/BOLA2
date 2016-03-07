//Xander Nuttle
//filter_scenarios_and_reformat.c
//Call: ./filter_scenarios_and_reformat sim_results_text_file
//
//Reformats a 'sim_results_text_file' for plotting each simulation outcome point.
//Also eliminates outcomes where Neanderthal and/or Denisova have at least 1 haplotype with BOLA2B
//and outcomes where both San and Yoruban populations lack (i.e., have lost) BOLA2B.

#include<stdio.h>
#include<string.h>

int main(int argc,char*argv[])
{
	//set up output file
	FILE*out;
	char output_base_name[101];
  int i;
	for(i=0;i<100;i++)
  {
    output_base_name[i]='\0';
  }
  char output_file_extension[17]=".reformatted.txt";
  strncpy(output_base_name,*(argv+1),strrchr(*(argv+1),'.')-(*(argv+1)));
  strcat(output_base_name,output_file_extension);
  out=fopen(output_base_name,"w");
	fprintf(out,"experiment_name\texperiment_type\tnum_san_haplotypes_with_bola2b\tnum_youban_haplotypes_with_bola2b\n");

	//read in sim_results_text_file and generate new file with color information added as a separate column
	FILE*in=fopen(*(argv+1),"r");
	char ch;
	long num=1,san,yor,nea,den;
	while((ch=getc(in))!='\n')
	{
		continue;
	}
	while((fscanf(in,"%ld %ld %ld %ld",&san,&yor,&nea,&den))==4)
	{
		if((!(nea+den))&&(san+yor))
		{
			fprintf(out,"sim%ld\tsimulation\t%ld\t%ld\n",num,san,yor);
			num++;
		}
	}
	fprintf(out,"observed_data\tnature\t8\t108\n");	

	//clean up and exit
	fclose(in);
	fclose(out);
	return 0;
}
