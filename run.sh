#!/bin/bash
#$ -l h_rt=0:20:00
#$ -l rt_AF=1
#$ -j y
#$ -N DDP_TEST
#$ -cwd
cat $SGE_JOB_HOSTLIST > ./hostfile
HOST=${HOSTNAME:0:5}
echo MASTER HOST $HOST
export NUM_GPUS_PER_NODE=8
NUM_NODES=${NHOSTS}
NUM_PROCS=$(expr ${NUM_NODES} \* ${NUM_GPUS_PER_NODE})


source /etc/profile.d/modules.sh
source modules.sh
export NCCL_DEBUG=WARN
# export NCCL_IB_DISABLE=0
# export NCCL_IB_CUDA_SUPPORT=0
# export NCCL_MAX_NCHANNELS=1
# export MLX5_SCATTER_TO_CQE=0
# export NCCL_IB_QPS_PER_CONNECTION=8
# export NCCL_NET_GDR_LEVEL=0
# MPIOPTS="-np ${NUM_PROCS} -map-by ppr:${NUM_GPUS_PER_NODE}:node -mca pml ob1 -mca btl self,tcp -mca btl_tcp_if_include bond0"

mpirun \
    --hostfile ./hostfile \
    -np $NHOSTS \
    --display-map \
    --map-by ppr:8:node \
    -x NCCL_DEBUG \
    python3 main.py

    # --hostfile ./hostfile \
    # -np $NHOSTS \
#echo
#echo ---------------------------dmesg---------------------
#echo

# dmesg
#    -x NCCL_MAX_NCHANNELS \
#    -x NCCL_IB_DISABLE \
