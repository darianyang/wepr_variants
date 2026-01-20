#!/bin/bash
# temp_sed.sh
# replace PDB_TEMP and VER in the std sim scripts dir with target PDB

# Parameters
# ----------
# arg 1 = pdb system prefix         :   e.g. 2kod_wt
# arg 2 = version of the replicate  :   e.g. v00

PDB=$1
VER=$2
PARTITION=$3
EMAIL=$4

# apply globally to all slurm files in current directory
sed -i "s/PDB_TEMP/${PDB}/g" *.slurm
sed -i "s/VER/${VER}/" *.slurm
sed -i "s/TEMP_PARTITION/${PARTITION}/" *.slurm 
sed -i "s/TEMP_EMAIL/${EMAIL}/" *.slurm
