CC := g++
SRCDIR := src
BUILDDIR := build
TARGET := main.out
CFLAGS := -g -O3 -std=c++11 -I include/

all: main

#vaga:
usuario:
	@mkdir -p build
	$(CC) $(CFLAGS) -c src/usuario.cpp -o build/usuario.o
funcionario:
	$(CC) $(CFLAGS) -c src/funcionario.cpp -o build/funcionario.o
sistema:
	$(CC) $(CFLAGS) -c src/sistema.cpp -o build/sistema.o

# Modifique a funcao main
main: usuario funcionario sistema
	$(CC) $(CFLAGS) build/usuario.o build/funcionario.o build/sistema.o src/main.cpp -o $(TARGET)
	@clear
clean:
	$(RM) -r $(BUILDDIR)/* $(TARGET)
