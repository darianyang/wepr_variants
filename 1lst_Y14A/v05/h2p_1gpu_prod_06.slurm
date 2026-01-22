#!/bin/bash
#SBATCH --job-name=v05_1lst_Y14A_PROD_06
#SBATCH --nodes=1 
#SBATCH --ntasks-per-node=1 
#SBATCH --cluster=gpu 
#SBATCH --gres=gpu:1
#SBATCH --partition=l40s
#SBATCH --time=23:59:59 
#SBATCH --mail-user=shp176@pitt.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --output=slurm_prod_06.out 
#SBATCH --error=slurm_prod_06.err 

# load appropriate modules.  First purge all modules then load in intel (a prereq for loading in amber) and then amber 
module purge
#module load gcc/8.2.0
#module load openmpi/4.0.3
module load amber/24

# echo commands to stdout
set -x

# Executable
SANDER=pmemd.cuda

# Amber input files and output name
INP=06_prod.in
TOP=1lst_Y14A_solv.prmtop
CRD=05_eq3.rst
OUT=06_prod

$SANDER  -O     -i   $INP   -p   $TOP   -c   $CRD   -r   $OUT.rst \
        -o   $OUT.out   -e   $OUT.ene   -v   $OUT.vel   -inf $OUT.nfo   -x   $OUT.nc &&

# make cpptraj input file
echo "parm 1lst_Y14A_solv.prmtop"                            > strip_06.in
echo "trajin 06_prod.nc"                                    >> strip_06.in
echo "autoimage"                                            >> strip_06.in
echo "strip :WAT,NA+,Cl- parmout 1lst_Y14A_dry.prmtop"       >> strip_06.in
echo "trajout 06_prod_dry.nc"                               >> strip_06.in
echo "go"                                                   >> strip_06.in
echo "quit"                                                 >> strip_06.in

# run cpptraj to strip water
cpptraj -i strip_06.in > strip_06.out

# remove solvated nc file
if [ -f "06_prod_dry.nc" ] ; then
    rm 06_prod.nc &&
    mv 06_prod_dry.nc 06_prod.nc
fi

