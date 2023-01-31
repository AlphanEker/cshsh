C##

-*Fundamentals*-
<alphanumeric> ::= <letter> | <digit> 
Alphanumeric characters are composed of letters and digits. They are the main component of variables.
<digit> ::= [0-9] 
	Numbers through 0-9 are digits. Integers are base10 numbers.
<letter> ::= [a-z] | [A-Z] 
	Uppercase and lowercase letters are included in this list.
<int> ::= <digit> | <int> <digit> 
Decimal numbers are kept as integers. Integers by definition do not have any signs so they don’t overflow. This is useful for keeping high amounts of counts/ variables with precision.
<sign_int> ::= <sign> <int> 
	In case signs are important, one should use signed integers, they include negative integers but can be used just like normal int if wanted.

<variable_name> ::= <letter> | <variable_name> <alphanumeric> #
For variables, they are composed of alphanumeric characters, only constraint being that they cannot start with a number. This removes the confusion if a token is a variable or an integer. The standard convention to name an integer will be in uppercase for the first letter of variables, resembling CamelCase. There are some reserved keywords, which are:
-send 
-receive 
-set 
-for 
-if 
-while 
-else 
-then 
-read
-when

Reserved words are words that were directly used in structure. They are not allowed as variable names, since there is no way for us to differentiate between them and strings by the use of lex. Symbols are not allowed in names, since they might create confusion while writing the variables.

<expression> ::=  <arithmetic_expr> | <func_expr> |  <logical_expr> | <variable_name> |  <values> | (<not_operator>)? “(”+ <expression> “)”
There are 3 different expression types which express arithmetic, function, logical, expressions. A variable or a value can be expressed themself and not operator before an expression turns a given expression to its inverse.

<arithmetic_expr> ::= <arithmetic_expr> <arithmetical_operator> <numeric_values> | ( <numeric_values> | <variable_name>)
| <variable_name> (<increment_operator> | <decrement_operator>) 
Arithmetic expressions are used in expressing an arithmetic operation or chain of arithmetic operations. Arithmetical operations defined as addition, subtraction, multiplication, division and mod. All these operations are left associative thus, arithmetic expressions are left recursive.

<logical_expr> ::=  (<values> | <variable_name>) <logical_operator> <logical_expr> | (<values> | <variable_name>)
Logical expressions are used in expressing the relation between a value (or a variable) and another expression. Values and variables can be logical expressions themselves. Logical operations are right associative thus, logical expressions are right recursive.

<parameter_list> ::= <parameter_list> “,” <variable_name> | <variable_name>
By definition, a parameter is a variable which is passed on a function call and a parameter list indicates multiple parameters which are separated from each other with commas.

<func_exp> ::= <communication_func> | <variable_name> "(" (<parameter_list>)? “)” 
	func_exp variable looks for an open parenthesis after a variable name, this indicates that a function-call action is going to be taken. Declaration of a function can return this too; however func_exp (function call) won't be longer than the definition of that function itself, therefore if one wants to declare a function this stmt won't interfere with that. Communication functions are predefined therefore it can be called directly there is no declaration of them.

<string> ::= "\”" ( <alphanumeric> |<string> <alphanumeric> | <string> " " |  “” ) "\”" #
Strings are composed only of alphanumeric characters and space characters. For not to be confused with variable names, they should be surrounded with “ character.


<return_type>::= <data_type> | "no_return"
	return_type is specifically designed for adding “no_return” to the data types. Because no_return can not be used in variables (oth. void) this return_type variable will be used in functions only. This variable both declares and returns types inside a function.
<values> ::= <numeric_values> | <string> | <boolean> 
<numeric_values> ::=  <int> | <sign_int> | <float> 
	Value is different from data types. These 5 values are specifying the values inside an identifier. numeric values are grouped differently since arithmetic operations are done only with numeric values.
<data_type> ::= “int” | “sign_int” | “string” | “float” | “boolean” | “letter”
	We have 6 types of data types, these are used in logical operations, if-while statements; so they should be detected in these statements. These are allowed types used for assignment operations.
