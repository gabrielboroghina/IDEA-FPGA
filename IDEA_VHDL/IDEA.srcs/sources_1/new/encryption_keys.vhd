library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.types.ALL;

entity encryption_keys is
    Port ( key : in STD_LOGIC_VECTOR (0 to 127);
           EK : out list);
end encryption_keys;

architecture Behavioral of encryption_keys is
    signal start : integer := 0;
    signal nr_subkeys : integer;
begin
    gen: for i in 0 to 5 generate
        gen_8_keys: for j in 0 to 7 generate
            foreach_bit: for k in 0 to 15 generate
                EK(i * 8 + j + 1)(15 - k) <= key((i * 25 + j * 16 + k) mod 128);
            end generate;
        end generate;
    end generate;
    
    gen_8_keys: for j in 0 to 3 generate
        foreach_bit: for k in 0 to 15 generate
            EK(49 + j)(15 - k) <= key((22 + j * 16 + k) mod 128);
        end generate;
    end generate;

end Behavioral;
