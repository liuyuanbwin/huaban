//
//  PSBroView.m
//  BroBoard
//
//  Created by Peter Shih on 5/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

/**
 This is an example of a subclass of PSCollectionViewCell
 */

#import "PSBroView.h"
#import "JCRBlurView.h"

#define MARGIN 4.0

@interface PSBroView ()

@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UILabel *captionLabel;

@end

@implementation PSBroView

@synthesize
imageView = _imageView,
captionLabel = _captionLabel;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        //self.alpha = 0.1;
        
        self.imageView = [[[UIImageView alloc] initWithFrame:CGRectZero] autorelease];
        self.imageView.clipsToBounds = YES;
        [self addSubview:self.imageView];
        
        self.captionLabel = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
        self.captionLabel.font = [UIFont boldSystemFontOfSize:14.0];
        self.captionLabel.numberOfLines = 0;
        [self addSubview:self.captionLabel];
    }
    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.imageView.image = nil;
    self.captionLabel.text = nil;
}

- (void)dealloc {
    self.imageView = nil;
    self.captionLabel = nil;
    [super dealloc];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = self.frame.size.width - MARGIN * 2;
    CGFloat top = MARGIN;
    CGFloat left = MARGIN;
    
    // Image
    CGFloat objectWidth = [[self.object objectForKey:@"width"] floatValue];
    CGFloat objectHeight = [[self.object objectForKey:@"height"] floatValue];
   // CGFloat objectWidth = 100;
    //CGFloat objectHeight = 100;
    CGFloat scaledHeight = floorf(objectHeight / (objectWidth / width));
    self.imageView.frame = CGRectMake(left, top, width, scaledHeight);
    
    // Label
    CGSize labelSize = CGSizeZero;
    labelSize = [self.captionLabel.text sizeWithFont:self.captionLabel.font constrainedToSize:CGSizeMake(width, INT_MAX) lineBreakMode:self.captionLabel.lineBreakMode];
    top = self.imageView.frame.origin.y + self.imageView.frame.size.height + MARGIN;
    self.captionLabel.frame = CGRectMake(left, top, labelSize.width, labelSize.height);
   // JCRBlurView * blur = [JCRBlurView new];
   // [blur setFrame:self.frame];
   //[self.captionLabel addSubview:blur];
}

- (void)fillViewWithObject:(id)object {
    [super fillViewWithObject:object];
    NSString * Url = [object objectForKey:@"imgUrl"];
    self.captionLabel.text = [object objectForKey:@"raw"];
    NSURL * imgUrl = [NSURL URLWithString:Url];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:imgUrl];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * response,NSData * data,NSError * error){
    self.imageView.image = [UIImage imageWithData:data];
    }];
}

+ (CGFloat)heightForViewWithObject:(id)object inColumnWidth:(CGFloat)columnWidth {
    CGFloat height = 0.0;
    CGFloat width = columnWidth - MARGIN * 2;
    
    height += MARGIN;
    
    // Image
    CGFloat objectWidth = [[object objectForKey:@"width"] floatValue];
    CGFloat objectHeight = [[object objectForKey:@"height"] floatValue];
#warning | w + h
   //CGFloat objectWidth = 100;
   //CGFloat objectHeight = 100;
    CGFloat scaledHeight = floorf(objectHeight / (objectWidth / width));
    height += scaledHeight;
    
    // Label
    NSString *caption = [object objectForKey:@"raw"];
    NSLog(@"caption = %@",caption);
  //NSString *caption = @"ddddd";
    CGSize labelSize = CGSizeZero;
    UIFont *labelFont = [UIFont boldSystemFontOfSize:14.0];
    labelSize = [caption sizeWithFont:labelFont constrainedToSize:CGSizeMake(width, INT_MAX) lineBreakMode:UILineBreakModeWordWrap];
    height += labelSize.height;
    
    height += MARGIN;
    height = (CGFloat)ceilf(height);
    return height;
}

@end
