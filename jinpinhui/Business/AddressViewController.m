//
//  AddressViewController.m
//  jinpinhui
//
//  Created by 于海超 on 15/8/1.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "AddressViewController.h"
#import "LoginUser.h"

@interface AddressViewController ()<UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic ,strong)UIPickerView *pickerView;
@property (strong, nonatomic) UIView *headerView;
@property (nonatomic ,strong)NSMutableArray *provincesAry;
//@property (nonatomic ,strong)NSMutableArray *cityAry;
//@property (nonatomic ,strong)NSMutableArray *areaAry;
@property (nonatomic ,strong)NSString *provincesStr;
@property (nonatomic ,strong)NSString *cityStr;
@property (nonatomic ,strong)NSString *areaStr;
@property (nonatomic ,strong)NSString *cityTextStr;
@property (nonatomic ,assign)NSInteger provincesRow;
@property (nonatomic ,assign)NSInteger cityRow;
@property (nonatomic ,assign)NSInteger areaRow;
@end

@implementation AddressViewController
- (UIPickerView *)pickerView
{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 216, 0, 0)];
        _pickerView.delegate = self;
        _pickerView.backgroundColor = [UIColor whiteColor];
        _pickerView.showsSelectionIndicator = YES;
        [_pickerView selectRow:0 inComponent:0 animated:YES];
    }
    return _pickerView;
}
- (UIView *)headerView
{
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        _headerView.backgroundColor = UIColorFromRGBA(242, 244, 248, 1);
        
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        rightButton.frame = CGRectMake(SCREEN_WIDTH - 70, 0, 60, 30);
        rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [rightButton setTitle:@"确定" forState:UIControlStateNormal];
        rightButton.tag = 101;
        [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
        [_headerView addSubview:rightButton];
        
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        leftButton.frame = CGRectMake(10, 0, 60, 30);
        leftButton.titleLabel.font = [UIFont systemFontOfSize:15];
        leftButton.tag = 100;
        [leftButton setTitle:@"取消" forState:UIControlStateNormal];
        [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [leftButton addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        [_headerView addSubview:leftButton];
    }
    return _headerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"收货地址";
    [self setLeftTextView];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cityTap)];
//    [_cityView addGestureRecognizer:tap];
    //注册键盘监听
        [[NSNotificationCenter defaultCenter] addObserver:self
    
                                                 selector:@selector(keyboardWillBeHidden:)
    
                                                     name:UIKeyboardWillHideNotification object:nil];
    //获取 城市
    NSData *reply = [[NSData alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"city" ofType:@"json"]];
    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:reply options:NSJSONReadingMutableLeaves error:nil];
    self.provincesAry = [NSMutableArray arrayWithArray:[responseJSON objectForKey:@"children"]];
    self.provincesStr = @"北京市";
    self.cityStr = @"北京市";
    self.areaStr = @"东城区";
//    self.provincesAry = [[NSMutableArray alloc]initWithCapacity:0];
//    self.cityAry = [[NSMutableArray alloc]init];
//    self.areaAry = [[NSMutableArray alloc]init];
   
