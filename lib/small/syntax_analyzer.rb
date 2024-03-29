module Small
	class SyntaxAnalyzerError < AnalyzerError
	end

	class SyntaxAnalyzer < Analyzer
		attr_accessor :table, :initial

		def initialize(table = nil, initial = nil)
			@table = table
			@initial = initial
		end

		def analyze(tokens)
			stack = []
			errors = []

			puts "Syntax analysis" if $debug

			stack.push initial
			
			i = 0
			while i < tokens.count
				puts "Stack #{stack.reverse.map{|a| a.is_a?(Symbol) ? ":#{a}" : a}.join(' ')}" if $debug

				token = tokens[i][0]
				line_number = tokens[i][1]
				line = tokens[i][2]

				top = stack.pop

				if top.nil?
					# remaining terminals, no recovery
					errors << "Syntax error: Found #{token} where EOF expected on line #{line_number}: #{line}"

					puts "Syntax error: Found #{token} where EOF expected on line #{line_number}: #{line}" if $debug

					break
				elsif top.is_a?(Symbol)
					# non-terminal
					if table[top] and table[top][token]
						# found rule, continue with added stack items
						puts "Using rule :#{top}" if $debug
						stack += table[top][token].reverse
					else
						# no rule, continue with next stack item
						errors << "Syntax error: Unexpected #{token} on line #{line_number}: #{line}"

						puts "Syntax error: Unexpected #{token} on line #{line_number}: #{line}" if $debug
					end
				elsif top == token
					# expected terminal, continue with next stack item and next terminal
					puts "Found expected terminal #{top}" if $debug
					i += 1
				else
					# unexpected terminal, continue with next stack item
					errors << "Syntax error: Found #{token} where #{top} expected on line #{line_number}: #{line}"

					puts "Syntax error: Found #{token} where #{top} expected on line #{line_number}: #{line}" if $debug
				end	
			end

			# raise if any erros
			raise SyntaxAnalyzerError.new(errors.join("\n")) if errors.any?
		end
	end
end