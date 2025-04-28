----------------------------------------------------------------------------------
-- Company: ecsalab.uop.gr
-- Engineer: Marios Papadopoulos
-- 
-- Create Date: 18.02.2025 19:07:27
-- Design Name: SHA256
-- Module Name: SHA256 - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

entity SHA256 is
Port (clk : in std_logic; reset: in std_logic; msg : in std_logic_vector(511 downto 0);  done : out std_logic; hash : out std_logic_vector(255 downto 0));
end SHA256;


architecture Behavioral of SHA256 is

type array_type is array (0 to 63) of std_logic_vector(31 downto 0);

signal w : array_type;

constant k : array_type := (
x"428a2f98", x"71374491", x"b5c0fbcf", x"e9b5dba5",
x"3956c25b", x"59f111f1", x"923f82a4", x"ab1c5ed5",
x"d807aa98", x"12835b01", x"243185be", x"550c7dc3",
x"72be5d74", x"80deb1fe", x"9bdc06a7", x"c19bf174",
x"e49b69c1", x"efbe4786", x"0fc19dc6", x"240ca1cc",
x"2de92c6f", x"4a7484aa", x"5cb0a9dc", x"76f988da",
x"983e5152", x"a831c66d", x"b00327c8", x"bf597fc7",
x"c6e00bf3", x"d5a79147", x"06ca6351", x"14292967",
x"27b70a85", x"2e1b2138", x"4d2c6dfc", x"53380d13",
x"650a7354", x"766a0abb", x"81c2c92e", x"92722c85",
x"a2bfe8a1", x"a81a664b", x"c24b8b70", x"c76c51a3",
x"d192e819", x"d6990624", x"f40e3585", x"106aa070",
x"19a4c116", x"1e376c08", x"2748774c", x"34b0bcb5",
x"391c0cb3", x"4ed8aa4a", x"5b9cca4f", x"682e6ff3",
x"748f82ee", x"78a5636f", x"84c87814", x"8cc70208",
x"90befffa", x"a4506ceb", x"bef9a3f7", x"c67178f2");

signal a : std_logic_vector(31 downto 0) := x"6a09e667";
signal b : std_logic_vector(31 downto 0) := x"bb67ae85";
signal c : std_logic_vector(31 downto 0) := x"3c6ef372";
signal d : std_logic_vector(31 downto 0) := x"a54ff53a";
signal e : std_logic_vector(31 downto 0) := x"510e527f";
signal f : std_logic_vector(31 downto 0) := x"9b05688c";
signal g : std_logic_vector(31 downto 0) := x"1f83d9ab";
signal h : std_logic_vector(31 downto 0) := x"5be0cd19";

signal h0 : std_logic_vector(31 downto 0) := x"6a09e667";
signal h1 : std_logic_vector(31 downto 0) := x"bb67ae85";
signal h2 : std_logic_vector(31 downto 0) := x"3c6ef372";
signal h3 : std_logic_vector(31 downto 0) := x"a54ff53a";
signal h4 : std_logic_vector(31 downto 0) := x"510e527f";
signal h5 : std_logic_vector(31 downto 0) := x"9b05688c";
signal h6 : std_logic_vector(31 downto 0) := x"1f83d9ab";
signal h7 : std_logic_vector(31 downto 0) := x"5be0cd19";





signal eff_clk : std_logic;

begin

p0 : process(clk)
variable count : integer range 0 to 1;
begin
if rising_edge(clk) then
if count = 1 then
eff_clk <= '1';
count := 0;
else
count := count + 1;
eff_clk <= '0';
end if;
end if;
end process p0;



p1 : process(eff_clk,reset)

function s0 (x : std_logic_vector) return std_logic_vector is
begin
return std_logic_vector(rotate_right(unsigned(x),7)) xor
std_logic_vector(rotate_right(unsigned(x),18)) xor
std_logic_vector(shift_right(unsigned(x),3));
end s0;

