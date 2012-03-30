FLAGS= -g
CC=gcc
OBJ=config-reader.o main.o

all: app

config-reader.o: config-reader.c
	${CC} ${FLAGS} -c config-reader.c

main.o: main.c
	${CC} ${FLAGS} -c main.c

app: ${OBJ}
	${CC} ${FLAGS} ${OBJ} -o app

clean:
	rm *~ app *.o
