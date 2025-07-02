/* cs152-miniL phase1 */

%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int line = 1;
int column = 1;

void change_line(){
   line++;
   column = 0;
}

void change_column(int length){
   column += length;
   printf("length: %d\n", length);
}

%}

%option noyywrap

%%

"function"      { printf("FUNCTION\n"); change_column(yyleng); }
"beginparams"   { printf("BEGIN_PARAMS\n"); change_column(yyleng); }
"endparams"     { printf("END_PARAMS\n"); change_column(yyleng); }
"beginlocals"   { printf("BEGIN_LOCALS\n"); change_column(yyleng); }
"endlocals"     { printf("END_LOCALS\n"); change_column(yyleng); }
"beginbody"     { printf("BEGIN_BODY\n"); change_column(yyleng); }
"endbody"       { printf("END_BODY\n"); change_column(yyleng); }
"integer"       { printf("INTEGER\n"); change_column(yyleng); }
"array"         { printf("ARRAY\n"); change_column(yyleng); }
"enum"          { printf("ENUM\n"); change_column(yyleng); }
"of"            { printf("OF\n"); change_column(yyleng); }
"if"            { printf("IF\n"); change_column(yyleng); }
"then"          { printf("THEN\n"); change_column(yyleng); }
"endif"         { printf("ENDIF\n"); change_column(yyleng); }
"else"          { printf("ELSE\n"); change_column(yyleng); }
"for"           { printf("FOR\n"); change_column(yyleng); }
"while"         { printf("WHILE\n"); change_column(yyleng); }
"do"            { printf("DO\n"); change_column(yyleng); }
"beginloop"     { printf("BEGINLOOP\n"); change_column(yyleng); }
"endloop"       { printf("ENDLOOP\n"); change_column(yyleng); }
"continue"      { printf("CONTINUE\n"); change_column(yyleng); }
"read"          { printf("READ\n"); change_column(yyleng); }
"write"         { printf("WRITE\n"); change_column(yyleng); }
"and"           { printf("AND\n"); change_column(yyleng); }
"or"            { printf("OR\n"); change_column(yyleng); }
"not"           { printf("NOT\n"); change_column(yyleng); }
"true"          { printf("TRUE\n"); change_column(yyleng); }
"false"         { printf("FALSE\n"); change_column(yyleng); }
"return"        { printf("RETURN\n"); change_column(yyleng); }
":="            { printf("ASSIGN\n"); change_column(yyleng); }
"=="            { printf("EQ\n"); change_column(yyleng); }
"<>"            { printf("NEQ\n"); change_column(yyleng); }
"<="            { printf("LTE\n"); change_column(yyleng); }
">="            { printf("GTE\n"); change_column(yyleng); }
"<"             { printf("LT\n"); change_column(yyleng); }
">"             { printf("GT\n"); change_column(yyleng); }
"-"             { printf("SUB\n"); change_column(yyleng); }
"+"             { printf("ADD\n"); change_column(yyleng); }
"*"             { printf("MULT\n"); change_column(yyleng); }
"/"             { printf("DIV\n"); change_column(yyleng); }
"%"             { printf("MOD\n"); change_column(yyleng); }
";"             { printf("SEMICOLON\n"); change_column(yyleng); }
":"             { printf("COLON\n"); change_column(yyleng); }
","             { printf("COMMA\n"); change_column(yyleng); }
"("             { printf("L_PAREN\n"); change_column(yyleng); }
")"             { printf("R_PAREN\n"); change_column(yyleng); }
"["             { printf("L_SQUARE_BRACKET\n"); change_column(yyleng); }
"]"             { printf("R_SQUARE_BRACKET\n"); change_column(yyleng); }
[0-9]+          { printf("NUMBER %s\n", yytext); change_column(yyleng); }
[a-zA-Z][a-zA-Z0-9_]*[a-zA-Z0-9] { printf("IDENT %s\n", yytext); change_column(yyleng); }
[a-zA-Z]        { printf("IDENT %s\n", yytext); change_column(yyleng); }
[0-9][a-zA-Z0-9_]* { 
    printf("Error at line %d, column %d: identifier \"%s\" must begin with a letter\n", 
           line, column, yytext); 
    exit(1); 
}
_[a-zA-Z0-9_]*  { 
    printf("Error at line %d, column %d: identifier \"%s\" must begin with a letter\n", 
           line, column, yytext); 
    exit(1); 
}
[a-zA-Z][a-zA-Z0-9_]*_ { 
    printf("Error at line %d, column %d: identifier \"%s\" cannot end with an underscore\n", 
           line, column, yytext); 
    exit(1); 
}
"##".*          { change_column(yyleng); }
[ \t]+          { }
\n              { change_line(); }
.               { 
    printf("Error at line %d, column %d: unrecognized symbol \"%s\"\n", 
           line, column, yytext); 
    exit(1); 
}

%%

int main(int argc, char ** argv)
{
   yylex();
   return 0;
}