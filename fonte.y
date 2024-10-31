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

%token IDENTIFICADOR INT FLOAT TIPO_FLOAT TIPO_INT
%token OR AND NOT
%token OP_AR OP_LOG IGUAL
%token ABRE_PARENTESIS FECHA_PARENTESIS
%token ABRE_CHAVE FECHA_CHAVE
%token ASPAS_DUPLAS 
%token VIRGULA BARRA HASHTAG PVIRGULA PONTO DOIS_PONTOS
%token MAIN STRING PRINTF SCANF INCREMENTO
%token IF ELSE ELSEIF WHILE FOR CODIGO_AUX DO

%start Programa_principal

%%

//ESTRUTURA DO PROGRAMA PRINCIPAL 

Programa_principal: MAIN ABRE_PARENTESIS FECHA_PARENTESIS ABRE_CHAVE Comandos FECHA_CHAVE ;

//COMANDOS QUE VÃO PODER SER UTILIZADOS NO PROGRAMA

Comandos: Declaracao 
        | Atribuicao 
        | Repeticao 
        | Condicional 
        | PrintfComando   
        | ScanfComando
        | Comandos Comandos 
        | error PVIRGULA {yyerrok;};

//TIPO QUE UMA VARIÁVEL PODE TER 

Tipo: TIPO_INT | TIPO_FLOAT | STRING ;

//DECLARAÇÃO DE VARIÁVEL

Declaracao: Tipo Declaracao_aux PVIRGULA ;

Declaracao_aux: IDENTIFICADOR IGUAL ExpressaoAritmetica
               | IDENTIFICADOR IGUAL ExpressaoAritmetica VIRGULA Declaracao_aux
               | IDENTIFICADOR VIRGULA Declaracao_aux
               | IDENTIFICADOR 
               | IDENTIFICADOR IGUAL ASPAS_DUPLAS Identificador_aux ASPAS_DUPLAS ;

//ATRIBUIÇÃO DE VARIÁVEL

Atribuicao: IDENTIFICADOR IGUAL ExpressaoAritmetica PVIRGULA 
          | IDENTIFICADOR IGUAL ASPAS_DUPLAS Identificador_aux ASPAS_DUPLAS PVIRGULA
          | INCREMENTO PVIRGULA ;

//CONDICIONAL

Condicional: IF ABRE_PARENTESIS Condicao FECHA_PARENTESIS ABRE_CHAVE Comandos FECHA_CHAVE 
            | ELSEIF ABRE_PARENTESIS Condicao_aux FECHA_PARENTESIS ABRE_CHAVE Comandos FECHA_CHAVE 
            | ELSE ABRE_CHAVE Comandos FECHA_CHAVE 
            | error PVIRGULA { yyerrok; };

//REPETIÇÃO 

Repeticao: WHILE ABRE_PARENTESIS Condicao FECHA_PARENTESIS ABRE_CHAVE Comandos FECHA_CHAVE 
         | FOR ABRE_PARENTESIS Atribuicao_aux Condicao PVIRGULA INCREMENTO FECHA_PARENTESIS ABRE_CHAVE Comandos FECHA_CHAVE 
         | DO ABRE_CHAVE Comandos FECHA_CHAVE WHILE ABRE_PARENTESIS Condicao FECHA_PARENTESIS PVIRGULA ;

Atribuicao_aux: IDENTIFICADOR IGUAL INT PVIRGULA
            | IDENTIFICADOR IGUAL IDENTIFICADOR ;


//CONDIÇÕES QUE VÃO PODER SER UTILZADAS NOS COMANDO CONDICIONAIS E NOS LAÇOS DE REPETIÇÃO

Condicao: Condicao_aux OP_LOG Condicao_aux ;

Condicao_aux: Condicao_aux OP_LOG Condicao_aux 
            | INT 
            | IDENTIFICADOR 
            | FLOAT 
            | FLOAT OP_AR FLOAT 
            | FLOAT OP_AR INT
            | FLOAT OP_AR IDENTIFICADOR
            | INT OP_AR INT
            | INT OP_AR FLOAT
            | INT OP_AR IDENTIFICADOR
            | IDENTIFICADOR OP_AR IDENTIFICADOR
            | IDENTIFICADOR OP_AR INT
            | IDENTIFICADOR OP_AR FLOAT ;

//EXPRESSÃO ARITMÉTICA

ExpressaoAritmetica: ExpressaoAritmetica OP_AR ExpressaoAritmetica 
                    | IDENTIFICADOR 
                    | INT 
                    | FLOAT
                    | IDENTIFICADOR OP_AR INT
                    | IDENTIFICADOR OP_AR FLOAT
                    | IDENTIFICADOR OP_AR IDENTIFICADOR
                    | IDENTIFICADOR IGUAL IDENTIFICADOR ;

//PRINT 

PrintfComando: PRINTF ABRE_PARENTESIS ASPAS_DUPLAS Identificador_aux CODIGO_AUX ASPAS_DUPLAS VIRGULA ExpressaoAritmetica FECHA_PARENTESIS PVIRGULA 
              | PRINTF ABRE_PARENTESIS ASPAS_DUPLAS Identificador_aux ASPAS_DUPLAS FECHA_PARENTESIS PVIRGULA ;

//FUNÇÃO AUXILIAR UTILIZADA PARA ESCREVER QUALQUER COISA NO PRINT E NA ATRIBUIÇÃO DE UMA STRING

Identificador_aux: IDENTIFICADOR | IDENTIFICADOR Identificador_aux 
                | PRINTF | PRINTF Identificador_aux 
                | IF | IF Identificador_aux 
                | ELSE | ELSE Identificador_aux 
                | ELSEIF | ELSEIF Identificador_aux 
                | STRING  | STRING Identificador_aux 
                | WHILE | WHILE Identificador_aux 
                | FOR | FOR Identificador_aux 
                | PRINTF | PRINTF Identificador_aux 
                | SCANF | SCANF Identificador_aux 
                | MAIN | MAIN Identificador_aux 
                | INT | INT Identificador_aux 
                | FLOAT | FLOAT Identificador_aux
                | OP_AR | OP_AR Identificador_aux
                | OP_LOG | OP_LOG Identificador_aux 
                | OR | OR Identificador_aux 
                | AND | AND Identificador_aux 
                | NOT | NOT Identificador_aux
                | IGUAL | IGUAL Identificador_aux 
                | VIRGULA | VIRGULA Identificador_aux
                | BARRA | BARRA Identificador_aux 
                | PVIRGULA | PVIRGULA Identificador_aux 
                | PONTO | PONTO Identificador_aux 
                | DOIS_PONTOS | DOIS_PONTOS Identificador_aux 
                | HASHTAG | HASHTAG Identificador_aux 


//SCANF 

ScanfComando: SCANF ABRE_PARENTESIS ASPAS_DUPLAS CODIGO_AUX ASPAS_DUPLAS VIRGULA AND IDENTIFICADOR FECHA_PARENTESIS PVIRGULA ;


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