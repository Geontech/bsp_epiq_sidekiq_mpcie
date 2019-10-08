-------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor: Xilinx
-- \   \   \/     Version : 1.7
--  \   \         Application : Spartan-6 FPGA GTP Transceiver Wizard
--  /   /         Filename : gtpa1_dual_wrapper.vhd
-- /___/   /\     Timestamp :
-- \   \  /  \
--  \___\/\___\
--
--
-- Module GTPA1_DUAL_WRAPPER (a GTP Wrapper)
-- Generated by Xilinx Spartan-6 FPGA GTP Transceiver Wizard
--
--
-- (c) Copyright 2009 Xilinx, Inc. All rights reserved.
--
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
--
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
--
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
--
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;


--***************************** Entity Declaration ****************************

entity GTPA1_DUAL_WRAPPER is
generic
(
    -- Simulation attributes
    WRAPPER_SIM_GTPRESET_SPEEDUP    : integer   := 0; -- Set to 1 to speed up sim reset
    WRAPPER_CLK25_DIVIDER_0         : integer   := 4;
    WRAPPER_CLK25_DIVIDER_1         : integer   := 4;
    WRAPPER_PLL_DIVSEL_FB_0         : integer   := 5;
    WRAPPER_PLL_DIVSEL_FB_1         : integer   := 5;
    WRAPPER_PLL_DIVSEL_REF_0        : integer   := 2;
    WRAPPER_PLL_DIVSEL_REF_1        : integer   := 2;
    WRAPPER_SIMULATION              : integer   := 0  -- Set to 1 for simulation
);
port
(

    --_________________________________________________________________________
    --_________________________________________________________________________
    --TILE0  (X0_Y0)

    ------------------------ Loopback and Powerdown Ports ----------------------
    TILE0_RXPOWERDOWN0_IN                   : in   std_logic_vector(1 downto 0);
    TILE0_RXPOWERDOWN1_IN                   : in   std_logic_vector(1 downto 0);
    TILE0_TXPOWERDOWN0_IN                   : in   std_logic_vector(1 downto 0);
    TILE0_TXPOWERDOWN1_IN                   : in   std_logic_vector(1 downto 0);
    --------------------------------- PLL Ports --------------------------------
    TILE0_CLK00_IN                          : in   std_logic;
    TILE0_CLK01_IN                          : in   std_logic;
    TILE0_GTPRESET0_IN                      : in   std_logic;
    TILE0_GTPRESET1_IN                      : in   std_logic;
    TILE0_PLLLKDET0_OUT                     : out  std_logic;
    TILE0_PLLLKDET1_OUT                     : out  std_logic;
    TILE0_RESETDONE0_OUT                    : out  std_logic;
    TILE0_RESETDONE1_OUT                    : out  std_logic;
    ----------------------- Receive Ports - 8b10b Decoder ----------------------
    TILE0_RXCHARISK0_OUT                    : out  std_logic_vector(1 downto 0);
    TILE0_RXCHARISK1_OUT                    : out  std_logic_vector(1 downto 0);
    TILE0_RXDISPERR0_OUT                    : out  std_logic_vector(1 downto 0);
    TILE0_RXDISPERR1_OUT                    : out  std_logic_vector(1 downto 0);
    TILE0_RXNOTINTABLE0_OUT                 : out  std_logic_vector(1 downto 0);
    TILE0_RXNOTINTABLE1_OUT                 : out  std_logic_vector(1 downto 0);
    ---------------------- Receive Ports - Clock Correction --------------------
    TILE0_RXCLKCORCNT0_OUT                  : out  std_logic_vector(2 downto 0);
    TILE0_RXCLKCORCNT1_OUT                  : out  std_logic_vector(2 downto 0);
    --------------- Receive Ports - Comma Detection and Alignment --------------
    TILE0_RXENMCOMMAALIGN0_IN               : in   std_logic;
    TILE0_RXENMCOMMAALIGN1_IN               : in   std_logic;
    TILE0_RXENPCOMMAALIGN0_IN               : in   std_logic;
    TILE0_RXENPCOMMAALIGN1_IN               : in   std_logic;
    ------------------- Receive Ports - RX Data Path interface -----------------
    TILE0_RXDATA0_OUT                       : out  std_logic_vector(15 downto 0);
    TILE0_RXDATA1_OUT                       : out  std_logic_vector(15 downto 0);
    TILE0_RXRESET0_IN                       : in   std_logic;
    TILE0_RXRESET1_IN                       : in   std_logic;
    TILE0_RXUSRCLK0_IN                      : in   std_logic;
    TILE0_RXUSRCLK1_IN                      : in   std_logic;
    TILE0_RXUSRCLK20_IN                     : in   std_logic;
    TILE0_RXUSRCLK21_IN                     : in   std_logic;
    ------- Receive Ports - RX Driver,OOB signalling,Coupling and Eq.,CDR ------
    TILE0_GATERXELECIDLE0_IN                : in   std_logic;
    TILE0_GATERXELECIDLE1_IN                : in   std_logic;
    TILE0_IGNORESIGDET0_IN                  : in   std_logic;
    TILE0_IGNORESIGDET1_IN                  : in   std_logic;
    TILE0_RXELECIDLE0_OUT                   : out  std_logic;
    TILE0_RXELECIDLE1_OUT                   : out  std_logic;
    TILE0_RXN0_IN                           : in   std_logic;
    TILE0_RXN1_IN                           : in   std_logic;
    TILE0_RXP0_IN                           : in   std_logic;
    TILE0_RXP1_IN                           : in   std_logic;
    ----------- Receive Ports - RX Elastic Buffer and Phase Alignment ----------
    TILE0_RXSTATUS0_OUT                     : out  std_logic_vector(2 downto 0);
    TILE0_RXSTATUS1_OUT                     : out  std_logic_vector(2 downto 0);
    -------------- Receive Ports - RX Pipe Control for PCI Express -------------
    TILE0_PHYSTATUS0_OUT                    : out  std_logic;
    TILE0_PHYSTATUS1_OUT                    : out  std_logic;
    TILE0_RXVALID0_OUT                      : out  std_logic;
    TILE0_RXVALID1_OUT                      : out  std_logic;
    -------------------- Receive Ports - RX Polarity Control -------------------
    TILE0_RXPOLARITY0_IN                    : in   std_logic;
    TILE0_RXPOLARITY1_IN                    : in   std_logic;
    ---------------------------- TX/RX Datapath Ports --------------------------
    TILE0_GTPCLKOUT0_OUT                    : out  std_logic_vector(1 downto 0);
    TILE0_GTPCLKOUT1_OUT                    : out  std_logic_vector(1 downto 0);
    ------------------- Transmit Ports - 8b10b Encoder Control -----------------
    TILE0_TXCHARDISPMODE0_IN                : in   std_logic_vector(1 downto 0);
    TILE0_TXCHARDISPMODE1_IN                : in   std_logic_vector(1 downto 0);
    TILE0_TXCHARISK0_IN                     : in   std_logic_vector(1 downto 0);
    TILE0_TXCHARISK1_IN                     : in   std_logic_vector(1 downto 0);
    ------------------ Transmit Ports - TX Data Path interface -----------------
    TILE0_TXDATA0_IN                        : in   std_logic_vector(15 downto 0);
    TILE0_TXDATA1_IN                        : in   std_logic_vector(15 downto 0);
    TILE0_TXUSRCLK0_IN                      : in   std_logic;
    TILE0_TXUSRCLK1_IN                      : in   std_logic;
    TILE0_TXUSRCLK20_IN                     : in   std_logic;
    TILE0_TXUSRCLK21_IN                     : in   std_logic;
    --------------- Transmit Ports - TX Driver and OOB signalling --------------
    TILE0_TXN0_OUT                          : out  std_logic;
    TILE0_TXN1_OUT                          : out  std_logic;
    TILE0_TXP0_OUT                          : out  std_logic;
    TILE0_TXP1_OUT                          : out  std_logic;
    ----------------- Transmit Ports - TX Ports for PCI Express ----------------
    TILE0_TXDETECTRX0_IN                    : in   std_logic;
    TILE0_TXDETECTRX1_IN                    : in   std_logic;
    TILE0_TXELECIDLE0_IN                    : in   std_logic;
    TILE0_TXELECIDLE1_IN                    : in   std_logic


);