//    for (NSInteger i = 0; i < allAry.count; i++) {
//        for (NSInteger j = 0; j < [[allAry[i] objectForKey:@"children"] count]; j++) {
//              [self.provincesAry addObject:[[[allAry objectAtIndex:i] objectForKey:@"children"] objectAtIndex:j]];
//        }
//      
//    }
//    NSLog(@"%@",self.provincesAry);
//    for (NSInteger i = 0; i < self.provincesAry.count; i++) {
//        for (NSInteger j = 0; j < [[[self.provincesAry objectAtIndex:i] objectForKey:@"children"] count]; j++) {
//              [self.cityAry addObject:[[[self.provincesAry objectAtIndex:i] objectForKey:@"children"] objectAtIndex:j]];
//        }
//      
//    }
//    NSLog(@"%@",self.cityAry);
//    for (NSInteger i = 0; i < self.cityAry.count; i++) {
//        for (NSInteger j = 0; j < [[[self.cityAry objectAtIndex:i] objectForKey:@"children"] count]; j++) {
//            [self.areaAry addObject:[[[self.cityAry objectAtIndex:i] objectForKey:@"children"] objectAtIndex:j]];
//        }
////         [self.areaAry addObject:[[self.cityAry objectAtIndex:i] objectForKey:@"children"]];
//    }
//     NSLog(@"%@",self.areaAry);
}
//设置text左侧标题
-(void) setLeftTextView{
    //手机号码
    UIView *phoneNumView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, CGRectGetHeight(_phoneNumText.frame))];
    phoneNumView.backgroundColor = [UIColor clearColor];
    UILabel *phoneNumLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 60, CGRectGetHeight(_phoneNumText.frame))];
    phoneNumLab.backgroundColor = [UIColor clearColor];
    phoneNumLab.font = [UIFont systemFontOfSize:14.0];
    phoneNumLab.text = @"手机号码";
    [phoneNumView addSubview:phoneNumLab];
    _phoneNumText.backgroundColor = UIColorFromRGB(240, 241, 242);
    _phoneNumText .leftView = phoneNumView;
    _phoneNumText.leftViewMode = UITextFieldViewModeAlways;
    _phoneNumText.placeholder = @"请输入手机号";
    _phoneNumText.text = [[LoginUser sharedLoginUser] tel];
    _phoneNumText.delegate = self;
    _phoneNumText.layer.borderWidth = 1;
    _phoneNumText.layer.borderColor = [UIColorFromRGB(202, 202, 208) CGColor];
    _phoneNumText.keyboardType = UIKeyboardTypeNumberPad;
    _phoneNumText.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    //收货人
    UIView *consigneeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, CGRectGetHeight(_consigneeText.frame))];
    consigneeView.backgroundColor = [UIColor clearColor];
    UILabel *consigneeLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 60, CGRectGetHeight(_consigneeText.frame))];
    consigneeLab.backgroundColor = [UIColor clearColor];
    consigneeLab.font = [UIFont systemFontOfSize:14.0];
    consigneeLab.text = @"收货人";
    [consigneeView addSubview:consigneeLab];
    _consigneeText.backgroundColor = UIColorFromRGB(240, 241, 242);
    _consigneeText .leftView = consigneeView;
    _consigneeText.leftViewMode = UITextFieldViewModeAlways;
    _consigneeText.placeholder = @"请输入收货人姓名";
    _consigneeText.text = [[LoginUser sharedLoginUser] consignee];
    _consigneeText.delegate = self;
    _consigneeText.layer.borderWidth = 1;
    _consigneeText.layer.borderColor = [UIColorFromRGB(202, 202, 208) CGColor];
//    _consigneeText.keyboardType = UIReturnKeyDone;
    _consigneeText.clearButtonMode = UITextFieldViewModeWhileEditing;
    //地区
    UIView *cityView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, CGRectGetHeight(_cityText.frame))];
    cityView.backgroundColor = [UIColor clearColor];
    UILabel *cityLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 60, CGRectGetHeight(_cityText.frame))];
    cityLab.backgroundColor = [UIColor clearColor];
    cityLab.font = [UIFont systemFontOfSize:14.0];
    cityLab.text = @"所在地区";
    [cityView addSubview:cityLab];
    _cityText.backgroundColor = UIColorFromRGB(240, 241, 242);
    _cityText .leftView = cityView;
    _cityText.leftViewMode = UITextFieldViewModeAlways;
    _cityText.placeholder = @"请选择所在地区";
    _cityText.text = [[LoginUser sharedLoginUser] city];
    _cityText.layer.borderWidth = 1;
    _cityText.userInteractionEnabled = YES;
    _cityText.inputAccessoryView = self.headerView;
    _cityText.inputView = self.pickerView;
    _cityText.layer.borderColor = [UIColorFromRGB(202, 202, 208) CGColor];
    _cityText.keyboardType = UIReturnKeyDone;
//    _cityText.clearButtonMode = UITextFieldViewModeWhileEditing;
    //详细地址
    UIView *addressView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, CGRectGetHeight(_addressText.frame))];
    addressView.backgroundColor = [UIColor clearColor];
    UILabel *addressLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 60, CGRectGetHeight(_addressText.frame))];
    addressLab.backgroundColor = [UIColor clearColor];
    addressLab.font = [UIFont systemFontOfSize:14.0];
    addressLab.text = @"详细地址";
    [addressView addSubview:addressLab];
    _addressText.backgroundColor = UIColorFromRGB(240, 241, 242);
    _addressText .leftView = addressView;
    _addressText.leftViewMode = UITextFieldViewModeAlways;
    _addressText.placeholder = @"请输入详细地址";
    _addressText.text = [[LoginUser sharedLoginUser] address];
    _addressText.delegate = self;
    _addressText.layer.borderWidth = 1;
    _addressText.layer.borderColor = [UIColorFromRGB(202, 202, 208) CGColor];
