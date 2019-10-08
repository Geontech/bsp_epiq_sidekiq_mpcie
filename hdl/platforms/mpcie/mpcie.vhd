--
-- Platform Worker: Sidekiq miniPCIe (Spartan6 LX45T + AD9361)
--
library IEEE; use IEEE.std_logic_1164.all; use ieee.numeric_std.all;
library ocpi; use ocpi.types.all; -- remove this to avoid all ocpi name collisions
library platform; use platform.platform_pkg.all;
library unisim; use unisim.vcomponents.all;
library bsv;
library proc_sys_reset_v3_00_a;
library axi; use axi.axi_pkg.all;
library axi_pcie_wrapper; use axi_pcie_wrapper.axi_pcie_wrapper_pkg.all;
library sdp; use sdp.sdp.all, sdp.sdp_axi.all;

architecture rtl of mpcie_worker is
  --
  signal sys_clkunbuf : std_logic;     -- unbuffered ?00mhz clock
  signal inter_aresetn : std_logic_vector(0 downto 0);
  signal clk           : std_logic;    -- Control Clock
  signal reset         : std_logic;    -- our positive reset
  --
  signal global_in  : axi_global_in_t;
  signal global_out : axi_global_out_t;
  signal msi_in     : msi_in_t;
  signal msi_out    : msi_out_t;
  signal pcie_in    : pcie_in_t;
  signal pcie_out   : pcie_out_t;
  signal m_axi_in   : axi32_s2m_t; --m_axi_in_t;       -- s2m
  signal m_axi_out  : axi32_m2s_t; --m_axi_out_t;      -- m2s
  --signal m_axi_in   : axi32_m2s_t; --m_axi_in_t;       -- s2m
  --signal m_axi_out  : axi32_s2m_t; --m_axi_out_t;      -- m2s
  --
  signal s_axi_in   : axi32_m2s_t; --s_axi_in_t;       -- m2s
  signal s_axi_out  : axi32_s2m_t; --s_axi_out_t;      -- s2m
  --
  signal count            : unsigned(25 downto 0);
  signal my_mpcie_out      : mpcie_out_t;
  signal my_mpcie_out_data : mpcie_out_data_t;
  signal dbg_state        : ulonglong_t;
  signal dbg_state1       : ulonglong_t;
  signal dbg_state2       : ulonglong_t;
  signal dbg_state_r      : ulonglong_t;
  signal dbg_state1_r     : ulonglong_t;
  signal dbg_state2_r     : ulonglong_t;
  -- debug state
  constant ntrace  : natural := to_integer(maxtrace);
  signal mpcie_in_seen     : std_logic;
  signal mpcie_out_seen    : std_logic;
  signal sdp_starting_in  : bool_t;
  signal sdp_starting_out : bool_t;
  signal sdp_header_count_in : unsigned(5 downto 0);
  signal sdp_count_in     : unsigned(5 downto 0);
  signal sdp_header_in    : ulonglong_array_t(0 to ntrace-1);
  signal sdp_data_in      : ulong_array_t(0 to ntrace-1);
  signal sdp_header_count_out : unsigned(5 downto 0);
  signal sdp_count_out     : unsigned(5 downto 0);
  signal sdp_header_out   : ulonglong_array_t(0 to ntrace-1);
  signal sdp_data_out     : ulonglong_array_t(0 to ntrace-1);
  signal sdp_out_status   : ulong_array_t(0 to ntrace-1);
  signal axi_cdcount      : unsigned(5 downto 0);
  signal axi_cacount      : unsigned(5 downto 0);
  signal axi_wdcount      : unsigned(5 downto 0);
  signal axi_rdcount      : unsigned(5 downto 0);
  signal axi_wacount      : unsigned(5 downto 0);
  signal axi_racount      : unsigned(5 downto 0);
  signal axi_cdata        : ulonglong_array_t(0 to ntrace-1);
  signal axi_caddr        : ulonglong_array_t(0 to ntrace-1);
  signal axi_rdata        : ulonglong_array_t(0 to ntrace-1);
  signal axi_raddr        : ulonglong_array_t(0 to ntrace-1);
  signal axi_wdata        : ulonglong_array_t(0 to ntrace-1);
  signal axi_waddr        : ulonglong_array_t(0 to ntrace-1);
  signal sdp_seen_r       : bool_t;
  --
  function fyv(b : std_logic) return std_logic_vector is
	variable v : std_logic_vector(0 downto 0);
  begin
    v(0) := b;
    return v;
  end fyv;

