require "rubygems"
require "bundler/setup"

require File.expand_path('lib/small', File.dirname(__FILE__))

file = if ARGV[0]
	File.open(ARGV[0], 'r')
else
	$stdin
end
input = file.read

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

syntax_analyzer = Small::SyntaxAnalyzer.new
syntax_analyzer.table = {
	:P => {
		'BEGIN' => []
	}
}
syntax_analyzer.initial = :P

begin
	tokens = lexical_analyzer.analyze(input)
	tokens.each { |token|
		puts token
	}
	#syntax_analyzer.analyze(tokens)
rescue Small::AnalyzerError => error
	puts error
end