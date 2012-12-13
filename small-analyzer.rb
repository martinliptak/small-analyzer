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
		puts "#{token[0]}\t\t#{token[1]}\t#{token[2]}"
	}
	#syntax_analyzer.analyze(tokens)
rescue Small::AnalyzerError => error
	puts error
end