function s1 (x : std_logic_vector) return std_logic_vector is
begin
return std_logic_vector(rotate_right(unsigned(x),17)) xor
std_logic_vector(rotate_right(unsigned(x),19)) xor
std_logic_vector(shift_right(unsigned(x),10));
end s1;

function f0 (x :std_logic_vector) return std_logic_vector is
begin
return std_logic_vector(rotate_right(unsigned(x),2)) xor
std_logic_vector(rotate_right(unsigned(x),13)) xor
std_logic_vector(rotate_right(unsigned(x),22));
end f0;

function f1 (x :std_logic_vector(31 downto 0)) return std_logic_vector
is
begin
return std_logic_vector(rotate_right(unsigned(x),6)) xor
std_logic_vector(rotate_right(unsigned(x),11)) xor
std_logic_vector(rotate_right(unsigned(x),25));
end f1;

variable i : integer := 0;
variable temp1, temp2: std_logic_vector(31 downto 0);


begin

if (reset='0') then
hash <= (others => '0');
done <= '0';
else

if rising_edge(eff_clk) then

if i = 0 then
w(0) <= msg(511 downto 480);

elsif i < 16 then
w(i) <= msg(511-i*32 downto 480-i*32);
temp1 := std_logic_vector(unsigned((e and f) xor ((not e) and g)) + unsigned(f1(e)) + unsigned(h) + unsigned(k(i-1)) + unsigned(w(i-1)));
temp2 := std_logic_vector(unsigned((a and b) xor (a and c) xor (b and c)) + unsigned(f0(a)));

h <= g;
g <= f;
f <= e;
e <= std_logic_vector(unsigned(d) + unsigned(temp1));
d <= c;
c <= b;
b <= a;
a <= std_logic_vector(unsigned(temp1) + unsigned(temp2));

elsif i < 64 then

w(i) <= std_logic_vector(unsigned(s1(w(i-2))) + unsigned(w((i-7))) + unsigned(s0(w((i-15)))) + unsigned(w((i-16))));
temp1 := std_logic_vector(unsigned((e and f) xor ((not e)and g)) + unsigned(f1(e)) + unsigned(h) + unsigned(k(i-1)) + unsigned(w(i-1)));
temp2 := std_logic_vector(unsigned((a and b) xor (a and c) xor (b and c)) + unsigned(f0(a)));
h <= g;
g <= f;
f <= e;
e <= std_logic_vector(unsigned(d) + unsigned(temp1));
d <= c;
c <= b;
b <= a;
a <= std_logic_vector(unsigned(temp1) + unsigned(temp2));

elsif i = 64 then

temp1 := std_logic_vector(unsigned((e and f) xor ((not e) and g)) + unsigned(f1(e)) + unsigned(h) + unsigned(k(i-1)) + unsigned(w(i-1)));
temp2 := std_logic_vector(unsigned((a and b) xor (a and c) xor (b and c)) + unsigned(f0(a)));
h <= g;
g <= f;
f <= e;
e <= std_logic_vector(unsigned(d) + unsigned(temp1));
d <= c;
c <= b;
b <= a;
a <= std_logic_vector(unsigned(temp1) + unsigned(temp2));

elsif i = 65 then

h0 <= std_logic_vector(unsigned(h0) + unsigned(a));
h1 <= std_logic_vector(unsigned(h1) + unsigned(b));
h2 <= std_logic_vector(unsigned(h2) + unsigned(c));
h3 <= std_logic_vector(unsigned(h3) + unsigned(d));
h4 <= std_logic_vector(unsigned(h4) + unsigned(e));
h5 <= std_logic_vector(unsigned(h5) + unsigned(f));
h6 <= std_logic_vector(unsigned(h6) + unsigned(g));
h7 <= std_logic_vector(unsigned(h7) + unsigned(h));

elsif i = 66 then
hash <= h0&h1&h2&h3&h4&h5&h6&h7;
done <= '1';
end if;

i := i + 1;
end if;
end if;

end process p1;

end Behavioral;

