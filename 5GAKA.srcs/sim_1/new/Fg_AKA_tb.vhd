library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Testbench entity declaration
entity Fg_AKA_tb is
end Fg_AKA_tb;

architecture behavior of Fg_AKA_tb is
    -- Component declaration for the Unit Under Test (UUT)
    component Fg_AKA 
    Port ( 
           CLK   : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           START : in  STD_LOGIC;
           SEL  : in  STD_LOGIC_vector(2 downto 0);
           K     : in std_logic_vector (127 downto 0); 
           RAND  : in std_logic_vector(127 downto 0);
           SQN   : in std_logic_vector(47 downto 0);
           AMF   : in std_logic_vector(15 downto 0)
           );
    end component;

    -- Signals to connect to UUT
    signal fgclk_tb          : STD_LOGIC := '0';
    signal fgreset_tb        : STD_LOGIC := '0';
    signal fgstart_tb        : STD_LOGIC := '0';
    signal fgsel_tb          : STD_LOGIC_VECTOR(2 downto 0) :="000";
    signal fgkey_tb          : STD_LOGIC_VECTOR(127 downto 0) :=x"465b5ce8b199b49faa5f0a2ee238a6bc";
    signal fgrand_tb         : STD_LOGIC_VECTOR(127 downto 0) :=x"23553cbe9637a89d218ae64dae47bf35";
    signal fgsqn_tb          : STD_LOGIC_VECTOR(47 downto 0)  :=x"ff9bb4d0b607";
    signal fgamf_tb          : STD_LOGIC_VECTOR(15 downto 0)  :=x"abdd";
   

    -- Clock period definition
    constant clk_period : time := 10 ns;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: Fg_AKA
        Port map (
            CLK => fgclk_tb ,
            RESET => fgreset_tb ,
            SEL => fgsel_tb ,
            K => fgkey_tb ,
            RAND => fgrand_tb ,
            START => fgstart_tb ,
            SQN => fgsqn_tb ,
            AMF => fgamf_tb 
        );
        
    -- Clock process definitions
   clk_process : process
    begin
        while true loop
            fgclk_tb <= '0';
            wait for CLK_PERIOD / 2;
            fgclk_tb <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process clk_process;

    -- Stimulus process
    stim_proc : process
    begin
        -- Reset the system
        fgreset_tb  <= '0';
        wait for 20 ns;
        fgsel_tb <="100";
        fgreset_tb  <= '1';
        fgstart_tb  <= '1';
        wait for 500 ns;

        wait;
   end process stim_proc;
end behavior;
