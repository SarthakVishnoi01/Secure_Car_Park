----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/30/2017 11:25:46 AM
-- Design Name: 
-- Module Name: secure_car_park - Behavioral
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
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY secure_car_park IS
    PORT (clk : IN STD_LOGIC;
          resetx : IN STD_LOGIC;
          entry_sensor : IN  STD_LOGIC;
          park_sensor : IN  STD_LOGIC;
          exit_sensor : IN STD_LOGIC;
          password : IN  STD_LOGIC_VECTOR(3 downto 0);
          id : IN STD_LOGIC_VECTOR(3 downto 0);
          set_password: IN STD_LOGIC_VECTOR(3 downto 0);
          password_led : OUT STD_LOGIC_VECTOR(3 downto 0);
          led1 : OUT  STD_LOGIC;
          led2 : OUT  STD_LOGIC;
          led3 : OUT STD_LOGIC;
          led4 : OUT STD_LOGIC;
          kicked : OUT STD_LOGIC;
          anode : INOUT STD_LOGIC_VECTOR(3 downto 0);
          cathode : OUT STD_LOGIC_VECTOR(6 downto 0);
          park_id: OUT STD_LOGIC_VECTOR(3 downto 0)
          ); 
END secure_car_park;

ARCHITECTURE Behavioral OF secure_car_park IS

BEGIN

entrypark: ENTITY WORK.entry_gate(Behavioral)
    PORT MAP(clk,resetx,entry_sensor,park_sensor,led1,led2,led4,password_led,password,set_password,led3,kicked);
exitpark: ENTITY WORK.exit_parking(Behavioral)
    PORT MAP(clk,resetx,park_sensor,exit_sensor,id,anode,cathode,park_id);

END Behavioral;