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

entity demux4to1_256 is
    Port (
        data_in : in  STD_LOGIC_VECTOR(255 downto 0);  
        selec : in  STD_LOGIC_VECTOR(1 downto 0);         
        data_out0 : out  STD_LOGIC_VECTOR(255 downto 0); 
        data_out1 : out  STD_LOGIC_VECTOR(255 downto 0); 
        data_out2 : out  STD_LOGIC_VECTOR(255 downto 0); 
        data_out3 : out  STD_LOGIC_VECTOR(255 downto 0)  
    );
end demux4to1_256;

architecture Behavioral of demux4to1_256 is
begin
    process(data_in, selec)
    begin
        -- Default outputs to zero
        data_out0 <= (others => '0');
        data_out1 <= (others => '0');
        data_out2 <= (others => '0');
        data_out3 <= (others => '0');

        case selec is
            when "00" =>
                data_out0 <= data_in;  -- Route input to output 0
            when "01" =>
                data_out1 <= data_in;  -- Route input to output 1
            when "10" =>
                data_out2 <= data_in;  -- Route input to output 2
            when "11" =>
                data_out3 <= data_in;  -- Route input to output 3
            when others =>
                -- No action needed, outputs are already set to zero
                null;
        end case;
    end process;
end Behavioral;