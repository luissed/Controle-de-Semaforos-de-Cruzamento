----- TB do comparador: tb_comparador_semaforoPedestres_Vertical.vhdl -----

---- Bibliotecas necessárias ----
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Entidade Testbench vazia ----
entity tb_comparador_semaforoPedestres_Vertical is
end tb_comparador_semaforoPedestres_Vertical;

---- Arquitetura do Testbench ----
architecture testbench of tb_comparador_semaforoPedestres_Vertical is
	-- Sinais de entrada do Testbench
	signal clk					: STD_LOGIC := '0'; -- Clock
	signal reset_cronometro	: STD_LOGIC := '0'; -- Reset do cronômetro
	signal segundos			: INTEGER	:= 0; -- Segundos passados
	
	-- Sinais de saída do Testbench
	signal fim_tempoVerde_pedestres			: STD_LOGIC := '0'; -- Sinal de entrada se o tempo da luz verde do semáforo de carros atingiu o limite
	signal fim_tempoVermelho_pedestres		: STD_LOGIC := '0'; -- Sinal de entrada se o tempo da luz vermelha do semáforo de carros atingiu o limite

	-- Clock de simulação (50 MHz)
	constant clk_period : time := 20 ns;  -- Clock ajustado para 50 MHz
begin
	-- Instanciando o comparador
	uut: entity work.comparador_semaforoPedestres_Vertical
		port map (
			clk								=> clk,
			reset_cronometro				=> reset_cronometro,
			segundos							=> segundos,
			fim_tempoVerde_pedestres	=> fim_tempoVerde_pedestres,
			fim_tempoVermelho_pedestres	=> fim_tempoVermelho_pedestres
		);

	-- Processo de clock
	process
	begin
		clk <= '1';
		wait for clk_period/2; -- Metade do período
		clk <= '0';
		wait for clk_period/2; -- Metade do período
	end process;	
	
	-- Processo de estimulos
	stim: process
	begin
		for i in 0 to 17 loop -- Vai de 0 a 12 segundos
			wait for clk_period * 5; -- Cada segundo demora 5 picos de clocks
			segundos <= i; -- Segundos recebe o valor de i de 0 a 12
		end loop;
		
		reset_cronometro <= '1'; -- Reseta o cronômetro
		segundos <= 0; -- Segundos recebe 0
		wait for clk_period; -- Aguardo 1 pico de clock
		reset_cronometro <= '0'; -- Retira o reset do cronômetro
		
		wait; -- Aguarda infinitamente
	end process stim;		

end testbench;
