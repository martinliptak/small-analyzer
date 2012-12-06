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
			while i < input.length
				if input[i..-1] =~ /\A(\s+)/ 	# skip white characters
					i += $1.length
				else
					found = false
					for t in terminals
						if t =~ input[i..-1]	# match tokens to terminals
							i += $1.length 		# next token
							tokens << $1 		# add to tokens
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

			tokens
		end
	end
end