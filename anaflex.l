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
ESPACO [\t\r" "]

%%

"int"               {return INT; }
"float"             { return FLOAT; }
"string"            {return STRING; }
"main"              { return MAIN; }
"if"                {return CONDICIONAL; }
"else"              {return CONDICIONAL; }
"else if"           {return CONDICIONAL; }
"while"             {return LOOP; }
"for"               {return LOOP; }

{CARACTERE}+         {return IDENTIFICADOR; }           
{CARACTERE}+{NUMERO}+  {return IDENTIFICADOR; }          
{CARACTERE}+{NUMERO}+{CARACTERE}+ {return IDENTIFICADOR; } 
{NUMERO}+{CARACTERE}+               { printf("Token inválido: %s - Linha: %d\n", yytext, linhas); erros++; }

{NUMERO}+                          {return INT; } 
{NUMERO}+[.]{NUMERO}+                {return FLOAT; }
{NUMERO}+[,]{NUMERO}+               { printf("Token inválido: %s - Linha: %d\n", yytext, linhas); erros++; }

"//"[^\n]*             

[|]            {return OR; }  
&              {return AND;}    
\!             {return NOT;}

\==            {return OP_LOG; }
[+|-|%|*|/] {return OP_AR;}
[|\>|\<]    {return OP_LOG;} 
\=              {return IGUAL;}       

[\{]                {return ABRE_CHAVE;}   
[\(]               {return ABRE_PARENTESIS;}    
[\}]                    {return FECHA_CHAVE;}
[\)]               {return FECHA_PARENTESIS;}
\[                  {return ABRE_COLCHETES;}    
\]                    {return FECHA_COLCHETES; }  

\"                 {return ASPAS_DUPLAS;}     
\'                    {return ASPAS_SIMPLES;}
,                       {return VIRGULA;}
[\\]                    {return BARRA;}
\#                     {return HASHTAG; }
\;                      {return PVIRGULA;}
\.                      {return PONTO; }
\:                      {return DOIS_PONTOS;}


{ESPACO}


\n                    { linhas++; }


.                     { printf("Token inválido: %c - Linha: %d\n", yytext[0], linhas); erros++; }

%%


int yywrap() {
    return 1;  // Indica que o fluxo de entrada terminou
}
