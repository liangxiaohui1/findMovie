//
//  sortMovie.c
//  sortMovie
//
//  Created by Xiaohui Liang on 24/3/20.
//  Copyright © 2020 Xiaohui Liang. All rights reserved.
//

#include "sortMovie.h"

#define swap_popularity(a,b) {double i=*(b); *(b)=*(a); *(a)=i;}
#define swap_title(a,b) {char *n=(a); (a)=(b); (b)=n;}

int sort_movie(filmNode *root, int max_number){
    filmNode *outer_p = NULL;
    filmNode *inner_p = NULL;
    
    if(root == NULL || root->next == NULL)
        return RV_OK;
    
    outer_p = root;
    while(outer_p != NULL && max_number-->0){
        inner_p = outer_p->next;
        while(inner_p != NULL){
            if(outer_p->popularity < inner_p->popularity){
                swap_popularity(&outer_p->popularity,&inner_p->popularity);
                swap_title(outer_p->title,inner_p->title);
            }
            inner_p = inner_p->next;
        }
        outer_p = outer_p->next;
    }

    return RV_OK;
}

