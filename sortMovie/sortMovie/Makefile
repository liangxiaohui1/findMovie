CFLAGS = -g -Wall -DDEBUG
CINCLUDE = -I .
compile:test_sortMovie
	
%.o:%.c 
	cc $(CFLAGS) $(CINCLUDE) -c $(filter %.c, $^) -o $@

test_sortMovie: test_sortMovie.o sortMovie.o
	cc $(CFLAGS) $(CINCLUDE) -o test_sortMovie test_sortMovie.o sortMovie.o

test_sortMovie.o:test_sortMovie.c sortMovie.c
	cc $(CFLAGS) $(CINCLUDE) -c test_sortMovie.c sortMovie.c

clean:
	-rm *.o
