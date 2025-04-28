----------------------------------------------------------------------------------
-- Company: UOP.GR
-- Engineer: PAPADOPOULOS MARIOS
-- 
-- Create Date: 15.04.2025 14:36:52
-- Design Name: 5GAKA
-- Module Name: Buffer - Behavioral
-- Project Name: 5GAKA
-- Target Devices: Zedboard
-- Tool Versions: Vivado 2024_2_1
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:1
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;  -- Optional, for arithmetic operations
use IEEE.STD_LOGIC_UNSIGNED.ALL; -- Optional, for unsigned operations

entity buff is
    Port (
        bufi : in  STD_LOGIC_VECTOR(255 downto 0);   
        en : in  STD_LOGIC;   
        bufo : out  STD_LOGIC_VECTOR(255 downto 0)  
    );
end buff;

architecture Behavioral of buff is
begin
    process(bufi, en)
    begin
        case en is
            when '1' =>
                bufo <= bufi;  
            when others =>
                bufo <= (others => '0');  
        end case;
    end process;
end Behavioral;
