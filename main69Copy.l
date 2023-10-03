%{
        #include<stdio.h>
	#include<stdlib.h>
	#include<string.h>



struct Variables {
    char name[256];
    struct Variables *next;
};

struct Variables *VariablesTable = NULL;




int CheckDuplicate(char *varName) {
    struct Variables *current = VariablesTable;
    while (current != NULL) {
        if (strcmp(current->name, varName) == 0) {
            return 1; // duplicate
        }
        current = current->next;
    }
    return 0; // no copy
}

void addToVariablesTable(char *varName) {
    struct Variables *newVariables = (struct Variables *)malloc(sizeof(struct Variables));
    strcpy(newVariables->name, varName);
    newVariables->next = VariablesTable;
    VariablesTable = newVariables;
}



%}




digit [0-9]
digits         [-]?[0-9]+
alphabets      [a-zA-z]
alpha_numbers  [a-zA-Z0-9]
char_type      [']{alpha_numbers}[']


identifiers [a-zA-Z]([a-zA-Z0-9])*
unary_operator "inc"|"dec"





%%







"import"[ ]+.+\n   {printf("header declaration\n");}

"introduce "{identifiers}" "({identifiers}|{digit})    {printf("define section\n");}



[#][#].*\n         {printf("single line comment\n");}

[!][<][a-zA-Z0-9!@#*(){}_+-,.:\|?><\n\t ]*[>][!]    {printf("multiple_line_comment\n");}









[i][i][ ]*(>>[ ]*[a-zA-Z][a-zA-Z0-9]*[ ]*)*[;] { printf("Input Statement\n"); }


[o][o][ ]*(<<[ ]*[a-zA-Z][a-zA-Z0-9]*[ ]*)*; { printf("Output Statement\n"); }






{identifiers}*[ \t\n]*<-[ \t\n]*({identifiers}|{digits})[ \t\n]*[;] { printf("Value Assigned"); }


"<-"            { printf("Assignment operator\n"); }

";"             { printf("End of line \n"); }




"var"[ \t\n]+("int_i"|long_l|"double_d"|"float_f"|"char_c"|"bool_b"|"str_s")*(" ")+{identifiers}[ ]*([,][ ]*{identifiers})*[;]           {


 char varName[256];
    int numVars = 0 , ck=0;
    char *token = strtok(yytext, ",");
    while (token != NULL) {
        strcpy(varName, token);

        int len = strlen(varName);
        if (varName[len - 1] ==';')varName[len - 1] = '\0';
        if (!CheckDuplicate(varName)) {


            if (ck > 0) {
                addToVariablesTable(varName);
                printf("Variable declaration for: %s\n", varName);
                numVars++;
            }
            ck++;
        } else {
            printf("duplicate variable: %s\n", varName);
        }


        token = strtok(NULL, ",");
    }

    printf("Number of variables: %d\n", numVars);

}




"int_i" 	        {  printf("INT");}
"long_l"                {printf("long");}
"double_d" 		{ printf("DOUBLE");}
"float_f" 		{ printf("float");}
"char_c" 		{ printf("CHAR");}
"bool_b"                {printf("BOOLEAN");}
"str_s"                 {printf("STRING");}


{identifiers}[ \t\n]*<-[ \t\n]*({identifiers}|{digits})[ \t\n]*("add")[ \t\n]*({identifiers}|{digits})[ \t\n]*; { printf("Addition Operation done\n"); }


{identifiers}[ \t\n]*<-[ \t\n]*({identifiers}|{digits})[ \t\n]*("sub")[ \t\n]*({identifiers}|{digits})[ \t\n]*; { printf("Subtruction Operation done\n"); }


{identifiers}[ \t\n]*<-[ \t\n]*({identifiers}|{digits})[ \t\n]*("mul")[ \t\n]*({identifiers}|{digits})[ \t\n]*; { printf("Multiplication Operation done\n"); }


{identifiers}[ \t\n]*<-[ \t\n]*({identifiers}|{digits})[ \t\n]*("div")[ \t\n]*({identifiers}|{digits})[ \t\n]*; { printf("Division Operation done\n"); }


"cmp "({identifiers}|{digits})[ \t\n]*("-gt")[ \t\n]*({identifiers}|{digits})[ \t\n]*":"(.+)[;] { printf("Greater than Comparation done\n"); }

"cmp "({identifiers}|{digits})[ \t\n]*("-ge")[ \t\n]*({identifiers}|{digits})[ \t\n]*":"(.+)[;] { printf("Greater than or equal Comparation done\n"); }

"cmp "({identifiers}|{digits})[ \t\n]*("-lt")[ \t\n]*({identifiers}|{digits})[ \t\n]*":"(.+)[;] { printf("Less than Comparation done\n"); }

"cmp "({identifiers}|{digits})[ \t\n]*("-le")[ \t\n]*({identifiers}|{digits})[ \t\n]*":"(.+)[;] { printf("less than or Comparation done\n"); }

"cmp "({identifiers}|{digits})[ \t\n]*("-eq")[ \t\n]*({identifiers}|{digits})[ \t\n]*":"(.+)[;] { printf("Equal Comparation done\n"); }

"cmp "({identifiers}|{digits})[ \t\n]*("-ne")[ \t\n]*({identifiers}|{digits})[ \t\n]*":"(.+)[;] { printf("Not equal Comparation done\n"); }

"return"[ ]+{digit}; { printf("Return statement\n"); }


({identifiers}[ ]+"inc")[;]|("inc"[ ]+{identifiers})[;]    printf("increment statement");
({identifiers}[ ]+"dec")[;]|("dec"[ ]+{identifiers})[;]    printf("decrement statement");





"add"         { printf("Operator: add\n"); }
"sub"         { printf("Operator: sub\n"); }
"mul"         { printf("Operator: mul\n"); }
"div"         { printf("Operator: div\n"); }

"-eq"         { printf("Operator: equal\n"); }
"-ne"         { printf("Operator: not equal\n"); }
"-lt"         { printf("Operator: less_than\n"); }
"-le"         { printf("Operator: less_than or equal\n"); }
"-gt"         { printf("Operator: greater than\n"); }
"-ge"         { printf("Operator: greater than or equal\n"); }




"SORT" 			{printf("SORT statement");}
"FACT"			{printf("FACT statement");}
"sin" 			{printf("SINFUNC statement");}
"cos" 			{printf("COSFUNC statement");}
"tan" 			{printf("TANFUNC statement");}
"MAX"  			{printf("MAXNUMBER statement");}
"MIN"  			{printf("MINNUMBER statement");}
"CMPR" 			{printf("COMPAREREVERSE statement");}
"REV" 			{printf("REVERSE statement");}
"log10"			{printf("LOG10FUNC statement");}
"log" 			{printf("LOGFUNC statement");}
"gcd" 			{printf("GCDFUNC statement");}
"lcm" 			{printf("LCMFUNC statement");}
"pow" 			{printf("POWERFUNC statement");}



"let"[ ]+{identifiers}	                                {printf("Switch Statement");}
"option"([ ]+)({identifiers}|{digits})":"(.+)[;]        {printf("Case Statement");}
"default"[ ]+":"(.+)[;]	                                {printf("DEFAULT");}


"when"[ ]*[(][ ]*{identifiers}*[ ]*("-eq"|"-ne"|"-lt"|"-le"|"-gt"|"-ge")[ ]*{identifiers}*[ ]*[)][ \t\n]*[{][ \t\n]*.*[ \t\n]*[}] {
    printf("While loop\n");
}



"any"[ ]*[(][ ]*{identifiers}[ ]*("-eq"|"-ne"|"-lt"|"-le"|"-gt"|"-ge")[ ]*{identifiers}[ ]*[)][ \t]*"then"[ \t]*[{][ \t\n]*.*[ \t\n]*[}][ \t\n]*"also"[ \t\n]*[(][ ]*{identifiers}[ ]*("-eq"|"-ne"|"-lt"|"-le"|"-gt"|"-ge")[ ]*{identifiers}[ ]*[)][ \t]*"then"[ \t]*[{][ \t\n]*.*[ \t\n]*[}][ \t\n]*"or"[ \t\n]*[{][ \t\n]*.*[ \t\n]*[}] {
    printf("If Else Ladder Block\n");
}



"FOR"[ ]*[(][ ]*{identifiers}[ ]*[,][ ]*{digits}[ ]*[,][ ]*{identifiers}[ ]*("-eq"|"-ne"|"-lt"|"-le"|"-gt"|"-ge")[ ]*({identifiers}|{digits})[ ]*[,][ ]*{identifiers}[ ]+("inc"|"dec")[)][ \t\n]*[{][ \t\n]*.*[ \t\n]*[}] {
    printf("FOR loop statement\n");
}





"BEGIN:" 			{printf("Beginning of Main section");}
"END" 			        {printf("Ending of Main section");}



%%





int yywrap() {
return 1;
}




int main()
{
	yyin = freopen("input.txt","r",stdin);
	yyout = freopen("output.txt","w",stdout);

       
	yylex();
	return 0;


}
