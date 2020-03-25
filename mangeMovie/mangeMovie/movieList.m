//
//  movieList.m
//  mangeMovie
//
//  Created by Xiaohui Liang on 24/3/20.
//  Copyright © 2020 Xiaohui Liang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "movieList.h"
#import <stdio.h>

extern int sort_movie();

@interface movieList()
@property filmNode *rootFilms;
@property filmNode *currFilms;
@property int number;
@property BOOL sorted;
- (int) sortFilms;
@end

@implementation movieList

- (id)init{
    self = [super init];
    if(self){
        _number = 0;
        _sorted = false;
        _rootFilms = NULL;
        _currFilms = NULL;
    }
    return self;
}
- (int) insertFilm:(NSNumber *) popularity andTitle:(NSString *) title{
    filmNode *newFilm = (filmNode *)malloc(sizeof(filmNode));
    if(newFilm == NULL){
        NSLog(@"malloc error inside %@",[[NSString alloc] initWithCString:(const char*)__FUNCTION__ encoding:NSASCIIStringEncoding]);
        return RV_ERR;
    }
    
    newFilm->popularity = popularity.doubleValue;
    newFilm->title = (char *)malloc(title.length+1);
    if(newFilm->title == NULL){
        free(newFilm);
        NSLog(@"malloc error inside %@",[[NSString alloc] initWithCString:(const char*)__FUNCTION__ encoding:NSASCIIStringEncoding]);
        return RV_ERR;
    }
    memcpy(newFilm->title, [title cStringUsingEncoding:NSUTF8StringEncoding], title.length+1);
    newFilm->next=NULL;
    
    if(_rootFilms == NULL){
        _rootFilms = newFilm;
        _currFilms = newFilm;
    }else{
        _currFilms->next = newFilm;
    }
    _currFilms = newFilm;
    _number++;
    _sorted = false;
    return RV_OK;
}

- (filmNode *) getFilm:(int)ranking{
    int i = 0;
    filmNode *iter = _rootFilms;
    
    if(_sorted == false){
        if(((RV_ERR) == self.sortFilms)){
            NSLog(@"sorting error inside %@",[[NSString alloc] initWithCString:(const char*)__FUNCTION__ encoding:NSASCIIStringEncoding]);
            return NULL;
        }
    }

    if(ranking == 0){
        return _rootFilms;
    }
    
    if(ranking > _number-1){
        return NULL;
    }
    
    while(i++ < ranking){
        iter = iter->next;
    }
    return iter;
}

- (int) sortFilms{
    if (RV_OK == sort_movie(_rootFilms,_number)){
        _sorted = true;
        return RV_OK;
    }
    return RV_ERR;
}

- (void) dealloc{
    filmNode *iter = _rootFilms;
    filmNode *temp = NULL;
    while(iter != NULL && _number > 0){
        temp =iter->next;
        free(iter->title);
        free(iter);
        _number--;
        iter = temp;
    }
}
@end
