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

/*structure to store movies information*/
struct Film {
    double popularity;
    char *title;
    struct Film *next;
};

typedef struct Film filmNode;
/*
**sort movies stored in fileNode chain according to popolarity
**parameter root[input/output]: pointer to root filmNode to be sorted
**parameter max_number[input] : the max number to be sorted.
**    sorting will stop either reaching max_number of movies or there is no more movies in chain
**return :RV_OK
*/
/* parameter max_number is not neccessary for this movie list project. but useful in case there are many
 * movies in chain, and it may take long time to sort all
 */
int sort_movie(filmNode *root, int max_number);

#endif /* sortMovie_h */
