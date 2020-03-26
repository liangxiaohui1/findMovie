CFLAGS = -g -Wall -DDEBUG
CINCLUDE = -I .
compile:test_sortMovie clean

test_sortMovie: test_sortMovie.o sortMovie.o
	cc $(CFLAGS) $(CINCLUDE) -o test_sortMovie test_sortMovie.o sortMovie.o

test_sortMovie.o: test/test_sortMovie.c sortMovie.c
	cc $(CFLAGS) $(CINCLUDE) -c test/test_sortMovie.c sortMovie.c

clean:
	-rm *.o
