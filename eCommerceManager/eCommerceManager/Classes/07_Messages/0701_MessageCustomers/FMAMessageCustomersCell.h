//
//  FMAMessageCustomersCell.h
//  eCommerceManager
//
//  Created by Albert Chen on 8/26/14.
//  Copyright (c) 2014 Albert Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface FMAMessageCustomersCell : UITableViewCell

@property (weak,   nonatomic) IBOutlet PFImageView      *imageviewCustomer;
@property (weak,    nonatomic) IBOutlet UILabel          *labelName;
@property (weak,    nonatomic) IBOutlet UILabel          *labelDistance;

// ----------------------------------------------------------------------------------------
#pragma mark - Main Functions
- (void)configureCellWithData:(id)data;

@end
