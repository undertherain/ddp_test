# ddp_test
debugging torch DDP on ABCI

the code works on V partition on multiple nodes

but failes on A partition when using more then one node with `Call to ibv_create_cq failed`
