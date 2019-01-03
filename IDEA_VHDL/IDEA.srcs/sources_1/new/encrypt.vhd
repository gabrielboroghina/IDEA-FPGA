library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.types.ALL;

entity encrypt is
    Port ( msg : in STD_LOGIC_VECTOR (0 to 63);
           key : in STD_LOGIC_VECTOR (0 to 127);
           msg_out : out STD_LOGIC_VECTOR (0 to 63));
end encrypt;

architecture Behavioral of encrypt is

    component encryption_keys is
        Port ( key : in STD_LOGIC_VECTOR (0 to 127);
               EK : out list);
    end component;
    
    component IDEA_block is
        Port ( msg : in STD_LOGIC_VECTOR (0 to 63);
               key : in list;
               msg_out : out STD_LOGIC_VECTOR (0 to 63));
    end component;

    signal EK : list;

begin
    -- generate encryption keys
    gen_keys: encryption_keys PORT MAP (key => key, EK => EK);
    
    apply_block: IDEA_block PORT MAP (msg => msg, key => EK, msg_out => msg_out);
end Behavioral;
