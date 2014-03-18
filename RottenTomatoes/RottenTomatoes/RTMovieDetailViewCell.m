//
//  RTMovieDetailViewCell.m
//  RottenTomatoes
//
//  Created by Chris Ahlering on 3/18/14.
//  Copyright (c) 2014 Chris Ahlering. All rights reserved.
//

#import "RTMovieDetailViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface RTMovieDetailViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;

@end

@implementation RTMovieDetailViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - public methods

-(void) setMovie:(RTMovieObject *)movie {
    _movie = movie;
    
    self.titleLabel.text = self.movie.title;
    self.synopsisLabel.text = self.movie.description;
    NSURL *thumbNailUrl = [NSURL  URLWithString:[self.movie.posters valueForKey:@"thumbnail"]];
    NSURLRequest *thumbnailRequest = [NSURLRequest requestWithURL:thumbNailUrl];
    UIImage *placeHolderImage = [UIImage imageNamed:@"loading"];
    
    [self.posterView setImageWithURLRequest:thumbnailRequest placeholderImage:placeHolderImage success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        self.posterView.image = image;
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        nil;
    }];
}
@end
