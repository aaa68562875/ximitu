//
//  AddressPickerView.m
//  ChinaSelect
//
//  Created by Wanrongtong on 16/6/23.
//  Copyright © 2016年 my. All rights reserved.
//

#import "AddressPickerSView.h"

@interface AddressPickerSView ()<UIPickerViewDelegate, UIPickerViewDataSource>
{
    
    
    NSArray *_data;
    
    NSInteger provinceIndex;
    NSInteger cityIndex;
    NSInteger districtIndex;
    
    NSString *allName;
    NSString *provinceId;
    NSString *cityId;
    NSString *districtId;
    
    NSArray *cityArray;
    NSMutableArray *zoneArray;
}

@property (weak, nonatomic) IBOutlet UIPickerView *myPickerView;

@end

@implementation AddressPickerSView


- (instancetype)initAddressPickerViewWithData:(NSArray *)data{
    
    self = [[NSBundle mainBundle] loadNibNamed:@"AddressPickerSView" owner:nil options:nil].lastObject;
    if (self) {
        
        _data = data;
        
        provinceIndex = 0;
        cityIndex = 0;
        districtIndex = 0;
        
        provinceId = _S(@"%@",_data[0][@"id"]);
        cityId = _S(@"%@",_data[0][@"list"][0][@"id"]);
        districtId = _S(@"%@",_data[0][@"list"][0][@"list"][0][@"id"]);
        
        allName = [NSString stringWithFormat:@"%@ %@ %@", _data[provinceIndex][@"name"], _data[provinceIndex][@"list"][cityIndex][@"name"], _data[provinceIndex][@"list"][cityIndex][@"list"][districtIndex][@"name"]];
        
        
        cityArray = [_data objectAtIndex:0][@"list"];
        
        
        
        zoneArray = [cityArray objectAtIndex:0][@"list"];
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
        self.block(allName,@"1", @"", @"",@"");
    }
}
//确定
- (IBAction)finishClick:(id)sender {
    if (self.block) {
        self.block(allName,@"2", provinceId, cityId,districtId);
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
            row = [_data count];
            break;
        case 1:
            
            row = [cityArray count];
            break;
        case 2:
            if ([cityArray count]!=0) {
                row = [zoneArray count];
            }
            break;
        default:
            break;
    }
    return row;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        
        cityArray = [[_data objectAtIndex:row] objectForKey:@"list"];
        provinceIndex = row;
        if ([cityArray count]!=0) {
            DLog(@"%@",cityArray);
            zoneArray = [[cityArray objectAtIndex:0] objectForKey:@"list"];
            [pickerView reloadComponent:1];
            [pickerView selectRow:0 inComponent:1 animated:NO];
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:2 animated:NO];
            
            provinceId = _S(@"%@",_data[row][@"id"]);
            cityId = _S(@"%@",cityArray[0][@"id"]);
            districtId = _S(@"%@",zoneArray[0][@"id"]);
            allName = [NSString stringWithFormat:@"%@ %@ %@", [[_data objectAtIndex:row] objectForKey:@"name"], [[cityArray objectAtIndex:0] objectForKey:@"name"], [[zoneArray objectAtIndex:0] objectForKey:@"name"]];
            
        }else{
            
            [pickerView reloadComponent:1];
            [pickerView reloadComponent:2];
            
            allName = [NSString stringWithFormat:@"%@", [[_data objectAtIndex:row] objectForKey:@"name"]];
            provinceId = _S(@"%@",_data[row][@"id"]);
            cityId = @"";
            districtId = @"";
        }
        
        //        NSLog(@"0 ---  %@ ",_data[row][@"name"]);
    }else if (component==1){
        if (cityArray.count == 0) {
            return;
        }
        zoneArray = [[cityArray objectAtIndex:row] objectForKey:@"list"];
        cityIndex = row;
        if (zoneArray.count != 0) {
            
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:2 animated:NO];
            
            allName = [NSString stringWithFormat:@"%@ %@ %@", [[_data objectAtIndex:provinceIndex] objectForKey:@"name"], [[cityArray objectAtIndex:row] objectForKey:@"name"], [[zoneArray objectAtIndex:0] objectForKey:@"name"]];
            
            provinceId = _S(@"%@",_data[provinceIndex][@"id"]);
            cityId = _S(@"%@",cityArray[row][@"id"]);
            districtId = _S(@"%@",zoneArray[0][@"id"]);
        }
        
        //        NSLog(@"1 ---  %@ ",allName);
    }else if (component == 2) {
        if ([cityArray count]==0) {
            return;
        }
        
        if (zoneArray.count != 0) {
            allName = [NSString stringWithFormat:@"%@ %@ %@", [[_data objectAtIndex:provinceIndex] objectForKey:@"name"], [[cityArray objectAtIndex:cityIndex] objectForKey:@"name"], [[zoneArray objectAtIndex:row] objectForKey:@"name"]];
            
            provinceId = _S(@"%@",_data[provinceIndex][@"id"]);
            cityId = _S(@"%@",cityArray[cityIndex][@"id"]);
            districtId = _S(@"%@",zoneArray[row][@"id"]);
        }
        else{
            return;
        }
        //        NSLog(@"2 ---  %@ ",allName);
    }
    
    //    DLog(@"%@",allName);
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSString *title = @"";
    
    if (component==0) {
        
        title =[[_data objectAtIndex:row] objectForKey:@"name"];
        provinceIndex = row;
        cityArray = _data[row][@"list"];
        if (cityArray.count == 0) {
//            [zoneArray removeAllObjects];
        }
    }else if (component==1){
        if (cityArray.count != 0) {
            title =[[cityArray objectAtIndex:row] objectForKey:@"name"];
            cityIndex = row;
        }else{
            cityIndex = 0;
//            [zoneArray removeAllObjects];
        }
        
        
    }else{
        if (cityArray.count != 0) {
            title = [[zoneArray objectAtIndex:row] objectForKey:@"name"];
            districtIndex = row;
        }else{
            districtIndex = 0;
        }
    }
    
    
    
    return title;
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
