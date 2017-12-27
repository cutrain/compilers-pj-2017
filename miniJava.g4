grammar miniJava;

goal: mainClass (classDeclaration)*;

mainClass :
	'class' identifier '{' 
	'public' 'static' 'void' 'main' '(' 'String' '[' ']' identifier ')' '{' statement '}' '}' 
	;

classDeclaration :
	'class' identifier 
	( 'extends' identifier )? 
	'{' ( varDeclaration )* ( methodDeclaration )* '}'
	;

varDeclaration :
	type identifier ';' 
	;

methodDeclaration :
	'public' type identifier 
	'(' ( type identifier ( ',' type identifier )* )? ')' 
	'{' ( varDeclaration )* ( statement )* 'return' expression ';' '}' 
	;

type : 
	'int' '['']'
	|'boolean'
	|'int'
	|identifier 
	;

statement : 
	'{' ( statement )* '}'
	|'if' '(' expression ')' statement 'else' statement
	|'while' '(' expression ')' statement
	|'System.out.println' '(' expression ')' ';'
	|identifier '=' expression ';'
	|identifier '[' expression ']' '=' expression ';' 
	;

extendexp : 
	expression
	|expression ')' {notifyErrorListeners("too many ')'");}
	|'(' expression {notifyErrorListeners("too many '('");}
	;

expression : 
	expression ('&&'|'<'|'+'|'-'|'*') expression   
	| expression '[' expression ']'
	| expression '.' 'length'
	| expression '.' identifier '(' ( expression ( ',' expression )* )? ')'
	| INTEGER_LITERAL
	| 'true'
	| 'false'
	| identifier
	| 'this'
	| 'new' 'int' '[' expression ']'
	| 'new' identifier '(' ')'
	| '!' expression
	| '(' expression ')'
	;

identifier : 
	ID
	;


ID:[a-zA-Z][a-zA-Z0-9_]*;
INT: [0-9]+;
WRONG:[0-9][a-zA-Z0-9_]*;
STR: '"' .*? '"';
WS: [ \t\r\n]+ -> skip;
COMMENT
	: '/*' .*? '*/' -> skip;
LINE_COMMENT
	: '//' .*? '\r'? '\n' -> skip;

