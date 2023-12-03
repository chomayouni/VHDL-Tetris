-- Example 73b: vga_bsprite_top
-- Copyright 2009, 2012 LBE Books, LLC
library IEEE;
use IEEE.STD_LOGIC_1164.all;


entity Tetris_VGA_Top is
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
end Tetris_VGA_Top;

architecture Behavioral of Tetris_VGA_Top is
--component A8 IS
--  PORT (
--    clka : IN STD_LOGIC;
--    addra : IN STD_LOGIC_VECTOR(14 DOWNTO 0);
--    douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
--  );
--END component;

component B8 IS
  PORT (
    clka : IN STD_LOGIC;
    addra : IN STD_LOGIC_VECTOR(14 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END component;

--component Background8 IS
--  PORT (
--    clka : IN STD_LOGIC;
--    addra : IN STD_LOGIC_VECTOR(18 DOWNTO 0);
--    douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
--  );
--END component;

component Tetris_Background_Sprite IS
  PORT (
    clka : IN STD_LOGIC;
    addra : IN STD_LOGIC_VECTOR(18 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END component;

component Tetris_Sprite_Display is
    port ( 
           vidon: in std_logic;
           hc : in std_logic_vector(9 downto 0);
           vc : in std_logic_vector(9 downto 0);
           MA: in std_logic_vector(7 downto 0);
           MB: in std_logic_vector(7 downto 0);
           MBack: in std_logic_vector(7 downto 0);   
           C1A, R1A: in std_logic_vector(9 downto 0);
           C1B, R1B: in std_logic_vector(9 downto 0);           
           rom_addr15A: out std_logic_vector(14 downto 0);
           rom_addr15B: out std_logic_vector(14 downto 0);
           rom_addr19Back: out std_logic_vector(18 downto 0);           
           red : out std_logic_vector(3 downto 0);
           green : out std_logic_vector(3 downto 0);
           blue : out std_logic_vector(3 downto 0)
           );
end component;

component clock_pulse is
    port(
		 inp : in STD_LOGIC;
		 cclk : in STD_LOGIC;
		 clr : in STD_LOGIC;
		 outp : out STD_LOGIC
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

component Tetris_VGA_640x480 is
    port ( clk, clr : in std_logic;
           hsync : out std_logic;
           vsync : out std_logic;
           hc : out std_logic_vector(9 downto 0);
           vc : out std_logic_vector(9 downto 0);
           vidon : out std_logic
	);
end component;

--component bounce is
--   port(
--		 cclk : in STD_LOGIC;
--		 clr : in STD_LOGIC;
--		 go : in STD_LOGIC;
--		 c1A, c1B : out STD_LOGIC_VECTOR(9 downto 0);
--		 r1A, r1B : out STD_LOGIC_VECTOR(9 downto 0)
--	     );
--end component;

signal go, inp, clr, clk25, clk190, vidon: std_logic;
signal hc, vc, R1A, C1A, R1B, C1B: std_logic_vector(9 downto 0);
signal MA, MB, MBack: std_logic_vector(7 downto 0);
signal rom_addr15A,rom_addr15B : std_logic_vector(14 downto 0);
signal rom_addr19Back : std_logic_vector(18 downto 0);

begin
    inp <= btn(0);
	clr <= btn(3);
--	cclk <= clk190;

U1 : clkdiv100MHZ
	port map(mclk => mclk, clr => clr, clk25 => clk25, clk190 => clk190);
	
U2 : Tetris_VGA_640x480
	port map(clk => clk25, clr => clr, hsync => hsync, 
      vsync => vsync, hc => hc, vc => vc, vidon => vidon); 
	
U3 : Tetris_Sprite_Display
	port map(
        vidon => vidon,
        hc => hc,
        vc => vc, 
        MA => MA,
        MB => MB,
        MBack => MBack, 
        R1A => R1A,
        C1A => C1A,
        R1B => R1B,
        C1B => C1B,
        rom_addr15A => rom_addr15A, 
        rom_addr15B => rom_addr15B,
        rom_addr19Back => rom_addr19Back,       
        red => red, 
        green => green,
        blue => blue
		);

--U4 : A8
--	port map (
--	clka => clk25,
--    addra => rom_addr15A,
--    douta => MA
--	);
U5 : B8
	port map (
	clka => clk25,
    addra => rom_addr15B,
    douta => MB
	);
	
--U6 : Background8
--	port map (
--	clka => clk25,
--    addra => rom_addr19Back,
--    douta => MBack
--	);
	
TEST : Tetris_Background_Sprite
	port map (
	clka => clk25,
    addra => rom_addr19Back,
    douta => MBack
	);
	
--U7: bounce port map (
--    cclk => clk190,
--    clr => clr,
--    go => go,
--    c1A => C1A,
--    c1B => C1B,
--    r1A => R1A,
--    r1B => R1B
--        );

U8: clock_pulse port map(
		 inp => inp,
		 cclk => clk190,
		 clr => clr,
		 outp => go
	     );
	
end Behavioral;