Libraries=axi sdp proc_sys_reset_v3_00_a proc_common_v3_00_a axi_pcie_v1_09_a axi_pcie_wrapper

SourceFiles=mpcie.vhd

Configurations=\
	base \

FFF=blk_mem_gen_v7_3_1 blk_mem_gen_v7_3_2 blk_mem_gen_v7_3_3 \
	fifo_generator_v9_3_1 fifo_generator_v9_3_2 fifo_generator_v9_3_3
MPLINKS=$(foreach i,$(FFF),$(info II:$i)lib/hdl/spartan6/mpcie_rv_$i.ngc)
$(info MM:$(MPLINKS))
all:
$(MPLINKS):
	$(AT)ln -s ../../../target-spartan6/$(@F) $@
ExportFiles=mpcie.ucf mpcie.mk mpcie.ut

#	./target-spartan6/mpcie_rv_blk_mem_gen_v7_3_1.ngc \
	./target-spartan6/mpcie_rv_blk_mem_gen_v7_3_2.ngc \
	./target-spartan6/mpcie_rv_blk_mem_gen_v7_3_3.ngc \
	./target-spartan6/mpcie_rv_fifo_generator_v9_3_1.ngc \
	./target-spartan6/mpcie_rv_fifo_generator_v9_3_2.ngc \
	./target-spartan6/mpcie_rv_fifo_generator_v9_3_3.ngc

include $(OCPI_CDK_DIR)/include/hdl/hdl-platform.mk
all: $(MPLINKS)
