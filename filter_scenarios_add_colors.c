//Xander Nuttle
//filter_scenarios_add_colors.c
//Call: ./filter_scenarios_add_colors sim_results_text_file color_key_text_file
//
//Adds a new column to a 'sim_results_text_file' with information on the color to use for plotting each simulation
//outcome point. Also eliminates outcomes where Neanderthal and/or Denisova have at least 1 haplotype with BOLA2B.

#include<stdio.h>
#include<string.h>

int main(int argc,char*argv[])
{
	//read in color key
	int colornums[9];
	long mins[9],maxes[9];
	FILE*ckey=fopen(*(argv+2),"r");
	int i;
	for(i=0;i<9;i++)
	{
		fscanf(ckey,"%d %ld %ld",&(colornums[i]),&(mins[i]),&(maxes[i]));
	}
	fclose(ckey);

	//set up output file
	FILE*out;
	char output_base_name[101];
  for(i=0;i<100;i++)
  {
    output_base_name[i]='\0';
  }
  char output_file_extension[13]=".colored.txt";
  strncpy(output_base_name,*(argv+1),strrchr(*(argv+1),'.')-(*(argv+1)));
  strcat(output_base_name,output_file_extension);
  out=fopen(output_base_name,"w");
	fprintf(out,"num_sims_with_outcome\tnum_san_haplotypes_with_bola2b\tnum_youban_haplotypes_with_bola2b\tcolor_to_use\n");

	//read in sim_results_text_file and generate new file with color information added as a separate column
	FILE*in=fopen(*(argv+1),"r");
	char ch;
	long num,san,yor,nea,den;
	while((ch=getc(in))!='\n')
	{
		continue;
	}
	while((fscanf(in,"%ld %ld %ld %ld %ld",&num,&san,&yor,&nea,&den))==5)
	{
		if(!(nea+den))
		{
			for(i=0;i<9;i++)
			{
				if((num>=mins[i])&&(num<=maxes[i]))
				{
					fprintf(out,"%ld\t%ld\t%ld\t%d\n",num,san,yor,colornums[i]);
					break;
				}
			}
		}
	}
	
	//clean up and exit
	fclose(in);
	fclose(out);
	return 0;
}
