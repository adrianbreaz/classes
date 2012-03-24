.PHONY : clean

CFLAGS = -Wall -g --pedantic

app.exe : main.o countLine.o
	gcc ${CFLAGS} main.o countLine.o -o app.exe

main.o : main.c
	gcc ${CFLAGS} -c  main.c

countLine.o : countLine.c
	gcc ${CFLAGS} -c  countLine.c

clean : 
	rm -f *.o *.exe
