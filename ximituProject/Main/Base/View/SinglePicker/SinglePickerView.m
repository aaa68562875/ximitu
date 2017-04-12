//
//  SinglePickerView.m
//  XingsiluCloud
//
//  Created by Wanrongtong on 16/7/18.
//  Copyright © 2016年 Wanrongtong. All rights reserved.
//

#import "SinglePickerView.h"

@interface SinglePickerView ()<UIPickerViewDelegate, UIPickerViewDataSource>
{
    
    NSArray *dataSource;
    NSInteger _row;
    
}
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@end

@implementation SinglePickerView

- (instancetype)initAddressPickerView{
    
    self = [[NSBundle mainBundle] loadNibNamed:@"SinglePickerView" owner:nil options:nil].lastObject;
    if (self) {
        
    }
    
    
    return self;
}

- (void)getData:(NSArray *)data{
    dataSource = data;
    _row = 0;
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    [_pickerView reloadAllComponents];
}

- (void)handlerRowWithBlock:(sendSelectRow)block{
    
    self.block = block;
    
}
#pragma mark -
- (IBAction)cancelClick:(id)sender {
    
    if (_block) {
        self.block(-1);
    }
}


- (IBAction)ensureClick:(id)sender {
    if (_block) {
        self.block(_row);
    }
}

#pragma mark - UIPickerViewDelegate, UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    return dataSource.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    return dataSource[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    _row = row;
    
    
//    if (_block) {
//        self.block(_row);
//    }

}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        // Setup label properties - frame, font, colors etc
        //adjustsFontSizeToFitWidth property to YES
        pickerLabel.minimumScaleFactor = 8.;
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:15]];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
    
}


@end
