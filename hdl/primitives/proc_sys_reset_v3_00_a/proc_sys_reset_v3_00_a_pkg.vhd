library ieee;
use ieee.std_logic_1164.all;
library unisim;
use unisim.vcomponents.all;

package proc_sys_reset_v3_00_a is
  
component proc_sys_reset
  generic (
    C_EXT_RST_WIDTH          : integer   := 4;
    C_AUX_RST_WIDTH          : integer   := 4;
    C_EXT_RESET_HIGH         : std_logic := '1'; -- High active input
    C_AUX_RESET_HIGH         : std_logic := '1'; -- High active input
    C_NUM_BUS_RST            : integer   := 1;
    C_NUM_PERP_RST           : integer   := 1;
    C_NUM_INTERCONNECT_ARESETN : integer   := 1; -- 3/15/2010
    C_NUM_PERP_ARESETN         : integer   := 1  -- 3/15/2010
  );
  port (
    Slowest_sync_clk     : in  std_logic;
    Ext_Reset_In         : in  std_logic;
    Aux_Reset_In         : in  std_logic;
    -- from MDM
    MB_Debug_Sys_Rst     : in  std_logic;
    -- from PPC
    Core_Reset_Req_0     : in  std_logic;
    Chip_Reset_Req_0     : in  std_logic;
    System_Reset_Req_0   : in  std_logic;
    Core_Reset_Req_1     : in  std_logic;
    Chip_Reset_Req_1     : in  std_logic;
    System_Reset_Req_1   : in  std_logic;
    -- DCM locked information
    Dcm_locked           : in  std_logic := '1';
    RstcPPCresetcore_0   : out std_logic := '0';
    RstcPPCresetchip_0   : out std_logic := '0';
    RstcPPCresetsys_0    : out std_logic := '0';
    RstcPPCresetcore_1   : out std_logic := '0';
    RstcPPCresetchip_1   : out std_logic := '0';
    RstcPPCresetsys_1    : out std_logic := '0';
    -- to Microblaze active high reset
    MB_Reset             : out std_logic := '0';
    -- active high resets
    Bus_Struct_Reset     : out std_logic_vector(0 to C_NUM_BUS_RST - 1)
                                                           := (others => '0');
    Peripheral_Reset     : out std_logic_vector(0 to C_NUM_PERP_RST - 1)
                                                           := (others => '0');
    -- active low resets
    Interconnect_aresetn : out
                          std_logic_vector(0 to (C_NUM_INTERCONNECT_ARESETN-1))
                                                            := (others => '1');
    Peripheral_aresetn   : out std_logic_vector(0 to (C_NUM_PERP_ARESETN-1))
                                                             := (others => '1')
   );
end component proc_sys_reset;

--component upcnt_n
--  generic(
--    C_SIZE : integer
--    );
--  port(
--    Data   : in  std_logic_vector (C_SIZE-1 downto 0);
--    Cnt_en : in  std_logic;
--    Load   : in  std_logic;
--    Clr    : in  std_logic;
--    Clk    : in  std_logic;
--    Qout   : out std_logic_vector (C_SIZE-1 downto 0)
--    );
--end component upcnt_n;

--component sequence
--  port(
--    Lpf_reset        : in  std_logic;
--    System_Reset_Req : in  std_logic;
--    Chip_Reset_Req   : in  std_logic;
--    Slowest_Sync_Clk : in  std_logic;
--    Bsr_out          : out std_logic;
--    Pr_out           : out std_logic;
--    Core_out         : out std_logic;
--    Chip_out         : out std_logic;
--    Sys_out          : out std_logic;
--    MB_out           : out std_logic
--    );
--end component sequence;

--component lpf
--  generic(
--    C_EXT_RST_WIDTH  : integer;
--    C_AUX_RST_WIDTH  : integer;
--    C_EXT_RESET_HIGH : std_logic;
--    C_AUX_RESET_HIGH : std_logic
--    );
--  port(
--    MB_Debug_Sys_Rst       : in  std_logic;
--    Dcm_locked             : in  std_logic;
--    External_System_Reset  : in  std_logic;
--    Auxiliary_System_Reset : in  std_logic;
--    Slowest_Sync_Clk       : in  std_logic;
--    Lpf_reset              : out std_logic
--    );
--end component lpf;

end package proc_sys_reset_v3_00_a; 
