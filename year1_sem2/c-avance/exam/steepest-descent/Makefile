CFLAGS = -g -Wall --pedantic -std=c99
OBJ=main.o steepestDescent.o
HEADERS=myHeader.h
CC=gcc
LIBS= -lm

default : steepestDescent.exe 

%.o: %.c
	${CC} ${CFLAGS} -c $^ -o $@

steepestDescent.exe: ${OBJ}
	${CC} ${CFLAGS} ${OBJ} ${HEADERS} -o steepestDescent.exe ${LIBS}

clean : 
	rm -f *.o *.exe *~
