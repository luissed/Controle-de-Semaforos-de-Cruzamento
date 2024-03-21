----- TB do cronômetro: tb_cronometro_semaforoCarros_Vertical.vhdl -----

---- Bibliotecas necessárias ----
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Entidade Testbench vazia ----
entity tb_cronometro_semaforoCarros_Vertical is
end tb_cronometro_semaforoCarros_Vertical;

---- Arquitetura do Testbench ----
architecture testbench of tb_cronometro_semaforoCarros_Vertical is
	-- Sinais de entrada do Testbench
	signal clk					:	STD_LOGIC := '0';
	signal reset_cronometro	:	STD_LOGIC := '0';
	
	-- Sinais de saída do Testbench
	signal segundos	:	INTEGER := 0;

	-- Clock de simulação (50 MHz)
	constant	clk_period	:	time :=	20 ns;
begin
	-- Instanciando a entidade semáforo
	uut: entity work.cronometro_semaforoCarros_Vertical
		port map (
			clk						=>	clk,
			reset_cronometro		=>	reset_cronometro,
			segundos					=>	segundos
		);

	-- Processo de geração de clock
	process
	begin
		clk <= '1';
		wait for clk_period/2; -- Metade do período para subida
		clk <= '0';
		wait for clk_period/2; -- Metade do período para descida
	end process;	
	
	-- Processo de geração do reset
	resetar: process
	begin
		reset_cronometro <= '1'; -- Reseta o cronômetro
		wait for clk_period; -- Aguardo um pulso do clock (20 ns)
		reset_cronometro <= '0'; -- reset_cronometro começa como 0
		wait for clk_period*50; -- Aguarda 50 períodos de clock (1000 ns)
		reset_cronometro <= '1'; -- Reseta o cronômetro
		wait for clk_period; -- Aguarda 1 pulso de clock (20 ns)
		reset_cronometro <= '0'; -- Tira o reset do cronômetro
		wait; -- Espera infinitamente até o fim do programa
	end process resetar;		

end testbench;
