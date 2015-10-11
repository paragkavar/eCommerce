//
//  FMACheckoutProductCell.m
//  eCommerceManager
//
//  Created by Albert Chen on 9/20/14.
//  Copyright (c) 2014 Albert Chen. All rights reserved.
//

#import "FMACheckoutProductCell.h"
#import "FMAData.h"
#import "FMAConstants.h"
#import "FMAUtil.h"
#import "FMAThemeManager.h"

@implementation FMACheckoutProductCell

// --------------------------------------------------------------------------------------------------------------------------
#pragma mark - Basic Functions
- (void)printLogWith:(NSString *)logMessage
{
    if (!debug || !debugFMACheckoutProductCell) return;
    
    NSString *logString = [NSString stringWithFormat:@"%@ %@", self.class, logMessage];
    
    NSLog(@"%@", logString);
}

- (void)dealloc
{
    [self printLogWith:@"dealloc"];
}

- (void)setSelected:(BOOL)selected
{
}

// --------------------------------------------------------------------------------------------------------------------------
#pragma mark - Main Functions
- (void)configureCellWithData:(id)data
{
    [self printLogWith:@"configureCellWithData"];
    
    [self initTheme];
    
    PFObject *product = data[kFMCartProductKey];
    int      quantity = [data[kFMCartQuantityKey] intValue];
    
    _txtQuantity.text       = [NSString stringWithFormat:@"%d", quantity];
    _labelProductTitle.text = product[kFMProductTitleKey];
    _labelUnitPrice.text    = [NSString stringWithFormat:@"%.2f", [product[kFMProductPriceKey] floatValue]];
    _labelTotalPrice.text   = [NSString stringWithFormat:@"%.2f", [self totalPriceByProduct:product quantity:quantity]];
    
    _imageviewProduct.file  = [product[kFMProductImagesKey] objectAtIndex:0];
    [_imageviewProduct loadInBackground];
}

// --------------------------------------------------------------------------------------------------------------------------
#pragma mark - Utility Functions
- (void)initTheme
{
    [FMAUtil setupInputAccessoryViewWithSetCancelButtonsForControl:_txtQuantity withTarget:self
                                              selectorForSetButton:@selector(onBtnSetInInputAccessoryView:)
                                           selectorForCancelButton:@selector(onBtnCancelInInputAccessoryView:)];
    
    [FMAThemeManager setBorderToView:_imageviewProduct width:1.f Color:[UIColor whiteColor]];
    [FMAThemeManager setBorderToView:_txtQuantity      width:1.f Color:[UIColor lightGrayColor]];
    
    _txtQuantity.backgroundColor = [UIColor clearColor];
}

- (CGFloat)totalPriceByProduct:(PFObject *)product quantity:(int)quantity
{
    return quantity * [product[kFMProductPriceKey] floatValue];
}

- (void)updateQuantity
{
    [self printLogWith:@"updateQuantity"];
    
    NSDictionary    *data = [_delegate checkoutProductCellGetPrdouctData:self];
    PFObject     *product = data[kFMCartProductKey];
    int       newQuantity = [_txtQuantity.text intValue];
    
    _labelTotalPrice.text = [NSString stringWithFormat:@"%.2f", [self totalPriceByProduct:product quantity:newQuantity]];
    
    [_delegate checkoutProductCell:self didUpdateQuantity:newQuantity];
}

// --------------------------------------------------------------------------------------------------------------------------
#pragma mark - TextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_txtQuantity resignFirstResponder];

    [self updateQuantity];
    
    return YES;
}

- (void)onBtnSetInInputAccessoryView:(id)sender
{
    [self printLogWith:@"onBtnSetInInputAccessoryView"];
    
    [_txtQuantity resignFirstResponder];
    
    [self updateQuantity];
}

- (void)onBtnCancelInInputAccessoryView:(id)sender
{
    [self printLogWith:@"onBtnCancelInInputAccessoryView"];
    
    [_txtQuantity resignFirstResponder];
    
    NSDictionary    *data = [_delegate checkoutProductCellGetPrdouctData:self];
    _txtQuantity.text     = [NSString stringWithFormat:@"%d", [data[kFMCartQuantityKey] intValue]];
}

@end
