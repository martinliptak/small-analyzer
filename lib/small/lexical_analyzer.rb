module Small
	class LexicalAnalyzerError < AnalyzerError
	end

	class LexicalAnalyzer < Analyzer
		TERMINALS = [
			/\A(BEGIN)/, 
			/\A(END)/, 
			/\A(:=)/, 
			/\A(READ)/, 
			/\A(WRITE)/, 
			/\A(\()/, 
			/\A(\))/, 
			/\A(;)/, 
			/\A(IF)/, 
			/\A(THEN)/, 
			/\A(ELSE)/, 
			/\A(,)/, 
			/\A(\+)/, 
			/\A(-)/, 
			/\A(OR)/, 
			/\A(END)/, 
			/\A(NOT)/, 
			/\A(TRUE)/, 
			/\A(FALSE)/, 
			/\A(\w)/,
			/\A(\d)/
		]

		def initialize
		end

		def analyze(input)
			terminals = []
			errors = []
			i = 0
			while i < input.length
				if input[i..-1] =~ /\A(\s+)/ 	# skip white characters
					i += $1.length
				else
					found = false
					for t in TERMINALS
						if t =~ input[i..-1]	# match tokens to terminals
							i += $1.length 		# next token
							terminals << $1 	# add to terminals
							found = true
							break
						end
					end
					unless found
						# add to errors
						line_number = input[0..i].lines.count
						line = input.lines.to_a[line_number - 1].strip
						errors << "Lexical error at line #{line_number}: #{line}"

						i += 1 					# skip character and continue
					end
				end
			end

			# raise if any erros
			raise LexicalAnalyzerError.new(errors.join("\n")) if errors.any?

			terminals
		end
	end
end