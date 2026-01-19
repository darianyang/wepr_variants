#!/bin/bash

SYSTEMS=(1lst_T121A 1lst_T121K)

for SYSTEM in ${SYSTEMS[@]} ; do
cd $SYSTEM
for V in {01..05} ; do
    # make dir
    mkdir v$V
    
    # copy files over
    cp ../stdMD_template/* v$V
    cp ../${SYSTEM}_solv.* v$V
    
    # go into new dir
    cd v$V

    # run temp sed
    bash temp_sed.sh $SYSTEM v$V

    # run prep
    sbatch prep_mpi.slurm 

    cd ..
done
cd ..
done
