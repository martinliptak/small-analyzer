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
		tokens = %w{a b d a}
		syntax_analyzer.analyze(tokens)
	end

	it "analyzes correct word" do
		tokens = %w{a d a}
		syntax_analyzer.analyze(tokens)
	end

	it "analyzes correct word" do
		tokens = %w{a a d}
		syntax_analyzer.analyze(tokens)
	end

	it "analyzes correct word" do
		tokens = %w{a a a a a a}
		syntax_analyzer.analyze(tokens)
	end

	it "word with unknown rule" do
		tokens = %w{a a b}
		lambda {
			syntax_analyzer.analyze(tokens)
		}.should raise_error Small::SyntaxAnalyzerUnknownError
	end

	it "word with unexpected terminal" do
		tokens = %w{a b a a}
		lambda {
			syntax_analyzer.analyze(tokens)
		}.should raise_error Small::SyntaxAnalyzerUnexpectedError
	end

	it "word with remaining terminals" do
		tokens = %w{a b d a a}
		lambda {
			syntax_analyzer.analyze(tokens)
		}.should raise_error Small::SyntaxAnalyzerRemainingError
	end
end
