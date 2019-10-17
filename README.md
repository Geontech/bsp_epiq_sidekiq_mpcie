# bsp_epiq_sidekiq_mpcie
OpenCPI Board Support Package (BSP) for the Epiq Solutions, Sidekiq(TM), Model:Mini PCIe

## Hardware Platform:
A Intel NUC (Model:D54250WYKH (w/ 16GB DDR3) was used for the development of the OpenCPI BSP.

## Below is a simple cheatsheet for cloning the required repos, building and execute a Control Plane only application. Refer to OpenCPI Installation guide for more details.

1. Clone OpenCPI framework, checkout proper branch and build framework for CentOS7
```
$ git clone https://github.com/Geontech/opencpi.git
$ git checkout release_1.5_epiq_sidekiq
$ ./scripts/install-opencpi.sh 
If a build error is observed for AD9361, it may be overcome by simply re-preforming the installation:
$ ./scripts/install-opencpi.sh 
Ensure that the driver is built successfully and loaded.
```

2. Clone BSP and checkout proper branch
```
$ git clone https://github.com/Geontech/bsp_epiq_sidekiq_mpcie.git
$ git checkout release_1.5
```

3. Setup terminal for OpenCPI environment
REQUIRED for each terminal where OpenCPI is to be used!
```
$ cd opencpi
$ . ./cdk/opencpi-setup.sh -r
$ export OCPI_XILINX_LICENSE_FILE=<yours>
```

4. Build the Core and Assets projects' HDL Primitive Libraries
Terminal A
```
$ make -C projects/core hdlprimitives HdlTargets=spartan6
$ make -C projects/assets hdlprimitives HdlTargets=spartan6
```

5. Build the Core and Assets projects' Workers
Terminal B
```
$ make -C projects/core -j 5 HdlTargets=spartan6
```
Terminal C
```
$ make -C projects/assets -j 5 HdlTargets=spartan6
```
Allow Step 5, in Terminal B and C to complete before proceeding to the next step:

6. Build Epiq Sidekiq MiniPCIe BSP, but not Assemblies 
In a terminal configured for OpenCPI:
```
$ cd bsp_epiq_sidekiq_mpcie
$ make Assemblies= HdlPlatform=mpcie
```

7. Build an assembly/container (bitstream) targeting the Epiq Sidekiq MiniPCIe BSP
In a terminal configured for OpenCPI:
```
$ cd bsp_epiq_sidekiq_mpcie
$ make Assemblies=tb_bias_v2 HdlPlatform=mpcie
```

8. Execute the Applications on the Epiq Sidekiq MiniPCIe BSP
In a terminal configured for OpenCPI:
```
$ cd bsp_epiq_sidekiq_mpcie/applications
$ ocpirun -v -d tb_bias_v2/tb_bias_v2.xml 
Warning: for property "", the "readable" attribute is deprecated: all properties are considered readable; workers can use the "readback" attribute in the OWD when required; see the CDG for details
Available containers are:  0: PCI:0000:03:00.0 [model: hdl os:  platform: mpcie], 1: rcc0 [model: rcc os: linux platform: centos7]
Actual deployment is:
  Instance  0 pattern_v2 (spec ocpi.assets.util_comps.pattern_v2) on hdl container 0: PCI:0000:03:00.0, using pattern_v2/a/pattern_v2 in ../artifacts/com.geontech.bsp.epiq_sidekiq_mpcie.tb_bias_v2_mpcie_base.hdl.0.mpcie.gz dated Fri Oct 11 13:59:34 2019
  Instance  1 bias (spec ocpi.core.bias) on hdl container 0: PCI:0000:03:00.0, using bias/a/bias in ../artifacts/com.geontech.bsp.epiq_sidekiq_mpcie.tb_bias_v2_mpcie_base.hdl.0.mpcie.gz dated Fri Oct 11 13:59:34 2019
  Instance  2 capture_v2 (spec ocpi.assets.util_comps.capture_v2) on hdl container 0: PCI:0000:03:00.0, using capture_v2/a/capture_v2 in ../artifacts/com.geontech.bsp.epiq_sidekiq_mpcie.tb_bias_v2_mpcie_base.hdl.0.mpcie.gz dated Fri Oct 11 13:59:34 2019
Application XML parsed and deployments (containers and artifacts) chosen
Checking existing loaded bitstream on OpenCPI HDL device "PCI:0000:03:00.0"...
[sudo] password for user: 
OpenCPI FPGA at PCI 0000:03:00.0: bitstream date Tue Oct  8 14:46:55 2019, platform "mpcie", part "xc6slx45t", UUID 001fd0de-e9fc-11e9-9417-bf92b9eb4f73
Existing loaded bitstream looks ok, proceeding to snapshot the PCI configuration (into /tmp/ocpibitstream12144.1).
The bitstream file "../artifacts/com.geontech.bsp.epiq_sidekiq_mpcie.tb_bias_v2_mpcie_base.hdl.0.mpcie.gz" is compressed. Expanding to temp file "/tmp/ocpibitstream12144.mpcie".
Loading bitstream
SKIQ[12214]: <INFO> libsidekiq v4.4.0 (gdadc7321)
store_user_fpga[12214]: <INFO> Sidekiq card 0 is serial number=30146, hardware MPCIE C (rev 2), product SKIQ-MPCIE-001 (mPCIe) (part ES004202-C0-00)
store_user_fpga[12214]: <INFO> Sidekiq card 0 firmware v2.7
store_user_fpga[12214]: <INFO> Sidekiq card 0 FPGA v0.0, (date 0, FIFO size unknown)
store_user_fpga[12214]: <INFO> Sidekiq card 0 is configured for an external 40000000 Hz reference clock
store_user_fpga[12214]: <DEBUG> erase flash sector 0x200000
store_user_fpga[12214]: <DEBUG> erase flash sector 0x210000
store_user_fpga[12214]: <DEBUG> erase flash sector 0x220000
store_user_fpga[12214]: <DEBUG> erase flash sector 0x230000
store_user_fpga[12214]: <DEBUG> erase flash sector 0x240000
store_user_fpga[12214]: <DEBUG> erase flash sector 0x250000
store_user_fpga[12214]: <DEBUG> erase flash sector 0x260000
store_user_fpga[12214]: <DEBUG> erase flash sector 0x270000
store_user_fpga[12214]: <DEBUG> erase flash sector 0x280000
store_user_fpga[12214]: <DEBUG> erase flash sector 0x290000
store_user_fpga[12214]: <DEBUG> erase flash sector 0x2a0000
store_user_fpga[12214]: <DEBUG> erase flash sector 0x2b0000
store_user_fpga[12214]: <DEBUG> erase flash sector 0x2c0000
store_user_fpga[12214]: <DEBUG> erase flash sector 0x2d0000
store_user_fpga[12214]: <DEBUG> erase flash sector 0x2e0000
store_user_fpga[12214]: <DEBUG> erase flash sector 0x2f0000
store_user_fpga[12214]: <DEBUG> erase flash sector 0x300000
store_user_fpga[12214]: <DEBUG> erase flash sector 0x310000
store_user_fpga[12214]: <DEBUG> erase flash sector 0x320000
store_user_fpga[12214]: <DEBUG> erase flash sector 0x330000
store_user_fpga[12214]: <DEBUG> erase flash sector 0x340000
store_user_fpga[12214]: <DEBUG> erase flash sector 0x350000
store_user_fpga[12214]: <DEBUG> erase flash sector 0x360000
store_user_fpga[12214]: <DEBUG> write flash sector 0x200000
store_user_fpga[12214]: <DEBUG> write flash sector 0x210000
store_user_fpga[12214]: <DEBUG> write flash sector 0x220000
store_user_fpga[12214]: <DEBUG> write flash sector 0x230000
store_user_fpga[12214]: <DEBUG> write flash sector 0x240000
store_user_fpga[12214]: <DEBUG> write flash sector 0x250000
store_user_fpga[12214]: <DEBUG> write flash sector 0x260000
store_user_fpga[12214]: <DEBUG> write flash sector 0x270000
store_user_fpga[12214]: <DEBUG> write flash sector 0x280000
store_user_fpga[12214]: <DEBUG> write flash sector 0x290000
store_user_fpga[12214]: <DEBUG> write flash sector 0x2a0000
store_user_fpga[12214]: <DEBUG> write flash sector 0x2b0000
store_user_fpga[12214]: <DEBUG> write flash sector 0x2c0000
store_user_fpga[12214]: <DEBUG> write flash sector 0x2d0000
store_user_fpga[12214]: <DEBUG> write flash sector 0x2e0000
store_user_fpga[12214]: <DEBUG> write flash sector 0x2f0000
store_user_fpga[12214]: <DEBUG> write flash sector 0x300000
store_user_fpga[12214]: <DEBUG> write flash sector 0x310000
store_user_fpga[12214]: <DEBUG> write flash sector 0x320000
store_user_fpga[12214]: <DEBUG> write flash sector 0x330000
store_user_fpga[12214]: <DEBUG> write flash sector 0x340000
store_user_fpga[12214]: <DEBUG> write flash sector 0x350000
store_user_fpga[12214]: <DEBUG> write flash sector 0x360000
Info: skiq_save_fpga_config_to_flash returned 0
Info: reloading FPGA from flash
store_user_fpga[12214]: <INFO> Sidekiq card 0 FPGA v0.0, (date 0, FIFO size unknown)
store_user_fpga[12214]: <INFO> unlocking card 0
Bitstream loaded successfully, proceeding to restore PCI config (from /tmp/ocpibitstream12144.1).
OpenCPI FPGA at PCI 0000:03:00.0: bitstream date Fri Oct 11 13:44:30 2019, platform "mpcie", part "xc6slx45t", UUID c726f0c8-ec4e-11e9-8142-9b71a26cb5ec
New bitstream is responding. The loading process was successful.
Application established: containers, workers, connections all created
Communication with the application established
Dump of all initial property values:
Property  0: pattern_v2.dataRepeat = "true" (cached)
Property  1: pattern_v2.numMessagesMax = "5" (parameter)
Property  2: pattern_v2.messagesToSend = "5"
Property  3: pattern_v2.messagesSent = "0"
Property  4: pattern_v2.dataSent = "0"
Property  5: pattern_v2.numDataWords = "15" (parameter)
Property  6: pattern_v2.numMessageFields = "2" (parameter)
Property  7: pattern_v2.messages = "{4,251},{8,252},{12,253},{16,254},{20,255}" (cached)
Property  8: pattern_v2.data = "0,1,2,3,4,5,6,7,8,9,10,11,12,13,14" (cached)
Property  9: pattern_v2.ocpi_debug = "false" (parameter)
Property 10: pattern_v2.ocpi_endian = "little" (parameter)
Property 18: bias.biasValue = "16909060" (cached)
Property 19: bias.ocpi_debug = "false" (parameter)
Property 20: bias.ocpi_endian = "little" (parameter)
Property 30: capture_v2.stopOnFull = "true" (cached)
Property 31: capture_v2.metadataCount = "0"
Property 32: capture_v2.dataCount = "0"
Property 33: capture_v2.numRecords = "256" (parameter)
Property 34: capture_v2.numDataWords = "1024" (parameter)
Property 35: capture_v2.numMetadataWords = "4" (parameter)
Property 36: capture_v2.metaFull = "false"
Property 37: capture_v2.dataFull = "false"
Property 38: capture_v2.stopZLMOpcode = "0" (cached)
Property 39: capture_v2.stopOnZLM = "false" (cached)
Property 40: capture_v2.stopOnEOF = "true" (cached)
Property 41: capture_v2.metadata = "{0}"
Property 42: capture_v2.data = "0"
Property 43: capture_v2.ocpi_debug = "false" (parameter)
Property 44: capture_v2.ocpi_endian = "little" (parameter)
Application started/running
Waiting for application to finish (no time limit)
Application finished
Dump of all final property values:
Property  2: pattern_v2.messagesToSend = "0"
Property  3: pattern_v2.messagesSent = "6"
Property  4: pattern_v2.dataSent = "15"
Property 31: capture_v2.metadataCount = "6"
Property 32: capture_v2.dataCount = "15"
Property 36: capture_v2.metaFull = "false"
Property 37: capture_v2.dataFull = "false"
Property 41: capture_v2.metadata = "{4211081220,1655369483,1655369483,1},{4227858440,1655369655,1655369612,1},{4244635660,1655369827,1655369741,1},{4261412880,1655370042,1655369913,1},{4278190100,1655370299,1655370128,1},{0,1655370342,1655370342,1},{0}"
Property 42: capture_v2.data = "16909060,16909060,16909061,16909060,16909061,16909062,16909060,16909061,16909062,16909063,16909060,16909061,16909062,16909063,16909064,0"
```