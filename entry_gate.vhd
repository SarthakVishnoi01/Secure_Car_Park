----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/30/2017 01:24:41 PM
-- Design Name: 
-- Module Name: entry_gate - Behavioral
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

ENTITY clk4sec is
    PORT( clk : in STD_LOGIC;
          reset : in STD_LOGIC;
          clk_out: out STD_LOGIC    
        );
END clk4sec;

ARCHITECTURE slow OF clk4sec IS
    SIGNAL temp: STD_LOGIC;
    SIGNAL counter: INTEGER RANGE 0 to 399999999 := 0;
  
BEGIN

PROCESS(reset, clk)
BEGIN
    IF (reset = '1' and reset'event) THEN
        counter <= 0;
        temp <= '0';
    END IF;
    IF(rising_edge(clk)) THEN
        IF(counter = 399999999) THEN
            temp <= not(temp);
            counter <= 0;
        ELSE
            counter <= counter + 1;
        END IF;
    END IF;
   
END PROCESS;
clk_out <= temp;
END slow;
-------------------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

ENTITY clk2hz is
    PORT( clk : in STD_LOGIC;
          reset : in STD_LOGIC;
          clk_out : out std_logic    
        );
END clk2hz;

ARCHITECTURE slow OF clk2hz IS
    SIGNAL temp: STD_LOGIC;
    SIGNAL counter: INTEGER RANGE 0 to 49999999 := 0;
    
BEGIN

PROCESS(reset, clk)
BEGIN
    IF (reset = '1' and reset'event) THEN
        counter <= 0;
        temp <= '0';
    END IF;
    IF(rising_edge(clk)) THEN
        IF(counter = 49999999) THEN
            temp <= not(temp);
            counter <= 0;
        ELSE
            counter <= counter + 1;
        END IF;
    END IF;
   
END PROCESS;

clk_out <= temp;

END slow;
-------------------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

ENTITY clk2sec is
    PORT( clk : in STD_LOGIC;
          reset : in STD_LOGIC;
          clk_out : out std_logic     
        );
END clk2sec;

ARCHITECTURE slow OF clk2sec IS
    SIGNAL temp: STD_LOGIC;
    SIGNAL counter: INTEGER RANGE 0 to 199999999 := 0;
    
BEGIN

PROCESS(reset, clk)
BEGIN
    IF (reset = '1' and reset'event) THEN
        counter <= 0;
        temp <= '0';
    END IF;
    IF(rising_edge(clk)) THEN
        IF(counter = 199999999) THEN
            temp <= not(temp);
            counter <= 0;
        ELSE
            counter <= counter + 1;
        END IF;
    END IF;
   
END PROCESS;

clk_out <= temp;

END slow;
--------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

ENTITY clk4htz is
    PORT( clk : in STD_LOGIC;
          reset : in STD_LOGIC;
          clk_out : out std_logic     
        );
END clk4htz;

ARCHITECTURE slow OF clk4htz IS
    SIGNAL temp: STD_LOGIC;
    SIGNAL counter: INTEGER RANGE 0 to 24999999 := 0;
    
BEGIN

PROCESS(reset, clk)
BEGIN
    IF (reset = '1' and reset'event) THEN
        counter <= 0;
        temp <= '0';
    END IF;
    IF(rising_edge(clk)) THEN
        IF(counter = 24999999) THEN
            temp <= not(temp);
            counter <= 0;
        ELSE
            counter <= counter + 1;
        END IF;
    END IF;
   
END PROCESS;

clk_out <= temp;

END slow;
---------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY entry_gate IS
    PORT( clk,resetx : in STD_LOGIC;
          entry_sensor, park_sensor : in STD_LOGIC;
          led1, led2, led4 : out STD_LOGIC := '0';
          password_led : out STD_LOGIC_VECTOR(3 downto 0);
          password : in STD_LOGIC_VECTOR(3 downto 0);
          set_password: in STD_LOGIC_VECTOR(3 downto 0);
          led3 : out STD_LOGIC := '0';
          kicked : out STD_LOGIC := '0'
          );
END entry_gate;

ARCHITECTURE Behavioral OF entry_gate IS
TYPE state IS (IDLE,WAITING,RIGHT,WRONG);
SIGNAL current_state : state := IDLE;
SIGNAL next_state : state;
SIGNAL led1_temp, led2_temp, led3_temp,led4_temp : STD_LOGIC := '0';
SIGNAL password_led_temp : STD_LOGIC_VECTOR(3 downto 0) := "0000";
SIGNAL bitslowclk : STD_LOGIC := '0';
SIGNAL blinkclk : STD_LOGIC := '0';
SIGNAL clk4hz: STD_LOGIC := '0';
SIGNAL reset1 : STD_LOGIC := '0';
SIGNAL reset2 :STD_LOGIC ;
SIGNAL reset3 :STD_LOGIC ;
SIGNAL reset4 :STD_LOGIC := '0';
SIGNAL reset5 :STD_LOGIC ;
SIGNAL kicked_temp: STD_LOGIC:='0';
SIGNAL counter1: INTEGER RANGE 0 to 399999999 := 0;
SIGNAL counter2: INTEGER RANGE 0 to 399999999 := 0;
SIGNAL slowclk1: STD_LOGIC := '0';
SIGNAL slowclk2: STD_LOGIC := '0';


BEGIN

clk4htz: ENTITY WORK.clk4htz(slow)
    PORT MAP(clk, reset5, clk4hz);
    
bitslowclock: ENTITY WORK.clk2sec(slow)   -- 1 sec
    PORT MAP(clk, reset2, bitslowclk);
    
blinkclock: ENTITY WORK.clk2hz(slow)---0.5 sec
    PORT MAP(clk, reset3 , blinkclk);

PROCESS(reset1,clk)
BEGIN
    IF(reset1 = '1') THEN
        counter1 <= 0;
        slowclk1 <= '0';
    ELSIF(rising_edge(clk)) THEN
        IF(counter1 = 399999999) THEN
            slowclk1 <= not(slowclk1);
            counter1 <= 0;
        ELSE
            counter1 <= counter1 + 1;
        END IF;
    END IF;     
END PROCESS;

PROCESS(reset4,clk)
BEGIN
    IF(reset4 = '1') THEN
        counter2 <= 0;
        slowclk2 <= '0';
    ELSIF(rising_edge(clk)) THEN
        IF(counter2 = 399999999) THEN
            slowclk2 <= not(slowclk2);
            counter2 <= 0;
        ELSE
            counter2 <= counter2 + 1;
        END IF;
    END IF;     
END PROCESS;

PROCESS(clk,resetx)
BEGIN   
    IF(resetx = '1') THEN
        current_state <= IDLE;
        reset1 <= '0';
        reset4 <= '0';
    ELSIF(rising_edge(clk)) THEN
        reset1 <= '0';
        reset4 <= '0';
        IF(current_state = IDLE) THEN  
                IF(entry_sensor = '1') THEN
                    reset1 <= '1';
                    kicked_temp <= '0';
                    current_state <= WAITING; 
                END IF;
        ELSIF(current_state = WAITING) THEN
                IF(slowclk1  = '1') THEN
                    IF(password = set_password) THEN
                        reset3 <= '1';
                        current_state <= RIGHT;
                    ELSIF(password /= set_password) THEN
                        reset4 <= '1';
                        reset5 <= '1';
                        current_state <= WRONG;
                    END IF;
                END IF;
        ELSIF(current_state = WRONG) THEN
                IF(slowclk2 = '1') THEN
                    IF(password = set_password) THEN
                        reset3 <= '1';
                        current_state <= RIGHT;
                    ELSIF(password /= set_password) THEN
                        kicked_temp <= '1';
                        current_state <= IDLE;
                    END IF;
                END IF;
        ELSIF(current_state = RIGHT) THEN
                IF(park_sensor = '1') THEN
                    kicked_temp <= '0';
                    reset1 <= '1';
                    reset4 <= '1';
                    current_state <= IDLE;
                END IF;   
        END IF;  
    END IF;
END PROCESS;

PROCESS(entry_sensor,park_sensor,resetx)
BEGIN
    IF(entry_sensor = '1') THEN
        led1_temp <= '1';
    ELSIF(park_sensor = '1' OR resetx = '1') THEN
        led1_temp <= '0';
    END IF;
END PROCESS;

PROCESS(bitslowclk,park_sensor,resetx,clk)
BEGIN
    IF(current_state = RIGHT) THEN
        IF(park_sensor = '1') THEN
            led2_temp <= '1';
            reset2 <= '1';
        END IF;
    END IF;
    IF(bitslowclk = '1' OR resetx = '1') THEN
        led2_temp <= '0';
    END IF;
END PROCESS;

PROCESS(blinkclk,clk,resetx)
BEGIN
    IF(current_state = RIGHT) THEN
        IF(blinkclk = '1' AND blinkclk'event) THEN
            led3_temp <= NOT led3_temp;
        END IF;
    ELSE
        led3_temp <= '0';
    END IF;
END PROCESS;

PROCESS(clk4hz,clk,resetx)
BEGIN
    IF(current_state = WRONG) THEN
        IF(clk4hz = '1' AND clk4hz'event) THEN
            led4_temp <= NOT led4_temp;
        END IF;
    ELSE
        led4_temp <= '0';
    END IF;
END PROCESS;

led1 <= led1_temp;
led2 <= led2_temp;
led3 <= led3_temp;
led4 <= led4_temp;
password_led <= password;
kicked <= kicked_temp;

END Behavioral;