//
//  ViewController.h
//  nativeSampleVideo
//
//  Created by  Hunter Hays on 2/7/17.
//  Copyright © 2017 Hunter Hays. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlurryAdNativeDelegate.h"

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISwitch *videoSwitch;

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *cardTitleLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *cardSummaryLabel;

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *cardSourceLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *sponseredImageView;
@property (weak, nonatomic) IBOutlet UILabel *cardSponsoredLabel;

@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *cardRectangleImageView;

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) IBOutlet UIButton *hideAdButton;


//this UIView overlaps cardRectangleImageView. It could be used for
//presenting a video ad, otherwise it can be hidden
//
@property (weak, nonatomic) IBOutlet UIView *cardRectangleVideoViewContainer;

@end

