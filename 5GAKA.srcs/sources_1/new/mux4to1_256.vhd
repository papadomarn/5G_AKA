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

entity mux4to1_256 is
    Port (
        a : in  STD_LOGIC_VECTOR(255 downto 0);  -- Input 0
        b : in  STD_LOGIC_VECTOR(255 downto 0);  -- Input 1
        c : in  STD_LOGIC_VECTOR(255 downto 0);  -- Input 2
        d : in  STD_LOGIC_VECTOR(255 downto 0);  -- Input 3
        sel : in  STD_LOGIC_VECTOR(1 downto 0);   -- 2-bit select signal
        y : out  STD_LOGIC_VECTOR(255 downto 0)   -- Output
    );
end mux4to1_256;

architecture Behavioral of mux4to1_256 is
begin
    process(a, b, c, d, sel)
    begin
        case sel is
            when "00" =>
                y <= a;  -- Select input a
            when "01" =>
                y <= b;  -- Select input b
            when "10" =>
                y <= c;  -- Select input c
            when "11" =>
                y <= d;  -- Select input d
            when others =>
                y <= (others => '0');  -- Default case (optional)
        end case;
    end process;
end Behavioral;