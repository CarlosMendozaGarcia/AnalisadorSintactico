%{
#include <stdio.h>
#include "y.tab.h"
void yyerror (char *);
int yylex( );
%}

%option yylineno

%%
["CREATE Table"|"CREATE Table"]                                       {return (CREATETABLE);}
["DROP Table"| "DROP table"]                                          {return (DROPTABLE);}
"SELECT"                                                            {return (SELECT);}
"WHERE"                                                             {return (WHERE);}
"GROUP BY"                                                          {return (GROUPBY);}
"ORDER BY"                                                          {return (ORDERBY);}
"INSERT"                                                            {return (INSERT);}
"DELETE"                                                            {return (DELETE);}
"UPDATE"                                                            {return (UPDATE);}  
"MAX"                                                               {return (MAX);}
"MIN"                                                               {return (MIN);}
"AVG"                                                               {return (AVG);}
"COUNT"                                                             {return (COUNT);}
"INTO"                                                              {return (INTO);}
"VALUES"                                                            {return (VALUES);}
"FROM"                                                              {return (FROM);}
"SET"                                                               {return (SET);}
"ASC"                                                               {return (ASC);}
"DESC"                                                              {return (DESC);}
"INTEGER"                                                           {return (INTEGER);}
"DECIMAL"                                                           {return (DECIMAL);}
"VARCHAR"                                                           {return (VARCHAR);}
"AND"                                                               {return (AND);}
"OR"                                                                {return (OR);}
[a-zA-Z][a-zA-Z0-9]*                                                {return (ID);}
[0-9]+                                                              {return (ENTEROS);}
[0-9]+["."|","][0-9]+                                               {return (DECIMALES);}
\'[^\']*\'                                                          {return (CADENA);}
[\n]+                                                                  
[\t\r]+
.                                                                   yyerror("incorrecto");
%%
int yywrap(void){
    return 1;
}
