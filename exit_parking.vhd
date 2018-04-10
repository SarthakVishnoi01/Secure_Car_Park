----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.11.2017 18:34:00
-- Design Name: 
-- Module Name: exit_parking - Behavioral
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
------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

ENTITY anodeclock is
    PORT( clk : in STD_LOGIC;
          reset : in STD_LOGIC;
          clk_out : out std_logic
         );
END anodeclock;

ARCHITECTURE slow OF anodeclock IS
    SIGNAL temp: STD_LOGIC := '0';
    SIGNAL counter: INTEGER RANGE 0 to 49999 := 0;
    
BEGIN

PROCESS(reset, clk)
BEGIN
    IF (reset = '1' and reset'event) THEN
        counter <= 0;
    END IF;
    IF(rising_edge(clk)) THEN
        IF(counter = 49999) THEN
            temp <= not(temp);
            counter <= 0;
        ELSE
            counter <= counter + 1;
        END IF;
    END IF;
   
END PROCESS;
 
clk_out <= temp;

END slow;
---------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY exit_parking IS
    PORT( clk,resetx: in STD_LOGIC;
          park_sensor: in STD_LOGIC;
          exit_sensor: in STD_LOGIC;
          id: in STD_LOGIC_VECTOR(3 downto 0);
          anode: inout STD_LOGIC_VECTOR(3 downto 0);
          cathode: out STD_LOGIC_VECTOR(6 downto 0);
          park_id: out STD_LOGIC_VECTOR(3 downto 0)
          );
END exit_parking;

ARCHITECTURE Behavioral OF exit_parking IS
SIGNAL cathode3: STD_LOGIC_VECTOR(6 downto 0);
SIGNAL cathode2: STD_LOGIC_VECTOR(6 downto 0);
SIGNAL cathode1: STD_LOGIC_VECTOR(6 downto 0);
SIGNAL cathode0: STD_LOGIC_VECTOR(6 downto 0);
SIGNAL reset: STD_LOGIC := '0';
SIGNAL reset1: STD_LOGIC := '0' ;
SIGNAL reset2: STD_LOGIC := '0';
SIGNAL reset3: STD_LOGIC := '0';
SIGNAL counter1 : INTEGER RANGE 0 TO 49999999;
SIGNAL counter2 : INTEGER RANGE 0 TO 249999999;
SIGNAL anodeclk: STD_LOGIC;
SIGNAL clk4sec: STD_LOGIC;
SIGNAL clk1sec: STD_LOGIC;
SIGNAL count: INTEGER;
SIGNAL myarray : STD_LOGIC_VECTOR(15 downto 0) := "0000000000000000";
type INT_ARRAY is array (integer range <>) of integer;
SIGNAL space: INT_ARRAY(0 to 15);
SIGNAL display: INTEGER;
SIGNAL parkid: STD_LOGIC_VECTOR := "0000";
SIGNAL OP1,OP2,OP3: STD_LOGIC;

BEGIN
    
myanodeclock: ENTITY WORK.anodeclock(slow)
    PORT MAP(clk, reset, anodeclk);

PROCESS(reset2, clk, clk1sec)
BEGIN
    IF (reset2 = '1') THEN
        counter1 <= 0;
        clk1sec <= '0';
    ELSIF(rising_edge(clk)) THEN
        IF(counter1 = 49999999) THEN
            clk1sec <= not(clk1sec);
            counter1 <= 0;
        ELSE
            counter1 <= counter1 + 1;
        END IF;
    END IF;
END PROCESS;
 
PROCESS(clk1sec,resetx)
BEGIN
    IF(resetx = '1') THEN
        myarray <= "0000000000000000";
        display <= 0;
    END IF;
    IF(clk1sec'EVENT and clk1sec='1') then
    IF(park_sensor = '1') THEN
        IF(myarray(0) = '0') THEN
            space(0) <= 0;
            parkid <= "0000";
            myarray(0) <= '1';
        ELSIF(myarray(1) = '0') THEN
            space(1) <= 0;
            parkid <= "0001";
            myarray(1) <= '1';
        ELSIF(myarray(2) = '0') THEN
            space(2) <= 0;  
            parkid <= "0010";
            myarray(2) <= '1';     
        ELSIF(myarray(3) = '0') THEN
            space(3) <= 0;
            parkid <= "0011";
            myarray(3) <= '1';
        ELSIF(myarray(4) = '0') THEN
            space(4) <= 0;
            parkid <= "0100";
            myarray(4) <= '1';
        ELSIF(myarray(5) = '0') THEN
            space(5) <= 0;
            parkid <= "0101";
            myarray(5) <= '1';
        ELSIF(myarray(6) = '0') THEN
            space(6) <= 0;
            parkid <= "0110";
            myarray(6) <= '1';
        ELSIF(myarray(7) = '0') THEN
            space(7) <= 0;
            parkid <= "0111";
            myarray(7) <= '1';
        ELSIF(myarray(8) = '0') THEN
            space(8) <= 0;
            parkid <= "1000";
            myarray(8) <= '1';                 
        ELSIF(myarray(9) = '0') THEN
            space(9) <= 0;
            parkid <= "1001";
            myarray(9) <= '1';           
        ELSIF(myarray(10) = '0') THEN
            space(10) <= 0;
            parkid <= "1010";
            myarray(10) <= '1';          
        ELSIF(myarray(11) = '0') THEN
            space(11) <= 0;
            parkid <= "1011";
            myarray(11) <= '1';
        ELSIF(myarray(12) = '0') THEN
            space(12) <= 0;
            parkid <= "1100";
            myarray(12) <= '1';
        ELSIF(myarray(13) = '0') THEN
            space(13) <= 0;
            parkid <= "1101";
            myarray(13) <= '1';
        ELSIF(myarray(14) = '0') THEN
            space(14) <= 0;
            parkid <= "1110";
            myarray(14) <= '1';
        ELSIF(myarray(15) ='0') THEN
            space(15) <= 0;
            parkid <= "1111";
            myarray(15) <= '1';
        END IF;
    ELSIF(exit_sensor = '1') THEN
        myarray(to_integer(unsigned(id))) <= '0';
        display <= space(to_integer(unsigned(id)));
    ELSE
        space(0) <= space(0) + 1;
        space(1) <= space(1) + 1;
        space(2) <= space(2) + 1;
        space(3) <= space(3) + 1;
        space(4) <= space(4) + 1;
        space(5) <= space(5) + 1;
        space(6) <= space(6) + 1;
        space(7) <= space(7) + 1;
        space(8) <= space(8) + 1;
        space(9) <= space(9) + 1;
        space(10) <= space(10) + 1;
        space(11) <= space(11) + 1;
        space(12) <= space(12) + 1;
        space(13) <= space(13) + 1;
        space(14) <= space(14) + 1;
        space(15) <= space(15) + 1;
     END IF;
     END IF;
END PROCESS;

PROCESS(anodeclk,exit_sensor)
BEGIN
    IF(exit_sensor = '1') THEN
        count <= 0;
    END IF;
    IF(anodeclk = '1' AND anodeclk'event) THEN
        IF(count = 3) THEN
            count <= 0;
        ELSE
            count <= count + 1;
        END IF;
    END IF;
END PROCESS;

PROCESS(count)
BEGIN
    IF(count = 0) THEN
        anode <= "0111";
        cathode <= cathode3;
    ELSIF (count = 1) THEN
        anode <= "1011";
        cathode <= cathode2;
    ELSIF (count = 2) THEN
        anode <= "1101";
        cathode <= cathode1;
    ELSIF (count = 3) THEN
        anode <= "1110";
        cathode <= cathode0;
    END IF;
END PROCESS;

PROCESS(clk)
BEGIN
        IF(id = "0000") THEN
            cathode3 <= "1000000";
        ELSIF(id = "0001") THEN
            cathode3 <= "1111001";
        ELSIF(id = "0010") THEN
            cathode3 <= "0100100";
        ELSIF(id = "0011") THEN
            cathode3 <= "0110000";
        ELSIF(id = "0100") THEN
            cathode3 <= "0011001";
        ELSIF(id = "0101") THEN
            cathode3 <= "0010010";
        ELSIF(id = "0110") THEN
            cathode3 <= "0000010";
        ELSIF(id = "0111") THEN
            cathode3 <= "1111000";
        ELSIF(id = "1000") THEN
            cathode3 <= "0000000";                   
        ELSIF(id = "1001") THEN
            cathode3 <= "0011000";
        ELSIF(id = "1010") THEN
            cathode3 <= "0001000";            
        ELSIF(id = "1011") THEN
            cathode3 <= "0000011";  
        ELSIF(id = "1100") THEN
            cathode3 <= "1000110";
        ELSIF(id = "1101") THEN
            cathode3 <= "0100001";
        ELSIF(id = "1110") THEN
            cathode3 <= "0000110";
        ELSIF(id = "1111") THEN
            cathode3 <= "0001110";
        END IF;
END PROCESS;

PROCESS(clk)
VARIABLE X : INTEGER;
VARIABLE Y : INTEGER;
VARIABLE Z : INTEGER;

BEGIN
    X := (display - display mod 100)/100; 
    Y := ((display mod 100) - (display mod 100) mod 10)/10;
    Z := display mod 10;                                   

    CASE X IS
        WHEN 0 => cathode2 <= "1000000";
        WHEN 1 => cathode2 <= "1111001";
        WHEN 2 => cathode2 <= "0100100";                                
        WHEN 3 => cathode2 <= "0110000";
        WHEN 4 => cathode2 <= "0011001";                                
        WHEN 5 => cathode2 <= "0010010";
        WHEN 6 => cathode2 <= "0000010";
        WHEN 7 => cathode2 <= "1111000";
        WHEN 8 => cathode2 <= "0000000";
        WHEN others => cathode2 <= "0011000";
     END CASE;

    CASE Y IS
        WHEN 0 => cathode1 <= "1000000";
        WHEN 1 => cathode1 <= "1111001";
        WHEN 2 => cathode1 <= "0100100";                                
        WHEN 3 => cathode1 <= "0110000";
        WHEN 4 => cathode1 <= "0011001";                                
        WHEN 5 => cathode1 <= "0010010";
        WHEN 6 => cathode1 <= "0000010";
        WHEN 7 => cathode1 <= "1111000";
        WHEN 8 => cathode1 <= "0000000";
        WHEN others => cathode1 <= "0011000";
     END CASE;
    CASE Z IS
            WHEN 0 => cathode0 <= "1000000";
            WHEN 1 => cathode0 <= "1111001";
            WHEN 2 => cathode0 <= "0100100";                                
            WHEN 3 => cathode0 <= "0110000";
            WHEN 4 => cathode0 <= "0011001";                                
            WHEN 5 => cathode0 <= "0010010";
            WHEN 6 => cathode0 <= "0000010";
            WHEN 7 => cathode0 <= "1111000";
            WHEN 8 => cathode0 <= "0000000";
            WHEN others => cathode0 <= "0011000";
         END CASE;
END PROCESS;

PROCESS(park_sensor,resetx)
BEGIN
    IF(park_sensor = '1') THEN
        park_id <= parkid;
    END IF;
    IF(resetx = '1') THEN
        park_id <= "0000";
    END IF;
END PROCESS;

END Behavioral;