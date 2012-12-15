require './spec/integration/setup'

describe 'Valid SMALL programs' do

  before :all do
    @a = IntegrationSetup.new
  end

  it 'example 1' do
    @a.run(
<<-SMALL
        BEGIN
          a := 35;
        END
SMALL
    ).should_not raise_error
  end

  it 'example 2' do
    @a.run(
<<-SMALL
        BEGIN
          READ(input);
          doubled := input + input;
          WRITE(doubled);
        END
SMALL
    ).should_not raise_error
  end

  it 'example 3' do
    @a.run(
<<-SMALL
        BEGIN
          READ(input);
          WRITE(input + input - 1);
        END
SMALL
    ).should_not raise_error
  end
  
  it 'example 4' do
    @a.run(
<<-SMALL
        BEGIN
          READ(input);
          WRITE(input, input + 10);
        END
SMALL
    ).should_not raise_error
  end

  it 'example 5' do
    @a.run(
<<-SMALL
        BEGIN
          READ(a, b);
          WRITE((a+5)-10+(b-6));
        END
SMALL
    ).should_not raise_error
  end
  
  it 'example 6' do
    @a.run(
<<-SMALL
        BEGIN
          READ(a, b);
          
          IF TRUE OR FALSE THEN
            WRITE(nonexistingidentifier + a - b);
          ELSE IF (FALSE AND NOT FALSE) OR ((TRUE) OR NOT TRUE) THEN
            WRITE(a, 2 + a - b, b + a);
          ELSE
            WRITE(-1); 
          ;;
        END
SMALL
    ).should_not raise_error
  end
  
  it 'example 7' do
    @a.run(
<<-SMALL
        BEGIN
          READ(a, b);
          
          IF TRUE OR FALSE THEN
            WRITE(nonexistingidentifier + a - b);
          ELSE IF FALSE AND NOT FALSE OR TRUE OR NOT TRUE THEN
            WRITE(a, 007);
          ELSE
            WRITE(-1); 
          ;;
        END
SMALL
    ).should_not raise_error
  end

  it 'example 8' do
    @a.run(
<<-SMALL
        BEGIN
          READ (a, b);

          sucet := a + b;
          rozdiel := a - b;

          IF TRUE THEN
            WRITE (sucet);
          ELSE
            WRITE (rozdiel);
          ;
        END 
SMALL
    ).should_not raise_error
  end

end