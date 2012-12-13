require "rubygems"
require "bundler/setup"

require File.expand_path('lib/small', File.dirname(__FILE__))

$debug = true

file = if ARGV[0]
	File.open(ARGV[0], 'r')
else
	$stdin
end
input = file.read

lexical_analyzer = Small::LexicalAnalyzer.new
lexical_definitions_file = File.expand_path('definitions/terminals.rb', 
	File.dirname(__FILE__))
lexical_analyzer.terminals = eval(File.read(lexical_definitions_file))

syntax_analyzer = Small::SyntaxAnalyzer.new
syntax_definitions_file = File.expand_path('definitions/table.rb', 
	File.dirname(__FILE__))
syntax_analyzer.table = eval(File.read(syntax_definitions_file))
syntax_analyzer.initial = :program

begin
	tokens = lexical_analyzer.analyze(input)
	#syntax_analyzer.analyze(tokens)
rescue Small::AnalyzerError => error
	puts error
end