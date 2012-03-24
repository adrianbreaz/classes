CFLAGS = -g --pedantic -std=c89
CC=gcc

default: app.exe

io.o : io.c
	${CC} ${CFLAGS} -c io.c

interpolate.o : interpolate.c
	${CC} ${CFLAGS} -c interpolate.c

main.o : main.c
	${CC} ${CFLAGS} -c main.c

app.exe : main.o io.o interpolate.o
	${CC} ${CFLAGS}  interpolate.o main.o io.o -o app.exe
	
clean:
	rm -f *.o *.exe
