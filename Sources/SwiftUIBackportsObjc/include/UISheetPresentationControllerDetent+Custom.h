//
//  UISheetPresentationControllerDetent+Custom.h
//
//
//  Created by tdt on 2023/12/14.
//

#if __has_include(<UIKit/UIKit.h>)
@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface UISheetPresentationControllerDetent (Custom)
+ (UISheetPresentationControllerDetent *)_detentWithIdentifier:(NSString *)identifier constant:(CGFloat)constant;
@end

NS_ASSUME_NONNULL_END
#endif
