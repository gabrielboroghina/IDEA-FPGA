library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

library work;
use work.types.ALL;


entity IDEA_block is
    Port ( msg : in STD_LOGIC_VECTOR (0 to 63);
           key : in list;
           msg_out : out STD_LOGIC_VECTOR (0 to 63));
end IDEA_block;

architecture Behavioral of IDEA_block is
    component mul is
        Port ( a, b : in unsigned (15 downto 0);
               res : out unsigned (15 downto 0));
    end component;

    type arr7 is array (1 to 8) of unsigned (15 downto 0);
    type arr9 is array (0 to 9) of unsigned (15 downto 0);
    signal x1k1, x2k2, x3k3, x4k4, xor13, xor24, mul_k5, add_k5, mul_k6, add_k6 : arr7;
    signal M1, M2, M3, M4 : arr9;
begin
    M1(0) <= unsigned(msg(0 to 15));
    M2(0) <= unsigned(msg(16 to 31));
    M3(0) <= unsigned(msg(32 to 47));
    M4(0) <= unsigned(msg(48 to 63));
    
    rounds_8: for i in 1 to 8 generate
        mul1: mul PORT MAP (a => M1(i - 1), b => unsigned(key((i - 1) * 6 + 1)), res => x1k1(i));
        x2k2(i) <= M2(i - 1) + unsigned(key((i - 1) * 6 + 2));
        x3k3(i) <= M3(i - 1) + unsigned(key((i - 1) * 6 + 3));
        mul4: mul PORT MAP (a => M4(i - 1), b => unsigned(key((i - 1) * 6 + 4)), res => x4k4(i));
        
        xor13(i) <= x1k1(i) xor x3k3(i);
        xor24(i) <= x2k2(i) xor x4k4(i);
        
        mulk5: mul PORT MAP (a => xor13(i), b => unsigned(key((i - 1) * 6 + 5)), res => mul_k5(i));
        add_k5(i) <= mul_k5(i) + xor24(i);
        
        mulk6: mul PORT MAP (a => add_k5(i), b => unsigned(key((i - 1) * 6 + 6)), res => mul_k6(i));
        add_k6(i) <= mul_k5(i) + mul_k6(i);
        
        M1(i) <= x1k1(i) xor mul_k6(i);
        M2(i) <= x3k3(i) xor mul_k6(i);
        M3(i) <= x2k2(i) xor add_k6(i);
        M4(i) <= x4k4(i) xor add_k6(i);
    end generate; 
    
    -- last half-round
    mul8_5_1: mul PORT MAP (a => M1(8), b => unsigned(key(49)), res => M1(9));
    M2(9) <= M3(8) + unsigned(key(50));
    M3(9) <= M2(8) + unsigned(key(51));
    mul8_5_4: mul PORT MAP (a => M4(8), b => unsigned(key(52)), res => M4(9));
    
    msg_out(0 to 15) <= std_logic_vector(M1(9));
    msg_out(16 to 31) <= std_logic_vector(M2(9));
    msg_out(32 to 47) <= std_logic_vector(M3(9));
    msg_out(48 to 63) <= std_logic_vector(M4(9));
end Behavioral;
