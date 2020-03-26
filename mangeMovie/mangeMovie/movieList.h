//
//  movieList.h
//  mangeMovie
//
//  Created by Xiaohui Liang on 24/3/20.
//  Copyright © 2020 Xiaohui Liang. All rights reserved.
//

#ifndef movieList_h
#define movieList_h

#import <Foundation/Foundation.h>
#import "sortMovie.h"
/*
**movieList is a class which store, sort and output movies information
**init: constructor function
**insertFilm: insert one film to chain
**    parameter popularity[input]: film's popularity
**    parameter title[input]: film's title
**    return: RV_OK if success
**            RV_ERR if failure
**getFilm:get one file according to ranking
**    parameter ranking(input):0 is most popular file. 1 is second.2...
**    return: the filmnode pointer if success
**            NULL if failure
**dealloc: destructor function
*/
@interface movieList:NSObject
- (id) init;
- (int) insertFilm:(NSNumber *) popularity andTitle:(NSString *) title;
- (filmNode *) getFilm:(int)ranking;
- (void) dealloc;
@end

#endif /* movieList_h */
