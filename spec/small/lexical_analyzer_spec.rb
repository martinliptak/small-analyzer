require 'spec_helper'

describe Small::LexicalAnalyzer do

	let(:lexical_analyzer) {
		lexical_analyzer = Small::LexicalAnalyzer.new
		lexical_analyzer.terminals = eval(File.read('./definitions/terminals.rb'))
		lexical_analyzer
	}

	it "analyzes correct input" do
		input = "BEGIN\n\tIF TRUE THEN \n \t WRITE(aa);\n\tELSE \n \t WRITE(b); \n335\na2i"
		tokens = lexical_analyzer.analyze(input)
		tokens.should == [
			['BEGIN', 1, 'BEGIN'], 
			['IF', 2, 'IF TRUE THEN'], 
			['TRUE', 2, 'IF TRUE THEN'], 
			['THEN', 2, 'IF TRUE THEN'], 
			['WRITE', 3, 'WRITE(aa);'], 
			['(', 3, 'WRITE(aa);'], 
			['LETTER', 3, 'WRITE(aa);'], 
			['LETTER', 3, 'WRITE(aa);'],
			[')', 3, 'WRITE(aa);'], 
			[';', 3, 'WRITE(aa);'], 
			['ELSE', 4, 'ELSE'], 
			['WRITE', 5, 'WRITE(b);'], 
			['(', 5, 'WRITE(b);'], 
			['LETTER', 5, 'WRITE(b);'], 
			[')', 5, 'WRITE(b);'], 
			[';', 5, 'WRITE(b);'], 
			['DIGIT', 6, '335'],
			['DIGIT', 6, '335'],
			['DIGIT', 6, '335'],
			['LETTER', 7, 'a2i'],
			['DIGIT', 7, 'a2i'],
			['LETTER', 7, 'a2i']
		]
	end

	it "analyzes incorrect input" do
		input = "BEGIN\n\t%\nIF TRUE THEN \n \t WRITE(a) $;\n\tELSE \n \t WRITE(b);\n"
		lambda {
			lexical_analyzer.analyze(input)
		}.should raise_error Small::LexicalAnalyzerError
	end
	
end