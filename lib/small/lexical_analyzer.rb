module Small
	class LexicalAnalyzerError < AnalyzerError
	end

	class LexicalAnalyzer < Analyzer
		attr_accessor :terminals

		def initialize(terminals = nil)
			@terminals = terminals
		end

		def analyze(input)
			tokens = []
			errors = []
			i = 0
			puts "Lexical analysis" if $debug
			while i < input.length
				if input[i..-1] =~ /\A(\s+)/ 	# skip white characters
					i += $1.length
				else
					line_number = input[0..i].lines.count
					line = input.lines.to_a[line_number - 1].strip

					found = false
					# match tokens to terminals
					for t in terminals.keys
						if t =~ input[i..-1]	
							i += $1.length 									# next token
							tokens << [terminals[t], line_number, line] 	# add to tokens
							found = true
							puts "Found terminal #{terminals[t]} at #{line_number}" if $debug
							break
						end
					end
					unless found
						# add to errors
						errors << "Lexical error at line #{line_number}: #{line}"

						puts "Lexical error at line #{line_number}: #{line}" if $debug
						
						# skip character and continue
						i += 1 
					end
				end
			end

			# raise if any erros
			raise LexicalAnalyzerError.new(errors.join("\n")) if errors.any?

			tokens
		end
	end
end