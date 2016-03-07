//Xander Nuttle
//filter_scenarios_broad.c
//Call: ./filter_scenarios_broad sim_results_text_file
//
//Parses a 'sim_results_text_file' to determine how many simulation outcomes reported in the file:
//	-match the observed frequency data for BOLA2B (hmcount)
//	-match or exceed the observed frequency data for BOLA2B in humans, with BOLA2B absent in Neandethal and Denisova (hgtecount)
//	-have BOLA2B absent in Neanderthal and Denisova but present on at least 1 human haplotype (hcount)
//	-match the observed frequency data for BOLA2B in humans, regardless of its status in Neanderthal and Denisova (mcount)
//	-match or exceed the observed frequency data for BOLA2B in humans, regardless of its status in Neanderthal and Denisova (gtecount)
//	-have BOLA2B present on at least 1 human haplotype, regardless of its status in Neanderthal and Denisova (count)
//	-have BOLA2B present on at least 1 haplotype, regardless of lineage (allcount)

#include<stdio.h>
#include<string.h>

int main(int argc,char*argv[])
{
	//parse sim_results_text_file
	long hmcount=0,hgtecount=0,hcount=0,mcount=0,gtecount=0,count=0,allcount=0;
	FILE*in=fopen(*(argv+1),"r");
	char ch;
	long san,yor,nea,den;
	while((ch=getc(in))!='\n')
	{
		continue;
	}
	while((fscanf(in,"%ld %ld %ld %ld",&san,&yor,&nea,&den))==4)
	{
		if(yor+san+nea+den)
		{
			allcount++; //BOLA2B present on at least 1 haplotype
			if(yor+san)
			{
				count++;
			}
			if((yor>=108)&&(san==8))
			{
				gtecount++; //BOLA2B frequency in humans as high or higher than observed frequency
				if(yor==108)
				{
					mcount++; //BOLA2B frequency in humans matches observed frequency
				}
			}
			if(!(nea+den))
			{
				hcount++; //BOLA2B present only in humans
				if((yor>=108)&&(san==8))
				{
					hgtecount++; //BOLA2B present only in humans and at a frequency as high as or higher than observed frequency
					if(yor==108)
        	{
						hmcount++; //BOLA2B present only in humans and at a frequency matching observed frequency
					}
				}
			}
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
	printf("%s\t%ld\t%ld\t%ld\t%ld\t%ld\t%ld\t%ld\n",sim_id,hmcount,hgtecount,hcount,mcount,gtecount,count,allcount);

	//clean up and exit
	return 0;
}
