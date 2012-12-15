require './spec/integration/setup'

describe 'Valid SMALL programs' do

  before :all do
    @a = IntegrationSetup.new
  end

  it 'example 1' do
    begin
      @a.run(
<<-SMALL
        BEGIN
          a := 5 * 35;
        END
SMALL
      )
    rescue Small::LexicalAnalyzerError => e
      e.message.should_not be_empty
      e.message.should =~ /Lexical error at line 2/
    end
  end

  it 'example 2' do
    begin
      @a.run(
<<-SMALL
        BEGIN
          READ(input);
          doubled := input + input; # just simple comment
          WRITE(doubled);
        END
SMALL
      )
    rescue Small::LexicalAnalyzerError => e
      e.message.should_not be_empty
      e.message.should =~ /Lexical error at line 3/
    end
  end

  it 'example 3' do
    begin
      @a.run(
<<-SMALL
        BEGIN
          READ(input);
          WRITE(input % 5);
        END
SMALL
      )
    rescue Small::LexicalAnalyzerError => e
      e.message.should_not be_empty
      e.message.should =~ /Lexical error at line 3/
    end
  end

  it 'example 4' do
    begin
      @a.run(
<<-SMALL
        BEGIN
          READ(a, b);
          
          IF TRUE == FALSE THEN
            WRITE(nonexistingidentifier + a - b);
          ELSE IF (FALSE AND NOT FALSE) OR ((TRUE) OR NOT TRUE) THEN
            WRIE(a, 2 + a - b, b + a);
          ELSE
            WRITE(-1); 
          ;;
        ED
SMALL
      ).should_not raise_error
    rescue Small::LexicalAnalyzerError => e
      e.message.should_not be_empty
      e.message.should =~ /Lexical error at line 4/
      e.message.should =~ /Lexical error at line 7/
      e.message.should =~ /Lexical error at line 11/
    end
  end
  
  it 'example 4' do
    begin
      @a.run(
<<-SMALL
        BEGIN
          READ(a, b);
          
          IF TRUE == FALSE THEN
            WRITE(nonexistingidentifier + a - b);
          ELSE IF (FALSE AND NOT FALSE) OR ((TRUE) OR NOT TRUE) THEN
            WRIE(a, 2 + a - b, b + a);
          ELSE
            WRITE(-1); 
          ;;
        ED
SMALL
      ).should_not raise_error
    rescue Small::LexicalAnalyzerError => e
      errors = e.message.split "\n"
      errors.length.should == 3
    end
  end
  
end