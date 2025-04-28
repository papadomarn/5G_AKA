library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Testbench entity declaration
entity Copc_tb is
end Copc_tb;

architecture behavior of Copc_tb is
    -- Component declaration for the Unit Under Test (UUT)
    component Copc 
        Port (
            opclk         : in  STD_LOGIC;
            opreset       : in  STD_LOGIC;
            key           : in  STD_LOGIC_VECTOR(255 downto 0); 
            OP            : in  STD_LOGIC_VECTOR(255 downto 0); 
            opstart       : in  STD_LOGIC;
            OP_c          : out STD_LOGIC_VECTOR(255 downto 0); 
            opdone        : out STD_LOGIC
        );
    end component;

    -- Signals to connect to UUT
    signal opclk_tb          : STD_LOGIC := '0';
    signal opreset_tb        : STD_LOGIC := '0';
    signal key_tb            : STD_LOGIC_VECTOR(255 downto 0) :=x"347137324A48675838397A33426B464D7436637751784C31724432386A704E35";
    signal OP_tb             : STD_LOGIC_VECTOR(255 downto 0) :=x"6162638000000000000000000000000000000000000000000000000000000018";
    signal opstart_tb        : STD_LOGIC := '0';
    signal OP_c_tb           : STD_LOGIC_VECTOR(255 downto 0);
    signal opdone_tb         : STD_LOGIC;

    -- Clock period definition
    constant clk_period : time := 10 ns;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: Copc
        Port map (
            opclk => opclk_tb ,
            opreset => opreset_tb ,
            key => key_tb ,
            OP => OP_tb ,
            opstart => opstart_tb ,
            OP_c => OP_c_tb ,
            opdone => opdone_tb 
        );
        
    -- Clock process definitions
   clk_process : process
    begin
        while true loop
            opclk_tb <= '0';
            wait for CLK_PERIOD / 2;
            opclk_tb <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process clk_process;

    -- Stimulus process
    stim_proc : process
    begin
        -- Reset the system
        opreset_tb  <= '0';
        wait for 20 ns;
        
        opreset_tb  <= '1';
        opstart_tb  <= '1';
        wait for 500 ns;

        wait;
   end process stim_proc;
end behavior;
