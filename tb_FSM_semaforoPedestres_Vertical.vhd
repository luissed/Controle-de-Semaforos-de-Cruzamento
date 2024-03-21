----- TB do semáforo de carros: tb_FSM_semaforoPedestres_Vertical.vhdl -----

---- Bibliotecas necessárias ----
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Entidade Testbench vazia ----
entity tb_FSM_semaforoPedestres_Vertical is
end tb_FSM_semaforoPedestres_Vertical;

---- Arquitetura do Testbench ----
architecture testbench of tb_FSM_semaforoPedestres_Vertical is
	-- Sinais de entrada do Testbench
	signal clk								: STD_LOGIC;
	signal reset							: STD_LOGIC := '0';
	signal fim_tempoVerde_pedestres		: STD_LOGIC := '0';
	signal fim_tempoVermelho_pedestres	: STD_LOGIC := '0';
	
	-- Sinais de saída do Testbench
	signal verde_semaforoPedestres		: STD_LOGIC 							:= '1';
	signal vermelho_semaforoPedestres	: STD_LOGIC 							:= '0';
	signal estado_semaforoPedestres		: STD_LOGIC_VECTOR(1 downto 0)	:= "01";
	signal reset_cronometro 				: STD_LOGIC 							:= '0';

	-- Clock de simulação (50 MHz)
	constant clk_period : time := 20 ns;  -- Pode ser ajustado conforme necessário
begin
	-- Instanciando o semáforo
	uut: entity work.FSM_semaforoPedestres_Vertical
		port map (
			clk									=> clk,
			reset									=> reset,
			fim_tempoVerde_pedestres		=> fim_tempoVerde_pedestres,
			fim_tempoVermelho_pedestres	=> fim_tempoVermelho_pedestres,
			verde_semaforoPedestres			=> verde_semaforoPedestres,
			vermelho_semaforoPedestres		=> vermelho_semaforoPedestres,
			estado_semaforoPedestres		=>	estado_semaforoPedestres,
			reset_cronometro					=>	reset_cronometro
		);

	-- Processo de clock
	process
	begin
		clk <= '0';
		wait for clk_period/2; -- Metade do período
		clk <= '1';
		wait for clk_period/2; -- Metade do período
	end process;

	-- Processo de estímulo
	estimulos: process
	begin
		-- Aguarda alguns ciclos antes de ativar o reset
		wait for clk_period;
		reset <= '1';

		-- Aguarda mais alguns ciclos antes de desativar o reset
		wait for clk_period * 2;
		reset <= '0';
		
		-- Aguarda mais alguns ciclos para atingir o tempo do verde		
		wait for clk_period * 4;
		fim_tempoVerde_pedestres <= '1';
		
		-- Aguarda mais alguns ciclos para zerar o verde		
		wait for clk_period * 4;
		fim_tempoVerde_pedestres <= '0';		
		
		-- Aguarda mais alguns ciclos para atingir o tempo do vermelho		
		wait for clk_period * 4;
		fim_tempoVermelho_pedestres <= '1';
		
		-- Aguarda mais alguns ciclos para zerar o tempo		
		wait for clk_period * 4;
		fim_tempoVermelho_pedestres <= '0';

		-- Termina a simulação
		wait;
	end process estimulos;

end testbench;