end GTPA1_DUAL_WRAPPER;

architecture RTL of GTPA1_DUAL_WRAPPER is
  attribute CORE_GENERATION_INFO           : string;
  attribute CORE_GENERATION_INFO of RTL    : architecture is "GTPA1_DUAL_WRAPPER,s6_gtpwizard_v1_4,{gtp0_protocol_file=pcie,gtp1_protocol_file=Use_GTP0_settings}";

--***************************** Signal Declarations *****************************

    -- ground and tied_to_vcc_i signals
    signal  tied_to_ground_i                :   std_logic;
    signal  tied_to_ground_vec_i            :   std_logic_vector(63 downto 0);
    signal  tied_to_vcc_i                   :   std_logic;

    signal  tile0_plllkdet0_i       :   std_logic;
    signal  tile0_plllkdet1_i       :   std_logic;

    signal  tile0_plllkdet0_i2       :   std_logic;
    signal  tile0_plllkdet1_i2       :   std_logic;


--*************************** Component Declarations **************************

component GTPA1_DUAL_WRAPPER_TILE
generic
(
    -- Simulation attributes
    TILE_SIM_GTPRESET_SPEEDUP    : integer   := 0; -- Set to 1 to speed up sim reset
    TILE_CLK25_DIVIDER_0         : integer   := 4;
    TILE_CLK25_DIVIDER_1         : integer   := 4;
    TILE_PLL_DIVSEL_FB_0         : integer   := 5;
    TILE_PLL_DIVSEL_FB_1         : integer   := 5;
    TILE_PLL_DIVSEL_REF_0        : integer   := 2;
    TILE_PLL_DIVSEL_REF_1        : integer   := 2;
    --
    TILE_PLL_SOURCE_0            : string    := "PLL0";
    TILE_PLL_SOURCE_1            : string    := "PLL1"
);
port
(
    ------------------------ Loopback and Powerdown Ports ----------------------
    RXPOWERDOWN0_IN                         : in   std_logic_vector(1 downto 0);
    RXPOWERDOWN1_IN                         : in   std_logic_vector(1 downto 0);
    TXPOWERDOWN0_IN                         : in   std_logic_vector(1 downto 0);
    TXPOWERDOWN1_IN                         : in   std_logic_vector(1 downto 0);
    --------------------------------- PLL Ports --------------------------------
    CLK00_IN                                : in   std_logic;
    CLK01_IN                                : in   std_logic;
    GTPRESET0_IN                            : in   std_logic;
    GTPRESET1_IN                            : in   std_logic;
    PLLLKDET0_OUT                           : out  std_logic;
    PLLLKDET1_OUT                           : out  std_logic;
    RESETDONE0_OUT                          : out  std_logic;
    RESETDONE1_OUT                          : out  std_logic;
    ----------------------- Receive Ports - 8b10b Decoder ----------------------
    RXCHARISK0_OUT                          : out  std_logic_vector(1 downto 0);
    RXCHARISK1_OUT                          : out  std_logic_vector(1 downto 0);
    RXDISPERR0_OUT                          : out  std_logic_vector(1 downto 0);
    RXDISPERR1_OUT                          : out  std_logic_vector(1 downto 0);
    RXNOTINTABLE0_OUT                       : out  std_logic_vector(1 downto 0);
    RXNOTINTABLE1_OUT                       : out  std_logic_vector(1 downto 0);
    ---------------------- Receive Ports - Clock Correction --------------------
    RXCLKCORCNT0_OUT                        : out  std_logic_vector(2 downto 0);
    RXCLKCORCNT1_OUT                        : out  std_logic_vector(2 downto 0);
    --------------- Receive Ports - Comma Detection and Alignment --------------
    RXENMCOMMAALIGN0_IN                     : in   std_logic;
    RXENMCOMMAALIGN1_IN                     : in   std_logic;
    RXENPCOMMAALIGN0_IN                     : in   std_logic;
    RXENPCOMMAALIGN1_IN                     : in   std_logic;
    ------------------- Receive Ports - RX Data Path interface -----------------
    RXDATA0_OUT                             : out  std_logic_vector(15 downto 0);
    RXDATA1_OUT                             : out  std_logic_vector(15 downto 0);
    RXRESET0_IN                             : in   std_logic;
    RXRESET1_IN                             : in   std_logic;
    RXUSRCLK0_IN                            : in   std_logic;
    RXUSRCLK1_IN                            : in   std_logic;
    RXUSRCLK20_IN                           : in   std_logic;
    RXUSRCLK21_IN                           : in   std_logic;
    ------- Receive Ports - RX Driver,OOB signalling,Coupling and Eq.,CDR ------
    GATERXELECIDLE0_IN                      : in   std_logic;
    GATERXELECIDLE1_IN                      : in   std_logic;
    IGNORESIGDET0_IN                        : in   std_logic;
    IGNORESIGDET1_IN                        : in   std_logic;
    RXELECIDLE0_OUT                         : out  std_logic;
    RXELECIDLE1_OUT                         : out  std_logic;
    RXN0_IN                                 : in   std_logic;
    RXN1_IN                                 : in   std_logic;
    RXP0_IN                                 : in   std_logic;
    RXP1_IN                                 : in   std_logic;
    ----------- Receive Ports - RX Elastic Buffer and Phase Alignment ----------
    RXSTATUS0_OUT                           : out  std_logic_vector(2 downto 0);
    RXSTATUS1_OUT                           : out  std_logic_vector(2 downto 0);
    -------------- Receive Ports - RX Pipe Control for PCI Express -------------
    PHYSTATUS0_OUT                          : out  std_logic;
    PHYSTATUS1_OUT                          : out  std_logic;
    RXVALID0_OUT                            : out  std_logic;
    RXVALID1_OUT                            : out  std_logic;
    -------------------- Receive Ports - RX Polarity Control -------------------
    RXPOLARITY0_IN                          : in   std_logic;
    RXPOLARITY1_IN                          : in   std_logic;
    ---------------------------- TX/RX Datapath Ports --------------------------
    GTPCLKOUT0_OUT                          : out  std_logic_vector(1 downto 0);
    GTPCLKOUT1_OUT                          : out  std_logic_vector(1 downto 0);
    ------------------- Transmit Ports - 8b10b Encoder Control -----------------
    TXCHARDISPMODE0_IN                      : in   std_logic_vector(1 downto 0);
    TXCHARDISPMODE1_IN                      : in   std_logic_vector(1 downto 0);
    TXCHARISK0_IN                           : in   std_logic_vector(1 downto 0);
    TXCHARISK1_IN                           : in   std_logic_vector(1 downto 0);
    ------------------ Transmit Ports - TX Data Path interface -----------------
    TXDATA0_IN                              : in   std_logic_vector(15 downto 0);
    TXDATA1_IN                              : in   std_logic_vector(15 downto 0);
    TXUSRCLK0_IN                            : in   std_logic;
    TXUSRCLK1_IN                            : in   std_logic;
    TXUSRCLK20_IN                           : in   std_logic;
    TXUSRCLK21_IN                           : in   std_logic;
    --------------- Transmit Ports - TX Driver and OOB signalling --------------
    TXN0_OUT                                : out  std_logic;
    TXN1_OUT                                : out  std_logic;
    TXP0_OUT                                : out  std_logic;
    TXP1_OUT                                : out  std_logic;
    ----------------- Transmit Ports - TX Ports for PCI Express ----------------
    TXDETECTRX0_IN                          : in   std_logic;
    TXDETECTRX1_IN                          : in   std_logic;
    TXELECIDLE0_IN                          : in   std_logic;
    TXELECIDLE1_IN                          : in   std_logic


);
end component;


