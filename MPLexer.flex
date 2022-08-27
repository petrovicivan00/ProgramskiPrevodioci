// import section
import java_cup.runtime.*;
%%
// declaration section
%class MPLexer

%cup

%line
%column

%eofval{
return new Symbol( sym.EOF);
%eofval}

%{
 public int getLine()
   {
      return yyline;
   }
%}

//states
%state COMMENT
//macros
slovo = [a-zA-Z]
cifra = [0-9]
oc16 = [0-9A-F]
oc8 = [0-7]
%%
// rules section
\/\/ { yybegin( COMMENT ); }
<COMMENT>~\n { yybegin( YYINITIAL ); }

[\t\n\r ] { ; }

//operators
&& { return new Symbol( sym.AND); }
\|\| { return new Symbol( sym.OR ); }
\+ { return new Symbol( sym.PLUS); }
\* { return new Symbol( sym.MUL ); }
\- { return new Symbol( sym.MIN ); }
\/  { return new Symbol( sym.DIV ); }
\< { return new Symbol( sym.LESS ); }
\<= { return new Symbol( sym.LESSE ); }
\> { return new Symbol( sym.GREAT ); }
\>= { return new Symbol( sym.GREATE ); }
== { return new Symbol( sym.EQ ); }
\<\> { return new Symbol( sym.NEQ ); }

//separators
;   { return new Symbol( sym.DOTCOMMA ); }
,   { return new Symbol( sym.COMMA ); }
=   { return new Symbol( sym.ASSIGN ); }
\(  { return new Symbol( sym.LP ); }
\)  { return new Symbol( sym.RP ); }

//keywords
"program"		{ return new Symbol( sym.PROGRAM );	}
"int"		    { return new Symbol( sym.INT );	}
"char"			{ return new Symbol( sym.CHAR );	}
"read"			{ return new Symbol( sym.READ );	}
"write"			{ return new Symbol( sym.WRITE );	}
"for"			{ return new Symbol( sym.FOR );	}
"begin"			{ return new Symbol( sym.BEGIN );	}
"end"			{ return new Symbol( sym.END );	}

//id-s
({slovo} | _)({slovo}|{cifra}| _ )* { return new Symbol(sym.ID, yyline, yytext()); }
//constants
{cifra}+ { return new Symbol( sym.CONST, yytext(), yyline, yycolumn ); }
0x{oc16}+ { return new Symbol( sym.CONST, yytext(), yyline, yycolumn ); }
0{oc8}+ { return new Symbol( sym.CONST, yytext(), yyline, yycolumn ); }
{cifra}+\.{cifra}+E[+\-]?{cifra}+ { return new Symbol( sym.REAL,yytext(), yyline, yycolumn );}
true  { return new Symbol( sym.BOOL,yytext(), yyline, yycolumn ); }
false { return new Symbol( sym.BOOL,yytext(), yyline, yycolumn ); }
//error symbol
. { if (yytext() != null && yytext().length() > 0) System.out.println( "ERROR: " + yytext() ); }
