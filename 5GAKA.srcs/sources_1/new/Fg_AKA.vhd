----------------------------------------------------------------------------------
-- Company: UOP 
-- Engineer: Papadopoulos Marios
-- 
-- Create Date: 30.03.2025 12:45:09
-- Design Name: 5G_AKA
-- Module Name: 5g_aka - Behavioral
-- Project Name: FPGA 5G AKA
-- Target Devices: Zedboard
-- Tool Versions: Vivado 2024.2.1
-- Description: 5G AKA AUTH SYSTEM
-- 
-- Dependencies: 
-- 
-- Revision: 1.0
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Fg_AKA is
    
    Port ( 
           CLK   : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           START : in  STD_LOGIC;
           SEL : in  STD_LOGIC_vector(2 downto 0);
           K     : in std_logic_vector (127 downto 0); 
           RAND  : in std_logic_vector(127 downto 0);
           SQN   : in std_logic_vector(47 downto 0);
           AMF   : in std_logic_vector(15 downto 0);
           AKADONE : out  STD_LOGIC;
           AKAOUT  : out std_logic_vector (255 downto 0)
           );
   end Fg_AKA;

architecture Behavioral of Fg_AKA is

signal SOP : std_logic_vector(255 downto 0) :=x"CDC202D5123E20F62B6D676AC72CB31800000000000000000000000000000000";
signal ZEROPAD : std_logic_vector(127 downto 0):=x"00000000000000000000000000000000";
signal ZEROPAD2 : std_logic_vector(191 downto 0):=x"000000000000000000000000000000000000000000000000";
signal PADRAND : std_logic_vector(255 downto 0);
signal PADK : std_logic_vector(255 downto 0);
signal PADSQNAMF : std_logic_vector(255 downto 0);
signal OPc : std_logic_vector(255 downto 0);
signal OP_done :  std_logic;
signal H1TMP : std_logic_vector(255 downto 0);
signal H2TMP : std_logic_vector(255 downto 0);
signal H3TMP : std_logic_vector(255 downto 0);
signal H4TMP : std_logic_vector(255 downto 0);
signal H5TMP : std_logic_vector(255 downto 0);
signal H6TMP : std_logic_vector(255 downto 0);
signal H7TMP : std_logic_vector(255 downto 0);
signal H2R1TMP: std_logic_vector(255 downto 0);
signal H2R2TMP: std_logic_vector(255 downto 0);
signal H2R3TMP: std_logic_vector(255 downto 0);
signal H2R4TMP: std_logic_vector(255 downto 0);
signal H2R5TMP: std_logic_vector(255 downto 0);
signal HASO1 : std_logic_vector(255 downto 0);
signal HASO2 : std_logic_vector(255 downto 0);
signal HASH1_done :  std_logic;
signal AKADONETMP :  std_logic;
signal SC1 :  std_logic_vector(255 downto 0):=x"0000000000000000000000000000000000000000000000000000000000000000";
signal SC2 :  std_logic_vector(255 downto 0):=x"0000000000000000000000000000000000000000000000000000000000000001";
signal SC3 :  std_logic_vector(255 downto 0):=x"0000000000000000000000000000000000000000000000000000000000000010";
signal SC4 :  std_logic_vector(255 downto 0):=x"0000000000000000000000000000000000000000000000000000000000000100";
signal SC5 :  std_logic_vector(255 downto 0):=x"0000000000000000000000000000000000000000000000000000000000001000";
signal CMO : std_logic_vector(255 downto 0);
signal DMO1 : std_logic_vector(255 downto 0);
signal DMO2 : std_logic_vector(255 downto 0);
signal DMO3 : std_logic_vector(255 downto 0);
signal DMO4 : std_logic_vector(255 downto 0);
signal CM1 : std_logic_vector(255 downto 0);

COMPONENT Copc IS
    PORT (OP : in std_logic_vector(255 downto 0);
         key : in std_logic_vector(255 downto 0);
         opclk : in std_logic;
         opreset : in std_logic;
         opstart : in std_logic;
         OP_c: out std_logic_vector(255 downto 0);
         opdone : out std_logic);
END COMPONENT;

COMPONENT HMAC IS
     PORT ( 
        hmac_clk         : in  STD_LOGIC;
        hmac_reset       : in  STD_LOGIC;
        hmac_key         : in  STD_LOGIC_VECTOR(255 downto 0); 
        hmac_msg     : in  STD_LOGIC_VECTOR(255 downto 0); 
        hmac_start       : in  STD_LOGIC;
        hmac_output  : out STD_LOGIC_VECTOR(255 downto 0); 
        hmac_done        : out STD_LOGIC);
END COMPONENT;

