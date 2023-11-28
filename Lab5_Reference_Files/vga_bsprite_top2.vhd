-- Example 73b: vga_bsprite_top
-- Copyright 2009, 2012 LBE Books, LLC
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use work.vga_components.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity vga_bsprite_top2 is
	 port(
		mclk : in STD_LOGIC;
		btn : in STD_LOGIC_VECTOR(3 downto 0);
		sw : in STD_LOGIC_VECTOR(7 downto 0);
		hsync : out STD_LOGIC;
		vsync : out STD_LOGIC;
         	red : out std_logic_vector(3 downto 0);
         	green : out std_logic_vector(3 downto 0);
         	blue : out std_logic_vector(3 downto 0)
	     );
end vga_bsprite_top2;

architecture Behavioral of vga_bsprite_top2 is

component A8 IS
  PORT (
    clka : IN STD_LOGIC;
    addra : IN STD_LOGIC_VECTOR(14 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END component;

component vga_bsprite140 is
    port ( vidon: in std_logic;
           hc : in std_logic_vector(9 downto 0);
           vc : in std_logic_vector(9 downto 0);
           M: in std_logic_vector(7 downto 0);
           sw: in std_logic_vector(7 downto 0);
           rom_addr15: out std_logic_vector(14 downto 0);
           red : out std_logic_vector(3 downto 0);
           green : out std_logic_vector(3 downto 0);
           blue : out std_logic_vector(3 downto 0)
           );
end component;

component clkdiv100MHZ is
	 port(
		 mclk : in STD_LOGIC;
		 clr : in STD_LOGIC;
		 clk25 : out STD_LOGIC
	     );
end component;

component vga_640x480 is
    port ( clk, clr : in std_logic;
           hsync : out std_logic;
           vsync : out std_logic;
           hc : out std_logic_vector(9 downto 0);
           vc : out std_logic_vector(9 downto 0);
           vidon : out std_logic
	);
end component;



signal clr, clk25, vidon: std_logic;
signal hc, vc: std_logic_vector(9 downto 0);
signal M: std_logic_vector(7 downto 0);
signal rom_addr15: std_logic_vector(14 downto 0);
begin
  
	clr <= btn(3);

U1 : clkdiv100MHZ
	port map(mclk => mclk, clr => clr, clk25 => clk25);
	
U2 : vga_640x480
	port map(clk => clk25, clr => clr, hsync => hsync, 
      vsync => vsync, hc => hc, vc => vc, vidon => vidon); 
	
U3 : vga_bsprite140
	port map(vidon => vidon, hc => hc, vc => vc, M => M, sw => sw,
		rom_addr15 => rom_addr15, red => red, green => green,
		blue => blue);

U4 : A8
	port map (
	clka => clk25,
    addra => rom_addr15,
    douta => M
	);
	
end Behavioral;
