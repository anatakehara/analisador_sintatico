/*Ana Beatriz Gomes Takehara e Heloísa Silveira Bula*/
%{
    #include "fonte.tab.h"  // Inclua o cabeçalho onde os tokens estão definidos
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    int linhas = 1; // Contador de linhas
    int erros = 0;  // Contador de erros
%}

CARACTERE [a-zA-ZáéíóúãõâêîôûàèìòùçÁÉÍÓÚÃÕÂÊÎÔÛÀÈÌÒÙÇ]
NUMERO [0-9]
PORCENTAGEM [%]
CODIGO [dfs]
ESPACO [\t\r" "]
MAIS [+]
MENOS[-]

%%

"int"               {return TIPO_INT; }
"float"             { return TIPO_FLOAT; }
"string"            {return STRING; }
"main"              { return MAIN; }
"if"                {return IF; }
"else"              {return ELSE; }
"elseif"           {return ELSEIF; }
"while"             {return WHILE; }
"for"               {return FOR; }
"printf"            {return PRINTF;}
"scanf"             {return SCANF; }
"do"                {return DO; }

{CARACTERE}+         {return IDENTIFICADOR; }           
{CARACTERE}+{NUMERO}+  {return IDENTIFICADOR; }          
{CARACTERE}+{NUMERO}+{CARACTERE}+ {return IDENTIFICADOR; } 
{NUMERO}+{CARACTERE}+               { printf("Token inválido: %s - Linha: %d\n", yytext, linhas); erros++; }

{NUMERO}+                          {return INT; } 
{NUMERO}+[.]{NUMERO}+                {return FLOAT; }
{NUMERO}+[,]{NUMERO}+               { printf("Token inválido: %s - Linha: %d\n", yytext, linhas); erros++; }


{PORCENTAGEM}{CODIGO}               { return CODIGO_AUX;}


{CARACTERE}+{MAIS}{MAIS}         {return INCREMENTO; }           
{CARACTERE}+{NUMERO}+{MAIS}{MAIS}   {return INCREMENTO; }          
{CARACTERE}+{NUMERO}+{CARACTERE}+{MAIS}{MAIS}  {return INCREMENTO; }

{CARACTERE}+{MENOS}{MENOS}         {return INCREMENTO; }           
{CARACTERE}+{NUMERO}+{MENOS}{MENOS}   {return INCREMENTO; }          
{CARACTERE}+{NUMERO}+{CARACTERE}+{MENOS}{MENOS}  {return INCREMENTO; }

"//"[^\n]*             

\|\|            {return OP_LOG; }  
\&&              {return OP_LOG;}    
\!             {return NOT;}

\&          {return AND;}

\==            {return OP_LOG; }
[+|\%|\*|\/] {return OP_AR;}
"-"         {return OP_AR;}
[|\>|\<]    {return OP_LOG;} 
\=              {return IGUAL;}       

[\{]                {return ABRE_CHAVE;}   
[\(]               {return ABRE_PARENTESIS;}    
[\}]                    {return FECHA_CHAVE;}
[\)]               {return FECHA_PARENTESIS;}

\"                 {return ASPAS_DUPLAS;}     
,                       {return VIRGULA;}
[\\]                    {return BARRA;}
\#                     {return HASHTAG; }
[\;]                      {return PVIRGULA;}
\.                      {return PONTO; }
\:                      {return DOIS_PONTOS;}


{ESPACO}


\n                    { linhas++; }


.                     { printf("Token inválido: %c - Linha: %d\n", yytext[0], linhas); erros++; }

%%


int yywrap() {
    return 1;  // Indica que o fluxo de entrada terminou
}
