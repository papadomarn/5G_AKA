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

entity 5g_aka is
    
    Port ( 
           CLK   : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           DHK   : in std_logic_vector (127 downto 0); 
           K     : in std_logic_vector (127 downto 0); 
           RAND  : in std_logic_vector(127 downto 0);
           SQN   : in std_logic_vector(47 downto 0);
           AMF   : in std_logic_vector(15 downto 0)
           );
   end 5g_aka;

architecture Behavioral of 5g_aka is

begin


end Behavioral;
