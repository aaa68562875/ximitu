//
//  AddressPickerView.m
//  ChinaSelect
//
//  Created by Wanrongtong on 16/6/23.
//  Copyright © 2016年 my. All rights reserved.
//

#import "AddressPickerView.h"

@interface AddressPickerView ()<UIPickerViewDelegate, UIPickerViewDataSource>
{
    NSArray *provinceArr;
    NSArray *cityArr;
    NSArray *districtArr;
    
    NSInteger provinceIndex;
    NSInteger cityIndex;
    NSInteger districtIndex;
    
    NSString *allName;
}

@property (weak, nonatomic) IBOutlet UIPickerView *myPickerView;

@end

@implementation AddressPickerView


- (instancetype)initAddressPickerView{
    
    self = [[NSBundle mainBundle] loadNibNamed:@"AddressPickerView" owner:nil options:nil].lastObject;
    if (self) {
        NSString *provincePath = [[NSBundle mainBundle] pathForResource:@"province" ofType:@"json"];
        NSData *provinceData = [NSData dataWithContentsOfFile:provincePath];
        NSDictionary *provinceDic = [NSJSONSerialization JSONObjectWithData:provinceData options:kNilOptions error:nil];
        provinceArr = [provinceDic objectForKey:@"province"];
        
        id cityItem = [provinceArr objectAtIndex:0];
        NSString *cityFilePath = [[NSBundle mainBundle] pathForResource:[cityItem objectForKey:@"spellName"] ofType:@"json"];
        NSData *cityData = [NSData dataWithContentsOfFile:cityFilePath];
        NSDictionary *cityDic = [NSJSONSerialization JSONObjectWithData:cityData options:kNilOptions error:nil];
        cityArr = [cityDic objectForKey:@"city"];
        
        id districtItem = [cityArr objectAtIndex:0];
        NSString *districtFilePath = [[NSBundle mainBundle] pathForResource:[districtItem objectForKey:@"spellName"] ofType:@"json"];
        NSData *districtData = [NSData dataWithContentsOfFile:districtFilePath];
        NSDictionary *districtDic = [NSJSONSerialization JSONObjectWithData:districtData options:kNilOptions error:nil];
        districtArr = [districtDic objectForKey:@"district"];
        
        allName = [NSString stringWithFormat:@"%@ %@ %@", [[provinceArr objectAtIndex:0] objectForKey:@"name"], [[cityArr objectAtIndex:0] objectForKey:@"name"], [[districtArr objectAtIndex:0] objectForKey:@"name"]];
    
        
        _myPickerView.delegate = self;
        _myPickerView.dataSource = self;
        
        
    }
    
    
    return self;
}



- (void)HandlerMessageBlock:(sendAddressBlock)block{
    
    self.block = block;
}

//取消
- (IBAction)cancellClick:(id)sender {
    if (self.block) {
        self.block(allName,@"1");
    }
}
//确定
- (IBAction)finishClick:(id)sender {
    if (self.block) {
        self.block(allName,@"2");
    }
}

#pragma mark - UIPickerViewDelegate, UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger row = 0;
    switch (component)
    {
        case 0:
            row = [provinceArr count];
            break;
        case 1:
            row = [cityArr count];
            break;
        case 2:
            row = [districtArr count];
            break;
        default:
            break;
    }
    return row;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title = @"";
    id item;
    switch (component)
    {
        case 0:
            item = [provinceArr objectAtIndex:row];
            provinceIndex = row;
            break;
        case 1:
            item = [cityArr objectAtIndex:row];
            cityIndex = row;
            break;
        case 2:
            item = [districtArr objectAtIndex:row];
            districtIndex = row;
            break;
        default:
            break;
    }
    if (item)
    {
        title = [item objectForKey:@"name"];
    }
    return title;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (0 == component)
    {
        id cityItem = [provinceArr objectAtIndex:row];
        NSString *cityFilePath = [[NSBundle mainBundle] pathForResource:[cityItem objectForKey:@"spellName"] ofType:@"json"];
        if (cityFilePath)
        {
            NSData *cityData = [NSData dataWithContentsOfFile:cityFilePath];
            NSDictionary *cityDic = [NSJSONSerialization JSONObjectWithData:cityData options:kNilOptions error:nil];
            cityArr = [cityDic objectForKey:@"city"];
            
            id districtItem = [cityArr objectAtIndex:0];
            NSString *districtFilePath = [[NSBundle mainBundle] pathForResource:[districtItem objectForKey:@"spellName"] ofType:@"json"];
            if (districtFilePath)
            {
                NSData *districtData = [NSData dataWithContentsOfFile:districtFilePath];
                NSDictionary *districtDic = [NSJSONSerialization JSONObjectWithData:districtData options:kNilOptions error:nil];
                districtArr = [districtDic objectForKey:@"district"];
            } else {
                districtArr = [[NSArray alloc] init];
            }
        } else {
            cityArr = [[NSArray alloc] init];
            districtArr = [[NSArray alloc] init];
        }
        
        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:1 animated:NO];
        [pickerView selectRow:0 inComponent:2 animated:NO];
        
        allName = [NSString stringWithFormat:@"%@ %@ %@", [[provinceArr objectAtIndex:row] objectForKey:@"name"], [[cityArr objectAtIndex:0] objectForKey:@"name"], [[districtArr objectAtIndex:0] objectForKey:@"name"]];
    }
    
    if (1 == component)
    {
        id districtItem = [cityArr objectAtIndex:row];
        NSString *districtFilePath = [[NSBundle mainBundle] pathForResource:[districtItem objectForKey:@"spellName"] ofType:@"json"];
        if (districtFilePath)
        {
            NSData *districtData = [NSData dataWithContentsOfFile:districtFilePath];
            NSDictionary *districtDic = [NSJSONSerialization JSONObjectWithData:districtData options:kNilOptions error:nil];
            districtArr = [districtDic objectForKey:@"district"];
        } else {
            districtArr = [[NSArray alloc] init];
        }
        
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:NO];
        
        allName = [NSString stringWithFormat:@"%@ %@ %@", [[provinceArr objectAtIndex:provinceIndex] objectForKey:@"name"], [[cityArr objectAtIndex:row] objectForKey:@"name"], [[districtArr objectAtIndex:0] objectForKey:@"name"]];
    }
    
    if (2 == component) {
        allName = [NSString stringWithFormat:@"%@ %@ %@", [[provinceArr objectAtIndex:provinceIndex] objectForKey:@"name"], [[cityArr objectAtIndex:cityIndex] objectForKey:@"name"], [[districtArr objectAtIndex:row] objectForKey:@"name"]];
    }
//    if (self.block) {
//        self.block(allName,@"3");
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
