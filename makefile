all : clean generate_bison generate_lex compile
	@./a.out

# Faz a compilacao do codigo em C++, porem precisa que exista o output do flex
generate_bison: clean
	@echo "\n==> Executando BISON...";
	@bison -d myshell.y

# Gera codigo a partar da especificacao do flex
generate_lex: clean generate_bison
	@echo "\n==> Executando FLEX...";
	@flex -l myshell.lex

compile: clean generate_bison generate_lex
	@echo "\n==> Compilando...";
	@gcc myshell.tab.c -ll -ly

# regra util para limpar os arquivos que o make gera automaticamente
clean:
	@echo "\n==> Removendo arquivos desnecessários";
	@rm -rf a.out lex.yy.c myshell.tab.c myshell.tab.h
