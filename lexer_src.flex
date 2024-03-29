/* JFlex MiniJava lexer */
import java_cup.runtime.Symbol;
import java_cup.runtime.*;
import syntaxtree.*;

%%

%class MiniJavaLexer
%unicode
%cupsym SymTable
%cup
%line
%column

%{
  StringBuffer string = new StringBuffer();

  private Symbol symbol(int type) {
    // System.out.printf("%d matched\n", type);
    return new Symbol(type, yyline + 1, yycolumn + 1);
  }
  private Symbol symbol(int type, Object value) {
    // System.out.printf("%d matched with value %s\n", type, value);
    return new Symbol(type, yyline + 1, yycolumn + 1, value);
  }
%}

WhiteSpace = [ \r\n\t\f]
LineBreak = \r|\n|\r\n

DecInt = -? "0"|[1-9][0-9]*
HexInt = "0"[xX][0-9a-fA-F]*
Integer = {DecInt} | {HexInt}

Identifier = [a-zA-Z_][a-zA-Z0-9_]*
BlockComment = "/*" ([^*] | "*" [^/])* "*/"
LineComment = "//" [^\r\n]* {LineBreak}?
Comment = {BlockComment} | {LineComment}

%%

"(" { return symbol(SymTable.LPAREN); }
")" { return symbol(SymTable.RPAREN); }
"{" { return symbol(SymTable.LBRACE); }
"}" { return symbol(SymTable.RBRACE); }
"[" { return symbol(SymTable.LBRACKET); }
"]" { return symbol(SymTable.RBRACKET); }
"+" { return symbol(SymTable.PLUS); }
"-" { return symbol(SymTable.MINUS); }
"*" { return symbol(SymTable.TIMES); }
"<" { return symbol(SymTable.LESSTHAN); }
"&&" { return symbol(SymTable.AND); }
"!" { return symbol(SymTable.NOT); }
"." { return symbol(SymTable.DOT); }
"," { return symbol(SymTable.COMMA); }
"=" { return symbol(SymTable.ASSIGNMENT); }
";" { return symbol(SymTable.SEMICOLON); }
"if" { return symbol(SymTable.IF); }
"while" { return symbol(SymTable.WHILE); }
"else" { return symbol(SymTable.ELSE); }
"int" { return symbol(SymTable.INT); }
"boolean" { return symbol(SymTable.BOOLEAN); }
"String" { return symbol(SymTable.STRING); }
"return" { return symbol(SymTable.RETURN); }
"true" { return symbol(SymTable.TRUE); }
"false" { return symbol(SymTable.FALSE); }
"class" { return symbol(SymTable.CLASS); }
"public" { return symbol(SymTable.PUBLIC); }
"static" { return symbol(SymTable.STATIC); }
"void" { return symbol(SymTable.VOID); }
"this" { return symbol(SymTable.THIS); }
"new" { return symbol(SymTable.NEW); }
"main" { return symbol(SymTable.MAIN); }
"extends" { return symbol(SymTable.EXTENDS); }
"length" { return symbol(SymTable.LENGTH); }
"System.out.println" { return symbol(SymTable.PRINT); }

{Integer} { return symbol(SymTable.INT_LITERAL, new IntegerLiteral(Integer.parseInt(yytext()), yyline + 1, yycolumn + 1)); }
{Identifier} { return symbol(SymTable.ID, new Identifier(yytext(), yyline + 1, yycolumn + 1)); }


{WhiteSpace} {}
{Comment} {}

[^] { System.out.printf("Illegal character '%c' at line %d column %d\n",
  yytext().charAt(0), yyline + 1, yycolumn + 1); }
