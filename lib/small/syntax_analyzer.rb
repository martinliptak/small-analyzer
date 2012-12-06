module Small
	class SyntaxAnalyzerError < AnalyzerError
	end

	class SyntaxAnalyzerRemainingError < SyntaxAnalyzerError
	end

	class SyntaxAnalyzerUnknownError < SyntaxAnalyzerError
	end

	class SyntaxAnalyzerUnexpectedError < SyntaxAnalyzerError
	end

	class SyntaxAnalyzer < Analyzer
		attr_accessor :table, :initial

		def initialize(table = nil, initial = nil)
			@table = table
			@initial = initial
		end

		def analyze(tokens)
			stack = []
			stack.push initial
			i = 0
			while i < tokens.count
				#puts stack.reverse.map{|a| a.is_a?(Symbol) ? ":#{a}" : a}.join(' ')
				t = tokens[i]
				s = stack.pop
				if s.nil?
					# remaining terminals
					raise SyntaxAnalyzerRemainingError.new("Syntax error: Remaining terminal #{t}")
				elsif s.is_a?(Symbol)
					# non-terminal
					if table[s] and table[s][t]
						stack += table[s][t].reverse
					else
						raise SyntaxAnalyzerUnknownError.new("Syntax error: Unknow rule for #{t} with stack on #{s}")
					end
				elsif s.is_a?(String) and s == t
					# expected terminal
					i += 1
				else
					# unexpected terminal
					raise SyntaxAnalyzerUnexpectedError.new("Syntax error: Unexpected terminal #{t} ")
				end	
			end
		end
	end
end