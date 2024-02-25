--PROGETTO DI:
-- Conti Alessandro     CP: 10710583    MATR: 955525
-- De Introna Federico  CP: 10796946    MATR: 960696

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity project_reti_logiche is
    port (
    i_clk : in std_logic;
    i_rst : in std_logic;
    i_start : in std_logic;
    i_w : in std_logic;
    o_z0 : out std_logic_vector(7 downto 0);
    o_z1 : out std_logic_vector(7 downto 0);
    o_z2 : out std_logic_vector(7 downto 0);
    o_z3 : out std_logic_vector(7 downto 0);
    o_done : out std_logic;
    o_mem_addr : out std_logic_vector(15 downto 0);
    i_mem_data : in std_logic_vector(7 downto 0);
    o_mem_we : out std_logic;
    o_mem_en : out std_logic
    );
end project_reti_logiche;
    
 
architecture project_reti_logiche_arch of project_reti_logiche is

    type S is (RST, READ_BIT2, READ_ADDR, ASK_MEM, READ_MEM , PUT_OUT);
    
    signal curr_state : S; 
    signal internal_done: std_logic; --Done interno così lo posso usare
--    signal out_rst : std_logic;  --Reset per i registri di uscita
    
    --Decoder
    signal decoder_en : std_logic;
    signal dec_out : std_logic_vector(3 downto 0);
    
    --Registri interni
    
    --Registro dell'indirizzo di memoria
    signal shift_reg : std_logic_vector(15 downto 0); --Registro
    signal shift_rst : std_logic;   --Reset per il registro che tiene l'indirizzo di memoria
    signal shift_reg_en : std_logic;  --Enable per lo shift_reg
    signal shift_to_mem : std_logic; --Enable per mandare lo shift_reg in memoria
    
    --Registro che fa da selettore per il decoder
    signal sel_reg : std_logic_vector(1 downto 0);  --Registro che tiene i 2 bit iniziali
    signal sel_reg_en : std_logic;  --Enable per il sel_reg
    
    --Registri di uscita
    signal z0_reg : std_logic_vector(7 downto 0);
    signal z1_reg : std_logic_vector(7 downto 0);
    signal z2_reg : std_logic_vector(7 downto 0);
    signal z3_reg : std_logic_vector(7 downto 0);
    
    
    
    
    
