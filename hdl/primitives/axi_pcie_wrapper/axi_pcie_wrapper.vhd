--
-- This file is our wrapper around the processing_system7_0 IP as found in
-- EDK/hw/XilinxProcessorIPLib/pcores/axi_pcie_v1_09_a/hdl/vhdl/axi_pcie.vhd
-- using pg055-axi-bridge-pcie_v1.06a.pdf
-- There is no logic here, just providing a simpler interface for the platform worker
-- that uses it.
--
-- (NEEDS WORK)
-- The instantiation parameters of axi_pcie_v1_09_a is based on
-- review of the product guide with a focus of supporting the Sidekiq MiniPCIe
-- platforms which contains a Spartan6 lx45t.
--
-- (NEEDS WORK)
-- We'll need to implement a mechanism to parameterize the setting of the generics
-- to support reconfiguration of the bridge for any FPGA.
--
library IEEE; use IEEE.std_logic_1164.all; use ieee.numeric_std.all;
library ocpi; use ocpi.types.all; -- remove this to avoid all ocpi name collisions
library axi; use axi.axi_pkg.all;
entity axi_pcie_wrapper is
  port(
    global_in      : in  axi_global_in_t;
    global_out     : out axi_global_out_t;
    msi_in         : in  msi_in_t;
    msi_out        : out msi_out_t;
    pcie_in        : in  pcie_in_t;
    pcie_out       : out pcie_out_t;
    s_axi_in       : in  axi32_m2s_t;
    s_axi_out      : out axi32_s2m_t;
    --
    m_axi_in       : in  axi32_s2m_t;
    m_axi_out      : out axi32_m2s_t
    --s_axi_lite_in  : in  s_axi_lite_in_t;
    --s_axi_lite_out : out s_axi_lite_out_t
    );
end entity axi_pcie_wrapper;

architecture rtl of axi_pcie_wrapper is
  
  constant s6_max_idwidth_c : integer                      := 4;
  
  -- Control Plane
  signal hps_h2f_axi_s2m     : axi32_s2m_t;
  signal hps_h2f_axi_m2s     : axi32_m2s_t;
  --
  signal h2faxim2s_aw_ID     : std_logic_vector(s6_max_idwidth_c-1 downto 0);
--  signal h2faxim2s_w_ID      : std_logic_vector(s6_max_idwidth_c-1 downto 0);
  signal h2faxim2s_ar_ID     : std_logic_vector(s6_max_idwidth_c-1 downto 0);
  --
  signal h2faxis2m_r_ID      : std_logic_vector(s6_max_idwidth_c-1 downto 0);
  signal h2faxis2m_b_ID      : std_logic_vector(s6_max_idwidth_c-1 downto 0);

  --
  signal s_axi_in_AW_LEN : std_logic_vector(7 downto 0);
  signal s_axi_in_AR_LEN : std_logic_vector(7 downto 0);
  --
  signal m_axi_out_AW_LEN : std_logic_vector(7 downto 0);
  signal m_axi_out_AR_LEN : std_logic_vector(7 downto 0);
  --
begin

  -- mapping AXI ID to CP ID
  h2faxis2m_b_ID             <= hps_h2f_axi_s2m.b.ID.node(1 downto 0) & hps_h2f_axi_s2m.b.ID.xid(1 downto 0);  --  bid
  h2faxis2m_r_ID             <= hps_h2f_axi_s2m.r.ID.node(1 downto 0) & hps_h2f_axi_s2m.r.ID.xid(1 downto 0);  --  rid
  hps_h2f_axi_m2s.aw.ID.node <= '0' & h2faxim2s_aw_ID(3 downto 2);  --  awid
  hps_h2f_axi_m2s.aw.ID.xid  <= '0' & h2faxim2s_aw_ID(1 downto 0);  --  awid
