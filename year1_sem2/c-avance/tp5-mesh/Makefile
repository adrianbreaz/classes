CFLAGS= -g
CC=gcc
OBJ=mesh.o main.o
LIBS= -lm

all: app.exe

%.o: %.c
	${CC} ${CFLAGS} -c $^ -o $@

app.exe: ${OBJ}
	${CC} ${CFLAGS} ${OBJ} -o app.exe ${LIBS}

clean:
	rm *~ app.exe *.o