<float> ::= <sign_int> "." <int>
	Float type is used to keep numbers that have values after the decimal point. It is signed by default.
<boolean> ::= “1” | “0”
	Bool values are used for cases where the value can only carry two values. True-false data format can be used in logical operations too. 
<sign> ::= "+" | "-" 
	Signs are different from arithmetic operations and they represent positive or negative values. They do not represent any arithmetical operation.

<assign_op> ::= "="
	Assign operator assigns the value of the variable at the right to the one at the left of it( operates left recursively). The data types should be the same on both sides, so that variables carry the correct value. Casting is not handled at this point.
<equals_op> ::= "=="
	This operator looks at the values of the variables at the both types; returns 1 if true, 0 if false. Both sides should have the same data type.
<not_operator> ::= “!”
	This operator returns the opposite boolean value of the variable or the statement at the right side.
<arithmetical_operator> ::= "+" | "/" | "-" | "*" | “%”
	This operator is used for arithmetical operations. The operations involve variables at both sides. The functions are the following:
+ : Adds both variables.
/ : Divides both opearates.
- : Subtracts variables.
* : Multiplies variables.
% : Calculates the modulo of variables.

The value is returned to the variable left to the assign_op, if it exists. If not the value is treated as a temporary data by itself.
<increment_op> ::= “++”
	This operator increments the value of the attached variable. It always takes place after the variable is used. Can be placed to both sides of the variable.
<decrement_op> ::= “--”
	This operator decrements the value of the attached variable. It always takes place after the variable is used. Can be placed to both sides of the variable.
<logical_operator> ::= “^” | “&” | “\|” | “<” | “>” | “<=” | “>=” | <equals_op>
	These operators follow the standard logical operations. They do bitwise operations and they return a boolean value according to the result of the logical operation.

<data_format> ::= <integer> | <float> | <double> | <timestamp> | <boolean>
	Data format is the general definition for the return types and variable types.
<timestamp> ::= <int> | <timestamp> <int>
	Timestamp is a data type where milliseconds from the UNIX epoch are kept. The given time is not needed to be converted, computers handle them automatically.

Url
<url> ::= "https://"<string>".com" 
	url is a special type that includes a string inside. This type will be specifically used to read and send data to ports. This will be defined before string therefore will have priority over the general string use case. 




Switch

10 switches that can be set as on/off to control some actuators,
<set_switch> ::= “setSwitch(” <deviceId> “,” <digit> “,” <switch_state> “)”
<switch_state> ::= “on” | “off”
There are 10 switches in a device so for each switch there is a digit assigned. set switch function enables the user to control the state of the switch which are on or off

<read_switch> ::= “readSwitch(” <deviceId>  “,” <digit> “)”
Read switch function reads the state of a specific switch on given device Id and returns the state of the switch.




Send and Receive

<communication_func> ::= <send_func> | <recieve_func> | <connect_func> | <timestamp_func>| <set_switch> | <switch_state> | <read_switch>
Communication Functions establishes communication between devices in a given environment (url), reads values from devices(sensor, timer etc.) or connects to an environment.

<connect_func> ::= “connect(”<url>”)#”
connect_func connects to a device using the url parameter. Then, the result is to be kept as a deviceId, which is used to identify IoT objects in other function calls. 

<timestamp_func> ::= “getTimestamp()#”
This function gets seconds elapsed from (UTC) January 1, 1070 from the timer.

<receive_func> ::= "receive("<deviceId> “)#"
<send_func> ::= "send(<deviceId> ",” <int>)#"
<deviceID> ::= <int>
	There are two different communication functions which are called send and receive functions. Send and receive are reserved words for send and receive functions. These functions are defined to send and receive only one integer to a location (a device ID) at a time. They are predefined functions so there is no need to specify their return types.

Function Properties

<program> ::= <stmt_list>
program is the starter function, all compileable programs can be and will be derived from this variable. This variable consists of a statement list which then is expanded to a multi statement program. This variable is important because it is the root of all the other variables.

