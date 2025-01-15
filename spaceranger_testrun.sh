#!/bin/bash
#SBATCH --job-name=spaceranger_testrun      # Job name
#SBATCH --output=./slurmOutput/spaceranger_testrun.out    # Standard output log
#SBATCH --error=./slurmOutput/spaceranger_testrun.err     # Standard error log
#SBATCH --ntasks=1                          # Number of tasks (processes)
#SBATCH --cpus-per-task=40                   # Number of CPU cores per task
#SBATCH --mem=150G                           # Memory allocation
#SBATCH --time=01:00:00                     # Time limit (hh:mm:ss)

# Echo the CPU and memory allocation
echo "Allocated CPUs: $SLURM_CPUS_PER_TASK"
echo "Allocated Memory: $SLURM_MEM_PER_NODE"

# Optionally, print the total number of CPUs available on the node
echo "Total CPUs on node: $(nproc)"

# Optionally, print memory information of the node
echo "Node Memory Info:"
free -h

/home/janzules/Spatial/software/spaceranger-3.1.2/spaceranger sitecheck > /home/janzules/Spatial/software/sitecheck_workmode.txt

# Run the SpaceRanger test run
/home/janzules/Spatial/software/spaceranger-3.1.2/spaceranger testrun --id=verify_install
