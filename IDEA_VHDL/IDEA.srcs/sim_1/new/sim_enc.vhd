----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/03/2019 12:37:41 PM
-- Design Name: 
-- Module Name: sim_enc - Behavioral
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


entity sim_enc is
--  Port ( );
end sim_enc;

architecture Behavioral of sim_enc is

    component encrypt is
        Port ( msg : in STD_LOGIC_VECTOR (0 to 63);
               key : in STD_LOGIC_VECTOR (0 to 127);
               msg_out : out STD_LOGIC_VECTOR (0 to 63));
    end component;

    signal M, output : std_logic_vector (0 to 63) := (others => '0');
    signal K : std_logic_vector (0 to 127) := (others => '0');
begin
    uut: encrypt PORT MAP (msg => M, key => K, msg_out => output);

    process
    begin
        wait for 10ns;
        M <= "0000010100110010000010100110010000010100110010000001100111111010";
        K <= "00000000011001000000000011001000000000010010110000000001100100000000000111110100000000100101100000000010101111000000001100100000";
        wait for 50ns;
    end process;
end Behavioral;
