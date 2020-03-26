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
@property NSString *website;
@property NSString *encryptedKeyValue;

- (int) storeAccessKey:(NSString*)newKeyValue;
- (NSString *) getAccessKey;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _website = @"https://api.themoviedb.org";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)searchMovie:(UIButton *)sender {
    NSString *startDate = @"2017-01-01";
    NSString *endDate = @"2018-01-01";
    NSString *jsonResultField = @"results";
    NSString *jsonPopularityField = @"popularity";
    NSString *jsonTitleField = @"title";
    NSString *jsonReleaseDateField = @"release_date";
    int numberToDisplay = 10;

    if (self.getAccessKey == NULL) {
        NSLog( @"NO access key");
        self.accessKey.text = @"please input your access key here";
        return;
    }
    
    NSMutableString *pathString = [[NSMutableString alloc] initWithFormat:@"%@/3/search/movie?api_key=",_website];
    [pathString appendString:self.getAccessKey];
    if(self.movieKeyWord.text.length == 0){
        NSLog( @"NO key word");
        self.movieKeyWord.text = @"please input your searching keyword";
        return;
    }
    [pathString appendString:[NSString stringWithFormat:@"&query=%@&language=en",self.movieKeyWord.text]];

    NSLog(@"pathString: %@", [pathString stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet]);  //delete
    
    NSURL * urlString = [NSURL URLWithString:[pathString stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet]];
    NSData *jsonData;
    NSDictionary * jsonDic;
    
    @try{
        jsonData = [NSData dataWithContentsOfURL:urlString];
        jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    }
    @catch(NSException *exception){
        NSLog(@"there is an exception when connecting url %@",exception.name);
        self.searchResult.text = @"there is an exception when connecting web";
        return;
    }

    NSArray * jsonArray = jsonDic[jsonResultField];
    
    NSString *dylibPath = [NSString stringWithFormat:@"%@/Documents/mangeMovie.framework/mangeMovie",NSHomeDirectory()];
    void * dylibHandle = NULL;
    dylibHandle = dlopen([dylibPath cStringUsingEncoding:NSUTF8StringEncoding], RTLD_NOW);
    if (dylibHandle == NULL) {
        NSLog(@"dlopen error: %s", dlerror());
        return;
    }
    
    id movieListObj;
    Class rootClass = NSClassFromString(@"movieList");
    if (rootClass) {
        movieListObj = [[rootClass alloc] init];
    }
    for (NSDictionary * di in jsonArray) {
        if([di[jsonReleaseDateField] compare:startDate]>= 0 && [di[jsonReleaseDateField] compare:endDate] < 0){
            if( RV_OK != [(movieList *)movieListObj insertFilm:di[jsonPopularityField] andTitle:di[jsonTitleField]]){
                NSLog(@"insert file to list failed");
            }
        }
    }

    NSMutableString *displayString = [[NSMutableString alloc] init];
    filmNode *aFilm = NULL;
    int ranking = 0;
    for(ranking = 0; ranking < numberToDisplay; ranking++){
        aFilm = [(movieList *)movieListObj getFilm:ranking];
        if(aFilm != NULL){
            [displayString appendString: [[NSString alloc] initWithFormat:@"%d：", ranking+1]];
            [displayString appendString: [[NSString alloc] initWithCString:(const char*)aFilm->title encoding:NSASCIIStringEncoding]];
            [displayString appendString: @"\n"];
        }
    }
    if(displayString.length == 0){
        [displayString appendString:@"no movie matched!"];
    }
        
    NSLog(@"resultString %@", displayString);
    self.searchResult.text = displayString;
    
}
- (IBAction)confirm:(UIButton *)sender {
    
    if(self.accessKey.text.length != 0){
        [self storeAccessKey:self.accessKey.text];
        //clear memory for security
        self.accessKey.text = [self.accessKey.text stringByReplacingCharactersInRange:NSMakeRange(0,self.accessKey.text.length) withString:@"Key value inputed!"];
    }
}

- (int) storeAccessKey:(NSString*)newKeyValue{
    if(newKeyValue.length != 0){
        /*the content twist method is meaningless, just show the point plain text should be stored directly*/
        newKeyValue = [newKeyValue stringByReplacingOccurrencesOfString:@"1" withString:@"k"];
        newKeyValue = [newKeyValue stringByReplacingOccurrencesOfString:@"a" withString:@"z"];
        _encryptedKeyValue = [[NSString alloc] initWithString:newKeyValue];
    }
    return RV_OK;
}

- (NSString *) getAccessKey{
    if(_encryptedKeyValue.length != 0){
        NSString *plainKeyValue = [[NSString alloc] initWithString:_encryptedKeyValue];
        plainKeyValue = [plainKeyValue stringByReplacingOccurrencesOfString:@"k" withString:@"1"];
        plainKeyValue = [plainKeyValue stringByReplacingOccurrencesOfString:@"z" withString:@"a"];
        return plainKeyValue;
    }
    else
        return NULL;
}

@end
