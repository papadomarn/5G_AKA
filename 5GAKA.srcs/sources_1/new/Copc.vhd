----------------------------------------------------------------------------------
-- Company: UOP
-- Engineer: Papadopoulos Marios
-- 
-- Create Date: 30.03.2025 13:29:08
-- Design Name: 5G AKA
-- Module Name: Copc - Behavioral
-- Project Name: Compute OPC
-- Target Devices: Zedboard
-- Tool Versions: Vivado 2024.2.1
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
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

entity Copc is
PORT (OP : in std_logic_vector(255 downto 0);
key : in std_logic_vector(255 downto 0);
opclk : in std_logic;
opreset : in std_logic;
opstart : in std_logic;
OP_c: out std_logic_vector(255 downto 0);
opdone : out std_logic);
end Copc;

architecture Behavioral of Copc is

COMPONENT HMAC IS
     Port ( 
        hmac_clk         : in  STD_LOGIC;
        hmac_reset       : in  STD_LOGIC;
        hmac_key         : in  STD_LOGIC_VECTOR(255 downto 0); 
        hmac_msg     : in  STD_LOGIC_VECTOR(255 downto 0); 
        hmac_start       : in  STD_LOGIC;
        hmac_output  : out STD_LOGIC_VECTOR(255 downto 0); 
        hmac_done        : out STD_LOGIC);
END COMPONENT;


SIGNAL temp : std_logic_vector(255 downto 0);

begin

pmap1 : HMAC PORT MAP (hmac_clk => opclk, hmac_reset => opreset ,  hmac_key => key, hmac_msg => OP , hmac_start => opstart, hmac_output => temp , hmac_done => opdone);
OP_C <= key XOR temp;

end Behavioral;
