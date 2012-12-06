module Small
	autoload :Analyzer, File.expand_path('small/analyzer', File.dirname(__FILE__))
	autoload :AnalyzerError, File.expand_path('small/analyzer', File.dirname(__FILE__))
	autoload :LexicalAnalyzer, File.expand_path('small/lexical_analyzer', File.dirname(__FILE__))
	autoload :LexicalAnalyzerError, File.expand_path('small/lexical_analyzer', File.dirname(__FILE__))
	autoload :SyntaxAnalyzer, File.expand_path('small/syntax_analyzer', File.dirname(__FILE__))
	autoload :SyntaxAnalyzerError, File.expand_path('small/syntax_analyzer', File.dirname(__FILE__))
end