#!/bin/bash

#SYSTEMS=(1lst_T121A 1lst_T121K)
SYSTEMS=(1lst_WT 1lst_Y14A 1lst_T121A-Y14A)

for SYSTEM in ${SYSTEMS[@]} ; do
cd $SYSTEM
echo "Analyzing sim files for $SYSTEM"
for V in {01..05} ; do
    echo "Analyzing $SYSTEM replica $V"
    # go into new dir
    cd v$V

    # run: traj_in top_in data_out
    python ../../analyze.py 06_prod.nc ${SYSTEM}_dry.prmtop 06_pcoord.dat

    cd ..
done
cd ..
echo "Done submitting $SYSTEM"
done
