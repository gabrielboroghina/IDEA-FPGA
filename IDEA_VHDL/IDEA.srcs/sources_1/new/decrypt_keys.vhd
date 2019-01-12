library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

library work;
use work.types.ALL;

entity decrypt_keys is
    Port ( key : in STD_LOGIC_VECTOR (0 to 127);
           DK : out list);
end decrypt_keys;

architecture Behavioral of decrypt_keys is
    component encryption_keys is
        Port ( key : in STD_LOGIC_VECTOR (0 to 127);
               EK : out list);
    end component;
    
    component inv_mod is
         Port ( y : in unsigned(15 downto 0);
              inv : out unsigned(15 downto 0));
    end component;
    
    signal EK : list;
begin
     enc_keys: encryption_keys PORT MAP (key => key, EK => EK);
     
     inv1: inv_mod PORT MAP (y => unsigned(EK(49)), std_logic_vector(inv) => DK(1));
     DK(2) <= std_logic_vector(unsigned( not EK(50)) + 1);
     DK(3) <= std_logic_vector(unsigned( not EK(51)) + 1);
     inv3: inv_mod PORT MAP (y => unsigned(EK(52)), std_logic_vector(inv) => DK(4));

     gen: for i in 0 to 7 generate
        DK(i*6+4 + 1) <= EK(51 - (i*6+4));
        DK(i*6+4 + 2) <= EK(51 - (i*6+4) + 1);
        inv1: inv_mod PORT MAP (y => unsigned(EK(51 - (i*6+4) - 4)), std_logic_vector(inv) => DK(i*6+4 + 3));
        
        last: if i*6+4 = 46 generate
            DK(i*6+4 + 4) <= std_logic_vector(unsigned( not EK(51 - (i*6+4) - 3)) + 1);
            DK(i*6+4 + 5) <= std_logic_vector(unsigned( not EK(51 - (i*6+4) - 2)) + 1);
        end generate last;
        
        not_last: if i*6+4 /= 46 generate
            DK(i*6+4 + 4) <= std_logic_vector(unsigned( not EK(51 - (i*6+4) - 2)) + 1);
            DK(i*6+4 + 5) <= std_logic_vector(unsigned( not EK(51 - (i*6+4) - 3)) + 1);
        end generate not_last;
        inv2: inv_mod PORT MAP (y => unsigned(EK(51 - (i*6+4) - 1)), std_logic_vector(inv) => DK(i*6+4 + 6));
     end generate gen;
end Behavioral;
