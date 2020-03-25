//
//  ViewController.m
//  MovieList
//
//  Created by Xiaohui Liang on 22/3/20.
//  Copyright © 2020 Xiaohui Liang. All rights reserved.
//

#import "ViewController.h"
#import "mangeMovie.h"
#import "movieList.h"
#import <dlfcn.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *movieKeyWord;
@property (weak, nonatomic) IBOutlet UITextField *accessKey;
@property (weak, nonatomic) IBOutlet UITextView *searchResult;
@property NSString *keyValue;

- (int) storeAccessKey:(NSString*)keyValue;
- (NSString *) getAccessKey;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)searchMovie:(UIButton *)sender {
    NSString *startDate = @"2017-01-01";
    NSString *endDate = @"2018-01-01";

    if (self.getAccessKey == NULL) {
        NSLog( @"NO access key");
        self.accessKey.text = @"please input your access key here";
        return;
    }
    
    NSMutableString *path = [[NSMutableString alloc] initWithString:@"https://api.themoviedb.org/3/search/movie?api_key="];
    [path appendString:self.getAccessKey];
    if(self.movieKeyWord.text.length == 0){
        NSLog( @"NO key word");
        self.movieKeyWord.text = @"please input your searching keyword";
        return;
    }
    [path appendString:[NSString stringWithFormat:@"&query=%@",self.movieKeyWord.text]];

    NSLog(@"path: %@", [path stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet]);
    
    NSURL * url = [NSURL URLWithString:[path stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet]];
    NSData * data = [NSData dataWithContentsOfURL:url];
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

    NSArray * jsonArr = dic[@"results"];
    
    NSString *documentsPath = [NSString stringWithFormat:@"%@/Documents/mangeMovie.framework/mangeMovie",NSHomeDirectory()];
    void * libHandle = NULL;
    libHandle = dlopen([documentsPath cStringUsingEncoding:NSUTF8StringEncoding], RTLD_NOW);
    if (libHandle == NULL) {
        char *error = dlerror();
        NSLog(@"dlopen error: %s", error);
    } else {
        NSLog(@"dlopen load framework success.");
    }
    id organizeFilms;
    Class rootClass = NSClassFromString(@"movieList");
    if (rootClass) {
        organizeFilms = [[rootClass alloc] init];
    }
    for (NSDictionary * di in jsonArr) {
        if([di[@"release_date"] compare:startDate]> 0 && [di[@"release_date"] compare:endDate] < 0){
            if( RV_OK != [(movieList *)organizeFilms insertFilm:di[@"popularity"] andTitle:di[@"title"]]){
                NSLog(@"insert file to list failed");
            }
        }
    }

    NSMutableString *resultString = [[NSMutableString alloc] init];
    filmNode *oneFilm = NULL;
    int ranking = 0;
    for(ranking = 0; ranking < 10; ranking++){
        oneFilm = [(movieList *)organizeFilms getFilm:ranking];
        if(oneFilm != NULL){
            [resultString appendString: [[NSString alloc] initWithFormat:@"%d：", ranking+1]];
            [resultString appendString: [[NSString alloc] initWithCString:(const char*)oneFilm->title encoding:NSASCIIStringEncoding]];
            [resultString appendString: @"\n"];
        }
    }
    if(resultString.length == 0){
        [resultString appendString:@"no movie matched!"];
    }
        
    NSLog(@"resultString %@", resultString);
    self.searchResult.text = resultString;
    
}
- (IBAction)confirm:(UIButton *)sender {
    
    if(self.accessKey.text.length != 0){
        [self storeAccessKey:(NSString *)self.accessKey.text];
    }
    self.accessKey.text = [self.accessKey.text stringByReplacingCharactersInRange:NSMakeRange(0,self.accessKey.text.length) withString:@"Key value saved!"];
}

- (int) storeAccessKey:(NSString*)keyValue{

    self.accessKey.text = [self.accessKey.text stringByReplacingOccurrencesOfString:@"1" withString:@"k"];
    self.accessKey.text = [self.accessKey.text stringByReplacingOccurrencesOfString:@"a" withString:@"z"];
    _keyValue = [[NSString alloc] initWithString:self.accessKey.text];
    NSLog(@"self.accessKey.text %@",_keyValue);
    return RV_OK;
}
- (NSString *) getAccessKey{
    if(_keyValue.length != 0){
        NSString *value = [[NSString alloc] initWithString:_keyValue];
        value = [value stringByReplacingOccurrencesOfString:@"k" withString:@"1"];
        value = [value stringByReplacingOccurrencesOfString:@"z" withString:@"a"];
        return value;
    }
    else
        return NULL;
}

@end
