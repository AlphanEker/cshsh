%token MULTI_COMMENT SET_SWITCH_FUNC RETURN_TOKEN INT NL DO_TOKEN FLOAT END_OF_STMT COMMENT_OP MULTI_COMMENT_START MULTI_COMMENT_END  LP RP ASSIGN_OP EQUALS_OP GREATER_OP GREATER_EQ_OP LESS_OP LESS_EQ_OP MIN_OP DECREMENT_OP PLUS_OP INCREMENT_OP DIV_OP MUL_OP LBRACE RBRACE DATA_TYPE BOOL FOR_TOKEN IF_TOKEN ELSE_TOKEN WHILE_TOKEN THEN_TOKEN WHEN_TOKEN RECIEVE_FUNC SEND_FUNC CONNECT_FUNC GET_TIMESTAMP_FUNC URL_TOKEN IDENTIFIER STRING AND_TOKEN OR_TOKEN XOR_TOKEN DONE_TOKEN COMMA NOT_OP
%%
program: stmt_list { if (isError == 0){ printf("Input program is valid\n\n");} return 0;}
stmt_list:|
	 stmt END_OF_STMT | 
	 stmt_list stmt END_OF_STMT
stmt:error {printf(" in line %d! ERROR OCCURS:", lineNumber, "\n");
            yyerrok;
	yyclearin;}| 
    |declaration_stmt  
    |assignment_stmt 
|if_stmt 
|loop_stmt 
|return_stmt 
|func_expr
|comment_stmt

comment_stmt: MULTI_COMMENT | SINGLE_COMMENT

declaration_stmt: variable_declaration | function_declaration

variable_declaration: DATA_TYPE IDENTIFIER

function_declaration: DATA_TYPE IDENTIFIER LP parameter_declaration RP LBRACE stmt_list return_stmt RBRACE

parameter_declaration: | parameter_declaration COMMA DATA_TYPE IDENTIFIER |
		     DATA_TYPE IDENTIFIER 

return_stmt: |  RETURN_TOKEN | RETURN_TOKEN IDENTIFIER

assignment_stmt: IDENTIFIER ASSIGN_OP expression

expression: arithmetic_expr | 
  	func_expr |  
	logical_expr |
	IDENTIFIER |
	values |
	NOT_OP LP expression RP

arithmetic_expr: arithmetic_expr arithmetical_operator numeric_values |
	       arithmetic_expr arithmetical_operator IDENTIFIER |
		IDENTIFIER |
		numeric_values |
		IDENTIFIER INCREMENT_OP |
		IDENTIFIER DECREMENT_OP

numeric_values: INT |
	      FLOAT

values: numeric_values |
        STRING |
	BOOL

arithmetical_operator : PLUS_OP |
		      MIN_OP |
			DIV_OP |
			MUL_OP

func_expr: communication_func |
	 IDENTIFIER LP parameter_list RP |
	IDENTIFIER LP RP

communication_func: RECIEVE_FUNC|
		    SEND_FUNC|
		    CONNECT_FUNC

parameter_list: |
	        parameter_list COMMA IDENTIFIER |
	        parameter_list COMMA values |
		IDENTIFIER |
		values

logical_expr: values logical_operator logical_expr |
	      IDENTIFIER  logical_operator logical_expr |
	      values |
	      IDENTIFIER

logical_operator: OR_TOKEN |
	          AND_TOKEN |
		  XOR_TOKEN |
		  LESS_OP | LESS_EQ_OP |
		  GREATER_OP | GREATER_EQ_OP |
		  EQUALS_OP

if_stmt: IF_TOKEN LP logical_expr RP THEN_TOKEN LBRACE stmt_list DONE_TOKEN RBRACE |
	 IF_TOKEN LP logical_expr RP THEN_TOKEN LBRACE stmt_list DONE_TOKEN RBRACE ELSE_TOKEN THEN_TOKEN LBRACE stmt_list DONE_TOKEN RBRACE

loop_stmt: while_stmt | for_stmt | do_while_stmt

while_stmt: WHILE_TOKEN LP logical_expr RP DO_TOKEN LBRACE stmt_list DONE_TOKEN RBRACE

do_while_stmt: DO_TOKEN LBRACE stmt_list DONE_TOKEN RBRACE WHILE_TOKEN LP logical_expr RP

for_stmt: FOR_TOKEN LP declaration_stmt END_OF_STMT assignment_stmt END_OF_STMT logical_expr END_OF_STMT arithmetic_expr RP DO_TOKEN LBRACE stmt_list DONE_TOKEN RBRACE 


%%
#include "lex.yy.c"
int lineNumber = 0;
int isError = 0;
void yyerror(char *s) { printf("%s", s); printf("\n"); isError = 1;}
int main() {
  return yyparse();
}
