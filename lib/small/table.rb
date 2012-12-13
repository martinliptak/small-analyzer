{
  :program => {
    'BEGIN' => [ 'BEGIN', :statement_list, 'END' ]
  },
  :statement_list => {
    'IF' => [ :statement, :statement_list_rest ],
    'READ' => [ :statement, :statement_list_rest ],
    'WRITE' => [ :statement, :statement_list_rest ],
    'LETTER' => [ :statement, :statement_list_rest ]
  },
  :statement_list_rest => {
    'END' => [ ],
    'IF' => [ :statement_list ],
    'READ' => [ :statement_list ],
    'WRITE' => [ :statement_list ],
    'LETTER' => [ :statement_list ]
  },
  :statement => {
    'IF' => [ 'IF', :boolean_expression, 'THEN', :statement, :else, ';' ],
    'READ' => [ 'READ', '(', :identifier_list, ')', ';' ],
    'WRITE' => [ 'WRITE', '(', :expression_list, ')', ';' ],
    'LETTER' => [ :identifier, ':=', :expression, ';' ]
  },
  :else => {
    ';' => [ ],
    'ELSE' => [ 'ELSE', :statement ]
  }
  :identifier_list => {
    'LETTER' => [ :identifier, :identifier_list_rest ]
  },
  :identifier_list_rest => {
    ')' => [ ],
    ',' => [ ',', :identifier_list ]
  },
  :expression_list => {
    '(' => [ :expression, :expression_list_rest ],
    '+' => [ :expression, :expression_list_rest ],
    '-' => [ :expression, :expression_list_rest ],
    'DIGIT' => [ :expression, :expression_list_rest ],
    'LETTER' => [ :expression, :expression_list_rest ]
  },
  :expressions_list_rest => {
    ')' => [ ],
    ',' => [ ',', :expression_list ]
  },
  :expression => {
    '(' => [ :factor, :expression_rest ],
    '+' => [ :factor, :expression_rest ],
    '-' => [ :factor, :expression_rest ],
    'DIGIT' => [ :factor, :expression_rest ],
    'LETTER' => [ :factor, :expression_rest ],
  },
  :expression_rest => {
    ')' => [ ],
    '+' => [ '+', :factor, :expression_rest ],
    ',' => [ ],
    '-' => [ '-', :factor, :expression_rest ],
    ';' => [ ]
  },
  :factor => {
    '(' => [ '(', :expression, ')' ],
    '+' => [ :number ],
    '-' => [ :number ],
    'DIGIT' => [ :number ],
    'LETTER' => [ :identifier ]
  },
  :boolean_expression => {
    '(' => [ :boolean_term, :boolean_expression_rest ],
    'FALSE' => [ :boolean_term, :boolean_expression_rest ],
    'TRUE' => [ :boolean_term, :boolean_expression_rest ],
    'NOT' => [ :boolean_term, :boolean_expression_rest ]
  },
  :boolean_expression_rest => {
    ')' => [ ],
    'OR' => [ 'OR', :boolean_term, :boolean_expression_rest ],
    'THEN' => [ ]
  }
  :boolean_term => {
    '(' => [ :boolean_factor, :boolean_term_rest ],
    'FALSE' => [ :boolean_factor, :boolean_term_rest ],
    'TRUE' => [ :boolean_factor, :boolean_term_rest ],
    'NOT' => [ :boolean_factor, :boolean_term_rest ]
  },
  :boolean_term_rest => {
    ')' => [ ],
    'AND' => [ 'AND', :boolean_factor, :boolean_term_rest ],
    'OR' => [ ],
    'THEN' => [ ] 
  },
  :boolean_factor => {
    '(' => [ '(', :boolean_expression, ')' ],
    'FALSE' => [ 'FALSE' ],
    'NOT' => [ 'NOT', :boolean_factor ],
    'TRUE' => [ 'TRUE' ]
  },
  :identifier => {
    'LETTER' => [ :letter, :identifier_rest ]
  },
  :identifier_rest => {
    ')' => [ ],
    '+' => [ ],
    ',' => [ ],
    '-' => [ ],
    'DIGIT' => [ :number, :identifier_rest ],
    ';' => [ ],
    '=' => [ ],
    'LETTER' => [ :letter, :identifier_rest ]
  },
  :number => {
    '+' => [ '+', :digit, :number_rest ],
    '-' => [ '-', :digit, :number_rest ],
    'DIGIT' => [ :digit, :number_rest ]
  },
  :number_rest => {
    ')' => [ ],
    '+' => [ ],
    ',' => [ ],
    '-' => [ ],
    'DIGIT' => [ :digit, :number_rest ],
    ';' => [ ]
  },
  :digit => {
    'DIGIT' => [ 'DIGIT' ]
  },
  :letter => {
    'LETTER' => [ 'LETTER' ]
  }
}