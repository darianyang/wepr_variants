#!/bin/bash

SYSTEMS=(noliz)

for SYSTEM in ${SYSTEMS[@]} ; do
cd /ihome/lchong/dty7/ssaxena_shared/1lst_cu_56_144/$SYSTEM
echo "Analyzing sim files for $SYSTEM"
for V in {1..5} ; do
    echo "Analyzing $SYSTEM replica $V"
    # go into dir
    cd rep$V

    # run: traj_in top_in data_out
    python /ihome/lchong/dty7/ssaxena_shared/wepr_variants/analyze.py all_nowat.nc 1lst_nowat.prmtop /ihome/lchong/dty7/ssaxena_shared/wepr_variants/$SYSTEM/all_pcoord_${V}.dat

    cd ..
done
cd ..
echo "Done submitting $SYSTEM"
done
