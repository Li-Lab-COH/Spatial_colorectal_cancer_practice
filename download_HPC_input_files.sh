#!/bin/bash
#SBATCH --job-name=download_files        # Job name
#SBATCH --output=download_files.log      # Output log file
#SBATCH --error=download_files.err       # Error log file
#SBATCH --time=01:00:00                  # Time limit (hh:mm:ss)
#SBATCH --ntasks=1                       # Number of tasks (processes)
#SBATCH --cpus-per-task=1                # Number of CPU cores per task
#SBATCH --mem=1G                         # Memory per node

# Define URLs
urls=(
  "https://cf.10xgenomics.com/samples/spatial-exp/3.0.0/Visium_HD_Human_Colon_Cancer/Visium_HD_Human_Colon_Cancer_image.tif"
  "https://cf.10xgenomics.com/samples/spatial-exp/3.0.0/Visium_HD_Human_Colon_Cancer/Visium_HD_Human_Colon_Cancer_tissue_image.btf"
  "https://cf.10xgenomics.com/samples/spatial-exp/3.0.0/Visium_HD_Human_Colon_Cancer/Visium_HD_Human_Colon_Cancer_alignment_file.json"
  "https://s3-us-west-2.amazonaws.com/10x.files/samples/spatial-exp/3.0.0/Visium_HD_Human_Colon_Cancer/Visium_HD_Human_Colon_Cancer_fastqs.tar"
  "https://cf.10xgenomics.com/samples/spatial-exp/3.0.0/Visium_HD_Human_Colon_Cancer/Visium_HD_Human_Colon_Cancer_probe_set.csv"
  "https://cf.10xgenomics.com/samples/spatial-exp/3.0.0/Visium_HD_Human_Colon_Cancer/Visium_HD_Human_Colon_Cancer_slide_file.vlf"
)

# Go to the working directory (change to your SLURM working directory)
cd /home/janzules/Spatial/practice_colorectal_cancer || exit

# Create a directory for the downloaded files
output_dir="input_files"
mkdir -p "$output_dir"

# Download files one by one
echo "Starting file downloads..."
for url in "${urls[@]}"; do
  echo "Downloading: $url"
  wget -P "$output_dir" "$url"
  if [ $? -ne 0 ]; then
    echo "Failed to download: $url"
  else
    echo "Successfully downloaded: $url"
  fi
done

echo "All downloads complete. Files are in the '$output_dir' directory."
