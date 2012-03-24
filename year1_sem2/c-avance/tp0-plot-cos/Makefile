OBJ=main.o
CC=gcc
FLAGS=-lm
FCT_ARG=

app: ${OBJ}
	${CC} ${OBJ} -o app ${FLAGS}

main.o: main.c
	${CC} main.c -c

start:
	./app ${FCT_ARG} > cos.plt
	./show-graph.sh 

clean:
	rm -f ${OBJ} app *~
