-- A package containing component declarations
-- for vga Examples 71 - 74
-- Copyright 2009, 2012 LBE Books, LLC
library IEEE;
use IEEE.std_logic_1164.all;

package vga_components is
	
	component clkdiv
	port(
		mclk : in std_logic;
		clr : in std_logic;
		clk25 : out std_logic);
	end component;

	component clkdiv2
	port(
		mclk : in std_logic;
		clr : in std_logic;
		clk190 : out std_logic;
		clk25 : out std_logic);
	end component;

	component debounce4
	port(
		cclk : in std_logic;
		clr : in std_logic;
		inp : in std_logic_vector(3 downto 0);
		outp : out std_logic_vector(3 downto 0));
	end component;

	component clock_pulse
	port(
		inp : in std_logic;
		cclk : in std_logic;
		clr : in std_logic;
		outp : out std_logic);
	end component;

	component gcd3
	port(
		clk : in std_logic;
		clr : in std_logic;
		go : in std_logic;
		xin : in std_logic_vector(3 downto 0);
		yin : in std_logic_vector(3 downto 0);
		done : out std_logic;
		gcd : out std_logic_vector(3 downto 0));
	end component;

	component x7segbc
	port(
		x : in std_logic_vector(15 downto 0);
		cclk : in std_logic;
		clr : in std_logic;
		a_to_g : out std_logic_vector(6 downto 0);
		an : out std_logic_vector(3 downto 0);
		dp : out std_logic );
	end component;

component brom8x16
	port (
	addr: IN std_logic_VECTOR(2 downto 0);
	clk: IN std_logic;
	dout: OUT std_logic_VECTOR(15 downto 0));
end component;

	component counter
	generic(
		N : INTEGER := 8);
	port(
		clr : in std_logic;
		clk : in std_logic;
		q : out std_logic_vector(N-1 downto 0));
	end component;
	
	component vga_640x480
	port(
		clk : in std_logic;
		clr : in std_logic;
		hsync : out std_logic;
		vsync : out std_logic;
		hc : out std_logic_vector(9 downto 0);
		vc : out std_logic_vector(9 downto 0);
		vidon : out std_logic);
	end component;

	component vga_stripes
	port(
		vidon : in std_logic;
		hc : in std_logic_vector(9 downto 0);
		vc : in std_logic_vector(9 downto 0);
		red : out std_logic_vector(2 downto 0);
		green : out std_logic_vector(2 downto 0);
		blue : out std_logic_vector(1 downto 0));
	end component;

	component prom_dmh
	port(
		addr : in std_logic_vector(3 downto 0);
		M : out std_logic_vector(0 to 31));
	end component;

	component vga_initials
	port(
		vidon : in std_logic;
		hc : in std_logic_vector(9 downto 0);
		vc : in std_logic_vector(9 downto 0);
		M : in std_logic_vector(0 to 31);
		sw : in std_logic_vector(7 downto 0);
		rom_addr4 : out std_logic_vector(3 downto 0);
		red : out std_logic_vector(2 downto 0);
		green : out std_logic_vector(2 downto 0);
		blue : out std_logic_vector(1 downto 0));
	end component;

component loons240x160
	port (
	addr: IN std_logic_VECTOR(15 downto 0);
	clk: IN std_logic;
	dout: OUT std_logic_VECTOR(7 downto 0));
end component;
	
	component vga_bsprite
	port(
		vidon : in std_logic;
		hc : in std_logic_vector(9 downto 0);
		vc : in std_logic_vector(9 downto 0);
		M : in std_logic_vector(7 downto 0);
		sw : in std_logic_vector(7 downto 0);
		rom_addr16 : out std_logic_vector(15 downto 0);
		red : out std_logic_vector(2 downto 0);
		green : out std_logic_vector(2 downto 0);
		blue : out std_logic_vector(1 downto 0));
	end component;
	
	component vga_screensaver
	port(
		vidon : in std_logic;
		hc : in std_logic_vector(9 downto 0);
		vc : in std_logic_vector(9 downto 0);
		M : in std_logic_vector(7 downto 0);
		C1 : in std_logic_vector(9 downto 0);
		R1 : in std_logic_vector(9 downto 0);
		rom_addr16 : out std_logic_vector(15 downto 0);
		red : out std_logic_vector(2 downto 0);
		green : out std_logic_vector(2 downto 0);
		blue : out std_logic_vector(1 downto 0));
	end component;

	component bounce
	port(
		cclk : in std_logic;
		clr : in std_logic;
		go : in std_logic;
		c1 : out std_logic_vector(9 downto 0);
		r1 : out std_logic_vector(9 downto 0));
	end component;

end vga_components; 
  
  
