-- Example 73b: vga_bsprite_top
-- Copyright 2009, 2012 LBE Books, LLC
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity group_photos_top is
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
end group_photos_top;

architecture Behavioral of group_photos_top is

component A8 IS
  PORT (
    clka : IN STD_LOGIC;
    addra : IN STD_LOGIC_VECTOR(14 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END component;

component B8 IS
  PORT (
    clka : IN STD_LOGIC;
    addra : IN STD_LOGIC_VECTOR(14 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END component;

component vga_bsprite4a is
    port ( vidon: in std_logic;
           hc : in std_logic_vector(9 downto 0);
           vc : in std_logic_vector(9 downto 0);
           MA: in std_logic_vector(7 downto 0);
           MB: in std_logic_vector(7 downto 0);           
           sw: in std_logic_vector(7 downto 0);
           rom_addr15A: out std_logic_vector(14 downto 0);
           rom_addr15B: out std_logic_vector(14 downto 0);           
           red : out std_logic_vector(3 downto 0);
           green : out std_logic_vector(3 downto 0);
           blue : out std_logic_vector(3 downto 0)
           );
end component;

component clkdiv100MHZ is
	 port(
		 mclk : in STD_LOGIC;
		 clr : in STD_LOGIC;
		 clk25 : out STD_LOGIC;
		 clk190 : out STD_LOGIC
	     );
end component;

component vga_640x480_bpMod is
    port ( clk, clr : in std_logic;
           hsync : out std_logic;
           vsync : out std_logic;
           hc : out std_logic_vector(9 downto 0);
           vc : out std_logic_vector(9 downto 0);
           vidon : out std_logic
	);
end component;



signal clr, clk25, clk190, vidon: std_logic;
signal hc, vc: std_logic_vector(9 downto 0);
signal MA, MB: std_logic_vector(7 downto 0);
signal rom_addr15A,rom_addr15B : std_logic_vector(14 downto 0);

begin
  
	clr <= btn(3);

U1 : clkdiv100MHZ
	port map(mclk => mclk, clr => clr, clk25 => clk25, clk190 =>clk190);
	
U2 : vga_640x480_bpMod
	port map(clk => clk25, clr => clr, hsync => hsync, 
      vsync => vsync, hc => hc, vc => vc, vidon => vidon); 
	
U3 : vga_bsprite4a
	port map(
        vidon => vidon,
        hc => hc,
        vc => vc, 
        MA => MA,
        MB => MB, 
        sw => sw,
        rom_addr15A => rom_addr15A, 
        rom_addr15B => rom_addr15B,       
        red => red, 
        green => green,
        blue => blue
		);

U4 : A8
	port map (
	clka => clk25,
    addra => rom_addr15A,
    douta => MA
	);
U5 : B8
	port map (
	clka => clk25,
    addra => rom_addr15B,
    douta => MB
	);
	

end Behavioral;
