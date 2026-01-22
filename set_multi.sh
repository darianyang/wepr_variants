#!/bin/bash

GPU_PARTITION="l40s"
EMAIL="shp176@pitt.edu"
SYSTEMS=(1lst_T121A 1lst_T121K)
#SYSTEMS=(1lst_Y14A 1lst_T121A-Y14A)

for SYSTEM in ${SYSTEMS[@]} ; do
cd $SYSTEM
echo "Prepping sim files for $SYSTEM"
for V in {01..05} ; do
    echo "Prepping $SYSTEM replica $V"
    # make dir if needed
    if [ ! -d "v$V" ]; then
        mkdir -v v$V
    fi
    
    # copy files over
    cp ../stdMD_template/* v$V
    cp -v ${SYSTEM}_solv.* v$V
    
    # go into new dir
    cd v$V

    # run temp sed
    bash temp_sed.sh $SYSTEM v$V $GPU_PARTITION $EMAIL

    # run prep
    #sbatch prep_mpi.slurm 
    #sbatch prep_gpu.slurm 

    cd ..
done
cd ..
echo "Done prepping $SYSTEM"
done
