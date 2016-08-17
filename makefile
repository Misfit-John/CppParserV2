LEXFILE=$(shell find ./script -type f -name '*.l')
GRAMFILE=$(shell find ./script -type f -name '*.y')
#we will begin a new project here, but we don't wanna rewrite some of the functions, so we just write it here
lex: $(LEXFILE) generated $(GRAMFILE)
	bison -o generated/grammar.cpp -d $(GRAMFILE) 
	flex -o generated/lex.cpp --header-file=generated/lex.h $(LEXFILE) 
	$(CXX) generated/lex.cpp -c -o generated/lex.o -I./generated

test: lex
	$(CXX) generated/lex.o -ll -o ./generated/lex
	sh ./script/LexTest.sh ./test_case/ ./generated/lex
	echo $?

generated:
	mkdir generated

clean:
	git clean -f

.PHONY:test,clean
