//
//  RTMovieListViewController.m
//  RottenTomatoes
//
//  Created by Chris Ahlering on 3/15/14.
//  Copyright (c) 2014 Chris Ahlering. All rights reserved.
//
//  Rotten Tomatoes api key: qqjjvmep568xkmjkrqd42bsa
//

#import "RTMovieListViewController.h"
#import "RTMovieDetailViewController.h"
#import "AFNetworking.h"
#import "RTMovieDetailViewCell.h"
#import "RTMovieObject.h"
#import "RTMovieResponse.h"

@interface RTMovieListViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) NSArray *movies;

@end

@implementation RTMovieListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self getMovies];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) getMovies
{
    self.title = @"Top DVDs";
    
    NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=qqjjvmep568xkmjkrqd42bsa";
    NSURL *nsUrl = [NSURL URLWithString: url];
    NSURLRequest *request = [NSURLRequest requestWithURL: nsUrl];
    
    AFHTTPRequestOperation *afRequestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    MUJSONResponseSerializer *movieSerializer = [[MUJSONResponseSerializer alloc] init] ;
    [movieSerializer setResponseObjectClass:[RTMovieResponse class]];
    
    afRequestOperation.responseSerializer = movieSerializer;
    [afRequestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        RTMovieResponse *response = (RTMovieResponse *)responseObject;
        self.movies = response.movies;
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Networking Error"
                                                         message:@"Replace this error"
                                                        delegate:nil
                                               cancelButtonTitle:@"Dismiss"
                                               otherButtonTitles: nil ];
        [alert show];
    }];
    
    [afRequestOperation start];
}

#pragma mark - UITableView data source methods


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.movies count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RTMovieDetailViewCell *movieCell = [[RTMovieDetailViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    RTMovieObject *movie = self.movies[indexPath.row];
    movieCell.textLabel.text = movie.title;
    
    return movieCell;
}


@end