<stmt_list> ::= <stmt_list> <stmt> | <stmt>
	stmt_list is a left recursive statement that allows our program to handle more than one statement. stmt_list can consist of unlimited statements (stmt). The reason that this variable is left recursive is, in class, we have discussed that -in general- left recursive programs are more efficient than other recursive programs.

<stmt> ::= (<declaration_stmt>  | <assignment_stmt> | <if_stmt> | <loop_stmt> | <return_stmt> | <func_expr>) “#”
	stmt variable can be derived into 4 variables which allows us to assign variables, declare variables, do computation, do statements that are conditional to a condition, structure different types of loops and call functions. A basic program can be constructed from these statements.

<return_stmt> ::= “return ” (<variable_name> |””)
	This is designed for adding returning functionality in function declarations. Every function should end with a return statement even if it has no_return return type.

<loop_stmt> ::= <while_stmt> | <for_stmt> | <do_while_stmt>
	loop_stmt consists of while, for and do-while loops.

<declaration_stmt> ::= <variable_declaration> | <function_declaration>
	declaration_stmt can be either variable_declaration or function_declaration.

<assignment_stmt> ::= <variable_name> <assign_op> <expression>
	assignment_stmt consists of a variable name, assign op and an expression. This means the left hand side (variable_name) will have the contents of the right hand side (expression) and the assign_op separates the LHS from RHS.

<variable_declaration> ::= <data_type> <variable_name>
<parameter_declaration> ::= <parameter_declaration> “,” <data_type> <variable_name> | <data_type> <variable_name>
<function_declaration> ::= <return_type> <variable_name> “(” [<parameter_declaration>]? “)” "{" [<stmt_list>]? <return_stmt>"}"
	This is the convention for declaring functions. variable name and the function name have the same convention. this declares a function which is identified with the variable_name  variable. When the function is called it executes the stmt_list and after that it executes return_stmt. return_stmt should return the same type as return_type but its check won't be made in here.  0 or more declaration_stmt’s are accepted inside the parentheses and these are the parameters of the function. Inside a function_declaration declaration_stmt’s are treated differently. It creates empty ones to be declared later on the program when the function is called with parameters.

<if_stmt> ::= "if (" <logical_expr> ") then {" <stmt_list> “done }” | "if (" <logical_expr> ") then {" <stmt_list> " done } else then {" <stmt_list> “done }”
	if_stmt looks inside the first logical_expr, if it returns true it executes the stmt_list until it sees the keyword done. Other alternative is same as the first one but adds a else statement which basically executes if logical_expr returns anything other than true

<while_stmt> ::= “while (” <logical_expr> “) do {” <stmt_list> “done}”
	while_stmt extends from loop_stmt and adds a basic functionality of a loop. This stmt does the stmt “while” logical_expr returns true. done keyword is to understand the borders of the while stmt

<do_while_stmt> ::= “do {” <stmt_list> “done}” “while (” <logical_expr> “)” 
	Similar to the while_stmt variable however there is one crucial difference, this loop checks the condition after the body is executed.

<for_stmt> ::= “for (” <declaration_stmt> “#” <assignment_stmt> “#” <logical_expr>  “#” <stmt> “) do {” <stmt_list> “ done}”
	For loop executes the second stmt while the first stmt returns true. After each iteration logical_expr will execute and rerun the body again

<when_stmt> ::= “when(” <timestamp> “)do{” <stmt_list> “done} #”
Since we are dealing with IoT devices, we might want to run a block of code in a timely manner. The timing is handled by when block, which is run when the timestamp is reached. This runs asynchronously.

Comment and Extras

<comment> ::= <multiline_comment>
<multiline_comment>   ::= ";*" <multiline_content> "*;#"
<multiline_content>	  ::= [^*^;]*
In our language, every statement is “#” (referred as sharp) terminated. We chose the sharp character since it is easy to see at the end of lines, improving readability. Comments are “;” characters, which distinguishes the code from generic english comments. The comments can begin after sharp, and they may span many lines given that they use multiline comment structure. A multi line comment should be closed, even if the comment is at the EOF. Same rules apply for the beginning character. 
