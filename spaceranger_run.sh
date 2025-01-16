#!/bin/bash
#SBATCH --job-name=spaceranger_ffpe       
#SBATCH --output=spaceranger_ffpe.out 
#SBATCH --error=spaceranger_ffpe.err  
#SBATCH --ntasks=1                       
#SBATCH --cpus-per-task=32               
#SBATCH --mem=128G                       
#SBATCH --time=48:00:00                  

# Define variables
SPACERANGER_PATH="https://www.10xgenomics.com/support/software/space-ranger/latest/analysis/inputs/input-overview"  # Path to Space Ranger installation
OUTPUT_DIR="/path/to/output_directory"  # Directory where outputs will be saved
TRANSCRIPTOME="/path/to/refdata"  # Reference transcriptome for mouse samples
PROBE_SET="/path/to/human_v2_probeset.csv"  # Probe set for FFPE
FASTQ_DIR="/path/to/fastq_directory"    # Directory containing FASTQ files
IMAGE="/path/to/tissue_image.jpg"       # Path to H&E stained image
SLIDE="V11J26-127"                      # Slide serial number
AREA="B1"                               # Capture area on the slide

#Testing_3

# Run Space Ranger count pipeline
${SPACERANGER_PATH}/spaceranger count \
    --id=spaceranger_ffpe_analysis \
    --transcriptome=${TRANSCRIPTOME} \
    --probe-set=${PROBE_SET} \
    --fastqs=${FASTQ_DIR} \
    --image=${IMAGE} \
    --slide=${SLIDE} \
    --area=${AREA} \
    --reorient-images=true \
    --localcores=32 \
    --localmem=128
