//
//  sortMovie.h
//  sortMovie
//
//  Created by Xiaohui Liang on 24/3/20.
//  Copyright © 2020 Xiaohui Liang. All rights reserved.
//

#ifndef sortMovie_h
#define sortMovie_h

#include <stdio.h>

/* function return value */
enum{
    RV_OK = 0,
    RV_ERR = 1,
};

/*structure to store movies information returned*/
struct Film {
    double popularity;
    char *title;
    struct Film *next;
};

typedef struct Film filmNode;
/*
**sort films stored in fileNode chain according to popolarity
**parameter root(input/output): root filmNode to be sorted
**parameter max_number(input) : the max number to be sorted.
**    sorting will stop either sorting max_number of film or there is no more movies in node
**return :RV_OK
*/
int sort_movie(filmNode *root, int max_number);

#endif /* sortMovie_h */
