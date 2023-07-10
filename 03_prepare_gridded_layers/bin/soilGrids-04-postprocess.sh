#!/bin/bash
#SBATCH -D /work/ehrmann/

# ---------------------------------------------------------------------------------
# slurm arguments
# ---------------------------------------------------------------------------------

#SBATCH -J soilGrids_aggregate
#SBATCH -t 0-3:00:00
#SBATCH --mem-per-cpu=150G

# ---------------------------------------------------------------------------------
# setup job report
# ---------------------------------------------------------------------------------

#SBATCH -o /gpfs1/data/idiv_meyer/01_projects/LUCKINet/02_data_processing/01_prepare_gridded_layers/%x-%j-%a_log.txt
#SBATCH --mail-user=steffen.ehrmann@idiv.de
#SBATCH --mail-type=BEGIN,FAIL,END

# ---------------------------------------------------------------------------------
# load required modules
# ---------------------------------------------------------------------------------

module load foss/2020b R/4.0.4-2

# ---------------------------------------------------------------------------------
# execute task
# ---------------------------------------------------------------------------------

Rscript --vanilla "/gpfs1/data/idiv_meyer/01_projects/LUCKINet/02_data_processing/01_prepare_gridded_layers/src/soilGrids-04-postprocess.R"