COMPONENT mux4to1_256 IS
Port (
        a : in  STD_LOGIC_VECTOR(255 downto 0); 
        b : in  STD_LOGIC_VECTOR(255 downto 0);  
        c : in  STD_LOGIC_VECTOR(255 downto 0);  
        d : in  STD_LOGIC_VECTOR(255 downto 0);  
        sel : in  STD_LOGIC_VECTOR(1 downto 0);   
        y : out  STD_LOGIC_VECTOR(255 downto 0)   
    );
END COMPONENT;

COMPONENT mux2to1_256 IS
Port (
        aa : in  STD_LOGIC_VECTOR(255 downto 0); 
        bb : in  STD_LOGIC_VECTOR(255 downto 0);   
        sele : in  STD_LOGIC;   
        yy : out  STD_LOGIC_VECTOR(255 downto 0)   
    );
END COMPONENT;

COMPONENT demux4to1_256 IS
Port (
        data_in : in  STD_LOGIC_VECTOR(255 downto 0);  
        selec : in  STD_LOGIC_VECTOR(1 downto 0);         
        data_out0 : out  STD_LOGIC_VECTOR(255 downto 0); 
        data_out1 : out  STD_LOGIC_VECTOR(255 downto 0); 
        data_out2 : out  STD_LOGIC_VECTOR(255 downto 0); 
        data_out3 : out  STD_LOGIC_VECTOR(255 downto 0)  
    );
END COMPONENT;

COMPONENT buff IS
 Port (
        bufi : in  STD_LOGIC_VECTOR(255 downto 0);   
        en : in  STD_LOGIC;   
        bufo : out  STD_LOGIC_VECTOR(255 downto 0)  
    );
END COMPONENT;
    
begin

PADK (255 downto 128) <= K;
PADK (127 downto 0) <= ZEROPAD;
PADRAND (255 downto 128) <= RAND;
PADRAND (127 downto 0) <= ZEROPAD;
PADSQNAMF (255 downto 208) <= SQN;
PADSQNAMF (207 downto 192) <= AMF;
PADSQNAMF (191 downto 0) <= ZEROPAD2;
c1: Copc port map(OP=>SOP,key =>PADK,opclk=>CLK,opreset=>RESET,opstart=>START,OP_c=>OPc,opdone=>OP_done);
H1TMP (255 downto 0) <= PADRAND (255 downto 0) xor OPc (255 downto 0);
H2TMP (255 downto 0) <= PADSQNAMF (255 downto 0) xor OPc (255 downto 0);
h1: HMAC port map(hmac_clk =>CLK, hmac_reset =>RESET,hmac_key=>PADK, hmac_msg=>H1TMP, hmac_start=>OP_done,hmac_output=>HASO1,hmac_done =>HASH1_done);

H2R1TMP (255 downto 0) <=H2TMP(191 downto 0) & H2TMP(255 downto 192);

H3TMP (255 downto 0) <= H2R1TMP (255 downto 0) xor SC1 (255 downto 0) xor HASO1 (255 downto 0);
H4TMP (255 downto 0) <= OPc (255 downto 0) xor HASO1 (255 downto 0);
MX1: mux4to1_256 port map (a=>SC2,b=>SC3,c=>SC4,d=>SC5,sel=>SEL(1 downto 0),Y=>CMO);
DM1 : demux4to1_256 port map (data_in =>H4TMP,selec=>SEL(1 downto 0),data_out0 =>DMO1,data_out1=>DMO2,data_out2=>DMO3,data_out3=>DMO4);

H2R2TMP (255 downto 0) <=DMO1;

-- make r3,r4,r5
H2R3TMP (255 downto 0) <=DMO2(223 downto 0) & DMO2(255 downto 224);
H2R4TMP (255 downto 0) <=DMO3(191 downto 0) & DMO3(255 downto 192);
H2R5TMP (255 downto 0) <=DMO4(159 downto 0) & DMO4(255 downto 160);
--
MX2: mux4to1_256 port map (a=>H2R2TMP,b=>H2R3TMP,c=>H2R4TMP,d=>H2R5TMP,sel=>SEL(1 downto 0),Y=>CM1);
H5TMP <= CM1 xor CMO;
MX3: mux2to1_256 port map (aa=>H5TMP,bb=>H3TMP,sele=>SEL(2),YY=>H6TMP);
h2: HMAC port map(hmac_clk =>CLK, hmac_reset =>RESET,hmac_key=>PADK, hmac_msg=>H6TMP, hmac_start=>HASH1_done,hmac_output=>HASO2,hmac_done =>AKADONETMP);
H7TMP <= HASO2 xor OPc;
buf: buff port map (bufi=>H7TMP,en=>AKADONETMP,bufo=>AKAOUT);
AKADONE<=AKADONETMP;
end Behavioral;
