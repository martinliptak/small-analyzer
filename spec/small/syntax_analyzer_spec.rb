require 'spec_helper'

describe Small::SyntaxAnalyzer do

	let(:syntax_analyzer) {
		syntax_analyzer = Small::SyntaxAnalyzer.new
		syntax_analyzer.table = {
			:S => {
				'a' => ['a', :A, :B, 'a'], 
				'b' => ['b', :B]
			}, 
			:A => {
				'a' => [:D, 'a'], 
				'b' => ['b', :B, 'd'], 
				'd' => [:D, 'a']
			},
			:B => {
				'a' => [], 
				'd' => []
			},
			:D => {
				'a' => ['a', :D], 
				'd' => ['d']
			}
		}
		syntax_analyzer.initial = :S
		syntax_analyzer
	}

	it "analyzes correct word" do
		tokens = [['a', 1, ''], ['b', 1, ''], ['d', 1, ''], ['a', 1, '']]
		syntax_analyzer.analyze(tokens)
	end

	it "analyzes correct word" do
		tokens = [['a', 1, ''], ['d', 1, ''], ['a', 1, ''],]
		syntax_analyzer.analyze(tokens)
	end

	it "analyzes correct word" do
		tokens = [['a', 1, ''], ['a', 1, ''], ['d', 1, ''],]
		syntax_analyzer.analyze(tokens)
	end

	it "analyzes correct word" do
		tokens = [['a', 1, ''], ['a', 1, ''], ['a', 1, ''], ['a', 1, ''], 
			['a', 1, ''], ['a', 1, ''],]
		syntax_analyzer.analyze(tokens)
	end

	it "word with unknown rule" do
		tokens = [['a', 1, ''], ['a', 1, ''], ['b', 1, ''],]
		lambda {
			syntax_analyzer.analyze(tokens)
		}.should raise_error Small::SyntaxAnalyzerError, /\ASyntax error: Unexpected b on line 1:/
	end

	it "word with unexpected terminal" do
		tokens = [['a', 1, ''], ['b', 1, ''], ['a', 1, ''], ['a', 1, ''],]
		lambda {
			syntax_analyzer.analyze(tokens)
		}.should raise_error Small::SyntaxAnalyzerError, /\ASyntax error: Found a where d expected on line 1:/
	end

	it "word with remaining terminals" do
		tokens = [['a', 1, ''], ['b', 1, ''], ['d', 1, ''], ['a', 1, ''], ['a', 1, ''],]
		lambda {
			syntax_analyzer.analyze(tokens)
		}.should raise_error Small::SyntaxAnalyzerError, /\ASyntax error: Found a where EOF expected on line 1:/
	end
end
