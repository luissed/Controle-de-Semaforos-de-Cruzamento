library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_semaforoPedestres_Vertical is
end tb_semaforoPedestres_Vertical;

architecture testbench of tb_semaforoPedestres_Vertical is
	-- Sinais de entrada do Testbench
	signal clk	: STD_LOGIC;
	signal reset	: STD_LOGIC	:= '0';
	
	-- Sinais de saída do Testbench
	signal verde_semaforoPedestres		:	STD_LOGIC							:= '1';
	signal vermelho_semaforoPedestres	:	STD_LOGIC							:= '0';
	signal estado_semaforoPedestres		:	STD_LOGIC_VECTOR(1 downto 0)	:= "01";

	constant CLOCK_PERIOD	: time := 20 ns;
	
	begin 
  -- Instantiate the Unit Under Test (UUT)
	uut: entity work.semaforoPedestres_Vertical
		port map (
			clk               		=> clk,
			reset							=> reset,
			verde_semaforoPedestres		=> verde_semaforoPedestres,
			vermelho_semaforoPedestres	=> vermelho_semaforoPedestres,
			estado_semaforoPedestres	=> estado_semaforoPedestres
		);
	
  -- Clock Process
	process
	begin
		clk <= '1';
		wait for CLOCK_PERIOD/2; -- Metade do período
		clk <= '0';
		wait for CLOCK_PERIOD/2; -- Metade do período
	end process;
	
	resetar: process
	begin
		reset <= '1';
		wait for CLOCK_PERIOD * 2; -- Metade do período
		reset <= '0';
		wait for CLOCK_PERIOD * 2; -- Metade do período
		
		wait;
	end process resetar;
	
	
end testbench;