--********************************* Main Body of Code**************************

begin

    tied_to_ground_i                    <= '0';
    tied_to_ground_vec_i(63 downto 0)   <= (others => '0');
    tied_to_vcc_i                       <= '1';

simulation : if WRAPPER_SIMULATION = 1 generate

    TILE0_PLLLKDET0_OUT                     <= tile0_plllkdet0_i2;
process
    begin
        wait until tile0_plllkdet0_i'event;
        if(tile0_plllkdet0_i = '1') then
           tile0_plllkdet0_i2 <= '1' after 100 ns;
        else
           tile0_plllkdet0_i2 <= tile0_plllkdet0_i;
        end if;
    end process;
    TILE0_PLLLKDET1_OUT                     <= tile0_plllkdet1_i2;
process
    begin
        wait until tile0_plllkdet1_i'event;
        if(tile0_plllkdet1_i = '1') then
           tile0_plllkdet1_i2 <= '1' after 100 ns;
        else
           tile0_plllkdet1_i2 <= tile0_plllkdet1_i;
        end if;
    end process;



end generate simulation;

implementation : if WRAPPER_SIMULATION = 0 generate

    TILE0_PLLLKDET0_OUT                     <= tile0_plllkdet0_i;
    TILE0_PLLLKDET1_OUT                     <= tile0_plllkdet1_i;

