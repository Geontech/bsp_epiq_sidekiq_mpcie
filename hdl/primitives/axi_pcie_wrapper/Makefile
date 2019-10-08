#
# This OCPI HDL primitive library was created from the pcore located at
# Xilinx/14.7/ISE_DS/EDK/hw/XilinxProcessorIPLib/pcores/axi_pcie_v1_09_a/vhdl/axi_pcie.vhd
#
# The HDL Primitive Library was created to serve at the wrapper for the axi_pcie.vhd.
#
# Used OCPI's simple rules for creating this library:
# 1) Created the package file axi_pcie_wrapper_pkg.vhd and declared the 
# components used in the library: axi_pcie_wrapper and axi_pcie.
# 2) Per the framework, the lone package will be built first and then 
# the other source modules. I.e, there's no need to explicitly assign SourceFiles.

Libraries=fixed_float ocpi platform axi proc_common_v3_00_a axi_pcie_v1_09_a
OnlyTargets=spartan6 xsim isim
#SourceFiles=axi_pcie_wrapper_pkg.vhd axi_pcie_wrapper.vhd axi_pcie.vhd

include $(OCPI_CDK_DIR)/include/hdl/hdl-lib.mk

