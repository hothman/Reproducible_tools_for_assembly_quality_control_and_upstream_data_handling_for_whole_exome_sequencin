#!/usr/bin/env nextflow

 /* 

	maintainer: Houcemeddine Othman
	email: houcemoo@gmail.com

 	The workflow assumes: that the FQSTQ files are compressind in .gz format
 						  The name of the files are is as follow SAMPLEID_{R1,R2}.fq.gz
 						  sampleIDs is a text file containing the ID of the sample per line 

*/

params.sampleIDs = "./list_samples.txt"
params.FASTQHOME = "../src"
params.OUTPUTDIR="./QC_output"


genes = Channel.fromPath("$params.sampleIDs").splitText()  { it.replaceAll("\n", "") }
		.ifEmpty { error "List of samples is empty" }


process ProcessFASTQ {
	echo true
	conda 'bioconda::afterqc=0.9.7'
	publishDir "${params.OUTPUTDIR}/afterqc_output", mode:'copy'

	input: 
		val(sampleID) from genes.flatMap()
	output:
		file '*/*.{html,json}' into afterqcOutput

	script: 
	    File a = new File(params.FASTQHOME)
	    String data_home = a.getCanonicalPath()  // get the absolute path

	"""
	echo $sampleID
	ln -s ${data_home}/${sampleID}_R1.fq.gz
	ln -s  ${data_home}/${sampleID}_R2.fq.gz
	after.py --qc_only -1 ${sampleID}_R1.fq.gz -2 ${sampleID}_R2.fq.gz >/dev/null
	mv QC ${sampleID}
	"""
}


process GenerateReport {
	conda 'bioconda::multiqc=1.9'
	publishDir "${params.OUTPUTDIR}", mode:'copy'
	input: 
		file ('*') from afterqcOutput.collect().ifEmpty([])

	output:
		file '*.html'
		file '*/*'

	"""
	multiqc . 
	"""

}