//
//  UIView+MASShorthandAdditions.h
//  Masonry
//
//  Created by Jonas Budelmann on 22/07/13.
//  Copyright (c) 2013 Jonas Budelmann. All rights reserved.
//

#import "View+MASAdditions.h"

#ifdef MAS_SHORTHAND

/**
 *	Shorthand view additions without the 'mas_' prefixes,
 *  only enabled if MAS_SHORTHAND is defined
 */
@interface MAS_VIEW (MASShorthandAdditions)

@property (nonatomic, strong, readonly) MASViewAttribute *left_mas;
@property (nonatomic, strong, readonly) MASViewAttribute *top_mas;
@property (nonatomic, strong, readonly) MASViewAttribute *right_mas;
@property (nonatomic, strong, readonly) MASViewAttribute *bottom_mas;
@property (nonatomic, strong, readonly) MASViewAttribute *leading_mas;
@property (nonatomic, strong, readonly) MASViewAttribute *trailing_mas;
@property (nonatomic, strong, readonly) MASViewAttribute *width_mas;
@property (nonatomic, strong, readonly) MASViewAttribute *height_mas;
@property (nonatomic, strong, readonly) MASViewAttribute *centerX_mas;
@property (nonatomic, strong, readonly) MASViewAttribute *centerY_mas;
@property (nonatomic, strong, readonly) MASViewAttribute *baseline_mas;
@property (nonatomic, strong, readonly) MASViewAttribute *(^attribute)(NSLayoutAttribute attr);

- (NSArray *)makeConstraints:(void(^)(MASConstraintMaker *make))block;
- (NSArray *)updateConstraints:(void(^)(MASConstraintMaker *make))block;
- (NSArray *)remakeConstraints:(void(^)(MASConstraintMaker *make))block;

@end

#define MAS_ATTR_FORWARD(attr)  \
- (MASViewAttribute *)attr {    \
    return [self mas_##attr];   \
}

@implementation MAS_VIEW (MASShorthandAdditions)

MAS_ATTR_FORWARD(top_mas);
MAS_ATTR_FORWARD(left_mas);
MAS_ATTR_FORWARD(bottom_mas);
MAS_ATTR_FORWARD(right_mas);
MAS_ATTR_FORWARD(leading_mas);
MAS_ATTR_FORWARD(trailing_mas);
MAS_ATTR_FORWARD(width_mas);
MAS_ATTR_FORWARD(height_mas);
MAS_ATTR_FORWARD(centerX_mas);
MAS_ATTR_FORWARD(centerY_mas);
MAS_ATTR_FORWARD(baseline_mas);

- (MASViewAttribute *(^)(NSLayoutAttribute))attribute {
    return [self mas_attribute];
}

- (NSArray *)makeConstraints:(void(^)(MASConstraintMaker *))block {
    return [self mas_makeConstraints:block];
}

- (NSArray *)updateConstraints:(void(^)(MASConstraintMaker *))block {
    return [self mas_updateConstraints:block];
}

- (NSArray *)remakeConstraints:(void(^)(MASConstraintMaker *))block {
    return [self mas_remakeConstraints:block];
}

@end

#endif
