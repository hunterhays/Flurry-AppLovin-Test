//
//  ViewController.m
//  nativeSampleVideo
//
//  Created by  Hunter Hays on 2/7/17.
//  Copyright © 2017 Hunter Hays. All rights reserved.
//

#import "ViewController.h"
#import "FlurryAdNative.h"
#import "FlurryAdNativeDelegate.h"
#import "AFNetworking/AFNetworking.h"
#import "UIImageView+AFNetworking.h"


@interface ViewController () <FlurryAdNativeDelegate>

@property (nonatomic, retain) FlurryAdNative* nativeAd;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    }

- (void) adNativeDidFetchAd:(FlurryAdNative*)nativeAd
{
    self.containerView.hidden=NO;
    self.hideAdButton.hidden=NO;
    
    // The SDK returns this callback for every instance of the native ad fetched.
    // The flurryAd object contains all the ad assets
    NSLog(@"Native Ad for Space [%@] Received Ad with [%lu] assets", nativeAd.space, (unsigned long)nativeAd.assetList.count);
    
    for (int ix = 0; ix < nativeAd.assetList.count; ++ix) {
        
        FlurryAdNativeAsset* asset = [nativeAd.assetList objectAtIndex:ix];
        
        if ([asset.name isEqualToString:@"headline"]) {
            self.cardTitleLabel.text = asset.value;
        }
        if ([asset.name isEqualToString:@"summary"]) {
            self.cardSummaryLabel.text = asset.value;
        }
        
        if ([asset.name isEqualToString:@"source"] && asset.value != nil && [asset.value isKindOfClass:[NSString class]]) {
            self.cardSourceLabel.text = asset.value;
        }
        if ([asset.name isEqualToString:@"secHqImage"])
        {
            self.cardRectangleImageView.contentMode = UIViewContentModeScaleAspectFit;
            [self.cardRectangleImageView setImageWithURL:[NSURL URLWithString:asset.value] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
            self.cardRectangleImageView.hidden = NO;
            self.cardRectangleVideoViewContainer.hidden = YES;
        }
    }
    self.cardSponsoredLabel.text = @"SPONSORED";
    
    if ([nativeAd isVideoAd]) {
        
        nativeAd.videoViewContainer =  self.cardRectangleVideoViewContainer;
        self.cardRectangleVideoViewContainer.hidden = NO;
        self.cardRectangleImageView.hidden = YES;
    }
    
   self.nativeAd.trackingView = self.containerView;
}

//Informational callback invoked when there is an ad error
- (void) adNative:(FlurryAdNative*)nativeAd
          adError:(FlurryAdError)adError
 errorDescription:(NSError*) errorDescription
{
    // The SDK returns this callback for every failed attempt to fetch a native ad.
    // The nativeAd object contains no assets,
    // the error provides further info on why the request failed.
    NSLog(@" Native Ad for Space [%@] Received Error # [%d], with description: [%@]  ================ ", nativeAd.space, adError, errorDescription );}

- (IBAction)loadAd:(UIButton *)sender {
    
    
    if (self.nativeAd) {
    [self.nativeAd removeTrackingView];
    
    //remove previous ad object
     self.nativeAd = nil;
    }
    
    NSString* adUnitName;
    adUnitName = @"fullCard";
    

    //”iOSNativeAd” is configured on dev.flurry.com as a Stream ad space
    
      FlurryAdNative* nativeAd = [[FlurryAdNative alloc] initWithSpace:adUnitName];
    
    //Assign the FlurryAdNativeDelegate
    nativeAd.adDelegate = self;
    
    //UIViewController used for presentation of the full screen after the user clicks on the ad
    nativeAd.viewControllerForPresentation = self;
    
    
    self.nativeAd = nativeAd;
    
    
    
    if (self.videoSwitch.isOn) {
        FlurryAdTargeting* adTargeting = [FlurryAdTargeting targeting];
        adTargeting.testAdsEnabled = YES;
        nativeAd.targeting = adTargeting;
    }
    
    
    
    //Request the ad from Flurry.
    [nativeAd fetchAd];
}

/*!
 *  @brief Informational callback invoked when an ad impression is logged
 *  @since 6.6.0
 *
 *  @param nativeAd The native ad object associated with the impressions
 *
 */
- (void) adNativeDidLogImpression:(FlurryAdNative*) nativeAd {
    NSLog(@"Impression will be counted!");
}
- (IBAction)hideAd:(id)sender {
    self.containerView.hidden=YES;
    self.hideAdButton.hidden=YES;
}
@end