--  hps_h2f_axi_m2s.w.ID.node  <= '0' & h2faxim2s_w_ID(3 downto 2);   --   wid
--  hps_h2f_axi_m2s.w.ID.xid   <= '0' & h2faxim2s_w_ID(1 downto 0);   --   wid
  hps_h2f_axi_m2s.ar.ID.node <= '0' & h2faxim2s_ar_ID(3 downto 2);  --  arid
  hps_h2f_axi_m2s.ar.ID.xid  <= '0' & h2faxim2s_ar_ID(1 downto 0);  --  arid

  --
  s_axi_in_AW_LEN <= x"0" & s_axi_in.AW.LEN;
  s_axi_in_AR_LEN <= x"0" & s_axi_in.AR.LEN;
  --
  m_axi_out.AW.LEN <= m_axi_out_AW_LEN(3 downto 0);
  m_axi_out.AR.LEN <= m_axi_out_AR_LEN(3 downto 0);
  
  axi_pcie_bridge : entity work.axi_pcie
    generic map(

      -- While these are listed in the pcore source,
      -- they are not listed in the pg055-axi-bridge-pcie_v1.06.a.pdf
      -- Hopefully the defaults shown here will be sufficient.
      C_PCIE_BLK_LOCN               => "0",
      C_XLNX_REF_BOARD              => "NONE",
      C_INSTANCE                    => "AXI_PCIe",
      C_EP_LINK_PARTNER_RCB         => 0,
      --
      -- Bridge
      C_FAMILY                      => "spartan6",
      C_INCLUDE_RC                  => 0,  -- 'Endpoint'      
      C_COMP_TIMEOUT                => 1,  -- 0=50 us, 1=50 ms Try longer first
--      C_INCLUDE_BAROFFSET_REG       => 0,  -- 'Exclude' regs for high-order bits
      C_INCLUDE_BAROFFSET_REG       => 1,  -- 'Include' regs for high-order
                                           -- address bits
      C_S_AXI_SUPPORTS_NARROW_BURST => 0,  -- 'Unsupported' ('Supported'
                                           -- results in build errors due to
                                           -- missing 'axi_upsizer' module)
--      C_AXIBAR_NUM                  => 1,
      C_AXIBAR_NUM                  => 2,  -- BAR_0 & BAR_1 enabled
      C_AXIBAR2PCIEBAR_0            => x"0000_0000",
      C_AXIBAR2PCIEBAR_1            => x"8000_0000",
      C_AXIBAR2PCIEBAR_2            => x"0000_0000",
      C_AXIBAR2PCIEBAR_3            => x"0000_0000",
      C_AXIBAR2PCIEBAR_4            => x"0000_0000",
      C_AXIBAR2PCIEBAR_5            => x"0000_0000",
      C_AXIBAR_AS_0                 => 0,
      C_AXIBAR_AS_1                 => 0,
      C_AXIBAR_AS_2                 => 0,
      C_AXIBAR_AS_3                 => 0,
      C_AXIBAR_AS_4                 => 0,
      C_AXIBAR_AS_5                 => 0,
      --C_AXIBAR_0                    => x"FFFF_FFFF",
      --C_AXIBAR_HIGHADDR_0           => x"0000_0000",
      --C_AXIBAR_1                    => x"FFFF_FFFF",
      --C_AXIBAR_HIGHADDR_1           => x"0000_0000",
      C_AXIBAR_0                    => x"0000_0000",
      C_AXIBAR_HIGHADDR_0           => x"7FFF_FFFF",
      C_AXIBAR_1                    => x"8000_0000",
      C_AXIBAR_HIGHADDR_1           => x"FFFF_FFFF",
      C_AXIBAR_2                    => x"FFFF_FFFF",
      C_AXIBAR_HIGHADDR_2           => x"0000_0000",
      C_AXIBAR_3                    => x"FFFF_FFFF",
      C_AXIBAR_HIGHADDR_3           => x"0000_0000",
      C_AXIBAR_4                    => x"FFFF_FFFF",
      C_AXIBAR_HIGHADDR_4           => x"0000_0000",
      C_AXIBAR_5                    => x"FFFF_FFFF",
      C_AXIBAR_HIGHADDR_5           => x"0000_0000",
      -- Memory Mapped AXI4
      C_M_AXI_DATA_WIDTH            => 32,          -- 32b Spartan6
      C_M_AXI_ADDR_WIDTH            => 32,
      C_S_AXI_ID_WIDTH              => 4,
      C_S_AXI_DATA_WIDTH            => 32,          -- 32b Spartan6
      C_S_AXI_ADDR_WIDTH            => 32,
      -- AXI4-Lite
      C_BASEADDR                    => x"FFFF_FFFF",
      C_HIGHADDR                    => x"0000_0000",
      -- Core for PCIe Configuration
      C_NO_OF_LANES                 => 1,
      C_DEVICE_ID                   => x"4243",
      C_VENDOR_ID                   => x"10EE",
      C_CLASS_CODE                  => x"050000",
      C_REV_ID                      => x"02",
      C_SUBSYSTEM_ID                => x"0007",
      C_SUBSYSTEM_VENDOR_ID         => x"10EE",
      C_PCIE_USE_MODE               => "1.0", -- N/A for Spartan6
      C_PCIE_CAP_SLOT_IMPLEMENTED   => 0,  -- N/A for 'Endpoint'
      C_REF_CLK_FREQ                => 0,  -- first try 100 MHz
      -- 0 - 100 MHz, 1 - 125 MHz, 2 - 250 MHz(N/A for Spartan6)
      C_NUM_MSI_REQ                 => 0,
      C_PCIEBAR_NUM                 => 2,  -- BAR_0 & BAR_1 enabled
      C_PCIEBAR_AS                  => 0,  -- three 32b PCIEBAR address apertures
      C_PCIEBAR_LEN_0               => 26, -- 64MB for 64 workers
      C_PCIEBAR2AXIBAR_0            => x"00000000",
      C_PCIEBAR2AXIBAR_0_SEC        => 1,
      C_PCIEBAR_LEN_1               => 20, -- 1MB
      C_PCIEBAR2AXIBAR_1            => x"00000000",
      C_PCIEBAR2AXIBAR_1_SEC        => 1,
      C_PCIEBAR_LEN_2               => 16,
      C_PCIEBAR2AXIBAR_2            => x"00000000",
      C_PCIEBAR2AXIBAR_2_SEC        => 1,
      --
      C_MAX_LINK_SPEED              => 0,  -- 0 = 2.5 GT/s (Spartan6), 1 = 5.0 GT/s
      C_INTERRUPT_PIN               => 0   -- Not used
      )
  port map (

    -- PCI Express (pci_exp) Interface
    -- Tx
    pci_exp_txp => pcie_out.pci_exp_txp,
    pci_exp_txn => pcie_out.pci_exp_txn,
    -- Rx
    pci_exp_rxp => pcie_in.pci_exp_rxp,
    pci_exp_rxn => pcie_in.pci_exp_rxn,

    -- AXI Global
    REFCLK            => global_in.REFCLK,
    axi_aclk          => global_in.AXI_ACLK,  -- AXI clock
    axi_aresetn       => global_in.AXI_ARESETN,  -- AXI active low synchronous reset
    axi_aclk_out      => global_out.AXI_ACLK_OUT,  -- PCIe clock for AXI clock
    axi_ctl_aclk      => global_in.AXI_CTL_ACLK,  -- AXI LITE clock
    axi_ctl_aclk_out  => global_out.AXI_CTL_ACLK_OUT,  -- PCIe clock for AXI LITE clock
    mmcm_lock         => global_out.MMCM_LOCK,  -- MMCM lock signal output
    interrupt_out     => global_out.INTERRUPT_OUT,  -- active high interrupt out
    INTX_MSI_Request  => msi_in.INTX_MSI_Request,  -- Legacy interrupt/initiate MSI (Endpoint only)
    INTX_MSI_Grant    => msi_out.INTX_MSI_Grant,  -- Legacy interrupt/MSI Grant signal (Endpoint only)
    MSI_enable        => msi_out.MSI_enable,  -- 1 = MSI, 0 = INTX
    MSI_Vector_Num    => msi_in.MSI_Vector_Num,  
    MSI_Vector_Width  => msi_out.MSI_Vector_Width,
    --
    -- AXI Slave Write Address Channel
--    s_axi_awid        => s_axi_in.AW.ID,
    s_axi_awid        => h2faxim2s_aw_ID,
    s_axi_awaddr      => s_axi_in.AW.ADDR,
    s_axi_awregion    => s_axi_in.AW.REGION,
--    s_axi_awlen       => s_axi_in.AW.LEN,
    s_axi_awlen       => s_axi_in_AW_LEN,    
    s_axi_awsize      => s_axi_in.AW.SIZE,
    s_axi_awburst     => s_axi_in.AW.BURST,
    s_axi_awvalid     => s_axi_in.AW.VALID,
    s_axi_awready     => s_axi_out.AW.READY,
    --
    -- AXI Slave Write Data Channel
    s_axi_wdata       => s_axi_in.W.DATA,
    s_axi_wstrb       => s_axi_in.W.STRB,
    s_axi_wlast       => s_axi_in.W.LAST,
    s_axi_wvalid      => s_axi_in.W.VALID,
    s_axi_wready      => s_axi_out.W.READY,
    --
    -- AXI Slave Write Response Channel
--    s_axi_bid         => s_axi_out.B.ID,
    s_axi_bid         => h2faxis2m_b_ID,    
    s_axi_bresp       => s_axi_out.B.RESP,
    s_axi_bvalid      => s_axi_out.B.VALID,
    s_axi_bready      => s_axi_in.B.READY,
    --
    -- AXI Slave Read Address Channel
--    s_axi_arid        => s_axi_in.AR.ID,
    s_axi_arid        => h2faxim2s_ar_ID,
    s_axi_araddr      => s_axi_in.AR.ADDR,
    s_axi_arregion    => s_axi_in.AR.REGION,
--    s_axi_arlen       => s_axi_in.AR.LEN,
    s_axi_arlen       => s_axi_in_AR_LEN,
    s_axi_arsize      => s_axi_in.AR.SIZE,
    s_axi_arburst     => s_axi_in.AR.BURST,
    s_axi_arvalid     => s_axi_in.AR.VALID,
    s_axi_arready     => s_axi_out.AR.READY,
    --
    -- AXI Slave Read Data Channel
--    s_axi_rid         => s_axi_out.R.ID,
    s_axi_rid         => h2faxis2m_r_ID, 
    s_axi_rdata       => s_axi_out.R.DATA,
    s_axi_rresp       => s_axi_out.R.RESP,
    s_axi_rlast       => s_axi_out.R.LAST,
    s_axi_rvalid      => s_axi_out.R.VALID,
    s_axi_rready      => s_axi_in.R.READY,
    --
    -- AXI Master Write Address Channel
    m_axi_awaddr      => m_axi_out.AW.ADDR,
--    m_axi_awlen       => m_axi_out.AW.LEN,
    m_axi_awlen       => m_axi_out_AW_LEN,    
    m_axi_awsize      => m_axi_out.AW.SIZE,
    m_axi_awburst     => m_axi_out.AW.BURST,
    m_axi_awprot      => m_axi_out.AW.PROT,
    m_axi_awvalid     => m_axi_out.AW.VALID,
    m_axi_awready     => m_axi_in.AW.READY,
    --m_axi_awid              : out std_logic_vector(C_M_AXI_THREAD_ID_WIDTH-1 downto 0);
    m_axi_awlock      => m_axi_out.AW.LOCK(0),  -- not listed in pg055-axi-bridge-pcie_v1.06.a.pdf    
    m_axi_awcache     => m_axi_out.AW.CACHE,  -- not listed in pg055-axi-bridge-pcie_v1.06.a.pdf    
    --
    -- AXI Master Write Data Channel
    m_axi_wdata       => m_axi_out.W.DATA,
    m_axi_wstrb       => m_axi_out.W.STRB,
    m_axi_wlast       => m_axi_out.W.LAST,
    m_axi_wvalid      => m_axi_out.W.VALID,
    m_axi_wready      => m_axi_in.W.READY,
    --
    -- AXI Master Write Response Channel
    m_axi_bresp       => m_axi_in.B.RESP,
    m_axi_bvalid      => m_axi_in.B.VALID,
    m_axi_bready      => m_axi_out.B.READY,
    --
    -- AXI Master Read Address Channel
    --m_axi_arid              : out std_logic_vector(C_M_AXI_THREAD_ID_WIDTH-1 downto 0);
    m_axi_araddr      => m_axi_out.AR.ADDR,
--    m_axi_arlen       => m_axi_out.AR.LEN,
    m_axi_arlen       => m_axi_out_AR_LEN,    
    m_axi_arsize      => m_axi_out.AR.SIZE,
    m_axi_arburst     => m_axi_out.AR.BURST,
    m_axi_arprot      => m_axi_out.AR.PROT,
    m_axi_arvalid     => m_axi_out.AR.VALID,
    m_axi_arready     => m_axi_in.AR.READY,
    m_axi_arlock      => m_axi_out.AR.LOCK(0),  -- not listed in pg055-axi-bridge-pcie_v1.06.a.pdf
    m_axi_arcache     => m_axi_out.AR.CACHE,  -- not listed in pg055-axi-bridge-pcie_v1.06.a.pdf
    --
    -- AXI Master Read Data Channel
    m_axi_rdata       => m_axi_in.R.DATA,
    m_axi_rresp       => m_axi_in.R.RESP,
    m_axi_rlast       => m_axi_in.R.LAST,
    m_axi_rvalid      => m_axi_in.R.VALID,
    m_axi_rready      => m_axi_out.R.READY,
    --
    --
    -- AXI -Lite Interface - CFG Block
    s_axi_ctl_awaddr  => (others => '0'),  --: in  std_logic_vector(31 downto 0); -- AXI Lite Write address
    s_axi_ctl_awvalid => '0',  --: in  std_logic;                     -- AXI Lite Write Address Valid
    s_axi_ctl_awready => open,  --: out std_logic;                     -- AXI Lite Write Address Core ready
    s_axi_ctl_wdata   => (others => '0'),  --: in  std_logic_vector(31 downto 0); -- AXI Lite Write Data
    s_axi_ctl_wstrb   => (others => '0'),  --: in  std_logic_vector(3 downto 0);  -- AXI Lite Write Data strobe
    s_axi_ctl_wvalid  => '0',  --: in  std_logic;                     -- AXI Lite Write data Valid
    s_axi_ctl_wready  => open,  --: out std_logic;                     -- AXI Lite Write Data Core ready
    s_axi_ctl_bresp   => open,  --: out std_logic_vector(1 downto 0);  -- AXI Lite Write Data strobe
    s_axi_ctl_bvalid  => open,  --: out std_logic;                     -- AXI Lite Write data Valid
    s_axi_ctl_bready  => '0',  --: in  std_logic;                     -- AXI Lite Write Data Core ready

    s_axi_ctl_araddr  => (others => '0'),  --: in  std_logic_vector(31 downto 0); -- AXI Lite Read address
    s_axi_ctl_arvalid => '0',  --: in  std_logic;                     -- AXI Lite Read Address Valid
    s_axi_ctl_arready => open,  --: out std_logic;                     -- AXI Lite Read Address Core ready
    s_axi_ctl_rdata   => open,  --: out std_logic_vector(31 downto 0); -- AXI Lite Read Data
    s_axi_ctl_rresp   => open,  --: out std_logic_vector(1 downto 0);  -- AXI Lite Read Data strobe
    s_axi_ctl_rvalid  => open,  --: out std_logic;                     -- AXI Lite Read data Valid
    s_axi_ctl_rready  => '0'  --: in  std_logic                     -- AXI Lite Read Data Core ready
    );

end rtl;
