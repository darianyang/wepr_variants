#!/bin/bash

SYSTEMS=(1lst_T121A 1lst_T121K)

for SYSTEM in ${SYSTEMS[@]} ; do
cd $SYSTEM
echo "Running sim files for $SYSTEM"
for V in {01..05} ; do
    echo "Submitting $SYSTEM replica $V"
    # go into new dir
    cd v$V

    # run
    #sbatch prep_mpi.slurm 
    sbatch prep_gpu.slurm 
    #sbatch h2p_1gpu_prod_06.slurm

    cd ..
done
cd ..
echo "Done submitting $SYSTEM"
done
