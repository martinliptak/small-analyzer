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
		tokens.should == ['BEGIN', 'IF', 'TRUE', 'THEN', 'WRITE', '(', 'a', ')', ';',
			'ELSE', 'WRITE', '(', 'b', ')', ';']
	end

	it "analyzes incorrect input" do
		input = "BEGIN\n\t%\nIF TRUE THEN \n \t WRITE(a) $;\n\tELSE \n \t WRITE(b);\n"
		lambda {
			lexical_analyzer.analyze(input)
		}.should raise_error Small::LexicalAnalyzerError
	end
	
end