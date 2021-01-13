# Workflow for WES 

## How to work with the repository

Some challenges would arise when many people try to develop, test and make changes to the same code. Working with `git` will help to to keep a record and manage a multi-contribution projects and creates a reliable collaborative environment. 

### Cloning the content of the repository

Let's say you are assigned to work on the QC pipeline. Some of your colleges has already written a part of the code and now you want to continue working to add other features. Your colleges also uploaded the code to Github. If you want to get the code, you can type: 

```
git clone https://github.com/hothman/WES_workflow.git
```

Now you will have a directory called `WES_workflow` that copies all the content from GitHub repository. 

### Generating dummy FASTQ files

Testing the pipline on real data at Gigabytes scale would be very inefficient. What you can do is generating dummy FASTQ files, test the code using these files and once you are sure that everything works fine you can apply your real data. 

To generate the dummy file go to `src` then type: 

```
bash generate_simulated_reads_WE.sh
```

This code will run `wgsim` to generate a forward ( `read1.fq` ) and reverse (`read2.fq`) FASTQ file based on the fasta sequences contained in the `fasta_ref.fa` file.  You can tweak the parameters in the bash file if you need more control on the content of the output. Normally, `wgsim` is part of `samtools` package. But you can also get it from  [this link](https://github.com/lh3/wgsim).

## Content description

* `QC`: pipeline for evaluating the quality. 
* `assembly`: pipeline for the genome assembly
* `variant_calling`: pipeline for the variant calling

Each pipeline is implemented in a bash script. 











