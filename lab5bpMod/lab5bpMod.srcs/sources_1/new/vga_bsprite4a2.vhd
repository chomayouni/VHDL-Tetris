-- Example 73a: vga_bsprite
-- Copyright 2009, 2012 LBE Books, LLC
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity vga_bsprite4a2 is
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
end vga_bsprite4a2;

architecture Behavioral of vga_bsprite4a2 is
constant hbp: std_logic_vector(9 downto 0) := "0010010000";	 
	--Horizontal back porch = 144 (128+16)
constant vbp: std_logic_vector(9 downto 0) := "0000100011";	 -- changed
	--Vertical back porch = 35 (2+33)
constant w: integer := 140;
constant h: integer := 140;
signal xpixA, ypixA, xpixB, ypixB, ypixBack, xpixBack: std_logic_vector(9 downto 0);			
signal R1As, R1Bs, C1As, C1Bs: std_logic_vector(9 downto 0);				
signal spriteonA, spriteonB, R, G, B: std_logic;

--240,80
-- next piece board 464, 192
-- all blocks 16px wide
begin
	--set R1 using switches
	C1As <= C1A;
	--C1A <= "00" & X"00"; -- 90  offsets for aesthetics
	C1Bs <= C1B;
	R1As <= R1A;
	R1Bs <= R1B;
	ypixA <= vc - vbp - R1As;
	xpixA <= hc - hbp - C1As; 
	ypixB <= vc - vbp - R1Bs;
	xpixB <= hc - hbp - C1Bs;
	
	ypixBack <=  vc - vbp;
	xpixBack <=  hc - hbp;
	   
    -- enable the sprite  
 	spriteonA <= '1' when (((xpixA >= 0) and (xpixA < w ))
           and ((ypixA >= 0) and (ypixA < h))) else '0';	
           
 	spriteonB <= '1' when (((xpixB >= 0) and (xpixB < w ))
           and ((ypixB >= 0) and (ypixB < h))) else '0';


 -- get address for next pixel's data
process(xpixA, ypixA, xpixB, ypixB, ypixBack, xpixBack)
	variable  xOffsetA, xOffsetB : STD_LOGIC_VECTOR (9 downto 0);
	variable xOffsetBack : STD_LOGIC_VECTOR (9 downto 0);
	variable  rom_addr1, rom_addr2: STD_LOGIC_VECTOR (16 downto 0);
	variable rom_addrBack1, rom_addrBack2 : std_logic_vector(19 downto 0);	
	begin 
	    xOffsetA := xpixA + ("00"& X"01"); -- addition in order to get the address for the NEXT pixel's data while displaying the current data
		rom_addr1 := (ypixA & "0000000") + ("0000" & ypixA & "000") + ("00000" & ypixA & "00");	
           -- y*(128+8+4) = y*140
		rom_addr2 := rom_addr1 + ("0000000" & xOffsetA);	-- y*140+x+1 
		rom_addr15A <= rom_addr2(14 downto 0);
		
		xOffsetB := xpixB + ("00"& X"01"); -- addition in order to get the address for the NEXT pixel's data while displaying the current data
		rom_addr1 := (ypixB & "0000000") + ("0000" & ypixB & "000") + ("00000" & ypixB & "00");	
           -- y*(128+8+4) = y*140
		rom_addr2 := rom_addr1 + ("0000000" & xOffsetB);	-- y*140+x+1 	
		rom_addr15B <= rom_addr2(14 downto 0);	
		
		xOffsetBack := xpixBack + ("00"& X"01"); -- addition in order to get the address for the NEXT pixel's data while displaying the current data
		rom_addrBack1 := ('0' & ypixBack & '0' & X"00") +	("000" & ypixBack & "0000000");
		-- y*(512+128) = y*640
		rom_addrBack2 := rom_addrBack1 + ("00" & X"00" & xOffsetBack); --y*640 +x +1
		rom_addr19Back <= rom_addrBack2(18 downto 0);
	end process;

	process(spriteonA,spriteonB, vidon, MA, MB, MBack)
  		variable j: integer;
 	begin
		red <= "0000";
		green <= "0000";
		blue <= "0000";
		if spriteonA = '1' and vidon = '1' then
    			red <= MA(7 downto 5)& '0';
    			green <= MA(4 downto 2) & '0';
    			blue <= MA(1 downto 0)& "00";
		end if;
		if spriteonB = '1' and vidon = '1' then
    			red <= MB(7 downto 5)& '0';
    			green <= MB(4 downto 2) & '0';
    			blue <= MB(1 downto 0)& "00";
		end if;
		if not( spriteonA = '1' or spriteonB = '1') and (vidon = '1') then
    			red <= MBack(7 downto 5)& '0';
    			green <= MBack(4 downto 2) & '0';
    			blue <= MBack(1 downto 0)& "00";
		end if;
  	end process; 		
end Behavioral;

