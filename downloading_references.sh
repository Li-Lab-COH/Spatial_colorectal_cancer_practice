#!/bin/bash
#SBATCH --job-name=download_human_reference
#SBATCH --output=slurmOutput/download_files.log      
#SBATCH --error=slurmOutput/download_files.err  
#SBATCH --time=01:00:00                  
#SBATCH --ntasks=1                      
#SBATCH --cpus-per-task=1               
#SBATCH --mem=1G                         

# Human reference
wget -P /home/janzules/Spatial/references "https://cf.10xgenomics.com/supp/spatial-exp/refdata-gex-GRCh38-2020-A.tar.gz"
