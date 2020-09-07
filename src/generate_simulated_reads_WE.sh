# you need wgsim and you can install it with bioconda 
# conda install -c bioconda wgsim 

read_length_forward=70
read_length_reverse=70
error_rate=0.05
rate_of_mutation=0.005
fraction_of_indels=0.10

wgsim       -1 $read_length_forward \
		-2 $read_length_reverse \
		-e $error_rate \
		-r $rate_of_mutation \
		-R $fraction_of_indels \
       		fasta_ref.fa read1.fq read2.fq  # output for forwar and reverse FASTQ file
		
