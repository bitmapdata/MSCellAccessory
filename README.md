MSCellAccessory
============

[![Version](http://cocoapod-badges.herokuapp.com/v/MSCellAccessory/badge.png)](http://cocoapod-badges.herokuapp.com/v/MSCellAccessory/badge.png)
[![Platform](http://cocoapod-badges.herokuapp.com/p/MSCellAccessory/badge.png)](http://cocoapod-badges.herokuapp.com/p/MSCellAccessory/badge.png)


MSCellAccessory is a UITableViewCell accessoryType can easily customize the colors. Many developer really want to customizing UITableViewCell accessoryType color. but, they using a customized png image are solved. but this method is not good. because Unnecessary to create an image file, and each would have to create all colors. and Loading it unnecessarily increases the capacity of the memory. If using a this library is more easily customizing accessoryType and more flexible via Programmatically. iOS7 also will support.

Below for the three accessoryType enables customization. and more one thing is TOGGLE_INDICATOR.

    DETAIL_DISCLOSURE: identical to UITableViewCellAccessoryDetailDisclosureButton / default colors (35,110,216)
 
    DISCLOSURE_INDICATOR: identical to UITableViewCellAccessoryDisclosureIndicator / default colors (127,127,127)
 
    CHECKMARK: identical to UITableViewCellAccessoryCheckmark                      / default colors (50, 79, 133)
 
    TOGGLE_INDICATOR: UIControl has a selected property. If the selected property is set to true, shape is V-shaped, 
                      set to false vice versa V-shaped.
    - Access as follows:
        MSCellAccessory *acc = (MSCellAccessory *)cell.accessoryView;
        acc.selected = true;


<p align="center" >
<img src="https://raw.github.com/bitmapdata/MSCellAccessory/master/MSCellAccessoryDemo/ScreenShot.png">
</p>

## Installation ##

MSCellAccessory is possible via CocoaPods. Just add the following to your Podfile.

    platform :ios
    pod 'MSCellAccessory'

Another way to, drag the included <b>MSCellAccessory</b> folder into your project.

## Usage ##

Requirements: At least iOS5

These classes was written under the ARC. Be sure to specify `-fobjc-arc` the 'Compile Sources' Build Phase for each file if you aren't using ARC project-wide

## Sample Code ##

    "#import "MSCellAccessory.h"

    - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        if(indexPath.row == 0)
        {
            cell.accessoryView = [MSCellAccessory accessoryWithType:DETAIL_DISCLOSURE color:[UIColor colorWithRed:253/255.0 green:184/255.0 blue:0/255.0 alpha:1.0]];
        }
        else if(indexPath.row == 1)
        {
            cell.accessoryView = [MSCellAccessory accessoryWithType:DISCLOSURE_INDICATOR color:[UIColor colorWithRed:132/255.0 green:100/255.0 blue:159/255.0 alpha:1.0]];
        }
        else if(indexPath.row == 2)
        {
            cell.accessoryView = [MSCellAccessory accessoryWithType:CHECKMARK color:[UIColor colorWithRed:0/255.0 green:166/255.0 blue:149/255.0 alpha:1.0]];
        }
        
        return cell;
    }


## License ##

Software License Agreement (BSD License)

Copyright (c) 2013 SHIM MIN SEOK. All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

  1. Redistributions of source code must retain the above copyright
     notice, this list of conditions and the following disclaimer.
   
  2. Redistributions in binary form must reproduce the above copyright
     notice, this list of conditions and the following disclaimer in
     the documentation and/or other materials provided with the
     distribution.

  3. Neither the name of Infrae nor the names of its contributors may
     be used to endorse or promote products derived from this software
     without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL INFRAE OR
CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

## Contact ##

bitmapdata.com@gmail.com
