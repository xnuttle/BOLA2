//Xander Nuttle
//parse_sim_bola2_recurrent.c
//Call: ./parse_sim_bola2_recurrent simulation_output_text_file
//
//This program parses msms simulation output for modeling BOLA2B evolution. For each simulation,
//the program prints one line of output showing the number of haplotypes from San, Yoruban, Neanderhal,
//and Denisova populations including BOLA2B. This program is compatible with recurrent mutation yielding
//msms outputs greater than 1.

#include<stdio.h>

int main(int argc,char*argv[])
{
	//specify number of simulated haplotypes in each population and create variables to track numbers of simulated haplotypes with BOLA2B
	long haps_S=8,haps_Y=110,haps_N=2,haps_D=2;
	long num_S,num_Y,num_N,num_D;

	//for each simulation, compute numbers of simulated haplotypes with BOLA2B
	FILE*in;
	char ch;
	long i;
	char bola2b;
	in=fopen(*(argv+1),"r");
	while((ch=getc(in))!=EOF)
	{
		num_S=0;
		num_Y=0;
		num_N=0;
		num_D=0;
		if(ch=='/')
		{
			fscanf(in,"%*s %*s %*s %*s %*s");
			for(i=0;i<haps_S;i++)
			{
				fscanf(in," %c",&bola2b);
				if(bola2b>'0')
				{
					num_S++;	
				}
			}
			for(i=0;i<haps_Y;i++)
      {
        fscanf(in," %c",&bola2b);
        if(bola2b>'0')
        {
          num_Y++;
        }
      }
			for(i=0;i<haps_N;i++)
      {
        fscanf(in," %c",&bola2b);
        if(bola2b>'0')
        {
          num_N++;
        }
      }
			for(i=0;i<haps_D;i++)
      {
        fscanf(in," %c",&bola2b);
        if(bola2b>'0')
        {
          num_D++;
        }
      }
			printf("%ld\t%ld\t%ld\t%ld\n",num_S,num_Y,num_N,num_D);
		}
	}
	
	//clean up and exit
	fclose(in);
	return 0;
} 
