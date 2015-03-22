//
//  FEZTweetCell.h
//  Fezaar
//
//  Created by t-matsumura on 3/22/15.
//  Copyright (c) 2015 HumourStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FEZTweet.h"

@interface FEZTweetCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *tweetTextLabel;

- (void)presentTweet:(FEZTweet *)tweet;

@end