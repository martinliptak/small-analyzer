require './lib/small'

class IntegrationSetup

  def initialize
    
    @lexical_analyzer = Small::LexicalAnalyzer.new
    @lexical_analyzer.terminals = eval(File.read('./definitions/terminals.rb'))

    @syntax_analyzer = Small::SyntaxAnalyzer.new
    @syntax_analyzer.table = eval(File.read('./definitions/table.rb'))
    @syntax_analyzer.initial = :program
    
  end

  def run(input)
    @syntax_analyzer.analyze(@lexical_analyzer.analyze(input))
  end

end
