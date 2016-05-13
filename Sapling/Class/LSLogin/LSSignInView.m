//
//  LSSignInView.m
//  Sapling
//
//  Created by sport on 16/4/21.
//  Copyright © 2016年 光前. All rights reserved.
//

#import "LSSignInView.h"

@interface LSSignInView()

@property (nonatomic, strong) UITextField * username;
@property (nonatomic, strong) UITextField * password;
@property (nonatomic, strong) UITextField * nickName;
@property (nonatomic, strong) UIButton * birthdayBtn;
@property (nonatomic, strong) UITextField * emailTextFiled;
@property (nonatomic, strong) UIDatePicker * datePicker;
@property (nonatomic, strong) UIButton  * sexButton;
@property (nonatomic, strong) UIButton  * registerButton;


@end

@implementation LSSignInView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self setup];
    }
    
    return self;
}
- (void)setup{
    //
    self.emailTextFiled.keyboardType = UIKeyboardTypeASCIICapable;
    self.username.keyboardType = UIKeyboardTypeASCIICapable;
    self.password.keyboardType = UIKeyboardTypeASCIICapable;
    self.password.secureTextEntry = YES;
    [_username setAutocorrectionType:UITextAutocorrectionTypeNo];
    [_username setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [_password setAutocorrectionType:UITextAutocorrectionTypeNo];
    [_password setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [_emailTextFiled setAutocorrectionType:UITextAutocorrectionTypeNo];
    [_emailTextFiled setAutocapitalizationType:UITextAutocapitalizationTypeNone];
   
    [self setupBirthDayDatePicker];
    //
    self.backgroundColor = [UIColor whiteColor];
    
    //
    _emailTextFiled = [self createCellViewwith:@"邮箱" andFrame:CGRectMake(0, 20, 0, 0)];
    _username = [self createCellViewwith:@"账号" andFrame:CGRectMake(0, CGRectGetMaxY(_emailTextFiled.frame), 0, 0)];
    _password = [self createCellViewwith:@"密码" andFrame:CGRectMake(0, CGRectGetMaxY(_username.frame), 0, 0)];
    _nickName = [self createCellViewwith:@"昵称" andFrame:CGRectMake(0, CGRectGetMaxY(_password.frame), 0, 0)];
    
    //生日 性别
    
    _birthdayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _birthdayBtn.frame = CGRectMake(10,CGRectGetMaxY(_nickName.frame) + 10 ,160 - 20 , 30);
    [_birthdayBtn setTitle:@"生日" forState:UIControlStateNormal];
    _birthdayBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [_birthdayBtn setBackgroundColor:BASE_GREEN_COLOR];
    _birthdayBtn.clipsToBounds = YES;
    _birthdayBtn.layer.cornerRadius = 3;
    [self addSubview:_birthdayBtn];
    [_birthdayBtn addTarget:self action:@selector(birthdayBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    _sexButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _sexButton.frame = CGRectMake(CGRectGetMaxX(_birthdayBtn.frame)+10,CGRectGetMaxY(_nickName.frame) + 10 ,160 - 20 , 30);
    [_sexButton setTitle:@"男" forState:UIControlStateNormal];
    _sexButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [_sexButton setBackgroundColor:BASE_GREEN_COLOR];
    _sexButton.clipsToBounds = YES;
    _sexButton.layer.cornerRadius = 3;
    [self addSubview:_sexButton];
    [_sexButton addTarget:self action:@selector(changeSexButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _registerButton.frame = CGRectMake(10,CGRectGetMaxY(_sexButton.frame) + 30 ,320 - 20 , 30);
    [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
    _registerButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [_registerButton setBackgroundColor:BASE_GREEN_COLOR];
    _registerButton.clipsToBounds = YES;
    _registerButton.layer.cornerRadius = 3;
    [self addSubview:_registerButton];
    [_registerButton addTarget:self action:@selector(registerButtonClicked) forControlEvents:UIControlEventTouchUpInside];





    
}
/** 生日*/
- (void)birthdayBtnClicked{
    [self endEditing:YES];
    [UIView animateWithDuration:0.3 animations:^{
        self.datePicker.frame = CGRectMake(0, SCREEN_HEIGHT - 216, SCREEN_WIDTH, 216);
    }];
}
/** 日期选择*/
- (void)chooseDate:(UIDatePicker *)sender {
    NSDate *selectedDate = sender.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    formatter.dateFormat = @"yyyy-MM-dd";
    [_birthdayBtn setTitle: [formatter stringFromDate:selectedDate] forState:UIControlStateNormal];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [UIView animateWithDuration:0.3 animations:^{
        self.datePicker.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 216);
    }];
    [self endEditing:YES];
}
/** 改变性别*/
- (void)changeSexButtonClicked{
    if ([_sexButton.titleLabel.text isEqualToString:@"男"]) {
        [_sexButton setTitle:@"女" forState:UIControlStateNormal];
    }
    else{
        [_sexButton setTitle:@"男" forState:UIControlStateNormal];
    }
}
/** 注册按钮*/
- (void)registerButtonClicked{
    if ([self.emailTextFiled.text isEqualToString:self.username.text]) {
        [MBProgressHUD showError:@"邮箱和用户名不能一致" toView:nil];
        return;
    }
    if (self.emailTextFiled.text.length < 1 || ![ZXCommens validateEmail:self.emailTextFiled.text]) {
        [MBProgressHUD showError:@"邮箱格式不正确" toView:nil];
        return;
    }
    if (self.username.text.length < 1) {
        [MBProgressHUD showError:@"请填写用户名" toView:nil];
        return;
    }
    if (self.password.text.length < 1) {
        [MBProgressHUD showError:@"请填写密码" toView:nil];
        return;
    }
    if (self.nickName.text.length < 1) {
        [MBProgressHUD showError:@"请填写昵称" toView:nil];
        return;
    }
    if (self.birthdayBtn.titleLabel.text.length < 1) {
        [MBProgressHUD showError:@"请选择生日" toView:nil];
        return;
    }
    
    NSDictionary *dic = [[NSDictionary alloc] init];
    NSString * deviceToken = [ZXCommens fetchDeviceToken];
    dic = [ZXCommens factionaryParams:@{
                                        @"username":_username.text,
                                        @"password":_password.text,
                                        @"email":_emailTextFiled.text,
                                        @"nickname":_nickName.text,
                                        @"gender":_sexButton.titleLabel.text,
                                        @"birthday":self.birthdayBtn.titleLabel.text
                                        }
                  WithServerAndMethod:@{
                                        @"service":@"user",
                                        @"method":@"register",
                                        @"device_token":deviceToken?deviceToken : @""}];
    ZXRequest * request = [[ZXRequest alloc] initWithRUrl:Host_Server andRMethod:YTKRequestMethodPost andRArgument:dic];
    [MBProgressHUD showHUDAddedTo:self animated:YES];
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        [MBProgressHUD hideAllHUDsForView:self animated:YES];
        if ([request.responseJSONObject[@"success"] integerValue] == 1) {
            ZXUser * user = [[ZXUser alloc] init];
            user = [ZXUser mj_objectWithKeyValues:request.responseJSONObject[@"entity"][@"user"]];
            user.domain = request.responseJSONObject[@"entity"][@"emsg_server"][@"domain"];
            user.port = request.responseJSONObject[@"entity"][@"emsg_server"][@"port"];
            user.host = request.responseJSONObject[@"entity"][@"emsg_server"][@"host"];
            user.token = request.responseJSONObject[@"entity"][@"token"];
            [ZXCommens putUserInfo:user];
            [self autoLoginMsgCilent];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:LOGIN_STATE object:@YES];
        }
        else{
            [MBProgressHUD showError:request.responseJSONObject[@"entity"][@"reason"] toView:nil];
        }
        
    } failure:^(YTKBaseRequest *request) {
        [MBProgressHUD hideAllHUDsForView:self animated:YES];
        [MBProgressHUD showError:@"网络好像出了问题" toView:nil];
    }];


}
- (void)autoLoginMsgCilent {
    ZXUser *userInfoModel = [ZXCommens fetchUser];
    if (userInfoModel.token) {
        //异步登陆账号
        EMDEngineManger *engine = [EMDEngineManger sharedInstance];
        if (![engine isAuthed]) {
            NSString *username =
            [NSString stringWithFormat:@"%@@%@/%@", userInfoModel.uid,
             userInfoModel.domain,
             userInfoModel.uid];
            
            BOOL successed =
            [engine auth:username
            withPassword:userInfoModel.token
                withHost:userInfoModel.host
                withPort:[userInfoModel.port integerValue]];
            
            if (successed) //连接成功
            {
                
            } else { //连接失败
                [engine autoReconnect];
            }
        }
    }
}


/** 建立UI*/
- (UITextField *)createCellViewwith:(NSString *)nameString andFrame:(CGRect)frame{
    //账号
    UILabel * title1 = [[UILabel alloc]init];
    title1.text = nameString;
    title1.font = [UIFont systemFontOfSize:15];
    title1.frame = CGRectMake(10, CGRectGetMaxY(frame)+ 10, 40, 20);
    [self addSubview:title1];
    
    UITextField * Text = [[UITextField alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(frame) + 10, 320 - 50, 20)];
    [Text setAutocorrectionType:UITextAutocorrectionTypeNo];
    [Text setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    Text.keyboardType = UIKeyboardTypeASCIICapable;
    UIView * line1 = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(title1.frame),
                                                             CGRectGetMaxY(Text.frame),
                                                             Text.frame.size.width - 10, 1)];
    line1.backgroundColor = BASE_CELL_LINE_COLOR;
    [self addSubview:line1];
    [self addSubview:Text];
    return Text;
}
/** 使用日期Picker*/
- (void)setupBirthDayDatePicker{
    
    UIDatePicker * _datePicker1 = [[UIDatePicker alloc] init];
    [_datePicker1 setTimeZone:[NSTimeZone defaultTimeZone]];
    _datePicker1.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 216);
    _datePicker1.datePickerMode = UIDatePickerModeDate;
    _datePicker1.maximumDate = [[NSDate alloc] init];
    _datePicker1.backgroundColor = [UIColor whiteColor];
    self.datePicker = _datePicker1;
    [self.datePicker addTarget:self action:@selector(chooseDate:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.datePicker];
}

@end
