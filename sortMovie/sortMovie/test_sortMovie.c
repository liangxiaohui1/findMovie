//
//  test_sortMovie.c
//  sortMovie
//
//  Created by Xiaohui Liang on 25/3/20.
//  Copyright © 2020 Xiaohui Liang. All rights reserved.
//

#include <stdio.h>
#include <string.h>
#include "sortMovie.h"

#define TEST(a) {if (a) {tests_passed++;} else {tests_failed++;}}

#define TEST_PASS 0
#define TEST_FAIL 1

static int test_sort_movie();

int main()
{
    int tests_passed=0;
    int tests_failed=0;
    
    TEST(test_sort_movie() == TEST_PASS);

    if(tests_failed > 0){
        printf("Test failed\n");
        return TEST_FAIL;
    }else{
        printf("Test passed\n");
        return TEST_PASS;
    }
}

static int test_sort_movie()
{
    int tests_passed=0;                                                 
    int tests_failed=0;
    
    filmNode film1;
    filmNode film2;
    filmNode film3;
    filmNode film4;
    
    double popularity1 = 5.1;
    double popularity2 = 4.1;
    double popularity3 = 3.1;
    double popularity4 = 2.2;
    char *title1 = "5.1star wars";
    char *title2 = "4.1transforms";
    char *title3 = "3.1Hello, Dolly!";
    char *title4 = "2.2Hello Again";
    
    film1.popularity = popularity3; film1.title = title3; film1.next = NULL;
    
    sort_movie(&film1, 1);
    
    TEST(film1.popularity == popularity3 && strncmp(film1.title, title3, strlen(title3))==0);
    
    film1.popularity = popularity3; film1.title = title3; film1.next = &film2;
    film2.popularity = popularity1; film2.title = title1; film2.next = NULL;

    sort_movie(&film1, 2);

    TEST(film1.popularity == popularity1 && strncmp(film1.title, title1, strlen(title1))==0);
    TEST(film2.popularity == popularity3 && strncmp(film2.title, title3, strlen(title3))==0);
    
    film1.popularity = popularity4; film1.title = title4; film1.next = &film2;
    film2.popularity = popularity3; film2.title = title3; film2.next = &film3;
    film3.popularity = popularity2; film3.title = title2; film3.next = &film4;
    film4.popularity = popularity1; film4.title = title1; film4.next = NULL;
    
    sort_movie(&film1, 4);

    TEST(film1.popularity == popularity1 && strncmp(film1.title, title1, strlen(title1))==0);
    TEST(film2.popularity == popularity2 && strncmp(film2.title, title2, strlen(title2))==0);
    TEST(film3.popularity == popularity3 && strncmp(film3.title, title3, strlen(title3))==0);
    TEST(film4.popularity == popularity4 && strncmp(film4.title, title4, strlen(title4))==0);
    
    if (tests_failed > 0)
    {
        return TEST_FAIL;
    }
    else {
        return TEST_PASS;
    }
    
}
