library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.types.ALL;

entity decrypt is
    Port ( msg : in STD_LOGIC_VECTOR (0 to 63);
           key : in STD_LOGIC_VECTOR (0 to 127);
           msg_out : out STD_LOGIC_VECTOR (0 to 63));
end decrypt;

architecture Behavioral of decrypt is

    component decrypt_keys is
        Port ( key : in STD_LOGIC_VECTOR (0 to 127);
               DK : out list);
    end component;
    
    component IDEA_block is
        Port ( msg : in STD_LOGIC_VECTOR (0 to 63);
               key : in list;
               msg_out : out STD_LOGIC_VECTOR (0 to 63));
    end component;

    signal DK : list;

begin
    -- generate decryption keys
    gen_keys: decrypt_keys PORT MAP (key => key, DK => DK);
    
    apply_block: IDEA_block PORT MAP (msg => msg, key => DK, msg_out => msg_out);
end Behavioral;
