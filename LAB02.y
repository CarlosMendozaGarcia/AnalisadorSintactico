%{ 
   #include<stdio.h> 
   int yylex( );
   void yyerror(char *s);
   int errorf=0;
   extern int yylineno;
%} 

%token CREATETABLE DROPTABLE INSERT DELETE UPDATE SELECT
%token WHERE GROUPBY ORDERBY MAX MIN AVG COUNT INTO VALUES FROM SET
%token ASC DESC
%token ID ENTEROS DECIMALES CADENA
%token AND OR
%token INTEGER DECIMAL VARCHAR
%error-verbose

%%
LINEA
    :COMANDO 
    |COMANDO LINEA 
    ;
COMANDO
    :CREATETABLE ID '(' ARGS ')' ';' 
    |DROPTABLE ID ';' 
    |INSERT INTO IDS VALUES '(' IDS ')' ';' 
    |DELETE FROM ID WHERE CONDICIONES ';' 
    |UPDATE ID SET ID '=' ID WHERE CONDICIONES ';' 
    |UPDATE ID SET ID '=' NUMERO  WHERE CONDICIONES ';' 
    |SELECT '*' FROM ID ORGANIZAR ';' 
    |SELECT MIX FROM ID ORGANIZAR ';' 
    |error ';' 
    ;
MIX
    : FUNCION 
    | ID 
    | FUNCION ',' MIX 
    | ID ',' MIX 
;
ORGANIZAR
    :GROUPBY ID 
    |ORDERBY IDS ORDEN 
    |WHERE CONDICIONES 
    |WHERE CONDICIONES GROUPBY ID ORDERBY IDS ORDEN 
    |/* epsilon */ 
;
FUNCION
    : MAX '(' ID ')' 
    | MIN '(' ID ')' 
    | AVG '(' ID ')' 
    | COUNT '(' ID ')' 
;
ARGS
    : ARG ',' ARGS 
    | ARG 
;
ARG
    :ID INTEGER '(' ENTEROS ')' 
    | ID DECIMAL '(' ENTEROS ')' 
    | ID VARCHAR '(' ENTEROS ')' 
;


IDS
    : ID 
    | ID ',' IDS 
;
NUMERO
    :ENTEROS 
    |DECIMALES 
;

CONDICIONES
    : CONDICION 
    | CONDICION AND CONDICIONES 
    | CONDICION OR CONDICIONES 
;
CONDICION
    :ID OPIGUALDAD ID 
    |ID OPCONDICION ID 
    |ID OPIGUALDAD NUMERO 
    |ID OPCONDICION NUMERO 
    |ID OPIGUALDAD CADENA 
;
OPIGUALDAD
    :'=''=' 
    |'=' ;
    |'<''>' 
;
OPCONDICION
    :'<' 
    |'>' 
    |'<''=' 
    |'>''=' 
;

ORDEN
    :ASC 
    |DESC 
;
%%

int main(int argc, char **argv) {

    FILE *yyin, *yyout;

    yyin = fopen(argv[1], "r");
    yyout = fopen(argv[3], "w");

    yyparse();
    if(!errorf){
        printf("Correcto");
    }

    fclose(yyin);
    fclose(yyout);

    return 0;
}

void yyerror(char *s) {
    errorf= 1;

    if (errorf){
        printf("Incorrecto");
    }
    printf( "line %d: %s\n",yylineno, s);
    printf("Error: %s", s);    
}
