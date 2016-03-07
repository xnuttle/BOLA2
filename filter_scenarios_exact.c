//Xander Nuttle
//filter_scenarios_exact.c
//Call: ./filter_scenarios_exact sim_results_text_file
//
//Parses a 'sim_results_text_file' to determine how many simulation outcomes reported in the file match
//the observed frequency data for BOLA2B as well as how many simulation outcomes have BOLA2B absent in
//Neanderthal and Denisova but present on at least 1 human haplotype.

#include<stdio.h>
#include<string.h>

int main(int argc,char*argv[])
{
	//parse sim_results_text_file
	long count=0,count2=0;
	FILE*in=fopen(*(argv+1),"r");
	char ch;
	long san,yor,nea,den;
	while((ch=getc(in))!='\n')
	{
		continue;
	}
	while((fscanf(in,"%ld %ld %ld %ld",&san,&yor,&nea,&den))==4)
	{
		if((yor==108)&&(san==8)&&(!(nea+den)))
		{
			count++; //exact matches
		}
		if((yor+san)&&(!(nea+den)))
		{
			count2++; //BOLA2B present only in humans
		}
	}

	//parse name of sim_results_text_file to determine simulation identifier
	char sim_id[101];
	long i;
	for(i=0;i<101;i++)
	{
		sim_id[i]='\0';
	}
	strncpy(sim_id,argv[1]+3,100);
	for(i=0;i<100;i++)
  {
    if(sim_id[i]=='_')
		{
			sim_id[i]='\0';
			break;
		}
  }

	//print result
	printf("%s\t%ld\t%ld\n",sim_id,count,count2);

	//clean up and exit
	return 0;
}
