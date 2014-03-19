//
//  RTMovieDetailViewCell.m
//  RottenTomatoes
//
//  Created by Chris Ahlering on 3/18/14.
//  Copyright (c) 2014 Chris Ahlering. All rights reserved.
//

#import "RTMovieDetailViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "RTCastMember.h"

@interface RTMovieDetailViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UILabel *castLabel;

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
    NSMutableString *castString = [[NSMutableString alloc]init];
    for (RTCastMember *castMember in self.movie.cast) {
        if (castString.length > 0) {
            [castString appendString:@", "];
        }
        [castString appendString:castMember.name];
    }
    self.castLabel.font = [UIFont fontWithName:@"Verdana-Italic" size:11];
    self.castLabel.text = [NSString stringWithString:castString];
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
