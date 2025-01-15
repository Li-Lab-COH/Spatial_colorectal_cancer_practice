#!/bin/bash
#SBATCH --job-name=download_files        # Job name
#SBATCH --output=slurmOutput/download_files.log      # Output log file
#SBATCH --error=slurmOutput/download_files.err       # Error log file
#SBATCH --time=04:00:00                  # Time limit (hh:mm:ss)
#SBATCH --ntasks=1                       # Number of tasks (processes)
#SBATCH --cpus-per-task=1                # Number of CPU cores per task
#SBATCH --mem=1G                         # Memory per node

echo "starting extraction"

tar -xvf ../data/input_files/fastq_file/Visium_HD_Human_Colon_Cancer_fastqs.tar

echo "extraction ended"ß