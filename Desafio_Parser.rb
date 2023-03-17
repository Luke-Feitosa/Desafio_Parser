require_relative 'modelos/jogo'
require_relative 'modulo/parse_log'
class QuakeLogParser
	
	def self.ler_arquivo (arquivo = 'games.log')
      linhas_array = []
      arquivo = File.open(arquivo, 'r')
      arquivo.each_line {|linha| linhas_array << linha}

	  linhas_array
	end

	def self.parse_jogos(arquivo = 'games.log')
		linhas_log = QuakeLogParser.ler_arquivo(arquivo)		
		
		jogos = []
		inicio_jogo_linha = nil

		linhas_log.each_with_index do |linha_log, index|

			if ParseLog.inicio_jogo_linha?(linha_log)
				inicio_jogo_linha = index
			
			elsif ParseLog.fim_jogo_linha?(linha_log)
				fim_jogo_linha = index - inicio_jogo_linha.to_i + 1
				jogos << (Jogo.new linhas_log[inicio_jogo_linha, fim_jogo_linha] ,"game_#{jogos.count+1}") unless inicio_jogo_linha.nil?
				inicio_jogo_linha = nil
			end
		end
		jogos
	end
end