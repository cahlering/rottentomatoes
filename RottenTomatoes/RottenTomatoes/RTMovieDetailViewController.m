//
//  RTMovieDetailListViewController.m
//  RottenTomatoes
//
//  Created by Chris Ahlering on 3/16/14.
//  Copyright (c) 2014 Chris Ahlering. All rights reserved.
//

#import "RTMovieDetailViewController.h"
#import "UIImageView+AFNetworking.h"

@interface RTMovieDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *cast;
@property (weak, nonatomic) IBOutlet UILabel *description;
@property (weak, nonatomic) IBOutlet UIImageView *poster;


@end

@implementation RTMovieDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title.text = self.movie.title;
    self.description.text = self.movie.description;
    //self.cast.text = [[self.movie.cast objectAtIndex:0] string];
    
    [self.poster setImageWithURL:[NSURL URLWithString:[self.movie.posters valueForKey:@"detailed"]]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
