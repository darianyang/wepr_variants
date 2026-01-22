#!/bin/bash

#SYSTEMS=(1lst_T121A 1lst_T121K)
SYSTEMS=(1lst_Y14A 1lst_T121A-Y14A)

for SYSTEM in ${SYSTEMS[@]} ; do
cd $SYSTEM
echo "Running sim files for $SYSTEM"
for V in {01..05} ; do
    echo "Submitting $SYSTEM replica $V"
    # go into new dir
    cd v$V

    # run prep and initial 200ns prod
    sbatch prep_gpu.slurm 

    # run prod 0.2-1us
    #sbatch h2p_1gpu_prod_07.slurm

    cd ..
done
cd ..
echo "Done submitting $SYSTEM"
done