//    _addressText.keyboardType = UIReturnKeyDone;
    _addressText.clearButtonMode = UITextFieldViewModeWhileEditing;
}
- (void)sureAction:(UIButton *)btn
{
    if ([self.provincesStr isEqualToString:self.cityStr]) {
        self.cityTextStr = [NSString stringWithFormat:@"%@ %@",self.provincesStr,self.areaStr];
    }else {
        self.cityTextStr =[NSString stringWithFormat:@"%@ %@ %@",self.provincesStr,self.cityStr,self.areaStr];
    }
    _cityText.text = self.cityTextStr;
    [self.view endEditing:YES];
}

- (void)cancelAction:(UIButton *)btn
{
    [self.view endEditing:YES];
}

#pragma mark UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}
- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    if (component == 0) {
        return self.provincesAry.count;
    }else if(component == 1){
//        NSInteger rowProvince = [pickerView selectedRowInComponent:0];
        return  [[[self.provincesAry objectAtIndex:self.provincesRow] objectForKey:@"children"] count];
        
    }else{
//        NSInteger rowProvince = [pickerView selectedRowInComponent:1];
        return   [[[[[self.provincesAry objectAtIndex:self.provincesRow] objectForKey:@"children"] objectAtIndex:self.cityRow] objectForKey:@"children"] count];;
    }
    
}

#pragma mark -
#pragma mark UIPickerViewDelegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    self.provincesRow = [pickerView selectedRowInComponent:0];
    self.cityRow = [pickerView selectedRowInComponent:1];
    self.areaRow = [pickerView selectedRowInComponent:2];
    if (component == 0) {
        self.cityRow = 0;
        self.areaRow = 0;
        [pickerView selectRow:self.cityRow inComponent:1 animated:YES];
        [pickerView selectRow:self.areaRow inComponent:2 animated:YES];
    }else if (component == 1){
         self.areaRow = 0;
         [pickerView selectRow:self.areaRow inComponent:2 animated:YES];
    }
    [pickerView reloadComponent:1];
    [pickerView reloadComponent:2];
    self.provincesStr = [[self.provincesAry objectAtIndex:self.provincesRow] objectForKey:@"name"];
    self.cityStr = [[[[self.provincesAry objectAtIndex:self.provincesRow] objectForKey:@"children"] objectAtIndex:self.cityRow] objectForKey:@"name"];
    self.areaStr = [[[[[[self.provincesAry objectAtIndex:self.provincesRow] objectForKey:@"children"] objectAtIndex:self.cityRow] objectForKey:@"children"] objectAtIndex:self.areaRow] objectForKey:@"name"];
}

//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//
//        if (component == 0) {
//            return [[self.provincesAry objectAtIndex:row] objectForKey:@"name"];
//        }else if(component == 1){
//            if ([[[self.provincesAry objectAtIndex:self.provincesRow] objectForKey:@"children"] count] - 1 < row) {
//                NSInteger currRow = [[[self.provincesAry objectAtIndex:self.provincesRow] objectForKey:@"children"] count] - 1;
//                 return [[[[self.provincesAry objectAtIndex:self.provincesRow] objectForKey:@"children"] objectAtIndex:currRow] objectForKey:@"name"];
//            }else{
//                 return [[[[self.provincesAry objectAtIndex:self.provincesRow] objectForKey:@"children"] objectAtIndex:row] objectForKey:@"name"];
//            }
//           
//        }else{
//            if ([[[[[self.provincesAry objectAtIndex:self.provincesRow] objectForKey:@"children"] objectAtIndex:self.cityRow] objectForKey:@"children"] count] - 1 < row) {
//                NSInteger currRow = [[[[[self.provincesAry objectAtIndex:self.provincesRow] objectForKey:@"children"] objectAtIndex:self.cityRow] objectForKey:@"children"] count] - 1;
//                 return [[[[[[self.provincesAry objectAtIndex:self.provincesRow] objectForKey:@"children"] objectAtIndex:self.cityRow] objectForKey:@"children"] objectAtIndex:currRow] objectForKey:@"name"];
//            }else
//            {
//                return [[[[[[self.provincesAry objectAtIndex:self.provincesRow] objectForKey:@"children"] objectAtIndex:self.cityRow] objectForKey:@"children"] objectAtIndex:row] objectForKey:@"name"];
//            }
//        }
//    
//}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *myView = nil;
    myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 100, 30)];
    
    myView.textAlignment = NSTextAlignmentCenter;
    if (component == 0) {
        myView.text = [[self.provincesAry objectAtIndex:row] objectForKey:@"name"];
    }else if(component == 1){
        if ([[[self.provincesAry objectAtIndex:self.provincesRow] objectForKey:@"children"] count] - 1 < row) {
            NSInteger currRow = [[[self.provincesAry objectAtIndex:self.provincesRow] objectForKey:@"children"] count] - 1;
            myView.text = [[[[self.provincesAry objectAtIndex:self.provincesRow] objectForKey:@"children"] objectAtIndex:currRow] objectForKey:@"name"];
        }else{
            myView.text = [[[[self.provincesAry objectAtIndex:self.provincesRow] objectForKey:@"children"] objectAtIndex:row] objectForKey:@"name"];
        }
        
    }else{
        if ([[[[[self.provincesAry objectAtIndex:self.provincesRow] objectForKey:@"children"] objectAtIndex:self.cityRow] objectForKey:@"children"] count] - 1 < row) {
            NSInteger currRow = [[[[[self.provincesAry objectAtIndex:self.provincesRow] objectForKey:@"children"] objectAtIndex:self.cityRow] objectForKey:@"children"] count] - 1;
            myView.text = [[[[[[self.provincesAry objectAtIndex:self.provincesRow] objectForKey:@"children"] objectAtIndex:self.cityRow] objectForKey:@"children"] objectAtIndex:currRow] objectForKey:@"name"];
        }else
        {
            myView.text = [[[[[[self.provincesAry objectAtIndex:self.provincesRow] objectForKey:@"children"] objectAtIndex:self.cityRow] objectForKey:@"children"] objectAtIndex:row] objectForKey:@"name"];
        }
    }

