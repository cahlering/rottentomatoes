//
//  RTMovieDetailListViewController.m
//  RottenTomatoes
//
//  Created by Chris Ahlering on 3/16/14.
//  Copyright (c) 2014 Chris Ahlering. All rights reserved.
//

#import "RTMovieDetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "RTCastMember.h"

@interface RTMovieDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *castLabel;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


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
    
    self.title = self.movie.title;
    self.descriptionLabel.text = self.movie.description;
    NSMutableString *castString = [[NSMutableString alloc]init];
    for (RTCastMember *castMember in self.movie.cast) {
        if (castString.length > 0) {
            [castString appendString:@", "];
        }
        [castString appendString:castMember.name];
    }
    self.castLabel.text = [NSString stringWithString:castString];
    
    [self.posterView setImageWithURL:[NSURL URLWithString:[self.movie.posters valueForKey:@"detailed"]]];
    
    self.scrollView.alpha = 0.85f;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
