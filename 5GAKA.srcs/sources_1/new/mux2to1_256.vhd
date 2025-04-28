----------------------------------------------------------------------------------
-- Company: UOP.GR
-- Engineer: PAPADOPOULOS MARIOS
-- 
-- Create Date: 15.04.2025 14:36:52
-- Design Name: 5GAKA
-- Module Name: mux4to1_256 - Behavioral
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

entity mux2to1_256 is
    Port (
        aa : in  STD_LOGIC_VECTOR(255 downto 0);  
        bb : in  STD_LOGIC_VECTOR(255 downto 0);  
        sele : in  STD_LOGIC;   
        yy : out  STD_LOGIC_VECTOR(255 downto 0)  
    );
end mux2to1_256;

architecture Behavioral of mux2to1_256 is
begin
    process(aa, bb, sele)
    begin
        case sele is
            when '0' =>
                yy <= aa;  
            when '1' =>
                yy <= bb; 
            when others =>
                yy <= (others => '0');  
        end case;
    end process;
end Behavioral;
