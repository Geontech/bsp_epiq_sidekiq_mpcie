[user@dewey-nuc applications]$ gdb ocpirun
GNU gdb (GDB) Red Hat Enterprise Linux 7.6.1-115.el7
Copyright (C) 2013 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "x86_64-redhat-linux-gnu".
For bug reporting instructions, please see:
<http://www.gnu.org/software/gdb/bugs/>...
Reading symbols from /home/user/ocpi/opencpi_v1.5.0_release/build/autotools/target-centos7/staging/bin/ocpirun...done.
(gdb) run  -v -d testbias.xml 
Starting program: /home/user/ocpi/opencpi_v1.5.0_release/cdk/centos7/bin/ocpirun -v -d testbias.xml
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib64/libthread_db.so.1".
Warning: for property "", the "readable" attribute is deprecated: all properties are considered readable; workers can use the "readback" attribute in the OWD when required; see the CDG for details
[New Thread 0x7ffff1db7700 (LWP 2079)]
Available containers are:  0: PCI:0000:03:00.0 [model: hdl os:  platform: mpcie], 1: rcc0 [model: rcc os: linux platform: centos7]
[New Thread 0x7ffff1565700 (LWP 2080)]
Actual deployment is:
  Instance  0 file_read (spec ocpi.core.file_read) on rcc container 1: rcc0, using file_read in ../imports/ocpi.core/components/file_read.rcc/target-centos7/file_read.so dated Tue Oct  8 12:15:23 2019
  Instance  1 bias (spec ocpi.core.bias) on hdl container 0: PCI:0000:03:00.0, using bias_vhdl/a/bias_vhdl in ../artifacts/com.geontech.bsp.epiq_sidekiq_mpcie.testbias_mpcie_base.hdl.0.mpcie.gz dated Tue Oct  8 14:57:31 2019
  Instance  2 file_write (spec ocpi.core.file_write) on rcc container 1: rcc0, using file_write in ../imports/ocpi.core/components/file_write.rcc/target-centos7/file_write.so dated Tue Oct  8 12:15:29 2019
Application XML parsed and deployments (containers and artifacts) chosen
[New Thread 0x7ffff0d13700 (LWP 2081)]
Application established: containers, workers, connections all created
Communication with the application established
Dump of all initial property values:
Property  0: file_read.fileName = "test.input" (cached)
Property  1: file_read.messagesInFile = "false" (cached)
Property  2: file_read.opcode = "0" (cached)
Property  3: file_read.messageSize = "16"
Property  4: file_read.granularity = "4" (cached)
Property  5: file_read.repeat = "false"
Property  6: file_read.bytesRead = "0"
Property  7: file_read.messagesWritten = "0"
Property  8: file_read.suppressEOF = "false"
Property  9: file_read.badMessage = "false"
Property 10: file_read.ocpi_debug = "false" (parameter)
Property 11: file_read.ocpi_endian = "little" (parameter)
Property 16: bias.biasValue = "16909060" (cached)
Property 17: bias.ocpi_debug = "false" (parameter)
Property 18: bias.ocpi_endian = "little" (parameter)
Property 20: bias.test64 = "0"
Property 29: file_write.fileName = "test.output" (cached)
Property 30: file_write.messagesInFile = "false" (cached)
Property 31: file_write.bytesWritten = "0"
Property 32: file_write.messagesWritten = "0"
Property 33: file_write.stopOnEOF = "true" (cached)
Property 34: file_write.ocpi_debug = "false" (parameter)
Property 35: file_write.ocpi_endian = "little" (parameter)
[New Thread 0x7fffe1580700 (LWP 2082)]
Application started/running
Waiting for application to finish (no time limit)
  C-c C-c
Program received signal SIGINT, Interrupt.
0x00007ffff6cbb953 in select () from /lib64/libc.so.6
Missing separate debuginfos, use: debuginfo-install glibc-2.17-292.el7.x86_64 libgcc-4.8.5-39.el7.x86_64 libstdc++-4.8.5-39.el7.x86_64
(gdb) bt
#0  0x00007ffff6cbb953 in select () from /lib64/libc.so.6
#1  0x00000000005d2d21 in OCPI::OS::sleep (msecs=10) at ../gen/os/liqnux/src/OcpiOsMisc.cxx:61
#2  0x0000000000539e10 in OCPI::Container::Worker::wait (this=0xce9af0, timer=0x0)
    at ../gen/runtime/container/src/ContainerWorker.cxx:788
#3  0x0000000000503aa7 in OCPI::API::ApplicationI::wait (this=0x8dd160, timer=0x0)
    at ../gen/runtime/application/src/OcpiApplication.cxx:1603
#4  0x00000000005059cf in OCPI::API::Application::wait (this=0x7fffffffe500, timeout_us=0, 
    timeOutIsError=false) at ../gen/runtime/application/src/OcpiApplication.cxx:1947
#5  0x00000000004f84c7 in mymain (ap=0x7fffffffe6a0)
    at ../gen/runtime/application/src/ocpirun_main.cxx:362
#6  0x0000000000592801 in OCPI::Util::BaseCommandOptions::main (
    this=0x8d57e0 <(anonymous namespace)::options>, initargv=0x7fffffffe688, 
    themain=0x4f7d3a <mymain(char const**)>) at ../gen/runtime/util/misc/src/CmdOption.cxx:205
#7  0x00000000004f7034 in main (argv=0x7fffffffe688)
    at ../gen/runtime/util/misc/include/CmdOption.h:130
(gdb) q