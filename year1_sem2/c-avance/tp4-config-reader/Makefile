FLAGS= -g
CC=gcc

all: app

readkey.o: readkey.c
	${CC} ${FLAGS} -c readkey.c

main.o: main.c
	${CC} ${FLAGS} -c main.c

app: readkey.o main.o
	${CC} ${FLAGS} main.o readkey.o -o app

clean:
	rm *~ app *.o
