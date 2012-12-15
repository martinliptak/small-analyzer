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
			regexp = /\A(BEGIN|END|:=|READ|WRITE|\(|\)|;|IF|THEN|ELSE|,|\+|\-|OR|AND|NOT|TRUE|FALSE|[a-z]|[0-9])/

			puts "Lexical analysis" if $debug
			
			input.lines.each_with_index do |line, i|
			
				line.strip!
				buffer = line.dup
			
				while buffer.length > 0 do

					buffer.lstrip!
					result = buffer.match(regexp)

					if result.nil?
						errors << "Lexical error at line #{i+1}: #{line}"	
						buffer.slice!(0, 1)
					else
						tokens << [ @terminals[result[1]], i+1, line ]
						puts "Found terminal #{result[1]} at #{i+1}" if $debug
						
						buffer.slice!(0, result[1].length)
					end
										
				end
			
			end
			
			# raise if any erros
			raise LexicalAnalyzerError.new(errors.join("\n")) if errors.any?

			tokens
			
		end
	end
end