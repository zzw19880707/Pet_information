//
//  TMQuiltView
//
//  Created by Bruno Virlet on 7/20/12.
//
//  Copyright (c) 2012 1000memories

//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"),
//  to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, 
//  and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR 
//  OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
//  DEALINGS IN THE SOFTWARE.
//


#import "TMPhotoQuiltViewCell.h"

const CGFloat kTMPhotoQuiltViewMargin = 5;

@implementation TMPhotoQuiltViewCell

@synthesize photoView = _photoView;
@synthesize titleLabel = _titleLabel;
@synthesize goodLabel = _goodLabel;
@synthesize backgroundView = _backgroundView;
- (void)dealloc {
    [_photoView release], _photoView = nil;
    [_titleLabel release], _titleLabel = nil;
    RELEASE_SAFELY(_goodLabel);
    
    [super dealloc];
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (UIImageView *)photoView {
    if (!_photoView) {
        _photoView = [[UIImageView alloc] init];
        _photoView.contentMode = UIViewContentModeScaleAspectFill;
        _photoView.clipsToBounds = YES;
        [self addSubview:_photoView];
    }
    return _photoView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = UITextAlignmentCenter;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

-(UILabel *)goodLabel{
    if (!_goodLabel) {
        _goodLabel = [[UILabel alloc]init];
        _goodLabel.backgroundColor =[[UIColor grayColor] colorWithAlphaComponent:0.5];
        _goodLabel.textColor = [UIColor whiteColor];
        _goodLabel.textAlignment = UITextAlignmentCenter;
        [self.backgroundView addSubview:_goodLabel];
    }
    return _goodLabel;
}

-(UIImageView *)backgroundView{
    if (!_backgroundView) {
        _backgroundView = [[UIImageView alloc]init];
        [_backgroundView setAlpha:0.8];
//        _backgroundView.image = [UIImage imageNamed:@""];
        UIImageView *goodView = [[UIImageView alloc]init];
        [goodView setAlpha:0.7];
        goodView.frame = CGRectMake((20-8)/2, (10-8)/2, 8, 8);
        [self.backgroundView addSubview:goodView];
        [self addSubview:self.backgroundView];
    }
    return _backgroundView;
}
- (void)layoutSubviews {
    self.photoView.frame = CGRectInset(self.bounds, kTMPhotoQuiltViewMargin, kTMPhotoQuiltViewMargin);
    self.titleLabel.frame = CGRectMake(kTMPhotoQuiltViewMargin, self.bounds.size.height - 20 - kTMPhotoQuiltViewMargin,
                                       self.bounds.size.width - 2 * kTMPhotoQuiltViewMargin, 20);
    
    self.backgroundView.frame = CGRectMake(self.bounds.size.width -kTMPhotoQuiltViewMargin -10 -20, 10, 20, 10);
    
}

@end
