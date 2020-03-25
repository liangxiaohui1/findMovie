
########### file description ###########
MovieList is application
manageMovie is dynamic library to handle data from website
	movieList.h : declaration of  class movieList
	movieList.m : implementation of class movieList 
sortMovie is static library
	sortMovie.h : declaration of sorting function, sort_movie
	sortMovie.c : implementation of function sort_movie
	test_sortMovie.c : test codes for function sort_movie
	makefile : compile test_sortMovie.c and sortMovie.c to generate test application test_sortMovie
	test_sortMovie: unit test application

########### how to use ###########
open MovieList.xcodeproj in xcode to view and run application
run test_sortMovie to test sorting function from static library
