#!/bin/bash
#SBATCH --job-name=spaceranger_ffpe_array
#SBATCH --output=slurmOutput/spaceranger_ffpe_%a.out  # Output for each array job
#SBATCH --error=slurmOutput/spaceranger_ffpe_%a.err   # Error for each array job
#SBATCH --ntasks=1                          
#SBATCH --cpus-per-task=32                  
#SBATCH --mem=128G                          
#SBATCH --time=48:00:00                     
#SBATCH --array=0-0

# Define CSV file location
CSV_FILE="/home/janzules/Spatial/practice_colorectal_cancer/code/addresses/spaceranger_count_reference.csv"
SPACERANGER_PATH="/home/janzules/Spatial/software/spaceranger-3.1.2"

# Parse the CSV file to extract relevant information
IFS=","
mapfile -t SAMPLE_INFO < <(tail -n +2 "$CSV_FILE")

# Get the current sample based on the job array index
CURRENT_SAMPLE="${SAMPLE_INFO[$SLURM_ARRAY_TASK_ID]}"

CLEAN_SAMPLE="$(echo "$CURRENT_SAMPLE" | sed 's/^\xef\xbb\xbf//')"

# Now parse the comma-separated values into the respective variables
IFS=',' read -r \
    sample_id \
    output_folder \
    fastq_file \
    transcriptome \
    probe_set \
    loupe_alignment \
    hne_image \
    cytassist_image \
    slide_info \
    area_info \
    <<< "$CLEAN_SAMPLE"

# At this point, each variable should contain the correct column value from the CSV
echo "Sample ID       : $sample_id"
echo "Output Folder   : $output_folder"
echo "Fastq File      : $fastq_file"
echo "Transcriptome   : $transcriptome"
echo "Probe Set       : $probe_set"
echo "Loupe Alignment : $loupe_alignment"
echo "H&E Image       : $hne_image"
echo "CytAssist Image : $cytassist_image"
echo "Slide Info      : $slide_info"
echo "Area Info       : $area_info"

# Log the current sample being processed
echo "Processing sample: $sample_id"

cd ${output_folder}
# Run Space Ranger count pipeline
${SPACERANGER_PATH}/spaceranger count \
    --id="${sample_id}" \
    --transcriptome="${transcriptome}" \
    --probe-set="${probe_set}" \
    --fastqs="${fastq_file}" \
    --image="${hne_image}" \
    --cytaimage="${cytassist_image}" \
    --loupe-alignment="${loupe_alignment}" \
    --create-bam=true \
    --localcores=32 \
    --localmem=128
    # --slide="${slide_info}" \
    # --area="${area_info}" \
    #  --output-dir "${output_folder}" \
