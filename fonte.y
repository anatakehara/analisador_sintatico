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
%token IF ELSE ELSEIF WHILE FOR DECLARACAO COMPARADORES

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
                    | IDENTIFICADOR IGUAL IDENTIFICADOR
                    | error {yyerror("Erro na expressão aritmética"); };

//PRINT
Print: PRINTF ABRE_PARENTESIS ASPAS_DUPLAS 

Printf_aux: IDENTIFICADOR | IDENTIFICADOR Printf_aux | 


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