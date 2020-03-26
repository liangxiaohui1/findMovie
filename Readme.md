########### file description ###########

MovieList is application
manageMovie is dynamic library to handle data from websit
	emovieList.h : declaration of class movieList 
	movieList.m : implementation of class movieList 
sortMovie is static library 
	sortMovie.h : declaration of sorting function, sort_movie 
	sortMovie.c : implementation of function sort_movie 
	test/test_sortMovie.c : test file for function sort_movie 
	makefile : compile test_sortMovie.c and test/sortMovie.c to generate test application test_sortMovie 
	test_sortMovie: unit test application

########### how to use ###########

open MovieList.xcodeproj from MovieList folder in xcode to view and run application(MovieList target) 
run test_sortMovie from sorMovie folder in terminal to test sort_movie function in static library


########### UI description ###########

1 text field to allow user to input keyword
1 search button to invoke seaching
1 text view to display search results between 2017.1.1 and 2018.1.1 according to popolarity
1 text field to allow user to input key, input once only
1 confirm button to safely store key during the sesssion

########### TODO ###########
1 No enough sanity check, for example user input