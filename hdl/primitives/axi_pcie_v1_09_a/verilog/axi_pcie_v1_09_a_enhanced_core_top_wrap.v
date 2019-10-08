//-----------------------------------------------------------------------------
//
// (c) Copyright 2009-2010 Xilinx, Inc. All rights reserved.
//
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
//
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
//
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
//
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
//
//-----------------------------------------------------------------------------
// Project    : Virtex-6 Integrated Block for PCI Express
// File       : axi_pcie_v1_09_a_enhanced_core_top_wrap.v
// Version    : 2.1
//----------------------------------------------------------------------------//
//  File: axi_pcie_v1_09_a_enhanced_core_top_wrap.v                  //
//                                                                            //
//  Description:                                                              //
//  Verilog wrapper for axi_pcie_enhanced_core_top.v used to fix parameter    //
//  passing                                                                   //
//                                                                            //
//  Notes:                                                                    //
//  Optional notes section.                                                   //
//                                                                            //
//  Hierarchical:                                                             //
//    enhanced_core_top_wrap                                                  //
//      axi_pcie_enhanced_core_top                                            //
//                                                                            //
//----------------------------------------------------------------------------//

`timescale 1ps/1ps

module axi_pcie_v1_09_a_enhanced_core_top_wrap #(

  parameter        C_DATA_WIDTH = 64,
  parameter        STRB_WIDTH = 8,//C_DATA_WIDTH / 8,

  parameter [15:0]  BAR0_U = 16'hffff,
  parameter [15:0]  BAR0_L = 16'hffff,
  parameter [15:0]  BAR1_U = 16'hffff,
  parameter [15:0]  BAR1_L = 16'hffff,
  parameter [15:0]  BAR2_U = 16'hffff,
  parameter [15:0]  BAR2_L = 16'hffff,
  parameter [15:0]  BAR3_U = 16'hffff,
  parameter [15:0]  BAR3_L = 16'hffff,
  parameter [15:0]  BAR4_U = 16'hffff,
  parameter [15:0]  BAR4_L = 16'hffff,
  parameter [15:0]  BAR5_U = 16'hffff,
  parameter [15:0]  BAR5_L = 16'hffff,

  parameter        CARDBUS_CIS_POINTER = 32'h00000000,
  parameter        CLASS_CODE = 24'h060000,
  parameter        CMD_INTX_IMPLEMENTED = "TRUE",
  parameter        CPL_TIMEOUT_DISABLE_SUPPORTED = "FALSE",
  parameter        CPL_TIMEOUT_RANGES_SUPPORTED = 4'h2,

  parameter        DEV_CAP_EXT_TAG_SUPPORTED = "FALSE",
  parameter        DEV_CAP_MAX_PAYLOAD_SUPPORTED = 2,
  parameter        DEV_CAP_PHANTOM_FUNCTIONS_SUPPORT = 0,
  parameter        DEVICE_ID = 16'h6111,

  parameter        DISABLE_LANE_REVERSAL = "TRUE",
  parameter        DISABLE_SCRAMBLING = "FALSE",
  parameter        DSN_BASE_PTR = 12'h100,
  parameter        DSN_CAP_NEXTPTR = 12'h000,
  parameter        DSN_CAP_ON = "TRUE",

  parameter        ENABLE_MSG_ROUTE = 11'b00000000000,
  parameter        ENABLE_RX_TD_ECRC_TRIM = "FALSE",
  parameter        EXPANSION_ROM_U = 16'hffff,
  parameter        EXPANSION_ROM_L = 16'hf001,
  parameter        EXT_CFG_CAP_PTR = 6'h3F,
  parameter        EXT_CFG_XP_CAP_PTR = 10'h3FF,
  parameter        HEADER_TYPE = 8'h01,
  parameter        INTERRUPT_PIN = 8'h1,

  parameter        LINK_CAP_DLL_LINK_ACTIVE_REPORTING_CAP = "FALSE",
  parameter        LINK_CAP_LINK_BANDWIDTH_NOTIFICATION_CAP = "FALSE",
  parameter        LINK_CAP_MAX_LINK_SPEED = 4'h1,
  parameter        LINK_CAP_MAX_LINK_WIDTH = 6'h01,
  parameter        LINK_CAP_SURPRISE_DOWN_ERROR_CAPABLE = "FALSE",

  parameter        LINK_CONTROL_RCB = 0,
  parameter        LINK_CTRL2_DEEMPHASIS = "FALSE",
  parameter        LINK_CTRL2_HW_AUTONOMOUS_SPEED_DISABLE = "FALSE",
  parameter        LINK_CTRL2_TARGET_LINK_SPEED = 4'h0,
  parameter        LINK_STATUS_SLOT_CLOCK_CONFIG = "FALSE",

  parameter        LL_ACK_TIMEOUT = 15'h0000,
  parameter        LL_ACK_TIMEOUT_EN = "FALSE",
  parameter        LL_ACK_TIMEOUT_FUNC = 0,
  parameter        LL_REPLAY_TIMEOUT = 15'h0026,
  parameter        LL_REPLAY_TIMEOUT_EN = "TRUE",
  parameter        LL_REPLAY_TIMEOUT_FUNC = 1,

  parameter        LTSSM_MAX_LINK_WIDTH = 6'h01,
  parameter        MSI_CAP_MULTIMSGCAP = 0,
  parameter        MSI_CAP_MULTIMSG_EXTENSION = 0,
  parameter        MSI_CAP_ON = "TRUE",
  parameter        MSI_CAP_PER_VECTOR_MASKING_CAPABLE = "FALSE",
  parameter        MSI_CAP_64_BIT_ADDR_CAPABLE = "TRUE",

  parameter        MSIX_CAP_ON = "FALSE",
  parameter        MSIX_CAP_PBA_BIR = 0,
  parameter        MSIX_CAP_PBA_OFFSET = 29'h0,
  parameter        MSIX_CAP_TABLE_BIR = 0,
  parameter        MSIX_CAP_TABLE_OFFSET = 29'h0,
  parameter        MSIX_CAP_TABLE_SIZE = 11'h000,

  parameter        PCIE_CAP_DEVICE_PORT_TYPE = 4'b0100,
  parameter        PCIE_CAP_INT_MSG_NUM = 5'h1,
  parameter        PCIE_CAP_NEXTPTR = 8'h00,
  parameter        PCIE_DRP_ENABLE = "FALSE",
  parameter        PIPE_PIPELINE_STAGES = 0,                // 0 - 0 stages, 1 - 1 stage, 2 - 2 stages

  parameter        PM_CAP_DSI = "FALSE",
  parameter        PM_CAP_D1SUPPORT = "FALSE",
  parameter        PM_CAP_D2SUPPORT = "FALSE",
  parameter        PM_CAP_NEXTPTR = 8'h48,
  parameter        PM_CAP_PMESUPPORT = 5'h0F,
  parameter        PM_CSR_NOSOFTRST = "TRUE",

  parameter        PM_DATA_SCALE0 = 2'h0,
  parameter        PM_DATA_SCALE1 = 2'h0,
  parameter        PM_DATA_SCALE2 = 2'h0,
  parameter        PM_DATA_SCALE3 = 2'h0,
  parameter        PM_DATA_SCALE4 = 2'h0,
  parameter        PM_DATA_SCALE5 = 2'h0,
  parameter        PM_DATA_SCALE6 = 2'h0,
  parameter        PM_DATA_SCALE7 = 2'h0,

  parameter        PM_DATA0 = 8'h00,
  parameter        PM_DATA1 = 8'h00,
  parameter        PM_DATA2 = 8'h00,
  parameter        PM_DATA3 = 8'h00,
  parameter        PM_DATA4 = 8'h00,
  parameter        PM_DATA5 = 8'h00,
  parameter        PM_DATA6 = 8'h00,
  parameter        PM_DATA7 = 8'h00,

  parameter        REF_CLK_FREQ = 0,                        // 0 - 100 MHz, 1 - 125 MHz, 2 - 250 MHz
  parameter        REVISION_ID = 8'h00,
  parameter        ROOT_CAP_CRS_SW_VISIBILITY = "FALSE",
  parameter        SPARE_BIT0 = 0,
  parameter        SUBSYSTEM_ID = 16'h0007,
  parameter        SUBSYSTEM_VENDOR_ID = 16'h10EE,

  parameter        SLOT_CAP_ATT_BUTTON_PRESENT = "FALSE",
  parameter        SLOT_CAP_ATT_INDICATOR_PRESENT = "FALSE",
  parameter        SLOT_CAP_ELEC_INTERLOCK_PRESENT = "FALSE",
  parameter        SLOT_CAP_HOTPLUG_CAPABLE = "FALSE",
  parameter        SLOT_CAP_HOTPLUG_SURPRISE = "FALSE",
  parameter        SLOT_CAP_MRL_SENSOR_PRESENT = "FALSE",
  parameter        SLOT_CAP_NO_CMD_COMPLETED_SUPPORT = "FALSE",
  parameter        SLOT_CAP_PHYSICAL_SLOT_NUM = 13'h0,
  parameter        SLOT_CAP_POWER_CONTROLLER_PRESENT = "FALSE",
  parameter        SLOT_CAP_POWER_INDICATOR_PRESENT = "FALSE",
  parameter        SLOT_CAP_SLOT_POWER_LIMIT_SCALE = 0,
  parameter        SLOT_CAP_SLOT_POWER_LIMIT_VALUE = 8'h0,

  parameter        TL_RX_RAM_RADDR_LATENCY = 0,
  parameter        TL_RX_RAM_RDATA_LATENCY = 2,
  parameter        TL_RX_RAM_WRITE_LATENCY = 0,
  parameter        TL_TX_RAM_RADDR_LATENCY = 0,
  parameter        TL_TX_RAM_RDATA_LATENCY = 2,
  parameter        TL_TX_RAM_WRITE_LATENCY = 0,

  parameter        UPCONFIG_CAPABLE = "TRUE",
  parameter        UPSTREAM_FACING = "FALSE",
  parameter        USER_CLK_FREQ = 1,
  parameter        VC_BASE_PTR = 12'h0,
  parameter        VC_CAP_NEXTPTR = 12'h000,
  parameter        VC_CAP_ON = "FALSE",
  parameter        VC_CAP_REJECT_SNOOP_TRANSACTIONS = "FALSE",

  parameter        VC0_CPL_INFINITE = "TRUE",
  parameter        VC0_RX_RAM_LIMIT = 13'h7FF,
  parameter        VC0_TOTAL_CREDITS_CD = 308,
  parameter        VC0_TOTAL_CREDITS_CH = 36,
  parameter        VC0_TOTAL_CREDITS_NPH = 12,
  parameter        VC0_TOTAL_CREDITS_PD = 308,
  parameter        VC0_TOTAL_CREDITS_PH = 32,
  parameter        VC0_TX_LASTPACKET = 29,

  parameter        VENDOR_ID = 16'h10EE,
  parameter        VSEC_BASE_PTR = 12'h0,
  parameter        VSEC_CAP_NEXTPTR = 12'h000,
  parameter        VSEC_CAP_ON = "FALSE",

  parameter        ALLOW_X8_GEN2 = "FALSE",
  parameter        AER_BASE_PTR = 12'h128,
  parameter        AER_CAP_ECRC_CHECK_CAPABLE = "FALSE",
  parameter        AER_CAP_ECRC_GEN_CAPABLE = "FALSE",
  parameter        AER_CAP_ID = 16'h0001,
  parameter        AER_CAP_INT_MSG_NUM_MSI = 5'h0a,
  parameter        AER_CAP_INT_MSG_NUM_MSIX = 5'h15,
  parameter        AER_CAP_NEXTPTR = 12'h160,
  parameter        AER_CAP_ON = "FALSE",
  parameter        AER_CAP_PERMIT_ROOTERR_UPDATE = "TRUE",
  parameter        AER_CAP_VERSION = 4'h1,

  parameter        CAPABILITIES_PTR = 8'h40,
  parameter        CRM_MODULE_RSTS = 7'h00,
  parameter        DEV_CAP_ENDPOINT_L0S_LATENCY = 0,
  parameter        DEV_CAP_ENDPOINT_L1_LATENCY = 0,
  parameter        DEV_CAP_FUNCTION_LEVEL_RESET_CAPABLE = "FALSE",
  parameter        DEV_CAP_ROLE_BASED_ERROR = "TRUE",
  parameter        DEV_CAP_RSVD_14_12 = 0,
  parameter        DEV_CAP_RSVD_17_16 = 0,
  parameter        DEV_CAP_RSVD_31_29 = 0,
  parameter        DEV_CAP_ENABLE_SLOT_PWR_LIMIT_SCALE = "FALSE",
  parameter        DEV_CAP_ENABLE_SLOT_PWR_LIMIT_VALUE = "FALSE",
  parameter        DEV_CONTROL_AUX_POWER_SUPPORTED = "FALSE",

  parameter        DISABLE_ASPM_L1_TIMER = "FALSE",
  parameter        DISABLE_BAR_FILTERING = "FALSE",
  parameter        DISABLE_ID_CHECK = "FALSE",
  parameter        DISABLE_RX_TC_FILTER = "FALSE",
  parameter        DNSTREAM_LINK_NUM = 8'h00,

  parameter        DS_PORT_HOT_RST = "FALSE",               // FALSE - for ROOT PORT(default), TRUE - for DOWNSTREAM PORT 
  parameter        DSN_CAP_ID = 16'h0003,
  parameter        DSN_CAP_VERSION = 4'h1,
  parameter        ENTER_RVRY_EI_L0 = "TRUE",
  parameter        INFER_EI = 5'h0c,
  parameter        IS_SWITCH = "FALSE",

  parameter        LAST_CONFIG_DWORD = 10'h3FF,
  parameter        LINK_CAP_ASPM_SUPPORT = 1,
  parameter        LINK_CAP_CLOCK_POWER_MANAGEMENT = "FALSE",
  parameter        LINK_CAP_L0S_EXIT_LATENCY_COMCLK_GEN1 = 7,
  parameter        LINK_CAP_L0S_EXIT_LATENCY_COMCLK_GEN2 = 7,
  parameter        LINK_CAP_L0S_EXIT_LATENCY_GEN1 = 7,
  parameter        LINK_CAP_L0S_EXIT_LATENCY_GEN2 = 7,
  parameter        LINK_CAP_L1_EXIT_LATENCY_COMCLK_GEN1 = 7,
  parameter        LINK_CAP_L1_EXIT_LATENCY_COMCLK_GEN2 = 7,
  parameter        LINK_CAP_L1_EXIT_LATENCY_GEN1 = 7,
  parameter        LINK_CAP_L1_EXIT_LATENCY_GEN2 = 7,
  parameter        LINK_CAP_RSVD_23_22 = 0,

  parameter        MSI_BASE_PTR = 8'h48,
  parameter        MSI_CAP_ID = 8'h05,
  parameter        MSI_CAP_NEXTPTR = 8'h60,
  parameter        MSIX_BASE_PTR = 8'h9c,
  parameter        MSIX_CAP_ID = 8'h11,
  parameter        MSIX_CAP_NEXTPTR = 8'h00,
  parameter        N_FTS_COMCLK_GEN1 = 255,
  parameter        N_FTS_COMCLK_GEN2 = 254,
  parameter        N_FTS_GEN1 = 255,
  parameter        N_FTS_GEN2 = 255,

  parameter        PCIE_BASE_PTR = 8'h60,
  parameter        PCIE_CAP_CAPABILITY_ID = 8'h10,
  parameter        PCIE_CAP_CAPABILITY_VERSION = 4'h2,
  parameter        PCIE_CAP_ON = "TRUE",
  parameter        PCIE_CAP_RSVD_15_14 = 0,
  parameter        PCIE_CAP_SLOT_IMPLEMENTED = "FALSE",
  parameter        PCIE_REVISION = 2,
  parameter        PGL0_LANE = 0,
  parameter        PGL1_LANE = 1,
  parameter        PGL2_LANE = 2,
  parameter        PGL3_LANE = 3,
  parameter        PGL4_LANE = 4,
  parameter        PGL5_LANE = 5,
  parameter        PGL6_LANE = 6,
  parameter        PGL7_LANE = 7,
  parameter        PL_AUTO_CONFIG = 0,
  parameter        PL_FAST_TRAIN = "FALSE",
  parameter        PCIE_EXT_CLK = "FALSE",

  parameter        PM_BASE_PTR = 8'h40,
  parameter        PM_CAP_AUXCURRENT = 0,
  parameter        PM_CAP_ID = 8'h01,
  parameter        PM_CAP_ON = "TRUE",
  parameter        PM_CAP_PME_CLOCK = "FALSE",
  parameter        PM_CAP_RSVD_04 = 0,
  parameter        PM_CAP_VERSION = 3,
  parameter        PM_CSR_BPCCEN = "FALSE",
  parameter        PM_CSR_B2B3 = "FALSE",

  parameter        RECRC_CHK = 0,
  parameter        RECRC_CHK_TRIM = "FALSE",
  parameter        SELECT_DLL_IF = "FALSE",
  parameter        SPARE_BIT1 = 0,
  parameter        SPARE_BIT2 = 0,
  parameter        SPARE_BIT3 = 0,
  parameter        SPARE_BIT4 = 0,
  parameter        SPARE_BIT5 = 0,
  parameter        SPARE_BIT6 = 0,
  parameter        SPARE_BIT7 = 0,
  parameter        SPARE_BIT8 = 0,
  parameter        SPARE_BYTE0 = 8'h00,
  parameter        SPARE_BYTE1 = 8'h00,
  parameter        SPARE_BYTE2 = 8'h00,
  parameter        SPARE_BYTE3 = 8'h00,
  parameter        SPARE_WORD0 = 32'h00000000,
  parameter        SPARE_WORD1 = 32'h00000000,
  parameter        SPARE_WORD2 = 32'h00000000,
  parameter        SPARE_WORD3 = 32'h00000000,

  parameter        TL_RBYPASS = "FALSE",
  parameter        TL_TFC_DISABLE = "FALSE",
  parameter        TL_TX_CHECKS_DISABLE = "FALSE",
  parameter        EXIT_LOOPBACK_ON_EI  = "TRUE",
  parameter        UR_INV_REQ = "TRUE",

  parameter        VC_CAP_ID = 16'h0002,
  parameter        VC_CAP_VERSION = 4'h1,
  parameter        VSEC_CAP_HDR_ID = 16'h1234,
  parameter        VSEC_CAP_HDR_LENGTH = 12'h018,
  parameter        VSEC_CAP_HDR_REVISION = 4'h1,
  parameter        VSEC_CAP_ID = 16'h000b,
  parameter        VSEC_CAP_IS_LINK_VISIBLE = "TRUE",
  parameter        VSEC_CAP_VERSION = 4'h1,

  parameter [15:0] C_BASEADDR_U = 16'hFFFF,    // AXI Lite Base Address upper 16 bits
  parameter [15:0] C_BASEADDR_L = 16'hFFFF,    // AXI Lite Base Address lower 16 bits
  parameter [15:0] C_HIGHADDR_U = 16'h0000,    // AXI Lite High Address upper 16 bits
  parameter [15:0] C_HIGHADDR_L = 16'h0000,    // AXI Lite High Address lower 16 bits
  parameter        C_MAX_LNK_WDT = 1,             // Maximum Number of PCIE Lanes
  parameter        C_ROOT_PORT = "TRUE",          // PCIe block is in root port mode
  parameter        C_RX_REALIGN = "TRUE",         // Enable or Disable Realignment at RX Interface
  parameter        C_RX_PRESERVE_ORDER = "FALSE", // Preserve WR/ RD Ordering at the RX Interface
  parameter [11:0] C_LAST_CORE_CAP_ADDR = 12'h000,// DWORD address of last enabled block capability
  parameter [11:0] C_VSEC_CAP_ADDR = 12'h000,     // DWORD address of start of VSEC Header
  parameter        C_VSEC_CAP_LAST = "FALSE",     // VSEC next capability offset control
  parameter [15:0] C_VSEC_ID = 16'h0000,
  parameter        C_DEVICE_NUMBER = 0,           // Device number for Root Port configurations only
  parameter        C_NUM_USER_INTR = 0,           // Number of user interrupts in User interrupt vector
  parameter [15:0] C_USER_PTR = 16'h0000,         // Address pointer to User Space
  parameter        C_COMP_TIMEOUT = 0,            // Configuration Completion Timeout Value 'b0 = 50us
                                                  // where 'b1 = 50ms
  parameter        C_FAMILY = "V6",               // Targeted FPGA family


  //*******************************************************************
  // S6 Parameter List
  //*******************************************************************

  parameter         USR_CFG                           = "FALSE",
  parameter         USR_EXT_CFG                       = "FALSE",
  parameter   [2:0] LINK_CAP_L0S_EXIT_LATENCY         = 3'd7,
  parameter   [2:0] LINK_CAP_L1_EXIT_LATENCY          = 3'd7,
  parameter         PLM_AUTO_CONFIG                   = "FALSE",
  parameter         FAST_TRAIN                        = "FALSE",
  parameter  [11:0] PCIE_GENERIC                      = 12'b000011101111,
  parameter   [0:0] GTP_SEL                           = 1'b0,
  parameter  [15:0] CFG_VEN_ID                        = 16'h10EE,
  parameter  [15:0] CFG_DEV_ID                        = 16'h0007,
  parameter   [7:0] CFG_REV_ID                        = 8'h00,
  parameter  [15:0] CFG_SUBSYS_VEN_ID                 = 16'h10EE,
  parameter  [15:0] CFG_SUBSYS_ID                     = 16'h0007,

  //*******************************************************************
  // K7 Parameter List
  //*******************************************************************

  parameter         AER_CAP_MULTIHEADER = "FALSE",
  parameter [23:0]  AER_CAP_OPTIONAL_ERR_SUPPORT = 24'h000000,
  parameter         DEV_CAP2_ARI_FORWARDING_SUPPORTED = "FALSE",
  parameter         DEV_CAP2_ATOMICOP32_COMPLETER_SUPPORTED = "FALSE",
  parameter         DEV_CAP2_ATOMICOP64_COMPLETER_SUPPORTED = "FALSE",
  parameter         DEV_CAP2_ATOMICOP_ROUTING_SUPPORTED = "FALSE",
  parameter         DEV_CAP2_CAS128_COMPLETER_SUPPORTED = "FALSE",
  parameter [1:0]   DEV_CAP2_TPH_COMPLETER_SUPPORTED = 2'b00,
  parameter         DEV_CONTROL_EXT_TAG_DEFAULT = "FALSE",
  parameter         DISABLE_RX_POISONED_RESP = "FALSE",
  parameter         LINK_CAP_ASPM_OPTIONALITY = "FALSE",
  parameter [11:0]  RBAR_BASE_PTR = 12'h0,
  parameter [4:0]   RBAR_CAP_CONTROL_ENCODEDBAR0 = 5'h00,
  parameter [4:0]   RBAR_CAP_CONTROL_ENCODEDBAR1 = 5'h00,
  parameter [4:0]   RBAR_CAP_CONTROL_ENCODEDBAR2 = 5'h00,
  parameter [4:0]   RBAR_CAP_CONTROL_ENCODEDBAR3 = 5'h00,
  parameter [4:0]   RBAR_CAP_CONTROL_ENCODEDBAR4 = 5'h00,
  parameter [4:0]   RBAR_CAP_CONTROL_ENCODEDBAR5 = 5'h00,
  parameter [2:0]   RBAR_CAP_INDEX0 = 3'h0,
  parameter [2:0]   RBAR_CAP_INDEX1 = 3'h0,
  parameter [2:0]   RBAR_CAP_INDEX2 = 3'h0,
  parameter [2:0]   RBAR_CAP_INDEX3 = 3'h0,
  parameter [2:0]   RBAR_CAP_INDEX4 = 3'h0,
  parameter [2:0]   RBAR_CAP_INDEX5 = 3'h0,
  parameter         RBAR_CAP_ON = "FALSE",
  parameter [31:0]  RBAR_CAP_SUP0 = 32'h00001,
  parameter [31:0]  RBAR_CAP_SUP1 = 32'h00001,
  parameter [31:0]  RBAR_CAP_SUP2 = 32'h00001,
  parameter [31:0]  RBAR_CAP_SUP3 = 32'h00001,
  parameter [31:0]  RBAR_CAP_SUP4 = 32'h00001,
  parameter [31:0]  RBAR_CAP_SUP5 = 32'h00001,
  parameter [2:0]   RBAR_NUM = 3'h0,
  parameter         TRN_NP_FC = "TRUE",
  parameter         TRN_DW = "FALSE",
  parameter         UR_ATOMIC = "FALSE",
  parameter         UR_PRS_RESPONSE = "TRUE",
  parameter         USER_CLK2_DIV2 = "FALSE",
  parameter         VC0_TOTAL_CREDITS_NPD = 24,
  parameter         LINK_CAP_RSVD_23 = 0,
  parameter         CFG_ECRC_ERR_CPLSTAT = 0,
  parameter         DISABLE_ERR_MSG = "FALSE",
  parameter         DISABLE_LOCKED_FILTER = "FALSE",
  parameter         DISABLE_PPM_FILTER = "FALSE",
  parameter         ENDEND_TLP_PREFIX_FORWARDING_SUPPORTED = "FALSE",
  parameter         INTERRUPT_STAT_AUTO = "TRUE",
  parameter         MPS_FORCE = "FALSE",
  parameter [14:0]  PM_ASPML0S_TIMEOUT = 15'h0000,
  parameter         PM_ASPML0S_TIMEOUT_EN = "FALSE",
  parameter         PM_ASPML0S_TIMEOUT_FUNC = 0,
  parameter         PM_ASPM_FASTEXIT = "FALSE",
  parameter         PM_MF = "FALSE",
  parameter [1:0]   RP_AUTO_SPD = 2'h1,
  parameter [4:0]   RP_AUTO_SPD_LOOPCNT = 5'h1f,
  parameter         SIM_VERSION = "1.0",
  parameter         SSL_MESSAGE_AUTO = "FALSE",
  parameter         TECRC_EP_INV = "FALSE",
  parameter         UR_CFG1 = "TRUE",
  parameter         USE_RID_PINS = "FALSE",
  parameter         DEV_CAP2_ENDEND_TLP_PREFIX_SUPPORTED = "FALSE",
  parameter         DEV_CAP2_EXTENDED_FMT_FIELD_SUPPORTED = "FALSE",
  parameter         DEV_CAP2_LTR_MECHANISM_SUPPORTED = "FALSE",
  parameter [1:0]   DEV_CAP2_MAX_ENDEND_TLP_PREFIXES = 2'h0,
  parameter         DEV_CAP2_NO_RO_ENABLED_PRPR_PASSING = "FALSE",
  parameter [15:0]  RBAR_CAP_ID = 16'h0015,
  parameter [11:0]  RBAR_CAP_NEXTPTR = 12'h000,
  parameter [3:0]   RBAR_CAP_VERSION = 4'h1,
  parameter         PCIE_USE_MODE = "1.0",
  parameter         PCIE_GT_DEVICE = "GTP",
  parameter         PCIE_CHAN_BOND = 1,
  parameter         PCIE_PLL_SEL   = "CPLL",
  parameter         PCIE_ASYNC_EN  = "FALSE",
  parameter         PCIE_TXBUF_EN  = "FALSE"
  )
(

//-------------------------------------------------------
  // 1. PCI Express (pci_exp) Interface
  //-------------------------------------------------------

  // Tx
  output  [(LINK_CAP_MAX_LINK_WIDTH - 1):0]     pci_exp_txp,
  output  [(LINK_CAP_MAX_LINK_WIDTH - 1):0]     pci_exp_txn,

  // Rx
  input   [(LINK_CAP_MAX_LINK_WIDTH - 1):0]     pci_exp_rxp,
  input   [(LINK_CAP_MAX_LINK_WIDTH - 1):0]     pci_exp_rxn,

  //-------------------------------------------------------
  // 2. Transaction (TRN) Interface
  //-------------------------------------------------------

  // Rx
  input                                         rx_np_ok,
  input                                         rx_np_req,

  // AXI TX - RW Interface
  //-----------
  input   [C_DATA_WIDTH-1:0] s_axis_rw_tdata,        // RW data from user
  input                      s_axis_rw_tvalid,       // RW data is valid
  output                     s_axis_rw_tready,       // RW ready for data
  input     [STRB_WIDTH-1:0] s_axis_rw_tstrb,        // RW strobe byte enables
  input                      s_axis_rw_tlast,        // RW data is last
  input                [3:0] s_axis_rw_tuser,        // RW user signals

  // AXI TX - RR Interface
  //-----------
  input   [C_DATA_WIDTH-1:0] s_axis_rr_tdata,        // RR data from user
  input                      s_axis_rr_tvalid,       // RR data is valid
  output                     s_axis_rr_tready,       // RR ready for data
  input     [STRB_WIDTH-1:0] s_axis_rr_tstrb,        // RR strobe byte enables
  input                      s_axis_rr_tlast,        // RR data is last
  input                [3:0] s_axis_rr_tuser,        // RR user signals

  // AXI TX - CC Interface
  //-----------
  input   [C_DATA_WIDTH-1:0] s_axis_cc_tdata,        // CC data from user
  input                      s_axis_cc_tvalid,       // CC data is valid
  output                     s_axis_cc_tready,       // CC ready for data
  input     [STRB_WIDTH-1:0] s_axis_cc_tstrb,        // CC strobe byte enables
  input                      s_axis_cc_tlast,        // CC data is last
  input                [3:0] s_axis_cc_tuser,        // CC user signals

  // AXI RX - CW Interface
  //-----------
  output  [C_DATA_WIDTH-1:0] m_axis_cw_tdata,        // CW data to user
  output                     m_axis_cw_tvalid,       // CW data is valid
  input                      m_axis_cw_tready,       // CW ready for data
  output    [STRB_WIDTH-1:0] m_axis_cw_tstrb,        // CW strobe byte enables
  output                     m_axis_cw_tlast,        // CW data is last
  output              [21:0] m_axis_cw_tuser,        // CW user signals

  // AXI RX - CR Interface
  //-----------
  output  [C_DATA_WIDTH-1:0] m_axis_cr_tdata,        // CR data to user
  output                     m_axis_cr_tvalid,       // CR data is valid
  input                      m_axis_cr_tready,       // CR ready for data
  output    [STRB_WIDTH-1:0] m_axis_cr_tstrb,        // CR strobe byte enables
  output                     m_axis_cr_tlast,        // CR data is last
  output              [21:0] m_axis_cr_tuser,        // CR user signals

  // AXI RX - RC Interface
  //-----------
  output  [C_DATA_WIDTH-1:0] m_axis_rc_tdata,        // RC data to user
  output                     m_axis_rc_tvalid,       // RC data is valid
  input                      m_axis_rc_tready,       // RC ready for data
  output    [STRB_WIDTH-1:0] m_axis_rc_tstrb,        // RC strobe byte enables
  output                     m_axis_rc_tlast,        // RC data is last
  output              [21:0] m_axis_rc_tuser,        // RC user signals

  // AXI -Lite Interface - CFG Block
  //-------------------------

  input               [31:0] s_axi_ctl_awaddr,       // AXI Lite Write address
  input                      s_axi_ctl_awvalid,      // AXI Lite Write Address Valid
  output                     s_axi_ctl_awready,      // AXI Lite Write Address Core ready
  input               [31:0] s_axi_ctl_wdata,        // AXI Lite Write Data
  input                [3:0] s_axi_ctl_wstrb,        // AXI Lite Write Data strobe
  input                      s_axi_ctl_wvalid,       // AXI Lite Write data Valid
  output                     s_axi_ctl_wready,       // AXI Lite Write Data Core ready
  output               [1:0] s_axi_ctl_bresp,        // AXI Lite Write Data strobe
  output                     s_axi_ctl_bvalid,       // AXI Lite Write data Valid
  input                      s_axi_ctl_bready,       // AXI Lite Write Data Core ready

  input               [31:0] s_axi_ctl_araddr,       // AXI Lite Read address
  input                      s_axi_ctl_arvalid,      // AXI Lite Read Address Valid
  output                     s_axi_ctl_arready,      // AXI Lite Read Address Core ready
  output              [31:0] s_axi_ctl_rdata,        // AXI Lite Read Data
  output               [1:0] s_axi_ctl_rresp,        // AXI Lite Read Data strobe
  output                     s_axi_ctl_rvalid,       // AXI Lite Read data Valid
  input                      s_axi_ctl_rready,       // AXI Lite Read Data Core ready

  // AXI Lite User IPIC Signals
  //---------------------------

  output                     Bus2IP_CS,              // Chip Select
  output               [3:0] Bus2IP_BE,              // Byte Enable Vector
  output                     Bus2IP_RNW,             // Read Npt Write Qualifier
  output              [31:0] Bus2IP_Addr,            // Address Bus
  output              [31:0] Bus2IP_Data,            // Write Data Bus
  input                      IP2Bus_RdAck,           // Read Acknowledgement
  input                      IP2Bus_WrAck,           // Write Acknowledgement
  input               [31:0] IP2Bus_Data,            // Read Data Bus
  input                      IP2Bus_Error,           // Error Qualifier

  //Interrupts
  //-----------------

  output                     ctl_intr,               // user interrupt
  input [C_NUM_USER_INTR-1:0]ctl_user_intr,          // User interrupt vector used only in axi_pcie_mm_s
  
  // User Misc.
  //-----------
  input                      np_cpl_pending,         // Non-Posted Completion Packets pending
  output                     RP_bridge_en,           // RP Bridge Enable 


  //-------------------------------------------------------
  // 3. Configuration (CFG) Interface
  //-------------------------------------------------------

  input                                         blk_err_cor,
  input                                         blk_err_ur,
  input                                         blk_err_ecrc,
  input                                         blk_err_cpl_timeout,
  input                                         blk_err_cpl_abort,
  input                                         blk_err_cpl_unexpect,
  input                                         blk_err_posted,
  input                                         blk_err_locked,
  input  [47:0]                                 blk_err_tlp_cpl_header,
  output                                        blk_err_cpl_rdy,
  input                                         blk_interrupt,
  output                                        blk_interrupt_rdy,
  input                                         blk_interrupt_assert,
  input  [7:0]                                  blk_interrupt_di,
  output [7:0]                                  cfg_interrupt_do,
  output [2:0]                                  blk_interrupt_mmenable,
  output                                        blk_interrupt_msienable,
  output                                        blk_interrupt_msixenable,
  output                                        blk_interrupt_msixfm,
  input                                         blk_trn_pending,
  input                                         cfg_pm_send_pme_to,
  output [15:0]                                 blk_status,
  output [15:0]                                 blk_command,
  output [15:0]                                 blk_dstatus,
  output [15:0]                                 blk_dcommand,
  output [15:0]                                 blk_lstatus,
  output [15:0]                                 blk_lcommand,
  output [15:0]                                 blk_dcommand2,
  output  [2:0]                                 blk_pcie_link_state,
  input  [63:0]                                 blk_dsn,
  output                                        blk_pmcsr_pme_en,
  output                                        blk_pmcsr_pme_status,
  output  [1:0]                                 blk_pmcsr_powerstate,

  output                                        cfg_msg_received,
  output [15:0]                                 blk_msg_data,
  output                                        blk_msg_received_err_cor,
  output                                        blk_msg_received_err_non_fatal,
  output                                        blk_msg_received_err_fatal,
  output                                        blk_msg_received_pme_to_ack,
  output                                        blk_msg_received_assert_inta,
  output                                        blk_msg_received_assert_intb,
  output                                        blk_msg_received_assert_intc,
  output                                        blk_msg_received_assert_intd,
  output                                        blk_msg_received_deassert_inta,
  output                                        blk_msg_received_deassert_intb,
  output                                        blk_msg_received_deassert_intc,
  output                                        blk_msg_received_deassert_intd,

  output                                        blk_link_up,
  
  input   [7:0]                                 blk_ds_bus_number,
  input   [4:0]                                 blk_ds_device_number,


  // Only for End point Cores
  output                                        blk_to_turnoff,
  input                                         blk_turnoff_ok,
  input                                         blk_pm_wake,

  output   [7:0]                                blk_bus_number,
  output   [4:0]                                blk_device_number,
  output   [2:0]                                blk_function_number,

  

  //-------------------------------------------------------
  // 4. Physical Layer Control and Status (PL) Interface
  //-------------------------------------------------------

  output [2:0]                                  blk_pl_initial_link_width,
  output [1:0]                                  blk_pl_lane_reversal_mode,
  output                                        blk_pl_link_gen2_capable,
  output                                        blk_pl_link_partner_gen2_supported,
  output                                        blk_pl_link_upcfg_capable,
  output [5:0]                                  blk_pl_ltssm_state,
  output                                        blk_pl_sel_link_rate,
  output [1:0]                                  blk_pl_sel_link_width,
  input                                         blk_pl_upstream_prefer_deemph,
  output                                        blk_pl_hot_rst,

  // Flow Control
  output [11:0]                                 blk_fc_cpld,
  output  [7:0]                                 blk_fc_cplh,
  output [11:0]                                 blk_fc_npd,
  output  [7:0]                                 blk_fc_nph,
  output [11:0]                                 blk_fc_pd,
  output  [7:0]                                 blk_fc_ph,
  input   [2:0]                                 blk_fc_sel,

  // Tx

  output  [5:0]                                 blk_tbuf_av,
  output                                        blk_tcfg_req,
  input                                         blk_tcfg_gnt,

  output                                        tx_err_drop,

  //S-6 Specific

  output [31:0]                                 cfg_do,
  output                                        cfg_rd_wr_done,
  input  [9:0]                                  cfg_dwaddr,
  input                                         cfg_rd_en,

  //-------------------------------------------------------
  // 5. System  (SYS) Interface
  //-------------------------------------------------------

  input                                         com_sysclk,
  input                                         com_sysrst,
  output                                        mmcm_lock,
  output                                        com_iclk,
  output                                        com_cclk,
  output                                        com_corereset,

  //-------------------------------------------------------
  // Additional Signals for K7
  //-------------------------------------------------------
  // Clock Inputs - For Partial Reconfig Support
  input  [(LINK_CAP_MAX_LINK_WIDTH - 1) : 0]   clk_fab_refclk,
  input                                        clk_pclk,
  input                                        clk_rxusrclk,
  input                                        clk_dclk,
  input                                        clk_userclk1,
  input                                        clk_userclk2,
  input                                        clk_oobclk_in,
  input                                        clk_mmcm_lock,
  output                                       clk_txoutclk,
  output [(LINK_CAP_MAX_LINK_WIDTH - 1) : 0]   clk_rxoutclk,
  output [(LINK_CAP_MAX_LINK_WIDTH - 1) : 0]   clk_pclk_sel,
  output                                       clk_gen3,
  // common
  output                                       user_clk_out,
  output                                       user_reset_out,
  // CFG Pins
  output wire                                  cfg_received_func_lvl_rst,
  input wire                                   cfg_err_atomic_egress_blocked,
  input wire                                   cfg_err_internal_cor,
  input wire                                   cfg_err_malformed,
  input wire                                   cfg_err_mc_blocked,
  input wire                                   cfg_err_poisoned,
  input wire                                   cfg_err_norecovery,
  input wire                                   cfg_err_acs,
  input wire                                   cfg_err_internal_uncor,
  input wire                                   cfg_pm_halt_aspm_l0s,
  input wire                                   cfg_pm_halt_aspm_l1,
  input wire                                   cfg_pm_force_state_en,
  input wire   [1:0]                           cfg_pm_force_state,
  input wire                                   cfg_interrupt_stat,
  input wire   [4:0]                           cfg_pciecap_interrupt_msgnum,
  output wire                                  cfg_bridge_serr_en,
  output wire                                  cfg_slot_control_electromech_il_ctl_pulse,
  output wire                                  cfg_root_control_syserr_corr_err_en,
  output wire                                  cfg_root_control_syserr_non_fatal_err_en,
  output wire                                  cfg_root_control_syserr_fatal_err_en,
  output wire                                  cfg_root_control_pme_int_en,
  output wire                                  cfg_aer_rooterr_corr_err_reporting_en,
  output wire                                  cfg_aer_rooterr_non_fatal_err_reporting_en,
  output wire                                  cfg_aer_rooterr_fatal_err_reporting_en,
  output wire                                  cfg_aer_rooterr_corr_err_received,
  output wire                                  cfg_aer_rooterr_non_fatal_err_received,
  output wire                                  cfg_aer_rooterr_fatal_err_received,
  output wire                                  cfg_msg_received_pm_as_nak,
  output wire                                  cfg_msg_received_pm_pme,
  output wire                                  cfg_msg_received_setslotpowerlimit,
  // PHY pins
  output wire                                  pl_phy_lnk_up,
  output wire  [2:0]                           pl_tx_pm_state,
  output wire  [1:0]                           pl_rx_pm_state,
  output wire                                  pl_directed_change_done,
  input wire                                   pl_downstream_deemph_source,
  // AER pins
  input wire   [127:0]                         cfg_err_aer_headerlog, 
  input wire   [4:0]                           cfg_aer_interrupt_msgnum, 
  output wire                                  cfg_err_aer_headerlog_set, 
  output wire                                  cfg_aer_ecrc_check_en, 
  output wire                                  cfg_aer_ecrc_gen_en, 
  // VC-TC Map
  output wire [6:0]                            cfg_vc_tcvc_map,
  output                                       config_gen_req

  );

  localparam [31:0]  BAR0 = {BAR0_U,BAR0_L};
  localparam [31:0]  BAR1 = {BAR1_U,BAR1_L};
  localparam [31:0]  BAR2 = {BAR2_U,BAR2_L};
  localparam [31:0]  BAR3 = {BAR3_U,BAR3_L};
  localparam [31:0]  BAR4 = {BAR4_U,BAR4_L};
  localparam [31:0]  BAR5 = {BAR5_U,BAR5_L};

  localparam [31:0]  EXPANSION_ROM = {EXPANSION_ROM_U,EXPANSION_ROM_L};

  localparam [31:0] C_BASEADDR = {C_BASEADDR_U,C_BASEADDR_L};
  localparam [31:0] C_HIGHADDR = {C_HIGHADDR_U,C_HIGHADDR_L}; 

axi_pcie_v1_09_a_axi_pcie_enhanced_core_top # (
  .C_DATA_WIDTH( C_DATA_WIDTH ),
  .STRB_WIDTH( STRB_WIDTH ) ,
  .BAR0( BAR0 ),
  .BAR1( BAR1 ),
  .BAR2( BAR2 ),
  .BAR3( BAR3 ),
  .BAR4( BAR4 ),
  .BAR5( BAR5 ),

  .CARDBUS_CIS_POINTER( CARDBUS_CIS_POINTER ),
  .CLASS_CODE( CLASS_CODE ),
  .CMD_INTX_IMPLEMENTED( CMD_INTX_IMPLEMENTED ),
  .CPL_TIMEOUT_DISABLE_SUPPORTED( CPL_TIMEOUT_DISABLE_SUPPORTED ),
  .CPL_TIMEOUT_RANGES_SUPPORTED( CPL_TIMEOUT_RANGES_SUPPORTED ),

  .DEV_CAP_EXT_TAG_SUPPORTED( DEV_CAP_EXT_TAG_SUPPORTED ),
  .DEV_CAP_MAX_PAYLOAD_SUPPORTED( DEV_CAP_MAX_PAYLOAD_SUPPORTED ),
  .DEV_CAP_PHANTOM_FUNCTIONS_SUPPORT( DEV_CAP_PHANTOM_FUNCTIONS_SUPPORT ),
  .DEVICE_ID( DEVICE_ID ),

  .DISABLE_LANE_REVERSAL( DISABLE_LANE_REVERSAL ),
  .DISABLE_SCRAMBLING( DISABLE_SCRAMBLING ),
  .DSN_BASE_PTR( DSN_BASE_PTR ),
  .DSN_CAP_NEXTPTR( DSN_CAP_NEXTPTR ),
  .DSN_CAP_ON( DSN_CAP_ON ),

  .ENABLE_MSG_ROUTE( ENABLE_MSG_ROUTE ),
  .ENABLE_RX_TD_ECRC_TRIM( ENABLE_RX_TD_ECRC_TRIM ),
  .EXPANSION_ROM( EXPANSION_ROM ),
  .EXT_CFG_CAP_PTR( EXT_CFG_CAP_PTR ),
  .EXT_CFG_XP_CAP_PTR( EXT_CFG_XP_CAP_PTR ),
  .HEADER_TYPE( HEADER_TYPE ),
  .INTERRUPT_PIN( INTERRUPT_PIN ),

  .LINK_CAP_DLL_LINK_ACTIVE_REPORTING_CAP( LINK_CAP_DLL_LINK_ACTIVE_REPORTING_CAP ),
  .LINK_CAP_LINK_BANDWIDTH_NOTIFICATION_CAP( LINK_CAP_LINK_BANDWIDTH_NOTIFICATION_CAP ),
  .LINK_CAP_MAX_LINK_SPEED( LINK_CAP_MAX_LINK_SPEED ),
  .LINK_CAP_MAX_LINK_WIDTH( LINK_CAP_MAX_LINK_WIDTH ),
  .LINK_CAP_SURPRISE_DOWN_ERROR_CAPABLE( LINK_CAP_SURPRISE_DOWN_ERROR_CAPABLE ),

  .LINK_CONTROL_RCB( LINK_CONTROL_RCB ),
  .LINK_CTRL2_DEEMPHASIS( LINK_CTRL2_DEEMPHASIS ),
  .LINK_CTRL2_HW_AUTONOMOUS_SPEED_DISABLE( LINK_CTRL2_HW_AUTONOMOUS_SPEED_DISABLE ),
  .LINK_CTRL2_TARGET_LINK_SPEED( LINK_CTRL2_TARGET_LINK_SPEED ),
  .LINK_STATUS_SLOT_CLOCK_CONFIG( LINK_STATUS_SLOT_CLOCK_CONFIG ),

  .LL_ACK_TIMEOUT( LL_ACK_TIMEOUT ),
  .LL_ACK_TIMEOUT_EN( LL_ACK_TIMEOUT_EN ),
  .LL_ACK_TIMEOUT_FUNC( LL_ACK_TIMEOUT_FUNC ),
  .LL_REPLAY_TIMEOUT( LL_REPLAY_TIMEOUT ),
  .LL_REPLAY_TIMEOUT_EN( LL_REPLAY_TIMEOUT_EN ),
  .LL_REPLAY_TIMEOUT_FUNC( LL_REPLAY_TIMEOUT_FUNC ),

  .LTSSM_MAX_LINK_WIDTH( LTSSM_MAX_LINK_WIDTH ),
  .MSI_CAP_MULTIMSGCAP( MSI_CAP_MULTIMSGCAP ),
  .MSI_CAP_MULTIMSG_EXTENSION( MSI_CAP_MULTIMSG_EXTENSION ),
  .MSI_CAP_ON( MSI_CAP_ON ),
  .MSI_CAP_PER_VECTOR_MASKING_CAPABLE( MSI_CAP_PER_VECTOR_MASKING_CAPABLE ),
  .MSI_CAP_64_BIT_ADDR_CAPABLE( MSI_CAP_64_BIT_ADDR_CAPABLE ),

  .MSIX_CAP_ON( MSIX_CAP_ON ),
  .MSIX_CAP_PBA_BIR( MSIX_CAP_PBA_BIR ),
  .MSIX_CAP_PBA_OFFSET( MSIX_CAP_PBA_OFFSET ),
  .MSIX_CAP_TABLE_BIR( MSIX_CAP_TABLE_BIR ),
  .MSIX_CAP_TABLE_OFFSET( MSIX_CAP_TABLE_OFFSET ),
  .MSIX_CAP_TABLE_SIZE( MSIX_CAP_TABLE_SIZE ),

  .PCIE_CAP_DEVICE_PORT_TYPE( PCIE_CAP_DEVICE_PORT_TYPE ),
  .PCIE_CAP_INT_MSG_NUM( PCIE_CAP_INT_MSG_NUM ),
  .PCIE_CAP_NEXTPTR( PCIE_CAP_NEXTPTR ),
  .PCIE_DRP_ENABLE( PCIE_DRP_ENABLE ),
  .PIPE_PIPELINE_STAGES( PIPE_PIPELINE_STAGES ), //2 - 2 stages

  .PM_CAP_DSI( PM_CAP_DSI ),
  .PM_CAP_D1SUPPORT( PM_CAP_D1SUPPORT ),
  .PM_CAP_D2SUPPORT( PM_CAP_D2SUPPORT ),
  .PM_CAP_NEXTPTR( PM_CAP_NEXTPTR ),
  .PM_CAP_PMESUPPORT( PM_CAP_PMESUPPORT ),
  .PM_CSR_NOSOFTRST( PM_CSR_NOSOFTRST ),

  .PM_DATA_SCALE0( PM_DATA_SCALE0 ),
  .PM_DATA_SCALE1( PM_DATA_SCALE1 ),
  .PM_DATA_SCALE2( PM_DATA_SCALE2 ),
  .PM_DATA_SCALE3( PM_DATA_SCALE3 ),
  .PM_DATA_SCALE4( PM_DATA_SCALE4 ),
  .PM_DATA_SCALE5( PM_DATA_SCALE5 ),
  .PM_DATA_SCALE6( PM_DATA_SCALE6 ),
  .PM_DATA_SCALE7( PM_DATA_SCALE7 ),

  .PM_DATA0( PM_DATA0 ),
  .PM_DATA1( PM_DATA1 ),
  .PM_DATA2( PM_DATA2 ),
  .PM_DATA3( PM_DATA3 ),
  .PM_DATA4( PM_DATA4 ),
  .PM_DATA5( PM_DATA5 ),
  .PM_DATA6( PM_DATA6 ),
  .PM_DATA7( PM_DATA7 ),

  .REF_CLK_FREQ( REF_CLK_FREQ ), //2 - 250 MHz
  .REVISION_ID( REVISION_ID ),
  .ROOT_CAP_CRS_SW_VISIBILITY( ROOT_CAP_CRS_SW_VISIBILITY ),
  .SPARE_BIT0( SPARE_BIT0 ),
  .SUBSYSTEM_ID( SUBSYSTEM_ID ),
  .SUBSYSTEM_VENDOR_ID( SUBSYSTEM_VENDOR_ID ),

  .SLOT_CAP_ATT_BUTTON_PRESENT( SLOT_CAP_ATT_BUTTON_PRESENT ),
  .SLOT_CAP_ATT_INDICATOR_PRESENT( SLOT_CAP_ATT_INDICATOR_PRESENT ),
  .SLOT_CAP_ELEC_INTERLOCK_PRESENT( SLOT_CAP_ELEC_INTERLOCK_PRESENT ),
  .SLOT_CAP_HOTPLUG_CAPABLE( SLOT_CAP_HOTPLUG_CAPABLE ),
  .SLOT_CAP_HOTPLUG_SURPRISE( SLOT_CAP_HOTPLUG_SURPRISE ),
  .SLOT_CAP_MRL_SENSOR_PRESENT( SLOT_CAP_MRL_SENSOR_PRESENT ),
  .SLOT_CAP_NO_CMD_COMPLETED_SUPPORT( SLOT_CAP_NO_CMD_COMPLETED_SUPPORT ),
  .SLOT_CAP_PHYSICAL_SLOT_NUM( SLOT_CAP_PHYSICAL_SLOT_NUM ),
  .SLOT_CAP_POWER_CONTROLLER_PRESENT( SLOT_CAP_POWER_CONTROLLER_PRESENT ),
  .SLOT_CAP_POWER_INDICATOR_PRESENT( SLOT_CAP_POWER_INDICATOR_PRESENT ),
  .SLOT_CAP_SLOT_POWER_LIMIT_SCALE( SLOT_CAP_SLOT_POWER_LIMIT_SCALE ),
  .SLOT_CAP_SLOT_POWER_LIMIT_VALUE( SLOT_CAP_SLOT_POWER_LIMIT_VALUE ),

  .TL_RX_RAM_RADDR_LATENCY( TL_RX_RAM_RADDR_LATENCY ),
  .TL_RX_RAM_RDATA_LATENCY( TL_RX_RAM_RDATA_LATENCY ),
  .TL_RX_RAM_WRITE_LATENCY( TL_RX_RAM_WRITE_LATENCY ),
  .TL_TX_RAM_RADDR_LATENCY( TL_TX_RAM_RADDR_LATENCY ),
  .TL_TX_RAM_RDATA_LATENCY( TL_TX_RAM_RDATA_LATENCY ),
  .TL_TX_RAM_WRITE_LATENCY( TL_TX_RAM_WRITE_LATENCY ),

  .UPCONFIG_CAPABLE( UPCONFIG_CAPABLE ),
  .UPSTREAM_FACING( UPSTREAM_FACING ),
  .USER_CLK_FREQ( USER_CLK_FREQ ),
  .VC_BASE_PTR( VC_BASE_PTR ),
  .VC_CAP_NEXTPTR( VC_CAP_NEXTPTR ),
  .VC_CAP_ON( VC_CAP_ON ),
  .VC_CAP_REJECT_SNOOP_TRANSACTIONS( VC_CAP_REJECT_SNOOP_TRANSACTIONS ),

  .VC0_CPL_INFINITE( VC0_CPL_INFINITE ),
  .VC0_RX_RAM_LIMIT( VC0_RX_RAM_LIMIT ),
  .VC0_TOTAL_CREDITS_CD( VC0_TOTAL_CREDITS_CD ),
  .VC0_TOTAL_CREDITS_CH( VC0_TOTAL_CREDITS_CH ),
  .VC0_TOTAL_CREDITS_NPH( VC0_TOTAL_CREDITS_NPH ),
  .VC0_TOTAL_CREDITS_PD( VC0_TOTAL_CREDITS_PD ),
  .VC0_TOTAL_CREDITS_PH( VC0_TOTAL_CREDITS_PH ),
  .VC0_TX_LASTPACKET( VC0_TX_LASTPACKET ),

  .VENDOR_ID( VENDOR_ID ),
  .VSEC_BASE_PTR( VSEC_BASE_PTR ),
  .VSEC_CAP_NEXTPTR( VSEC_CAP_NEXTPTR ),
  .VSEC_CAP_ON( VSEC_CAP_ON ),

  .ALLOW_X8_GEN2( ALLOW_X8_GEN2 ),
  .AER_BASE_PTR( AER_BASE_PTR ),
  .AER_CAP_ECRC_CHECK_CAPABLE( AER_CAP_ECRC_CHECK_CAPABLE ),
  .AER_CAP_ECRC_GEN_CAPABLE( AER_CAP_ECRC_GEN_CAPABLE ),
  .AER_CAP_ID( AER_CAP_ID ),
  .AER_CAP_INT_MSG_NUM_MSI( AER_CAP_INT_MSG_NUM_MSI ),
  .AER_CAP_INT_MSG_NUM_MSIX( AER_CAP_INT_MSG_NUM_MSIX ),
  .AER_CAP_NEXTPTR( AER_CAP_NEXTPTR ),
  .AER_CAP_ON( AER_CAP_ON ),
  .AER_CAP_PERMIT_ROOTERR_UPDATE( AER_CAP_PERMIT_ROOTERR_UPDATE ),
  .AER_CAP_VERSION( AER_CAP_VERSION ),

  .CAPABILITIES_PTR( CAPABILITIES_PTR ),
  .CRM_MODULE_RSTS( CRM_MODULE_RSTS ),
  .DEV_CAP_ENDPOINT_L0S_LATENCY( DEV_CAP_ENDPOINT_L0S_LATENCY ),
  .DEV_CAP_ENDPOINT_L1_LATENCY( DEV_CAP_ENDPOINT_L1_LATENCY ),
  .DEV_CAP_FUNCTION_LEVEL_RESET_CAPABLE( DEV_CAP_FUNCTION_LEVEL_RESET_CAPABLE ),
  .DEV_CAP_ROLE_BASED_ERROR( DEV_CAP_ROLE_BASED_ERROR ),
  .DEV_CAP_RSVD_14_12( DEV_CAP_RSVD_14_12 ),
  .DEV_CAP_RSVD_17_16( DEV_CAP_RSVD_17_16 ),
  .DEV_CAP_RSVD_31_29( DEV_CAP_RSVD_31_29 ),
  .DEV_CAP_ENABLE_SLOT_PWR_LIMIT_SCALE( DEV_CAP_ENABLE_SLOT_PWR_LIMIT_SCALE ),
  .DEV_CAP_ENABLE_SLOT_PWR_LIMIT_VALUE( DEV_CAP_ENABLE_SLOT_PWR_LIMIT_VALUE ),
  .DEV_CONTROL_AUX_POWER_SUPPORTED( DEV_CONTROL_AUX_POWER_SUPPORTED ),

  .DISABLE_ASPM_L1_TIMER( DISABLE_ASPM_L1_TIMER ),
  .DISABLE_BAR_FILTERING( DISABLE_BAR_FILTERING ),
  .DISABLE_ID_CHECK( DISABLE_ID_CHECK ),
  .DISABLE_RX_TC_FILTER( DISABLE_RX_TC_FILTER ),
  .DNSTREAM_LINK_NUM( DNSTREAM_LINK_NUM ),

  .DS_PORT_HOT_RST( DS_PORT_HOT_RST ), //TRUE - for DOWNSTREAM PORT 
  .DSN_CAP_ID( DSN_CAP_ID ),
  .DSN_CAP_VERSION( DSN_CAP_VERSION ),
  .ENTER_RVRY_EI_L0( ENTER_RVRY_EI_L0 ),
  .INFER_EI( INFER_EI ),
  .IS_SWITCH( IS_SWITCH ),

  .LAST_CONFIG_DWORD( LAST_CONFIG_DWORD ),
  .LINK_CAP_ASPM_SUPPORT( LINK_CAP_ASPM_SUPPORT ),
  .LINK_CAP_CLOCK_POWER_MANAGEMENT( LINK_CAP_CLOCK_POWER_MANAGEMENT ),
  .LINK_CAP_L0S_EXIT_LATENCY_COMCLK_GEN1( LINK_CAP_L0S_EXIT_LATENCY_COMCLK_GEN1 ),
  .LINK_CAP_L0S_EXIT_LATENCY_COMCLK_GEN2( LINK_CAP_L0S_EXIT_LATENCY_COMCLK_GEN2 ),
  .LINK_CAP_L0S_EXIT_LATENCY_GEN1( LINK_CAP_L0S_EXIT_LATENCY_GEN1 ),
  .LINK_CAP_L0S_EXIT_LATENCY_GEN2( LINK_CAP_L0S_EXIT_LATENCY_GEN2 ),
  .LINK_CAP_L1_EXIT_LATENCY_COMCLK_GEN1( LINK_CAP_L1_EXIT_LATENCY_COMCLK_GEN1 ),
  .LINK_CAP_L1_EXIT_LATENCY_COMCLK_GEN2( LINK_CAP_L1_EXIT_LATENCY_COMCLK_GEN2 ),
  .LINK_CAP_L1_EXIT_LATENCY_GEN1( LINK_CAP_L1_EXIT_LATENCY_GEN1 ),
  .LINK_CAP_L1_EXIT_LATENCY_GEN2( LINK_CAP_L1_EXIT_LATENCY_GEN2 ),
  .LINK_CAP_RSVD_23_22( LINK_CAP_RSVD_23_22 ),

  .MSI_BASE_PTR( MSI_BASE_PTR ),
  .MSI_CAP_ID( MSI_CAP_ID ),
  .MSI_CAP_NEXTPTR( MSI_CAP_NEXTPTR ),
  .MSIX_BASE_PTR( MSIX_BASE_PTR ),
  .MSIX_CAP_ID( MSIX_CAP_ID ),
  .MSIX_CAP_NEXTPTR( MSIX_CAP_NEXTPTR ),
  .N_FTS_COMCLK_GEN1( N_FTS_COMCLK_GEN1 ),
  .N_FTS_COMCLK_GEN2( N_FTS_COMCLK_GEN2 ),
  .N_FTS_GEN1( N_FTS_GEN1 ),
  .N_FTS_GEN2( N_FTS_GEN2 ),

  .PCIE_BASE_PTR( PCIE_BASE_PTR ),
  .PCIE_CAP_CAPABILITY_ID( PCIE_CAP_CAPABILITY_ID ),
  .PCIE_CAP_CAPABILITY_VERSION( PCIE_CAP_CAPABILITY_VERSION ),
  .PCIE_CAP_ON( PCIE_CAP_ON ),
  .PCIE_CAP_RSVD_15_14( PCIE_CAP_RSVD_15_14 ),
  .PCIE_CAP_SLOT_IMPLEMENTED( PCIE_CAP_SLOT_IMPLEMENTED ),
  .PCIE_REVISION( PCIE_REVISION ),
  .PGL0_LANE( PGL0_LANE ),
  .PGL1_LANE( PGL1_LANE ),
  .PGL2_LANE( PGL2_LANE ),
  .PGL3_LANE( PGL3_LANE ),
  .PGL4_LANE( PGL4_LANE ),
  .PGL5_LANE( PGL5_LANE ),
  .PGL6_LANE( PGL6_LANE ),
  .PGL7_LANE( PGL7_LANE ),
  .PL_AUTO_CONFIG( PL_AUTO_CONFIG ),
  .PL_FAST_TRAIN( PL_FAST_TRAIN ),
  .PCIE_EXT_CLK( PCIE_EXT_CLK ),

  .PM_BASE_PTR( PM_BASE_PTR ),
  .PM_CAP_AUXCURRENT( PM_CAP_AUXCURRENT ),
  .PM_CAP_ID( PM_CAP_ID ),
  .PM_CAP_ON( PM_CAP_ON ),
  .PM_CAP_PME_CLOCK( PM_CAP_PME_CLOCK ),
  .PM_CAP_RSVD_04( PM_CAP_RSVD_04 ),
  .PM_CAP_VERSION( PM_CAP_VERSION ),
  .PM_CSR_BPCCEN( PM_CSR_BPCCEN ),
  .PM_CSR_B2B3( PM_CSR_B2B3 ),

  .RECRC_CHK( RECRC_CHK ),
  .RECRC_CHK_TRIM( RECRC_CHK_TRIM ),
  .SELECT_DLL_IF( SELECT_DLL_IF ),
  .SPARE_BIT1( SPARE_BIT1 ),
  .SPARE_BIT2( SPARE_BIT2 ),
  .SPARE_BIT3( SPARE_BIT3 ),
  .SPARE_BIT4( SPARE_BIT4 ),
  .SPARE_BIT5( SPARE_BIT5 ),
  .SPARE_BIT6( SPARE_BIT6 ),
  .SPARE_BIT7( SPARE_BIT7 ),
  .SPARE_BIT8( SPARE_BIT8 ),
  .SPARE_BYTE0( SPARE_BYTE0 ),
  .SPARE_BYTE1( SPARE_BYTE1 ),
  .SPARE_BYTE2( SPARE_BYTE2 ),
  .SPARE_BYTE3( SPARE_BYTE3 ),
  .SPARE_WORD0( SPARE_WORD0 ),
  .SPARE_WORD1( SPARE_WORD1 ),
  .SPARE_WORD2( SPARE_WORD2 ),
  .SPARE_WORD3( SPARE_WORD3 ),

  .TL_RBYPASS( TL_RBYPASS ),
  .TL_TFC_DISABLE( TL_TFC_DISABLE ),
  .TL_TX_CHECKS_DISABLE( TL_TX_CHECKS_DISABLE ),
  .EXIT_LOOPBACK_ON_EI ( EXIT_LOOPBACK_ON_EI  ),
  .UR_INV_REQ( UR_INV_REQ ),

  .VC_CAP_ID( VC_CAP_ID ),
  .VC_CAP_VERSION( VC_CAP_VERSION ),
  .VSEC_CAP_HDR_ID( VSEC_CAP_HDR_ID ),
  .VSEC_CAP_HDR_LENGTH( VSEC_CAP_HDR_LENGTH ),
  .VSEC_CAP_HDR_REVISION( VSEC_CAP_HDR_REVISION ),
  .VSEC_CAP_ID( VSEC_CAP_ID ),
  .VSEC_CAP_IS_LINK_VISIBLE( VSEC_CAP_IS_LINK_VISIBLE ),
  .VSEC_CAP_VERSION( VSEC_CAP_VERSION ),
  .C_BASEADDR( C_BASEADDR ),
  .C_HIGHADDR( C_HIGHADDR ),
  .C_MAX_LNK_WDT( C_MAX_LNK_WDT ),
  .C_ROOT_PORT( C_ROOT_PORT ),
  .C_RX_REALIGN( C_RX_REALIGN ),
  .C_RX_PRESERVE_ORDER( C_RX_PRESERVE_ORDER ),
  .C_LAST_CORE_CAP_ADDR( C_LAST_CORE_CAP_ADDR ),
  .C_VSEC_CAP_ADDR( C_VSEC_CAP_ADDR ),
  .C_VSEC_CAP_LAST( C_VSEC_CAP_LAST ),
  .C_VSEC_ID( C_VSEC_ID ),
  .C_DEVICE_NUMBER( C_DEVICE_NUMBER ),
  .C_NUM_USER_INTR( C_NUM_USER_INTR ),
  .C_USER_PTR( C_USER_PTR ),
  .C_COMP_TIMEOUT( C_COMP_TIMEOUT ),
  .C_FAMILY( C_FAMILY ),
  .USR_CFG( USR_CFG ),
  .USR_EXT_CFG( USR_EXT_CFG ),
  .LINK_CAP_L0S_EXIT_LATENCY( LINK_CAP_L0S_EXIT_LATENCY ),
  .LINK_CAP_L1_EXIT_LATENCY( LINK_CAP_L1_EXIT_LATENCY ),
  .PLM_AUTO_CONFIG( PLM_AUTO_CONFIG ),
  .FAST_TRAIN( FAST_TRAIN ),
  .PCIE_GENERIC( PCIE_GENERIC ),
  .GTP_SEL( GTP_SEL ),
  .CFG_VEN_ID( CFG_VEN_ID ),
  .CFG_DEV_ID( CFG_DEV_ID ),
  .CFG_REV_ID( CFG_REV_ID ),
  .CFG_SUBSYS_VEN_ID( CFG_SUBSYS_VEN_ID ),
  .CFG_SUBSYS_ID( CFG_SUBSYS_ID ),
  .AER_CAP_MULTIHEADER ( AER_CAP_MULTIHEADER ),
  .AER_CAP_OPTIONAL_ERR_SUPPORT ( AER_CAP_OPTIONAL_ERR_SUPPORT ),
  .DEV_CAP2_ARI_FORWARDING_SUPPORTED ( DEV_CAP2_ARI_FORWARDING_SUPPORTED ),
  .DEV_CAP2_ATOMICOP32_COMPLETER_SUPPORTED ( DEV_CAP2_ATOMICOP32_COMPLETER_SUPPORTED ),
  .DEV_CAP2_ATOMICOP64_COMPLETER_SUPPORTED ( DEV_CAP2_ATOMICOP64_COMPLETER_SUPPORTED ),
  .DEV_CAP2_ATOMICOP_ROUTING_SUPPORTED ( DEV_CAP2_ATOMICOP_ROUTING_SUPPORTED ),
  .DEV_CAP2_CAS128_COMPLETER_SUPPORTED ( DEV_CAP2_CAS128_COMPLETER_SUPPORTED ),
  .DEV_CAP2_TPH_COMPLETER_SUPPORTED ( DEV_CAP2_TPH_COMPLETER_SUPPORTED ),
  .DEV_CONTROL_EXT_TAG_DEFAULT ( DEV_CONTROL_EXT_TAG_DEFAULT ),
  .DISABLE_RX_POISONED_RESP ( DISABLE_RX_POISONED_RESP ),
  .LINK_CAP_ASPM_OPTIONALITY ( LINK_CAP_ASPM_OPTIONALITY ),
  .RBAR_BASE_PTR ( RBAR_BASE_PTR ),
  .RBAR_CAP_CONTROL_ENCODEDBAR0 ( RBAR_CAP_CONTROL_ENCODEDBAR0 ),
  .RBAR_CAP_CONTROL_ENCODEDBAR1 ( RBAR_CAP_CONTROL_ENCODEDBAR1 ),
  .RBAR_CAP_CONTROL_ENCODEDBAR2 ( RBAR_CAP_CONTROL_ENCODEDBAR2 ),
  .RBAR_CAP_CONTROL_ENCODEDBAR3 ( RBAR_CAP_CONTROL_ENCODEDBAR3 ),
  .RBAR_CAP_CONTROL_ENCODEDBAR4 ( RBAR_CAP_CONTROL_ENCODEDBAR4 ),
  .RBAR_CAP_CONTROL_ENCODEDBAR5 ( RBAR_CAP_CONTROL_ENCODEDBAR5 ),
  .RBAR_CAP_INDEX0 ( RBAR_CAP_INDEX0 ),
  .RBAR_CAP_INDEX1 ( RBAR_CAP_INDEX1 ),
  .RBAR_CAP_INDEX2 ( RBAR_CAP_INDEX2 ),
  .RBAR_CAP_INDEX3 ( RBAR_CAP_INDEX3 ),
  .RBAR_CAP_INDEX4 ( RBAR_CAP_INDEX4 ),
  .RBAR_CAP_INDEX5 ( RBAR_CAP_INDEX5 ),
  .RBAR_CAP_ON ( RBAR_CAP_ON ),
  .RBAR_CAP_SUP0 ( RBAR_CAP_SUP0 ),
  .RBAR_CAP_SUP1 ( RBAR_CAP_SUP1 ),
  .RBAR_CAP_SUP2 ( RBAR_CAP_SUP2 ),
  .RBAR_CAP_SUP3 ( RBAR_CAP_SUP3 ),
  .RBAR_CAP_SUP4 ( RBAR_CAP_SUP4 ),
  .RBAR_CAP_SUP5 ( RBAR_CAP_SUP5 ),
  .RBAR_NUM ( RBAR_NUM ),
  .TRN_NP_FC ( TRN_NP_FC ),
  .TRN_DW ( TRN_DW ),
  .UR_ATOMIC ( UR_ATOMIC ),
  .UR_PRS_RESPONSE ( UR_PRS_RESPONSE ),
  .USER_CLK2_DIV2 ( USER_CLK2_DIV2 ),
  .VC0_TOTAL_CREDITS_NPD ( VC0_TOTAL_CREDITS_NPD ),
  .LINK_CAP_RSVD_23 ( LINK_CAP_RSVD_23 ),
  .CFG_ECRC_ERR_CPLSTAT ( CFG_ECRC_ERR_CPLSTAT ),
  .DISABLE_ERR_MSG ( DISABLE_ERR_MSG ),
  .DISABLE_LOCKED_FILTER ( DISABLE_LOCKED_FILTER ),
  .DISABLE_PPM_FILTER ( DISABLE_PPM_FILTER ),
  .ENDEND_TLP_PREFIX_FORWARDING_SUPPORTED ( ENDEND_TLP_PREFIX_FORWARDING_SUPPORTED ),
  .INTERRUPT_STAT_AUTO ( INTERRUPT_STAT_AUTO ),
  .MPS_FORCE ( MPS_FORCE ),
  .PM_ASPML0S_TIMEOUT ( PM_ASPML0S_TIMEOUT ),
  .PM_ASPML0S_TIMEOUT_EN ( PM_ASPML0S_TIMEOUT_EN ),
  .PM_ASPML0S_TIMEOUT_FUNC ( PM_ASPML0S_TIMEOUT_FUNC ),
  .PM_ASPM_FASTEXIT ( PM_ASPM_FASTEXIT ),
  .PM_MF ( PM_MF ),
  .RP_AUTO_SPD ( RP_AUTO_SPD ),
  .RP_AUTO_SPD_LOOPCNT ( RP_AUTO_SPD_LOOPCNT ),
  .SIM_VERSION ( SIM_VERSION ),
  .SSL_MESSAGE_AUTO ( SSL_MESSAGE_AUTO ),
  .TECRC_EP_INV ( TECRC_EP_INV ),
  .UR_CFG1 ( UR_CFG1 ),
  .USE_RID_PINS ( USE_RID_PINS ),
  .DEV_CAP2_ENDEND_TLP_PREFIX_SUPPORTED ( DEV_CAP2_ENDEND_TLP_PREFIX_SUPPORTED ),
  .DEV_CAP2_EXTENDED_FMT_FIELD_SUPPORTED ( DEV_CAP2_EXTENDED_FMT_FIELD_SUPPORTED ),
  .DEV_CAP2_LTR_MECHANISM_SUPPORTED ( DEV_CAP2_LTR_MECHANISM_SUPPORTED ),
  .DEV_CAP2_MAX_ENDEND_TLP_PREFIXES ( DEV_CAP2_MAX_ENDEND_TLP_PREFIXES ),
  .DEV_CAP2_NO_RO_ENABLED_PRPR_PASSING ( DEV_CAP2_NO_RO_ENABLED_PRPR_PASSING ),
  .RBAR_CAP_ID ( RBAR_CAP_ID ),
  .RBAR_CAP_NEXTPTR ( RBAR_CAP_NEXTPTR ),
  .RBAR_CAP_VERSION ( RBAR_CAP_VERSION ),
  .PCIE_USE_MODE ( PCIE_USE_MODE ),
  .PCIE_GT_DEVICE ( PCIE_GT_DEVICE ),
  .PCIE_PLL_SEL ( PCIE_PLL_SEL ),
  .PCIE_ASYNC_EN ( PCIE_ASYNC_EN ),
  .PCIE_TXBUF_EN ( PCIE_TXBUF_EN ),
  .PCIE_CHAN_BOND ( PCIE_CHAN_BOND )
  )
axi_pcie_enhanced_core_top_i (
    .pci_exp_txp( pci_exp_txp ),
    .pci_exp_txn( pci_exp_txn ),
    .pci_exp_rxp( pci_exp_rxp ),
    .pci_exp_rxn( pci_exp_rxn ),
    .rx_np_ok( rx_np_ok ),
    .rx_np_req( rx_np_req ),
    .np_cpl_pending( np_cpl_pending ),
    .RP_bridge_en( RP_bridge_en ),
    .s_axis_rw_tdata( s_axis_rw_tdata ),
    .s_axis_rw_tvalid( s_axis_rw_tvalid ),
    .s_axis_rw_tready( s_axis_rw_tready ),
    .s_axis_rw_tstrb( s_axis_rw_tstrb ),
    .s_axis_rw_tlast( s_axis_rw_tlast ),
    .s_axis_rw_tuser( s_axis_rw_tuser ),
    .s_axis_rr_tdata( s_axis_rr_tdata ),
    .s_axis_rr_tvalid( s_axis_rr_tvalid ),
    .s_axis_rr_tready( s_axis_rr_tready ),
    .s_axis_rr_tstrb( s_axis_rr_tstrb ),
    .s_axis_rr_tlast( s_axis_rr_tlast ),
    .s_axis_rr_tuser( s_axis_rr_tuser ),
    .s_axis_cc_tdata( s_axis_cc_tdata ),
    .s_axis_cc_tvalid( s_axis_cc_tvalid ),
    .s_axis_cc_tready( s_axis_cc_tready ),
    .s_axis_cc_tstrb( s_axis_cc_tstrb ),
    .s_axis_cc_tlast( s_axis_cc_tlast ),
    .s_axis_cc_tuser( s_axis_cc_tuser ),
    .m_axis_cw_tdata( m_axis_cw_tdata ),
    .m_axis_cw_tvalid( m_axis_cw_tvalid ),
    .m_axis_cw_tready( m_axis_cw_tready ),
    .m_axis_cw_tstrb( m_axis_cw_tstrb ),
    .m_axis_cw_tlast( m_axis_cw_tlast ),
    .m_axis_cw_tuser( m_axis_cw_tuser ),
    .m_axis_cr_tdata( m_axis_cr_tdata ),
    .m_axis_cr_tvalid( m_axis_cr_tvalid ),
    .m_axis_cr_tready( m_axis_cr_tready ),
    .m_axis_cr_tstrb( m_axis_cr_tstrb ),
    .m_axis_cr_tlast( m_axis_cr_tlast ),
    .m_axis_cr_tuser( m_axis_cr_tuser ),
    .m_axis_rc_tdata( m_axis_rc_tdata ),
    .m_axis_rc_tvalid( m_axis_rc_tvalid ),
    .m_axis_rc_tready( m_axis_rc_tready ),
    .m_axis_rc_tstrb( m_axis_rc_tstrb ),
    .m_axis_rc_tlast( m_axis_rc_tlast ),
    .m_axis_rc_tuser( m_axis_rc_tuser ),
    .s_axi_ctl_awaddr( s_axi_ctl_awaddr ),
    .s_axi_ctl_awvalid( s_axi_ctl_awvalid ),
    .s_axi_ctl_awready( s_axi_ctl_awready ),
    .s_axi_ctl_wdata( s_axi_ctl_wdata ),
    .s_axi_ctl_wstrb( s_axi_ctl_wstrb ),
    .s_axi_ctl_wvalid( s_axi_ctl_wvalid ),
    .s_axi_ctl_wready( s_axi_ctl_wready ),
    .s_axi_ctl_bresp( s_axi_ctl_bresp ),
    .s_axi_ctl_bvalid( s_axi_ctl_bvalid ),
    .s_axi_ctl_bready( s_axi_ctl_bready ),
    .s_axi_ctl_araddr( s_axi_ctl_araddr ),
    .s_axi_ctl_arvalid( s_axi_ctl_arvalid ),
    .s_axi_ctl_arready( s_axi_ctl_arready ),
    .s_axi_ctl_rdata( s_axi_ctl_rdata ),
    .s_axi_ctl_rresp( s_axi_ctl_rresp ),
    .s_axi_ctl_rvalid( s_axi_ctl_rvalid ),
    .s_axi_ctl_rready( s_axi_ctl_rready ),
    .Bus2IP_CS( Bus2IP_CS ),
    .Bus2IP_BE( Bus2IP_BE ),
    .Bus2IP_RNW( Bus2IP_RNW ),
    .Bus2IP_Addr( Bus2IP_Addr ),
    .Bus2IP_Data( Bus2IP_Data ),
    .IP2Bus_RdAck( IP2Bus_RdAck ),
    .IP2Bus_WrAck( IP2Bus_WrAck ),
    .IP2Bus_Data( IP2Bus_Data ),
    .IP2Bus_Error( IP2Bus_Error ),
    .ctl_intr( ctl_intr ),
    .ctl_user_intr( ctl_user_intr ),
    .blk_err_cor( blk_err_cor ),
    .blk_err_ur( blk_err_ur ),
    .blk_err_ecrc( blk_err_ecrc ),
    .blk_err_cpl_timeout( blk_err_cpl_timeout ),
    .blk_err_cpl_abort( blk_err_cpl_abort ),
    .blk_err_cpl_unexpect( blk_err_cpl_unexpect ),
    .blk_err_posted( blk_err_posted ),
    .blk_err_locked( blk_err_locked ),
    .blk_err_tlp_cpl_header( blk_err_tlp_cpl_header ),
    .blk_err_cpl_rdy( blk_err_cpl_rdy ),
    .blk_interrupt( blk_interrupt ),
    .blk_interrupt_rdy( blk_interrupt_rdy ),
    .blk_interrupt_assert( blk_interrupt_assert ),
    .blk_interrupt_di( blk_interrupt_di ),
    .cfg_interrupt_do( cfg_interrupt_do ),
    .blk_interrupt_mmenable( blk_interrupt_mmenable ),
    .blk_interrupt_msienable( blk_interrupt_msienable ),
    .blk_interrupt_msixenable( blk_interrupt_msixenable ),
    .blk_interrupt_msixfm( blk_interrupt_msixfm ),
    .blk_trn_pending( blk_trn_pending ),
    .cfg_pm_send_pme_to( cfg_pm_send_pme_to ),
    .blk_status( blk_status ),
    .blk_command( blk_command ),
    .blk_dstatus( blk_dstatus ),
    .blk_dcommand( blk_dcommand ),
    .blk_lstatus( blk_lstatus ),
    .blk_lcommand( blk_lcommand ),
    .blk_dcommand2( blk_dcommand2 ),
    .blk_pcie_link_state( blk_pcie_link_state ),
    .blk_dsn( blk_dsn ),
    .blk_pmcsr_pme_en( blk_pmcsr_pme_en ),
    .blk_pmcsr_pme_status( blk_pmcsr_pme_status ),
    .blk_pmcsr_powerstate( blk_pmcsr_powerstate ),
    .cfg_msg_received( cfg_msg_received ),
    .blk_msg_data( blk_msg_data ),
    .blk_msg_received_err_cor( blk_msg_received_err_cor ),
    .blk_msg_received_err_non_fatal( blk_msg_received_err_non_fatal ),
    .blk_msg_received_err_fatal( blk_msg_received_err_fatal ),
    .blk_msg_received_pme_to_ack( blk_msg_received_pme_to_ack ),
    .blk_msg_received_assert_inta( blk_msg_received_assert_inta ),
    .blk_msg_received_assert_intb( blk_msg_received_assert_intb ),
    .blk_msg_received_assert_intc( blk_msg_received_assert_intc ),
    .blk_msg_received_assert_intd( blk_msg_received_assert_intd ),
    .blk_msg_received_deassert_inta( blk_msg_received_deassert_inta ),
    .blk_msg_received_deassert_intb( blk_msg_received_deassert_intb ),
    .blk_msg_received_deassert_intc( blk_msg_received_deassert_intc ),
    .blk_msg_received_deassert_intd( blk_msg_received_deassert_intd ),
    .blk_link_up( blk_link_up ),
    .blk_ds_bus_number( blk_ds_bus_number ),
    .blk_ds_device_number( blk_ds_device_number ),
    .blk_to_turnoff( blk_to_turnoff ),
    .blk_turnoff_ok( blk_turnoff_ok ),
    .blk_pm_wake( blk_pm_wake ),
    .blk_bus_number( blk_bus_number ),
    .blk_device_number( blk_device_number ),
    .blk_function_number( blk_function_number ),
    .blk_pl_initial_link_width( blk_pl_initial_link_width ),
    .blk_pl_lane_reversal_mode( blk_pl_lane_reversal_mode ),
    .blk_pl_link_gen2_capable( blk_pl_link_gen2_capable ),
    .blk_pl_link_partner_gen2_supported( blk_pl_link_partner_gen2_supported ),
    .blk_pl_link_upcfg_capable( blk_pl_link_upcfg_capable ),
    .blk_pl_ltssm_state( blk_pl_ltssm_state ),
    .blk_pl_sel_link_rate( blk_pl_sel_link_rate ),
    .blk_pl_sel_link_width( blk_pl_sel_link_width ),
    .blk_pl_upstream_prefer_deemph( blk_pl_upstream_prefer_deemph ),
    .blk_pl_hot_rst( blk_pl_hot_rst ),
    .blk_fc_cpld( blk_fc_cpld ),
    .blk_fc_cplh( blk_fc_cplh ),
    .blk_fc_npd( blk_fc_npd ),
    .blk_fc_nph( blk_fc_nph ),
    .blk_fc_pd( blk_fc_pd ),
    .blk_fc_ph( blk_fc_ph ),
    .blk_fc_sel( blk_fc_sel ),
    .blk_tbuf_av( blk_tbuf_av ),
    .blk_tcfg_req( blk_tcfg_req ),
    .blk_tcfg_gnt( blk_tcfg_gnt ),
    .tx_err_drop( tx_err_drop ),
    .cfg_do( cfg_do ),
    .cfg_rd_wr_done( cfg_rd_wr_done ),
    .cfg_dwaddr( cfg_dwaddr ),
    .cfg_rd_en( cfg_rd_en ),
    .com_sysclk( com_sysclk ),
    .com_sysrst( com_sysrst ),
    .mmcm_lock( mmcm_lock ),
    .com_iclk( com_iclk ),
    .com_cclk( com_cclk ),
    .com_corereset( com_corereset ),
    .PIPE_RXOUTCLK_IN( clk_fab_refclk ),
    .PIPE_PCLK_IN( clk_pclk ),
    .PIPE_RXUSRCLK_IN( clk_rxusrclk ),
    .PIPE_DCLK_IN( clk_dclk ),
    .PIPE_USERCLK1_IN( clk_userclk1 ),
    .PIPE_USERCLK2_IN( clk_userclk2 ),
    .PIPE_OOBCLK_IN( clk_oobclk_in ),
    .PIPE_MMCM_LOCK_IN( clk_mmcm_lock ),
    .PIPE_TXOUTCLK_OUT( clk_txoutclk ),
    .PIPE_RXOUTCLK_OUT( clk_rxoutclk ),
    .PIPE_PCLK_SEL_OUT( clk_pclk_sel ),
    .PIPE_GEN3_OUT( clk_gen3 ),
    .user_clk_out( user_clk_out ),
    .user_reset_out( user_reset_out ),
    .cfg_received_func_lvl_rst( cfg_received_func_lvl_rst ),
    .cfg_err_atomic_egress_blocked( cfg_err_atomic_egress_blocked ),
    .cfg_err_internal_cor( cfg_err_internal_cor ),
    .cfg_err_malformed( cfg_err_malformed ),
    .cfg_err_mc_blocked( cfg_err_mc_blocked ),
    .cfg_err_poisoned( cfg_err_poisoned ),
    .cfg_err_norecovery( cfg_err_norecovery ),
    .cfg_err_acs( cfg_err_acs ),
    .cfg_err_internal_uncor( cfg_err_internal_uncor ),
    .cfg_pm_halt_aspm_l0s( cfg_pm_halt_aspm_l0s ),
    .cfg_pm_halt_aspm_l1( cfg_pm_halt_aspm_l1 ),
    .cfg_pm_force_state_en( cfg_pm_force_state_en ),
    .cfg_pm_force_state( cfg_pm_force_state ),
    .cfg_interrupt_stat( cfg_interrupt_stat ),
    .cfg_pciecap_interrupt_msgnum( cfg_pciecap_interrupt_msgnum ),
    .cfg_bridge_serr_en( cfg_bridge_serr_en ),
    .cfg_slot_control_electromech_il_ctl_pulse( cfg_slot_control_electromech_il_ctl_pulse ),
    .cfg_root_control_syserr_corr_err_en( cfg_root_control_syserr_corr_err_en ),
    .cfg_root_control_syserr_non_fatal_err_en( cfg_root_control_syserr_non_fatal_err_en ),
    .cfg_root_control_syserr_fatal_err_en( cfg_root_control_syserr_fatal_err_en ),
    .cfg_root_control_pme_int_en( cfg_root_control_pme_int_en ),
    .cfg_aer_rooterr_corr_err_reporting_en( cfg_aer_rooterr_corr_err_reporting_en ),
    .cfg_aer_rooterr_non_fatal_err_reporting_en( cfg_aer_rooterr_non_fatal_err_reporting_en ),
    .cfg_aer_rooterr_fatal_err_reporting_en( cfg_aer_rooterr_fatal_err_reporting_en ),
    .cfg_aer_rooterr_corr_err_received( cfg_aer_rooterr_corr_err_received ),
    .cfg_aer_rooterr_non_fatal_err_received( cfg_aer_rooterr_non_fatal_err_received ),
    .cfg_aer_rooterr_fatal_err_received( cfg_aer_rooterr_fatal_err_received ),
    .cfg_msg_received_pm_as_nak( cfg_msg_received_pm_as_nak ),
    .cfg_msg_received_pm_pme( cfg_msg_received_pm_pme ),
    .cfg_msg_received_setslotpowerlimit( cfg_msg_received_setslotpowerlimit ),
    .pl_phy_lnk_up( pl_phy_lnk_up ),
    .pl_tx_pm_state( pl_tx_pm_state ),
    .pl_rx_pm_state( pl_rx_pm_state ),
    .pl_directed_change_done( pl_directed_change_done ),
    .pl_downstream_deemph_source( pl_downstream_deemph_source ),
    .cfg_err_aer_headerlog( cfg_err_aer_headerlog ),
    .cfg_aer_interrupt_msgnum( cfg_aer_interrupt_msgnum ),
    .cfg_err_aer_headerlog_set( cfg_err_aer_headerlog_set ),
    .cfg_aer_ecrc_check_en( cfg_aer_ecrc_check_en ),
    .cfg_aer_ecrc_gen_en( cfg_aer_ecrc_gen_en ),
    .cfg_vc_tcvc_map( cfg_vc_tcvc_map ),
    .config_gen_req (config_gen_req)
  );

endmodule
