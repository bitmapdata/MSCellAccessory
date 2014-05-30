//
//  MSCellAccessory.h
//  MSCellAccessory
//
//  Created by SHIM MIN SEOK on 13. 6. 19..
//
//  Software License Agreement (BSD License)
//
//  Copyright (c) 2013 SHIM MIN SEOK. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright
//  notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright
//  notice, this list of conditions and the following disclaimer in
//  the documentation and/or other materials provided with the
//  distribution.
//
//  3. Neither the name of Infrae nor the names of its contributors may
//  be used to endorse or promote products derived from this software
//  without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
//  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
//  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
//  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL INFRAE OR
//  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
//  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
//  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
//  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
//  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
//  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

#import <UIKit/UIKit.h>

/*
 ------------------------------------------------------------------------------------------------------------------------------------------------------
 
 *** iOS7 Flat Design
 
 FLAT_DETAIL_DISCLOSURE: identical to iOS7 UITableViewCellAccessoryDetailDisclosureButton
 
 FLAT_DETAIL_BUTTON: identical to iOS7 UITableViewCellAccessoryDetailButton
 
 FLAT_DISCLOSURE_INDICATOR: identical to iOS7 UITableViewCellAccessoryDisclosureIndicator
 
 FLAT_CHECKMARK: identical to iOS7 UITableViewCellAccessoryCheckmark
 
 FLAT_UNFOLD_INDICATOR: Flat unfold indicator
 
 FLAT_FOLD_INDICATOR: Flat fold indicator
 
 ------------------------------------------------------------------------------------------------------------------------------------------------------
 
 *** Prior to iOS7
 
 DETAIL_DISCLOSURE: identical to UITableViewCellAccessoryDetailDisclosureButton
 
 DISCLOSURE_INDICATOR: identical to UITableViewCellAccessoryDisclosureIndicator
 
 CHECKMARK: identical to UITableViewCellAccessoryCheckmark
 
 UNFOLD_INDICATOR: unfold indicator
 
 FOLD_INDICATOR: fold indicator
 
 ------------------------------------------------------------------------------------------------------------------------------------------------------
 */

#define DETAIL_DISCLOSURE_DEFAULT_COLOR             [UIColor colorWithRed:35/255.0 green:110/255.0 blue:216/255.0 alpha:1.0]
#define DISCLOSURE_INDICATOR_DEFAULT_COLOR          [UIColor colorWithRed:127/255.0 green:127/255.0 blue:127/255.0 alpha:1.0]
#define CHECKMARK_DEFAULT_DEFAULT_COLOR             [UIColor colorWithRed:50/255.0 green:79/255.0 blue:133/255.0 alpha:1.0]
#define FLAT_DETAIL_BUTTON_DEFAULT_COLOR            [UIColor colorWithRed:0/255.0 green:122/255.0 blue:255/255.0 alpha:1.0]
#define FLAT_DISCLOSURE_INDICATOR_DEFAULT_COLOR     [UIColor colorWithRed:199/255.0 green:199/255.0 blue:204/255.0 alpha:1.0]
#define FLAT_CHECKMARK_DEFAULT_COLOR                [UIColor colorWithRed:0/255.0 green:122/255.0 blue:255/255.0 alpha:1.0]

typedef NS_ENUM(NSInteger, MSCellAccessoryType)
{
    DETAIL_DISCLOSURE,
    DISCLOSURE_INDICATOR,
    CHECKMARK,
    UNFOLD_INDICATOR,
    FOLD_INDICATOR,
    PLUS_INDICATOR,
    MINUS_INDICATOR,
    FLAT_DETAIL_DISCLOSURE,
    FLAT_DETAIL_BUTTON,
    FLAT_DISCLOSURE_INDICATOR,
    FLAT_CHECKMARK,
    FLAT_UNFOLD_INDICATOR,
    FLAT_FOLD_INDICATOR,
    FLAT_PLUS_INDICATOR,
    FLAT_MINUS_INDICATOR
};

@interface MSCellAccessory : UIControl
@property (nonatomic, assign) MSCellAccessoryType accType;
@property (nonatomic, assign) BOOL isAutoLayout; //default is YES. if set to NO, accessory layout does not adjust automatically.

+ (MSCellAccessory *)accessoryWithType:(MSCellAccessoryType)accessoryType color:(UIColor *)color;
+ (MSCellAccessory *)accessoryWithType:(MSCellAccessoryType)accessoryType color:(UIColor *)color highlightedColor:(UIColor *)highlightedColor;

// If you using a FLAT_DETAIL_DISCLOSURE, use these method. because FLAT_DETAIL_DISCLOSURE has a two different UI (FLAT_DETAIL_BUTTON, FLAT_DISCLOSURE_INDICATOR), must set a each color.
+ (MSCellAccessory *)accessoryWithType:(MSCellAccessoryType)accessoryType colors:(NSArray *)colors;
+ (MSCellAccessory *)accessoryWithType:(MSCellAccessoryType)accessoryType colors:(NSArray *)colors highlightedColors:(NSArray *)highlightedColors;

@end
