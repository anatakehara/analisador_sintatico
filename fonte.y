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

%token IDENTIFICADOR INT FLOAT 
%token OR AND NOT
%token OP_AR OP_LOG IGUAL
%token ABRE_PARENTESIS FECHA_PARENTESIS
%token ABRE_CHAVE FECHA_CHAVE
%token ABRE_COLCHETES FECHA_COLCHETES
%token ASPAS_DUPLAS ASPAS_SIMPLES
%token VIRGULA BARRA HASHTAG PVIRGULA PONTO DOIS_PONTOS
%token MAIN STRING
%token ATRIBUICAO CONDICIONAL LOOP DECLARACAO COMPARADORES INCREMENTO

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

// Comandos
Atribuicao: IDENTIFICADOR IGUAL ExpressaoAritimetica PVIRGULA 
          | IDENTIFICADOR IGUAL FLOAT PVIRGULA 
          | IDENTIFICADOR IGUAL ASPAS_DUPLAS IDENTIFICADOR ASPAS_DUPLAS PVIRGULA
          | IDENTIFICADOR IGUAL IDENTIFICADOR PVIRGULA
          | error {yyerror("Erro sintático na atribuição"); };

Condicional: CONDICIONAL ABRE_PARENTESIS Condicao FECHA_PARENTESIS ABRE_CHAVE Comandos FECHA_CHAVE
           | error {yyerror("Erro sintático de condicional"); };

Repeticao: LOOP ABRE_PARENTESIS Condicao FECHA_PARENTESIS ABRE_CHAVE Comandos FECHA_CHAVE 
         | LOOP ABRE_PARENTESIS Atribuicao Condicao PVIRGULA ExpressaoAritimetica FECHA_PARENTESIS ABRE_CHAVE Comandos FECHA_CHAVE 
         | error {yyerror("Erro sintático na repetição"); };

Declaracao: Tipo IDENTIFICADOR PVIRGULA 
          | Tipo IDENTIFICADOR VIRGULA IDENTIFICADOR PVIRGULA
          | error {yyerror("Erro sintático na declaração"); };

// Expressões aritméticas
ExpressaoAritimetica: ExpressaoAritimetica OP_AR ExpressaoAritimetica 
                    | IDENTIFICADOR 
                    | INT 
                    | FLOAT
                    | IDENTIFICADOR INCREMENTO
                    | IDENTIFICADOR OP_AR INT
                    | IDENTIFICADOR OP_AR FLOAT
                    | error {yyerror("Erro na expressão aritmética"); };

// Condições lógicas
Condicao: IDENTIFICADOR OP_LOG ExpressaoAritimetica 
        | IDENTIFICADOR OP_AR IDENTIFICADOR OP_LOG ExpressaoAritimetica
        | error {yyerror("Erro na condição"); };

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
