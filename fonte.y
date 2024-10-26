%{
    #include "cabecalho.h"
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    extern int linhas;
    extern int erros;
    int yylex();
    int yyerror(const char *str);
%}

%define parse.error detailed

%token IDENTIFICADOR INT FLOAT 
%token OR AND NOT
%token OP_AR OP_LOG IGUAL
%token ABRE_PARENTESIS FECHA_PARENTESIS
%token ABRE_CHAVE FECHA_CHAVE
%token ABRE_COLCHETES FECHA_COLCHETES
%token ASPAS_DUPLAS ASPAS_SIMPLES
%token VIRGULA BARRA HASHTAG PVIRGULA PONTO DOIS_PONTOS
%token MAIN STRING PRINTF SCANF
%token IF ELSE ELSEIF WHILE FOR DECLARACAO COMPARADORES CODIGO_AUX

%start Programa_principal

%%

// Programa principal
Programa_principal: MAIN ABRE_PARENTESIS FECHA_PARENTESIS ABRE_CHAVE Comandos FECHA_CHAVE
                  | error {yyerror("Erro de sintaxe"); };

Comandos: Declaracao 
        | Atribuicao 
        | Repeticao 
        | Condicional 
        | ExpressaoAritimetica PVIRGULA
        | PrintfComando   // Regra para printf
        | ScanfComando
        | Comandos Comandos
        | error {yyerror("Erro no comando"); };

Tipo: INT | FLOAT | STRING ;

//DECLARAÇÃO - PRONTA
Declaracao: Tipo Declaracao_aux | Tipo IDENTIFICADOR IGUAL FLOAT PVIRGULA | Tipo IDENTIFICADOR IGUAL INT PVIRGULA | Tipo IDENTIFICADOR IGUAL IDENTIFICADOR PVIRGULA | Tipo IDENTIFICADOR IGUAL ASPAS_DUPLAS IDENTIFICADOR ASPAS_DUPLAS PVIRGULA
          | error;

Declaracao_aux: IDENTIFICADOR VIRGULA Declaracao_aux | IDENTIFICADOR PVIRGULA

//ATRIBUIÇÃO - PRONTA
Atribuicao: IDENTIFICADOR IGUAL ExpressaoAritimetica PVIRGULA 
          | IDENTIFICADOR IGUAL ASPAS_DUPLAS IDENTIFICADOR ASPAS_DUPLAS PVIRGULA
          | error;

//CONDICIONAL - PRONTA
Condicional: IF ABRE_PARENTESIS Condicao FECHA_PARENTESIS ABRE_CHAVE Comandos FECHA_CHAVE | ELSEIF ABRE_PARENTESIS Condicao FECHA_PARENTESIS ABRE_CHAVE Comandos FECHA_CHAVE | ELSE ABRE_CHAVE Comandos FECHA_CHAVE
           | error {yyerror("Erro sintático de condicional"); };

//REPETIÇÃO - PRONTA
Repeticao: WHILE ABRE_PARENTESIS Condicao FECHA_PARENTESIS ABRE_CHAVE Comandos FECHA_CHAVE 
         | FOR ABRE_PARENTESIS Atribuicao Condicao PVIRGULA ExpressaoAritimetica FECHA_PARENTESIS ABRE_CHAVE Comandos FECHA_CHAVE 
         | error {yyerror("Erro sintático na repetição"); };

// Condições lógicas - PRONTA
Condicao: IDENTIFICADOR OP_LOG ExpressaoAritimetica 
        | IDENTIFICADOR OP_AR IDENTIFICADOR OP_LOG ExpressaoAritimetica
        | error {yyerror("Erro na condição"); };


//EXPRESSÃO ARITMÉTICA - PRONTA
ExpressaoAritimetica: ExpressaoAritimetica OP_AR ExpressaoAritimetica 
                    | IDENTIFICADOR 
                    | INT 
                    | FLOAT
                    | IDENTIFICADOR OP_AR INT
                    | IDENTIFICADOR OP_AR FLOAT
                    | IDENTIFICADOR OP_AR IDENTIFICADOR
                    | IDENTIFICADOR IGUAL IDENTIFICADOR
                    | error {yyerror("Erro na expressão aritmética"); };

//PRINT - PRONTO
PrintfComando: PRINTF ABRE_PARENTESIS ASPAS_DUPLAS Identificador_aux CODIGO_AUX ASPAS_DUPLAS VIRGULA ExpressaoAritimetica FECHA_PARENTESIS PVIRGULA 
              | PRINTF ABRE_PARENTESIS ASPAS_DUPLAS Identificador_aux ASPAS_DUPLAS FECHA_PARENTESIS PVIRGULA | error // Para imprimir apenas uma string

Identificador_aux: IDENTIFICADOR | IDENTIFICADOR Identificador_aux | PRINTF | PRINTF Identificador_aux | IF | IF Identificador_aux | ELSE | ELSE Identificador_aux | ELSEIF | ELSEIF Identificador_aux | STRING | STRING Identificador_aux | WHILE | WHILE Identificador_aux | FOR | FOR Identificador_aux | PRINTF | PRINTF Identificador_aux | SCANF | SCANF Identificador_aux |MAIN | MAIN Identificador_aux | INT | INT Identificador_aux | FLOAT | FLOAT Identificador_aux| OP_AR | OP_AR Identificador_aux| OP_LOG | OP_LOG Identificador_aux | OR | OR Identificador_aux | AND | AND Identificador_aux | NOT | NOT Identificador_aux| IGUAL | IGUAL Identificador_aux | VIRGULA | VIRGULA Identificador_aux| BARRA | BARRA Identificador_aux | PVIRGULA | PVIRGULA Identificador_aux | PONTO | PONTO Identificador_aux | DOIS_PONTOS | DOIS_PONTOS Identificador_aux | error

ScanfComando: SCANF ABRE_PARENTESIS ASPAS_DUPLAS CODIGO_AUX ASPAS_DUPLAS VIRGULA AND IDENTIFICADOR FECHA_PARENTESIS PVIRGULA 
%%

extern FILE *yyin;

int yyerror(const char *str) {
    erros++;
    printf("Erro: %s. Linha: %d\n", str, linhas);
    return erros;
}

int main (int argc, char **argv ) {
    ++argv, --argc;
    if (argc > 0)
        yyin = fopen(argv[0], "r");
    else {
        puts("Falha ao abrir arquivo. Nome incorreto ou não especificado.");
        exit(0);
    }

    do {
        yyparse();
    } while (!feof(yyin));

    if(erros == 0)
        puts("Análise concluída com sucesso");

    return 0;
}