//Xander Nuttle
//make_command_sim_bola2b_single_age_no_selection_with_recurrence.c
//Call: ./make_command_sim_bola2b_single_age_no_selection_with_recurrence (long)number_of_simulation_replicates (long)bola2b_age_in_years (double)recurrence_mutation_rate
//
//The recurrence mutation rate input to this program should be in units of "substitutions" per site per generation.
//Prints to standard output an msms command for modelling BOLA2B evolution incorporating its age and recurrent mutation at a specified level (possibly zero).

#include<stdio.h>
#include<stdlib.h>

int main(int argc,char*argv[])
{
	//set up demographic model
	long age=strtol(*(argv+2),NULL,10); //time (in years) of BOLA2B formation
	double tND_YS=26000; //time (in 25 year generations) of Neanderthal/Denisova divergence from modern humans
	double tN_D=21000; //time (in 25 year generations) of Neanderthal-Denisova divergence
	double tY_S=8000; //time (in 25 year generations) of Yoruban-San divergence
	double tYe=6300; //time (in 25 year generations) of Yoruban population size increase
	double tYd=1500; //time (in 25 year generations) of Yoruban population size decline
	double nY=10000; //current size of Yoruban population
	long NY=10000; //current size of Yoruban population (will not be scaled)
	double nYe=45000; //size of Yoruban population after expansion
	double nS=10000; //current size of San population
	double nYS=24000; //size of Yoruban-San ancestor (and size of ancestral Yoruban population before expansion)
	double nND=500; //"current" size of Neanderthal and Denisova populations
	double nNDYS=21600; //size of Neanderthal-Denisova-Yoruban-San ancestral population
	double t_age=age/25.0; //time (in 25 year generations) of BOLA2B formation
	double init_freq=1.0/(2.0*NY); //initial frequency of BOLA2B
	double mu=strtod(*(argv+3),NULL); //recurrence mutation rate
	long cY=110; //number of Yoruban chromosomes sampled
	long cS=8; //number of San chromosomes sampled
	long cN=2; //number of Neanderthal chromosomes sampled
	long cD=2; //number of Denisova chromosomes sampled
	long nreps=strtol(*(argv+1),NULL,10);

	//convert times to units of 4Ne generations
	tND_YS=tND_YS/(4.0*nY);
	tN_D=tN_D/(4.0*nY);
	tY_S=tY_S/(4.0*nY);
	tYe=tYe/(4.0*nY);
	tYd=tYd/(4.0*nY);
	t_age=t_age/(4.0*nY);

	//scale population sizes to current Yoruban population size
	nYe=nYe/nY;
	nS=nS/nY;
	nYS=nYS/nY;
	nND=nND/nY;
	nNDYS=nNDYS/nY;
	nY=nY/nY;

	//scale recurrence mutation rate
	mu=4.0*NY*mu;

	//calculate total number of chromosomes samples
	long cTOT=cY+cS+cN+cD;

	//generate msms command
	printf("/net/gs/vol2/home/xnuttle/programs/msms/bin/msms %ld %ld -N %ld -s 0 -I 4 %ld %ld %ld %ld -n 1 %.13g -n 2 %.13g -n 3 %.13g -n 4 %.13g -en %.13g 2 %.13g -en %.13g 2 %.13g -ej %.13g 1 2 -ej %.13g 3 4 -ej %.13g 4 2 -en %.13g 2 %.13g -SI %.13g 4 0 %.13g 0 0 -Smu %.13g -SAA 0 -SaA 0 -Smark\n",cTOT,nreps,NY,cS,cY,cN,cD,nS,nY,nND,nND,tYd,nYe,tYe,nYS,tY_S,tN_D,tND_YS,tND_YS,nNDYS,t_age,init_freq,mu);
	return 0;
}
