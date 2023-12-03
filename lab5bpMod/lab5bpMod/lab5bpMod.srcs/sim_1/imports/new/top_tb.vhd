----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/21/2023 06:36:06 PM
-- Design Name: 
-- Module Name: top_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top_tb is
--  Port ( );
end top_tb;

architecture Behavioral of top_tb is

component group_photos_top2 is
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
end component;

signal clk_tb, btn0_tb, btn1_tb, btn2_tb, btn3_tb, hsync_tb, vsync_tb : std_logic := '0';
signal red_tb, green_tb, blue_tb : std_logic_vector(3 downto 0) := X"0";
signal sw_tb : std_logic_vector(7 downto 0) := X"00";


begin

UUT : group_photos_top2 port map(
		mclk => clk_tb,
		btn => btn3_tb & btn2_tb & btn1_tb & btn0_tb,
		sw => sw_tb,
		hsync => hsync_tb,
		vsync => vsync_tb,
        red => red_tb,
        green => green_tb,
        blue => blue_tb
);


clk_generator : process 
begin
        clk_tb <= '1';
        wait for 5 ns;
        clk_tb  <= '0';
        wait for 5 ns;
end process;

test : process
    begin
        -- wait for sim fpga to turn on 
        btn3_tb <= '1';
        wait for 50 ns;
        btn3_tb <= '0';
        
        
        wait;
    end process;

end Behavioral;
