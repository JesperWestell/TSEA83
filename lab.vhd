library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity lab is
    Port ( clk,rst, rx : in  STD_LOGIC;
           seg: out  STD_LOGIC_VECTOR(7 downto 0);
           an : out  STD_LOGIC_VECTOR (3 downto 0));
end lab;

architecture Behavioral of lab is
    component leddriver
    Port ( clk,rst : in  STD_LOGIC;
           seg : out  STD_LOGIC_VECTOR(7 downto 0);
           an : out  STD_LOGIC_VECTOR (3 downto 0);
           value : in  STD_LOGIC_VECTOR (15 downto 0));
    end component;
    signal sreg : STD_LOGIC_VECTOR(9 downto 0) := B"0_00000000_0";  -- 10 bit skiftregister
    signal tal : STD_LOGIC_VECTOR(15 downto 0) := X"0000";  
    signal rx1,rx2 : std_logic;         -- vippor på insignalen
    signal sp : std_logic;              -- skiftpuls
    signal lp : std_logic;         -- laddpuls
    signal pos : STD_LOGIC_VECTOR(1 downto 0) := "00";
begin
  -- rst är tryckknappen i mitten under displayen
  -- *****************************
  -- *  synkroniseringsvippor    *
  -- *****************************

  process(clk) begin
    if rising_edge(clk) then
      if rst = '1' then
        rx1 <= 1;
        rx2 <= 1;
      else
        rx1 <= rx;
        rx2 <= rx1;
    end if;
  end process;
  
  -- *****************************
  -- *       styrenhet           *
  -- *****************************

  process(clk) begin
    if rising_edge(clk) then
      
  end process;

  
  -- *****************************
  -- * 10 bit skiftregister      *
  -- *****************************

  process(clk) begin
    if rising_edge(clk) then
      if rst = '1' then
        sreg <= 0;
      else if sp = '1' then
        -- shift right and concatenate rx2 on shiftregister
        sreg <= rx2 & sreg(9 downto 1);
    end if;
  end process;  

  -- *****************************
  -- * 2  bit register           *
  -- *****************************
  process(clk) begin
    if rising_edge(clk) then
      if rst = '1' then
        pos <= 0;
      else if lp = '1' then
        pos <= pos + 1;
    end if;
  end process;  

  -- *****************************
  -- * 16 bit register           *
  -- *****************************
  
  process(clk) begin
    if rising_edge(clk) then
      if rst = '1' then
        tal <= 0;
      else if lp = '1' then
        if pos = '0' then
        
    end if;
  end process;  

  -- *****************************
  -- * Multiplexad display       *
  -- *****************************
  led: leddriver port map (clk, rst, seg, an, tal);
end Behavioral;