//    myView.text = [pickerNameArray objectAtIndex:row];
    
    myView.font = [UIFont systemFontOfSize:14];         //用label来设置字体大小
    
    myView.backgroundColor = [UIColor clearColor];
    return myView;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:_addressText]) {
        if (SCREEN_HEIGHT == 480) {
            [UIView animateWithDuration:0.33 animations:^{
                self.view.frame = CGRectMake(0, -60, SCREEN_WIDTH, SCREEN_HEIGHT);
            }];
        }
        
    }
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    if (SCREEN_HEIGHT == 480) {
        [UIView animateWithDuration:0.33 animations:^{
            self.view.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT);
        }];
    }
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)SvaeClick:(id)sender {
    if (_phoneNumText.text.length == 0) {
        [self showCustomProgressHUDWithText:@"请输入手机号！"];
    }else if (_consigneeText.text.length == 0){
         [self showCustomProgressHUDWithText:@"请填写收货人！"];
    }else if (_cityText.text.length == 0 || [_cityText.text isEqualToString:@""]){
         [self showCustomProgressHUDWithText:@"请选择城市！"];
    }else if (_addressText.text.length == 0){
          [self showCustomProgressHUDWithText:@"请填写详细地址！"];
    }else{
    
        [self RequestSetAddress];
    }
}
-(void)RequestSetAddress{
    
//   NSString *dataGBK = [_cityText.text stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//      NSString *dataUTF8 = [_cityText.text  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSLog(@"%@",dataUTF8);
//     NSString *dataGBK = [dataUTF8 stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *para = [NSString stringWithFormat:@"%@|%@|%@|%@",_consigneeText.text,_cityText.text,_addressText.text,_phoneNumText.text];
    NSLog(@"%@",para);
    [self.Parameters setValue:@"SETD" forKey:@"cmd"];
    [self.Parameters setValue:para forKey:@"para"];
    [self.Parameters setValue:[self getCurrentTime] forKey:@"date"];
    [self.Parameters setValue:[self encryption] forKey:@"md5"];
    
    CZRequestModel *request = [[CZRequestMaker sharedClient] getBin_cmdWithParameters:self.Parameters];
    [self jsonWithRequest:request delegate:self code:112 object:nil];
}
-(void)czRequestForResultDic:(NSDictionary *)resultDic code:(NSInteger)code object:(id)obj{
    if ([[resultDic objectForKey:@"resp_code"] isEqualToString:@"200"]) {
        [[LoginUser sharedLoginUser] setConsignee:_consigneeText.text];
        [[LoginUser sharedLoginUser] setTel:_phoneNumText.text];
        [[LoginUser sharedLoginUser] setCity:_cityText.text];
        [[LoginUser sharedLoginUser] setAddress:_addressText.text];
        [self showAlertViewWithMessage:@"保存成功！"];
    }
    NSLog(@"%@",resultDic);
    NSLog(@"%@",[resultDic objectForKey:@"error"]);
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
