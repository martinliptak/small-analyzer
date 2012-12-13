{
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
	/\A(\d+)/ => 'DIGIT',
	/\A(\w[\w\d]*)/ => 'LETTER'
}