begin

  -- Receive the differential clock, then put it on a clock buffer
  sys_clk_ibufds : IBUFDS port map(I  => sys_clkp,
                                   IB => sys_clkn,
                                   O  => sys_clkunbuf);

  -- pg055 - "Resets"
  sys_resetn : proc_sys_reset_v3_00_a.proc_sys_reset_v3_00_a.proc_sys_reset
    generic map(
      C_EXT_RST_WIDTH            => 1,  --: integer   := 4;
      C_AUX_RST_WIDTH            => 1,  --: integer   := 4;
      C_EXT_RESET_HIGH           => '1',  --: std_logic := '1'; -- High active input
      C_AUX_RESET_HIGH           => '0',  --: std_logic := '1'; -- High active input
      C_NUM_BUS_RST              => 0,  --: integer   := 1;
      C_NUM_PERP_RST             => 0,  --: integer   := 1;
      C_NUM_INTERCONNECT_ARESETN => 1,  --: integer   := 1; -- 3/15/2010
      C_NUM_PERP_ARESETN         => 0  --: integer   := 1  -- 3/15/2010
      )
    port map(
      Slowest_sync_clk     => aux_clk,
      Ext_Reset_In         => '0',
      Aux_Reset_In         => perst_n,
      -- from MDM
      MB_Debug_Sys_Rst     => '0',
      -- from PPC
      Core_Reset_Req_0     => '0',
      Chip_Reset_Req_0     => '0',
      System_Reset_Req_0   => '0',
      Core_Reset_Req_1     => '0',
      Chip_Reset_Req_1     => '0',
      System_Reset_Req_1   => '0',
      -- DCM locked information
      Dcm_locked           => global_out.MMCM_LOCK,
      RstcPPCresetcore_0   => open,
      RstcPPCresetchip_0   => open,
      RstcPPCresetsys_0    => open,
      RstcPPCresetcore_1   => open,
      RstcPPCresetchip_1   => open,
      RstcPPCresetsys_1    => open,
      -- to Microblaze active high reset
      MB_Reset             => open,
      -- active high resets
      Bus_Struct_Reset     => open,
      Peripheral_Reset     => open,
      -- active low resets
      Interconnect_aresetn => inter_aresetn,
      Peripheral_aresetn   => open
      );

  clk                    <= global_out.AXI_ACLK_OUT;  -- Control Clock
  reset                  <= not inter_aresetn(0);
  --
  timebase_out.clk       <= clk;
  timebase_out.reset     <= reset;
  timebase_out.ppsIn     <= ppsExtIn;
  --
  pcie_in.pci_exp_rxp    <= pcie_rxp;
  pcie_in.pci_exp_rxn    <= pcie_rxn;
  pcie_txp               <= pcie_out.pci_exp_txp;
  pcie_txn               <= pcie_out.pci_exp_txn;
  --
  global_in.REFCLK       <= sys_clkunbuf;
  global_in.AXI_ARESETN  <= perst_n;
  global_in.AXI_ACLK     <= global_out.AXI_ACLK_OUT;
  global_in.AXI_CTL_ACLK <= global_out.AXI_CTL_ACLK_OUT;
  --
  -- Instantiate the AXI to PCIe Bridge
  bridge : axi_pcie_wrapper.axi_pcie_wrapper_pkg.axi_pcie_wrapper
    port map(
      global_in  => global_in,
      global_out => global_out,
      msi_in     => msi_in,
      msi_out    => msi_out,
      pcie_in    => pcie_in,
      pcie_out   => pcie_out,
      s_axi_in   => s_axi_in,           -- Data Plane
      s_axi_out  => s_axi_out,          -- Data Plane
      m_axi_in   => m_axi_in,           -- Control Plane
      m_axi_out  => m_axi_out           -- Control Plane
      );
  
  -- Adapt the axi master from the PS to be a CP Master
  cp : axi2cp
    port map(
      clk     => clk,
      reset   => reset,
      axi_in  => m_axi_out,
      axi_out => m_axi_in,
      cp_in   => cp_in,
      cp_out  => cp_out
      );

  -- IGNORE DATA PLANE UNTIL CONTROL PLANE IS WORKING
  -- REQUIRES REWORK OF THE opencpi/hdl/primitives/sdp
  -- HDL LIBRARY TO BE MORE GENERIC
  mpcie_out               <= my_mpcie_out;
  mpcie_out_data          <= my_mpcie_out_data;
  props_out.sdpDropCount <= mpcie_in.dropCount;
  props_out.debug_state  <= dbg_state_r;
  props_out.debug_state1 <= dbg_state1_r;
  props_out.debug_state2 <= dbg_state2_r;

 
  --  dp : sdp2axi_generic
  dp : sdp2axi    
    generic map(ocpi_debug => false,
                sdp_width  => to_integer(sdp_width),
                axi_width  => s_axi_in.W.DATA'length/dword_size)
    port map(   clk          => clk,
                reset        => reset,
                sdp_in       => mpcie_in,
                sdp_in_data  => mpcie_in_data,
                sdp_out      => my_mpcie_out,
                sdp_out_data => my_mpcie_out_data,
                axi_in       => s_axi_out,
                axi_out      => s_axi_in,
                axi_error    => props_out.axi_error,
                dbg_state    => dbg_state,
                dbg_state1   => dbg_state1,
                dbg_state2   => dbg_state2);

  -- Output/readable properties
  props_out.dna             <= (others => '0');
  props_out.nSwitches       <= (others => '0');
  props_out.switches        <= (others => '0');
  props_out.memories_length <= to_ulong(1);
  props_out.memories        <= (others => to_ulong(0));
--  props_out.nLEDs           <= to_ulong(0); --led'length);
  props_out.UUID            <= metadata_in.UUID;
  props_out.romData         <= metadata_in.romData;
  -- props_out.pciId          <= ushort_t(unsigned(pci_id));
  -- Settable properties - drive the leds that are not driven by hardware from the property
  -- led(6 downto 1)           <= std_logic_vector(props_in.leds(6 downto 1));
  -- led(led'left downto 8)    <= (others => '0');

  -- Drive metadata interface
  metadata_out.clk          <= clk;
  metadata_out.romAddr      <= props_in.romAddr;
  metadata_out.romEn        <= props_in.romData_read;
  --
  led <= '1';
  gpio_expander <= '0';

  ------------------------------------------------------------------------------
  -- SDP DEBUG
  ------------------------------------------------------------------------------
  g0: if its(ocpi_debug) generate
    -- If we don't assign the outputs, the "debug overhead" will disappear
    props_out.axi_caddr <= axi_caddr;
    props_out.axi_waddr <= axi_waddr;
    props_out.axi_raddr <= axi_raddr;
    props_out.axi_cdata <= axi_cdata;
    props_out.axi_wdata <= axi_wdata;
    props_out.axi_rdata <= axi_rdata;
    props_out.axi_racount <= resize(axi_racount,32);
    props_out.axi_wacount <= resize(axi_wacount,32);
    props_out.axi_rdcount <= resize(axi_rdcount,32);
    props_out.axi_wdcount <= resize(axi_wdcount,32);
    props_out.sdp_header_count_in <= resize(sdp_header_count_in,32);
    props_out.sdp_count_in <= resize(sdp_count_in,32);
    props_out.sdp_headers_in <= sdp_header_in;
    props_out.sdp_data_in <= sdp_data_in;
    props_out.sdp_header_count_out <= resize(sdp_header_count_out,32);
    props_out.sdp_count_out <= resize(sdp_count_out,32);
    props_out.sdp_headers_out <= sdp_header_out;
    props_out.sdp_data_out <= sdp_data_out;
  end generate g0;

  proc_debug : process(clk)
  begin
    if rising_edge(clk) then
      if reset = '1' then
        dbg_state_r <= (others => '0');
      else
        dbg_state_r <= dbg_state;
        --dbg_state1_r <= dbg_state1;
        --dbg_state2_r <= dbg_state2;
      end if;
    end if;
  end process;
  
--  proc_debug : process(clk)
--  begin
--    if rising_edge(clk) then
--      if reset = '1' then
--        count <= (others => '0');
--        sdp_count_in <= (others => '0');
--        sdp_count_out <= (others => '0');
--        sdp_header_count_in <= (others => '0');
--        sdp_header_count_out <= (others => '0');
--        sdp_header_in  <= (others => (others => '0'));
--        sdp_header_out <= (others => (others => '0'));
--        axi_raddr  <= (others => (others => '0'));
--        axi_waddr  <= (others => (others => '0'));
--        axi_rdata  <= (others => (others => '0'));
--        axi_wdata  <= (others => (others => '0'));
--        axi_wdcount <= (others => '0');
--        axi_rdcount <= (others => '0');
--        axi_wacount <= (others => '0');
--        axi_racount <= (others => '0');
--        axi_cacount <= (others => '0');
--        axi_cdcount <= (others => '0');
--        mpcie_in_seen <= '0';
--        mpcie_out_seen <= '0';
--        sdp_starting_in <= btrue;
--        sdp_starting_out <= btrue;
--        sdp_seen_r <= bfalse;
--      else
--        if its(props_in.sdp_count_in_written) then
--          sdp_count_in <= (others => '0');
--          sdp_count_out <= (others => '0');
--          sdp_header_count_in <= (others => '0');
--          sdp_header_count_out <= (others => '0');
--          axi_wdcount <= (others => '0');
--          axi_rdcount <= (others => '0');
--          axi_wacount <= (others => '0');
--          axi_racount <= (others => '0');
--          axi_cacount <= (others => '0');
--          axi_cdcount <= (others => '0');
--          sdp_seen_r <= bfalse;
--        end if;
--        dbg_state_r <= dbg_state;
--        dbg_state1_r <= dbg_state1;
--        dbg_state2_r <= dbg_state2;
--        if its(my_mpcie_out.sdp.valid) then
--          mpcie_out_seen <= '1';
--        end if;
--        if its(mpcie_in.sdp.valid) then
--          mpcie_in_seen <= '1';
--        end if;
--        if its(my_mpcie_out.sdp.valid) and mpcie_in.sdp.ready then
--          sdp_starting_out <= my_mpcie_out.sdp.eop;
--          if its(sdp_starting_out) then
--            if sdp_header_count_out /= ntrace-1 then
--              sdp_header_out(to_integer(sdp_header_count_out)) <=
--                to_ulonglong(std_logic_vector(count(15 downto 0)) &
--                             std_logic_vector(header2dws(my_mpcie_out.sdp.header)(1)(14 downto 0)) & "0" &
--                             std_logic_vector(header2dws(my_mpcie_out.sdp.header)(0))); 
--              sdp_header_count_out <= sdp_header_count_out + 1;
--            end if;
--          end if;
--          if sdp_count_out /= ntrace-1 then
--            sdp_data_out(to_integer(sdp_count_out)) <=
--              to_ulonglong(std_logic_vector(count(15 downto 0)) &
--                           std_logic_vector(dbg_state(0)(15 downto 0)) &
--                           my_mpcie_out_data(0));
--            sdp_count_out <= sdp_count_out + 1;
--          end if;
--        end if;
--        if its(mpcie_in.sdp.valid) and my_mpcie_out.sdp.ready then
--          sdp_starting_in <= mpcie_in.sdp.eop;
--          if its(sdp_starting_in) then
--            sdp_seen_r <= btrue;
--            if sdp_header_count_in /= ntrace-1 then
--              sdp_header_in(to_integer(sdp_header_count_in)) <=
--                to_ulonglong(std_logic_vector(count(15 downto 0)) &
--                             std_logic_vector(header2dws(mpcie_in.sdp.header)(1)(10 downto 0)) &
--                             std_logic_vector(header2dws(mpcie_in.sdp.header)(0)(31 downto 25)) & "00" &
--                             fyv(mpcie_in.sdp.eop) & -- 27
--                             "00" &
--                             std_logic_vector(header2dws(mpcie_in.sdp.header)(0)(24 downto 0))); 
--              sdp_header_count_in <= sdp_header_count_in + 1;
--            end if;
--          end if;
--          if sdp_count_in /= ntrace-1 then
--            sdp_data_in(to_integer(sdp_count_in)) <= to_ulong(mpcie_in_data(0));
--            sdp_count_in <= sdp_count_in + 1;
--          end if;
--        end if;
--        if its(s_axi_out.R.VALID) and s_axi_in.R.READY and axi_rdcount /= ntrace-1 then
--          axi_rdata(to_integer(axi_rdcount)) <=
----            to_ulonglong(s_axi_out.R.DATA(63 downto 0)); -- &
--            to_ulong(s_axi_out.R.DATA(31 downto 0)); -- &          
----                         "00010010001101000101011001110000");
--          axi_rdcount <= axi_rdcount + 1;
--        end if;
--        if its(s_axi_in.AR.VALID and s_axi_out.AR.READY) and axi_racount /= ntrace-1 then
--          axi_raddr(to_integer(axi_racount)) <=
--            to_ulonglong(--std_logic_vector(count(15 downto 0)) & -- 16
--                         std_logic_vector(dbg_state(0)(31 downto 0)) & -- 28
--                         s_axi_in.AR.LEN & -- 4
--                         s_axi_in.AR.ADDR(27 downto 0)); -- 28
--          axi_racount <= axi_racount + 1;
--        end if;
--        if its(s_axi_in.W.VALID) and s_axi_out.W.READY and axi_wdcount /= ntrace-1 then
--          axi_wdata(to_integer(axi_wdcount)) <=
--            to_ulonglong(
--              std_logic_vector(count(15 downto 0)) & -- 16
--              std_logic_vector(dbg_state1(0)(15 downto 0)) &
--              -- fyv(s_axi_in.W.LAST) & -- 1
--              --s_axi_in.W.STRB & -- 8
--              --std_logic_vector(dbg_state1(31 downto 0)));
----              s_axi_in.W.DATA(63 downto 56) & -- 8
----              s_axi_in.W.DATA(39 downto 32) & -- 8
--              s_axi_in.W.DATA(31 downto 24) & -- 8
--              s_axi_in.W.DATA(7 downto 0)); -- 8
--          axi_wdcount <= axi_wdcount + 1;
--        end if;
--        if its(s_axi_in.AW.VALID and s_axi_out.AW.READY) and axi_wacount /= ntrace-1 then
--          axi_waddr(to_integer(axi_wacount)) <=
--            to_ulonglong(
--              --std_logic_vector(dbg_state(27 downto 4)) & -- 24
--              --                            "0" & s_axi_in.AW.SIZE & -- 4
--              --                            s_axi_in.AW.LEN & -- 4
--              std_logic_vector(count(15 downto 0)) & -- 16
--              "000000000000" &
--              s_axi_in.AW.LEN & -- 4
--              s_axi_in.AW.ADDR); -- 32
--          axi_wacount <= axi_wacount + 1;
--        end if;
--        if its(m_axi_out.W.VALID) and m_axi_in.W.READY and axi_cdcount /= ntrace-1 and sdp_seen_r then
--          axi_cdata(to_integer(axi_cdcount)) <=
--            to_ulonglong(
--              std_logic_vector(count(15 downto 0)) & -- 16
--              std_logic_vector(dbg_state1(0)(15 downto 5)) &
--              fyv(m_axi_out.W.LAST) & -- 1
--              m_axi_out.W.STRB & -- 8
--              m_axi_out.W.DATA);
--   --         s_axi_in.W.DATA(63 downto 56) & -- 8
--   --         s_axi_in.W.DATA(39 downto 32) & -- 8
--   --         s_axi_in.W.DATA(31 downto 24) & -- 8
--   --         s_axi_in.W.DATA(7 downto 0)); -- 8
--          axi_cdcount <= axi_cdcount + 1;
--        end if;
--        if its(m_axi_out.AW.VALID and m_axi_in.AW.READY) and axi_cacount /= ntrace-1 and sdp_seen_r then
--          axi_caddr(to_integer(axi_cacount)) <=
--            to_ulonglong(
--              --std_logic_vector(dbg_state(27 downto 4)) & -- 24
--              --                            "0" & ps_axi_in.AW.SIZE & -- 4
--              --                            s_axi_in.AW.LEN & -- 4
--              std_logic_vector(count(15 downto 0)) & -- 16
--              "000000000000" &
--              m_axi_out.AW.LEN & -- 4
--              m_axi_out.AW.ADDR); -- 32
--          axi_cacount <= axi_cacount + 1;
--        end if;
--        count <= count + 1;
--        --if m_axi_out.ARVALID = '1' and m_axi_out.ARLEN = "0001" then
--        --  seen_burst <= '1';
--        --end if;
--      end if;
--    end if;
--  end process;
  
end rtl;
