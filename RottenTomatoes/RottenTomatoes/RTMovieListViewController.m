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
#import "MBProgressHUD.h"
#import "MBAlertView.h"


@interface RTMovieListViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) RTMovieResponse *movieResponse;
@property (weak, nonatomic) MBProgressHUD *spinner;

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
    
    self.tableView.rowHeight = 80;
    self.tableView.dataSource = self;
    UINib *rtMovieCellNib = [UINib nibWithNibName:@"RTMovieDetailViewCell" bundle:nil];
    [self.tableView registerNib:rtMovieCellNib forCellReuseIdentifier: @"RTMovieDetailViewCell"];
    
    // refresh on pull
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    [self.tableView addSubview:refreshControl];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) getMovies
{
    self.spinner = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.spinner.mode = MBProgressHUDModeAnnularDeterminate;
    self.spinner.labelText = @"retrieving movies...";
    
    self.title = @"Top DVDs";
    
    NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=qqjjvmep568xkmjkrqd42bsa";
    NSURL *nsUrl = [NSURL URLWithString: url];
    NSURLRequest *request = [NSURLRequest requestWithURL: nsUrl];
    
    AFHTTPRequestOperation *afRequestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    MUJSONResponseSerializer *movieSerializer = [[MUJSONResponseSerializer alloc] init] ;
    [movieSerializer setResponseObjectClass:[RTMovieResponse class]];
    
    afRequestOperation.responseSerializer = movieSerializer;
    [afRequestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.spinner hide:TRUE];
        RTMovieResponse *response = (RTMovieResponse *)responseObject;
        self.movieResponse = response;
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.spinner hide:TRUE];
        MBAlertView* alert = [MBAlertView alertWithBody:@"Error Contacting Rotten Tomatoes" cancelTitle:nil cancelBlock:nil];
        [alert addButtonWithText:@"Dismiss" type:MBAlertViewItemTypePositive block:^{}];
        [alert addToDisplayQueue];
    }];
    
    [afRequestOperation start];
}

- (void)refresh:(UIRefreshControl *)refreshControl {
    [self getMovies];
    [refreshControl endRefreshing];
}

#pragma mark - UITableView data source methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movieResponse.movies.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 85;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RTMovieDetailViewCell *movieCell = [tableView dequeueReusableCellWithIdentifier:@"RTMovieDetailViewCell" forIndexPath:indexPath];
    
    NSInteger rowIndex = indexPath.row;
    RTMovieObject *lm = self.movieResponse.movies[rowIndex];
    [movieCell setMovie: lm];
    return movieCell;
//    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
//    RTMovieObject *movie = self.movieResponse.movies[indexPath.row];
//    cell.textLabel.text = movie.title;
//    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RTMovieDetailViewController *movieDetailControlller = [[RTMovieDetailViewController alloc] init];
    movieDetailControlller.movie = self.movieResponse.movies[indexPath.row];
    [self.navigationController pushViewController:movieDetailControlller animated:YES];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
