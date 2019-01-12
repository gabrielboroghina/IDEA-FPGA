library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity inv_mod is
    Port ( y : in unsigned(15 downto 0);
           inv : out unsigned(15 downto 0));
end inv_mod;

architecture Behavioral of inv_mod is
    type pow_array is array(0 to 14) of unsigned(33 downto 0);
    signal pow : pow_array;
    signal x : unsigned (33 downto 0);
    constant m : unsigned(33 downto 0) := to_unsigned(65537, 34);
begin
    x(33 downto 16) <= (others => '0');
    x(15 downto 0) <= y;
    
    -- compute modular inverse for y modulo 65537 with euler's theorem
    pow(0) <= ((x * x) mod m * x) mod m; -- x^3
    pow(1) <= ((pow(0) * pow(0)) mod m * x) mod m; -- x^7
    pow(2) <= ((pow(1) * pow(1)) mod m * x) mod m; -- x^15
    pow(3) <= ((pow(2) * pow(2)) mod m * x) mod m; -- x^31
    pow(4) <= ((pow(3) * pow(3)) mod m * x) mod m; -- x^63
    pow(5) <= ((pow(4) * pow(4)) mod m * x) mod m; -- x^127
    pow(6) <= ((pow(5) * pow(5)) mod m * x) mod m; -- x^255
    pow(7) <= ((pow(6) * pow(6)) mod m * x) mod m; -- x^511
    pow(8) <= ((pow(7) * pow(7)) mod m * x) mod m; -- x^1023
    pow(9) <= ((pow(8) * pow(8)) mod m * x) mod m; -- x^2047
    pow(10) <= ((pow(9) * pow(9)) mod m * x) mod m; -- x^4095
    pow(11) <= ((pow(10) * pow(10)) mod m * x) mod m; -- x^8191
    pow(12) <= ((pow(11) * pow(11)) mod m * x) mod m; -- x^16383
    pow(13) <= ((pow(12) * pow(12)) mod m * x) mod m; -- x^32767
    pow(14) <= ((pow(13) * pow(13)) mod m * x) mod m; -- x^65535
    
    inv <= pow(14)(15 downto 0);
end Behavioral;
