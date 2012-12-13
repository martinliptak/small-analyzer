require 'spec_helper'

describe Small::LexicalAnalyzer do

	let(:lexical_analyzer) {
		lexical_analyzer = Small::LexicalAnalyzer.new
		lexical_analyzer.terminals = {
			/\A(BEGIN)/ => 'BEGIN', 
			/\A(END)/ => 'END', 
			/\A(:=)/ => ':=', 
			/\A(READ)/ => 'READ', 
			/\A(WRITE)/ => 'WRITE', 
			/\A(\()/ => '(', 
			/\A(\))/ => ')', 
			/\A(;)/ => ';', 
			/\A(IF)/ => 'IF', 
			/\A(THEN)/ => 'THEN', 
			/\A(ELSE)/ => 'ELSE', 
			/\A(,)/ => ',', 
			/\A(\+)/ => '+', 
			/\A(-)/ => '-', 
			/\A(OR)/ => 'OR', 
			/\A(END)/ => 'END', 
			/\A(NOT)/ => 'NOT', 
			/\A(TRUE)/ => 'TRUE', 
			/\A(FALSE)/ => 'FALSE', 
			/\A(\d+)/ => 'NUMBER',
			/\A(\w[\w\d]*)/ => 'IDENTIFIER'
		}
		lexical_analyzer
	}

	it "analyzes correct input" do
		input = "BEGIN\n\tIF TRUE THEN \n \t WRITE(aa);\n\tELSE \n \t WRITE(b); \n335\nadd21integers"
		tokens = lexical_analyzer.analyze(input)
		tokens.should == [
			['BEGIN', 1, 'BEGIN'], 
			['IF', 2, 'IF TRUE THEN'], 
			['TRUE', 2, 'IF TRUE THEN'], 
			['THEN', 2, 'IF TRUE THEN'], 
			['WRITE', 3, 'WRITE(aa);'], 
			['(', 3, 'WRITE(aa);'], 
			['IDENTIFIER', 3, 'WRITE(aa);'], 
			[')', 3, 'WRITE(aa);'], 
			[';', 3, 'WRITE(aa);'], 
			['ELSE', 4, 'ELSE'], 
			['WRITE', 5, 'WRITE(b);'], 
			['(', 5, 'WRITE(b);'], 
			['IDENTIFIER', 5, 'WRITE(b);'], 
			[')', 5, 'WRITE(b);'], 
			[';', 5, 'WRITE(b);'], 
			['NUMBER', 6, '335'],
			['IDENTIFIER', 7, 'add21integers']
		]
	end

	it "analyzes incorrect input" do
		input = "BEGIN\n\t%\nIF TRUE THEN \n \t WRITE(a) $;\n\tELSE \n \t WRITE(b);\n"
		lambda {
			lexical_analyzer.analyze(input)
		}.should raise_error Small::LexicalAnalyzerError
	end
	
end