begin

  sel_reg_proc : process(i_clk,i_rst)
  --salvataggio dei primi due bit in uno shift register
    begin
        if i_rst = '1' then
        
            sel_reg <= "00";
      
        elsif i_clk'event and i_clk = '1' then
        
            if i_start = '1' and sel_reg_en = '1' then
            
                sel_reg(1) <= sel_reg(0);
                sel_reg(0) <= i_w;
                
            end if;
       end if;
    end process;

    shift_reg_proc : process(i_clk, shift_rst, i_rst)
      --salvataggio dei bit dell'indirizzo di memoria in uno shift register
        begin
        if i_rst = '1' or shift_rst = '1' then
        
            shift_reg <= "0000000000000000";
         
        elsif i_clk'event and i_clk = '1' then
       
            if i_start = '1' and shift_reg_en = '1' then
            
                shift_reg(15 downto 1) <= shift_reg(14 downto 0);
                shift_reg(0) <= i_w;
                
            end if;
           end if;
        end process;
        
        
        --Devo collegare il registro alla memoria, non so quale dei due metodi è migliore
        --E non so se il primo metodo va bene in generale
        --o_mem_addr <= shift_reg;
        
        ask_mem_proc: process(shift_reg)
        begin
           
                o_mem_addr <= shift_reg;
 
        end process;
        
        
     decoder : process(sel_reg, decoder_en)
    --Decoder per il write enable dei registri di uscita
     begin
     if decoder_en = '1' then
        case sel_reg is
            when "00" => dec_out <= "0001";
            when "01" => dec_out <= "0010";
            when "10" => dec_out <= "0100";
            when "11" => dec_out <= "1000";
            when others => dec_out <= "XXXX";
            
        end case;
     else dec_out <= "0000";
     end if;
     end process;
      
        
   --Registri di uscita, ricevono tutti in ingresso il dato della memoria
        z0_reg_proc : process(i_clk, i_rst) --out_rst
        begin
        if i_rst = '1' then --or out_rst = '1'
            z0_reg <= "00000000";
         elsif i_clk'event and i_clk = '1' then
            if dec_out(0) = '1' then
                z0_reg <= i_mem_data;
            end if;
         end if;
         end process;
         
     z1_reg_proc : process(i_clk, i_rst) --out_rst
        begin
        if i_rst = '1' then --or out_rst = '1'
            z1_reg <= "00000000";
         elsif i_clk'event and i_clk = '1' then
            if dec_out(1) = '1' then
                z1_reg <= i_mem_data;
            end if;
         end if;
         end process;
         
     z2_reg_proc : process(i_clk, i_rst) --out_rst
        begin
        if i_rst = '1'  then --or out_rst = '1' 
            z2_reg <= "00000000";
         elsif i_clk'event and i_clk = '1' then
            if dec_out(2) = '1' then
                z2_reg <= i_mem_data;
            end if;
         end if;
         end process;
         
    z3_reg_proc : process(i_clk, i_rst) --out_rst
        begin
        if i_rst = '1'  then --or out_rst = '1' then
            z3_reg <= "00000000";
         elsif i_clk'event and i_clk = '1' then
            if dec_out(3) = '1' then
                z3_reg <= i_mem_data;
            end if;
         end if;
         end process;
         
        
        
        
    
      --Uscita sempre a zero tranne quando il done interno è 1
    out_process : process(internal_done, z0_reg, z1_reg, z2_reg, z3_reg)
    begin
        if  internal_done = '1' then
            o_z0 <= z0_reg;
            o_z1 <= z1_reg;
            o_z2 <= z2_reg;
            o_z3 <= z3_reg;
            
        else 
            o_z0 <= "00000000";
            o_z1 <= "00000000";
            o_z2 <= "00000000";
            o_z3 <= "00000000";
            
        end if;
    end process;
    


--FSM

    fsm: process(i_clk, i_rst) --out_rst)
    begin
    
        if i_rst = '1' then
            curr_state <= RST;
        elsif i_clk'event and i_clk = '1' then
            case curr_state is
                when RST =>
                    if i_start = '1' then
                        curr_state <= READ_BIT2;
                    end if;
                    
                 when READ_BIT2 =>
                        curr_state <= READ_ADDR;
                    
                 when READ_ADDR =>
                    if i_start = '0' then
                        curr_state <= ASK_MEM;
                    end if;
                    
                 when ASK_MEM =>
                        curr_state <= READ_MEM;
                    
                 when READ_MEM =>
                        curr_state <= PUT_OUT;
                        
                 when PUT_OUT =>
                        curr_state <= RST;
            
            
            end case;
        end if;
    end process;


    fsm_lambda: process(curr_state)
    begin
    internal_done <= '0'; 
    o_done <= '0';          
    o_mem_we <= '0';        
    o_mem_en <= '0';        
    shift_rst <= '0';       
    shift_reg_en <= '0';    
    shift_to_mem <= '0';    
    sel_reg_en <= '0';  
    decoder_en <= '0'; 
 --   out_rst <= '0';
    
    case curr_state is 
        when RST =>  sel_reg_en <= '1';
                     shift_rst <= '1';
        
        when READ_BIT2 => sel_reg_en <= '1';
        
        when READ_ADDR => shift_reg_en <= '1';
        
        when ASK_MEM => shift_to_mem <= '1';
                        o_mem_en <= '1';
        
        when READ_MEM => decoder_en <= '1';
                       
        when PUT_OUT => o_done <= '1';
                        internal_done <= '1';
        end case;
        
    end process;
    



end project_reti_logiche_arch;