end generate implementation;

    --------------------------- Tile Instances  -------------------------------


    --_________________________________________________________________________
    --_________________________________________________________________________
    --TILE0  (X0_Y0)

    tile0_gtpa1_dual_wrapper_i : GTPA1_DUAL_WRAPPER_TILE
    generic map
    (
        -- Simulation attributes
        TILE_SIM_GTPRESET_SPEEDUP    => WRAPPER_SIM_GTPRESET_SPEEDUP,
        TILE_CLK25_DIVIDER_0         => WRAPPER_CLK25_DIVIDER_0,
        TILE_CLK25_DIVIDER_1         => WRAPPER_CLK25_DIVIDER_1,
        TILE_PLL_DIVSEL_FB_0         => WRAPPER_PLL_DIVSEL_FB_0,
        TILE_PLL_DIVSEL_FB_1         => WRAPPER_PLL_DIVSEL_FB_1,
        TILE_PLL_DIVSEL_REF_0        => WRAPPER_PLL_DIVSEL_REF_0,
        TILE_PLL_DIVSEL_REF_1        => WRAPPER_PLL_DIVSEL_REF_1,

        --
        TILE_PLL_SOURCE_0            => "PLL0",
        TILE_PLL_SOURCE_1            => "PLL1"
    )
    port map
    (
        ------------------------ Loopback and Powerdown Ports ----------------------
        RXPOWERDOWN0_IN                 =>      TILE0_RXPOWERDOWN0_IN,
        RXPOWERDOWN1_IN                 =>      TILE0_RXPOWERDOWN1_IN,
        TXPOWERDOWN0_IN                 =>      TILE0_TXPOWERDOWN0_IN,
        TXPOWERDOWN1_IN                 =>      TILE0_TXPOWERDOWN1_IN,
        --------------------------------- PLL Ports --------------------------------
        CLK00_IN                        =>      TILE0_CLK00_IN,
        CLK01_IN                        =>      TILE0_CLK01_IN,
        GTPRESET0_IN                    =>      TILE0_GTPRESET0_IN,
        GTPRESET1_IN                    =>      TILE0_GTPRESET1_IN,
        PLLLKDET0_OUT                   =>      tile0_plllkdet0_i,
        PLLLKDET1_OUT                   =>      tile0_plllkdet1_i,
        RESETDONE0_OUT                  =>      TILE0_RESETDONE0_OUT,
        RESETDONE1_OUT                  =>      TILE0_RESETDONE1_OUT,
        ----------------------- Receive Ports - 8b10b Decoder ----------------------
        RXCHARISK0_OUT                  =>      TILE0_RXCHARISK0_OUT,
        RXCHARISK1_OUT                  =>      TILE0_RXCHARISK1_OUT,
        RXDISPERR0_OUT                  =>      TILE0_RXDISPERR0_OUT,
        RXDISPERR1_OUT                  =>      TILE0_RXDISPERR1_OUT,
        RXNOTINTABLE0_OUT               =>      TILE0_RXNOTINTABLE0_OUT,
        RXNOTINTABLE1_OUT               =>      TILE0_RXNOTINTABLE1_OUT,
        ---------------------- Receive Ports - Clock Correction --------------------
        RXCLKCORCNT0_OUT                =>      TILE0_RXCLKCORCNT0_OUT,
        RXCLKCORCNT1_OUT                =>      TILE0_RXCLKCORCNT1_OUT,
        --------------- Receive Ports - Comma Detection and Alignment --------------
        RXENMCOMMAALIGN0_IN             =>      TILE0_RXENMCOMMAALIGN0_IN,
        RXENMCOMMAALIGN1_IN             =>      TILE0_RXENMCOMMAALIGN1_IN,
        RXENPCOMMAALIGN0_IN             =>      TILE0_RXENPCOMMAALIGN0_IN,
        RXENPCOMMAALIGN1_IN             =>      TILE0_RXENPCOMMAALIGN1_IN,
        ------------------- Receive Ports - RX Data Path interface -----------------
        RXDATA0_OUT                     =>      TILE0_RXDATA0_OUT,
        RXDATA1_OUT                     =>      TILE0_RXDATA1_OUT,
        RXRESET0_IN                     =>      TILE0_RXRESET0_IN,
        RXRESET1_IN                     =>      TILE0_RXRESET1_IN,
        RXUSRCLK0_IN                    =>      TILE0_RXUSRCLK0_IN,
        RXUSRCLK1_IN                    =>      TILE0_RXUSRCLK1_IN,
        RXUSRCLK20_IN                   =>      TILE0_RXUSRCLK20_IN,
        RXUSRCLK21_IN                   =>      TILE0_RXUSRCLK21_IN,
        ------- Receive Ports - RX Driver,OOB signalling,Coupling and Eq.,CDR ------
        GATERXELECIDLE0_IN              =>      TILE0_GATERXELECIDLE0_IN,
        GATERXELECIDLE1_IN              =>      TILE0_GATERXELECIDLE1_IN,
        IGNORESIGDET0_IN                =>      TILE0_IGNORESIGDET0_IN,
        IGNORESIGDET1_IN                =>      TILE0_IGNORESIGDET1_IN,
        RXELECIDLE0_OUT                 =>      TILE0_RXELECIDLE0_OUT,
        RXELECIDLE1_OUT                 =>      TILE0_RXELECIDLE1_OUT,
        RXN0_IN                         =>      TILE0_RXN0_IN,
        RXN1_IN                         =>      TILE0_RXN1_IN,
        RXP0_IN                         =>      TILE0_RXP0_IN,
        RXP1_IN                         =>      TILE0_RXP1_IN,
        ----------- Receive Ports - RX Elastic Buffer and Phase Alignment ----------
        RXSTATUS0_OUT                   =>      TILE0_RXSTATUS0_OUT,
        RXSTATUS1_OUT                   =>      TILE0_RXSTATUS1_OUT,
        -------------- Receive Ports - RX Pipe Control for PCI Express -------------
        PHYSTATUS0_OUT                  =>      TILE0_PHYSTATUS0_OUT,
        PHYSTATUS1_OUT                  =>      TILE0_PHYSTATUS1_OUT,
        RXVALID0_OUT                    =>      TILE0_RXVALID0_OUT,
        RXVALID1_OUT                    =>      TILE0_RXVALID1_OUT,
        -------------------- Receive Ports - RX Polarity Control -------------------
        RXPOLARITY0_IN                  =>      TILE0_RXPOLARITY0_IN,
        RXPOLARITY1_IN                  =>      TILE0_RXPOLARITY1_IN,
        ---------------------------- TX/RX Datapath Ports --------------------------
        GTPCLKOUT0_OUT                  =>      TILE0_GTPCLKOUT0_OUT,
        GTPCLKOUT1_OUT                  =>      TILE0_GTPCLKOUT1_OUT,
        ------------------- Transmit Ports - 8b10b Encoder Control -----------------
        TXCHARDISPMODE0_IN              =>      TILE0_TXCHARDISPMODE0_IN,
        TXCHARDISPMODE1_IN              =>      TILE0_TXCHARDISPMODE1_IN,
        TXCHARISK0_IN                   =>      TILE0_TXCHARISK0_IN,
        TXCHARISK1_IN                   =>      TILE0_TXCHARISK1_IN,
        ------------------ Transmit Ports - TX Data Path interface -----------------
        TXDATA0_IN                      =>      TILE0_TXDATA0_IN,
        TXDATA1_IN                      =>      TILE0_TXDATA1_IN,
        TXUSRCLK0_IN                    =>      TILE0_TXUSRCLK0_IN,
        TXUSRCLK1_IN                    =>      TILE0_TXUSRCLK1_IN,
        TXUSRCLK20_IN                   =>      TILE0_TXUSRCLK20_IN,
        TXUSRCLK21_IN                   =>      TILE0_TXUSRCLK21_IN,
        --------------- Transmit Ports - TX Driver and OOB signalling --------------
        TXN0_OUT                        =>      TILE0_TXN0_OUT,
        TXN1_OUT                        =>      TILE0_TXN1_OUT,
        TXP0_OUT                        =>      TILE0_TXP0_OUT,
        TXP1_OUT                        =>      TILE0_TXP1_OUT,
        ----------------- Transmit Ports - TX Ports for PCI Express ----------------
        TXDETECTRX0_IN                  =>      TILE0_TXDETECTRX0_IN,
        TXDETECTRX1_IN                  =>      TILE0_TXDETECTRX1_IN,
        TXELECIDLE0_IN                  =>      TILE0_TXELECIDLE0_IN,
        TXELECIDLE1_IN                  =>      TILE0_TXELECIDLE1_IN

    );


end RTL;
