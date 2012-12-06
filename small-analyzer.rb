#!/usr/bin/ruby

require File.expand_path('lib/small', File.dirname(__FILE__))

file = if ARGV[0]
	File.open(ARGV[0], 'r')
else
	$stdin
end
input = file.read

lexical_analyzer = Small::LexicalAnalyzer.new

begin
	tokens = lexical_analyzer.analyze(input)
	tokens.each { |token|
		puts token
	}
rescue Small::AnalyzerError => error
	puts error
end