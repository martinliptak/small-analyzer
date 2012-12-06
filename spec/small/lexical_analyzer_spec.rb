require 'spec_helper'

describe Small::LexicalAnalyzer do

	let(:lexical_analyzer) {
		lexical_analyzer = Small::LexicalAnalyzer.new
		lexical_analyzer.terminals = [
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
		lexical_analyzer
	}

	it "analyzes correct input" do
		input = "BEGIN\n\tIF TRUE THEN \n \t WRITE(a);\n\tELSE \n \t WRITE(b);\n"
		tokens = lexical_analyzer.analyze(input)
		tokens.should == [
			['BEGIN', 1, 'BEGIN'], 
			['IF', 2, 'IF TRUE THEN'], 
			['TRUE', 2, 'IF TRUE THEN'], 
			['THEN', 2, 'IF TRUE THEN'], 
			['WRITE', 3, 'WRITE(a);'], 
			['(', 3, 'WRITE(a);'], 
			['a', 3, 'WRITE(a);'], 
			[')', 3, 'WRITE(a);'], 
			[';', 3, 'WRITE(a);'], 
			['ELSE', 4, 'ELSE'], 
			['WRITE', 5, 'WRITE(b);'], 
			['(', 5, 'WRITE(b);'], 
			['b', 5, 'WRITE(b);'], 
			[')', 5, 'WRITE(b);'], 
			[';', 5, 'WRITE(b);']
		]
	end

	it "analyzes incorrect input" do
		input = "BEGIN\n\t%\nIF TRUE THEN \n \t WRITE(a) $;\n\tELSE \n \t WRITE(b);\n"
		lambda {
			lexical_analyzer.analyze(input)
		}.should raise_error Small::LexicalAnalyzerError
	end
	
end