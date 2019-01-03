library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;


entity mul is
    Port ( a, b : in unsigned (15 downto 0);
           res : out unsigned (15 downto 0));
end mul;

architecture Behavioral of mul is
    signal lo, hi : unsigned (15 downto 0) := (others => '0');
    signal prod : unsigned (31 downto 0) := (others => '0');
begin
    prod <= a * b;
    hi <= prod(31 downto 16);
    lo <= prod(15 downto 0);
    
    res <= 1 - a - b when prod = (31 downto 0 => '0') else
           lo - hi when lo > hi else
           lo - hi + 1;
end Behavioral;
