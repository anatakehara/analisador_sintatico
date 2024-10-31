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
    TIPO_FLOAT = 261,              /* TIPO_FLOAT  */
    TIPO_INT = 262,                /* TIPO_INT  */
    OR = 263,                      /* OR  */
    AND = 264,                     /* AND  */
    NOT = 265,                     /* NOT  */
    OP_AR = 266,                   /* OP_AR  */
    OP_LOG = 267,                  /* OP_LOG  */
    IGUAL = 268,                   /* IGUAL  */
    ABRE_PARENTESIS = 269,         /* ABRE_PARENTESIS  */
    FECHA_PARENTESIS = 270,        /* FECHA_PARENTESIS  */
    ABRE_CHAVE = 271,              /* ABRE_CHAVE  */
    FECHA_CHAVE = 272,             /* FECHA_CHAVE  */
    ASPAS_DUPLAS = 273,            /* ASPAS_DUPLAS  */
    VIRGULA = 274,                 /* VIRGULA  */
    BARRA = 275,                   /* BARRA  */
    HASHTAG = 276,                 /* HASHTAG  */
    PVIRGULA = 277,                /* PVIRGULA  */
    PONTO = 278,                   /* PONTO  */
    DOIS_PONTOS = 279,             /* DOIS_PONTOS  */
    MAIN = 280,                    /* MAIN  */
    STRING = 281,                  /* STRING  */
    PRINTF = 282,                  /* PRINTF  */
    SCANF = 283,                   /* SCANF  */
    INCREMENTO = 284,              /* INCREMENTO  */
    IF = 285,                      /* IF  */
    ELSE = 286,                    /* ELSE  */
    ELSEIF = 287,                  /* ELSEIF  */
    WHILE = 288,                   /* WHILE  */
    FOR = 289,                     /* FOR  */
    CODIGO_AUX = 290,              /* CODIGO_AUX  */
    DO = 291                       /* DO  */
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
