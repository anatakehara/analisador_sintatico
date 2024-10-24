/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_FONTE_TAB_H_INCLUDED
# define YY_YY_FONTE_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    IDENTIFICADOR = 258,           /* IDENTIFICADOR  */
    INT = 259,                     /* INT  */
    FLOAT = 260,                   /* FLOAT  */
    OR = 261,                      /* OR  */
    AND = 262,                     /* AND  */
    NOT = 263,                     /* NOT  */
    OP_AR = 264,                   /* OP_AR  */
    OP_LOG = 265,                  /* OP_LOG  */
    IGUAL = 266,                   /* IGUAL  */
    ABRE_PARENTESIS = 267,         /* ABRE_PARENTESIS  */
    FECHA_PARENTESIS = 268,        /* FECHA_PARENTESIS  */
    ABRE_CHAVE = 269,              /* ABRE_CHAVE  */
    FECHA_CHAVE = 270,             /* FECHA_CHAVE  */
    ABRE_COLCHETES = 271,          /* ABRE_COLCHETES  */
    FECHA_COLCHETES = 272,         /* FECHA_COLCHETES  */
    ASPAS_DUPLAS = 273,            /* ASPAS_DUPLAS  */
    ASPAS_SIMPLES = 274,           /* ASPAS_SIMPLES  */
    VIRGULA = 275,                 /* VIRGULA  */
    BARRA = 276,                   /* BARRA  */
    HASHTAG = 277,                 /* HASHTAG  */
    PVIRGULA = 278,                /* PVIRGULA  */
    PONTO = 279,                   /* PONTO  */
    DOIS_PONTOS = 280,             /* DOIS_PONTOS  */
    MAIN = 281,                    /* MAIN  */
    STRING = 282,                  /* STRING  */
    CONDICIONAL = 283,             /* CONDICIONAL  */
    LOOP = 284,                    /* LOOP  */
    DECLARACAO = 285,              /* DECLARACAO  */
    COMPARADORES = 286,            /* COMPARADORES  */
    INCREMENTO = 287               /* INCREMENTO  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_FONTE_TAB_H_INCLUDED  */
