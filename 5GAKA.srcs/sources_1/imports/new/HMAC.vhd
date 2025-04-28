----------------------------------------------------------------------------------
-- Company: ecsalab.uop.gr
-- Engineer: Marios Papadopoulos
-- 
-- Create Date: 18.02.2025 19:07:27
-- Design Name: HMAC
-- Module Name: HMAC - Behavioral
-- Project Name: 5G AKA
-- Target Devices: Zedboard
-- Tool Versions: Vivado 2024.2.1
-- Description: None
-- 
-- Dependencies: None
-- 
-- Revision:1.0
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;

entity HMAC is
    Port (
        hmac_clk         : in  STD_LOGIC;
        hmac_reset       : in  STD_LOGIC;
        hmac_key         : in  STD_LOGIC_VECTOR(255 downto 0); 
        hmac_msg     : in  STD_LOGIC_VECTOR(255 downto 0); 
        hmac_start       : in  STD_LOGIC;
        hmac_output  : out STD_LOGIC_VECTOR(255 downto 0); 
        hmac_done        : out STD_LOGIC
    );
end HMAC;

architecture Behavioral of HMAC is

    signal inner_hash : STD_LOGIC_VECTOR(255 downto 0);
    signal outer_hash : STD_LOGIC_VECTOR(255 downto 0);
    signal ipad_key   : STD_LOGIC_VECTOR(255 downto 0);
    signal opad_key   : STD_LOGIC_VECTOR(255 downto 0);
    signal inner_padded_msg : STD_LOGIC_VECTOR(511 downto 0);
    signal outter_padded_msg : STD_LOGIC_VECTOR(511 downto 0);
    signal hash1_out : STD_LOGIC_VECTOR(255 downto 0);
    signal h2reset : STD_LOGIC;
    
    component SHA256 is
        Port (
            clk         : in  STD_LOGIC;
            reset       : in  STD_LOGIC;
            msg         : in  STD_LOGIC_VECTOR(511 downto 0);
            done        : out STD_LOGIC;
            hash        : out STD_LOGIC_VECTOR(255 downto 0)
        );
    end component;


begin
 
 
    process(hmac_key)
    begin
    
    for i in 0 to 31 loop  
    ipad_key(i * 8 + 7 downto i * 8) <= hmac_key(i * 8 + 7 downto i * 8) xor X"36";
    opad_key(i * 8 + 7 downto i * 8) <= hmac_key(i * 8 + 7 downto i * 8) xor X"5C";
    end loop;
    
    end process;
    inner_padded_msg <= ipad_key & hmac_msg;
    outter_padded_msg <= opad_key & hash1_out;
    c1: SHA256 port map(clk => hmac_clk,reset => hmac_reset, msg=> inner_padded_msg, done=> h2reset, hash=> hash1_out);
    c2: SHA256 port map(clk => hmac_clk,reset => h2reset, msg=> outter_padded_msg, done=> hmac_done, hash=> hmac_output);
   
end Behavioral;