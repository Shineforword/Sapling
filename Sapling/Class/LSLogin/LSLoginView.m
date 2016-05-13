//
//  LSLoginView.m
//  Sapling
//
//  Created by sport on 16/4/21.
//  Copyright © 2016年 光前. All rights reserved.
//

#import "LSLoginView.h"

@interface LSLoginView ()

@property (nonatomic, strong) UITextField * usernameTextfield;
@property (nonatomic, strong) UITextField * passwordTextfield;
@property (nonatomic, strong) UIButton * loginBtn;
@property (nonatomic, strong) UIButton * signInBtn;
@property (nonatomic, strong) UIButton * forgetBtn;

@end
@implementation LSLoginView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        /** 1.没有适配*/
//        [self setup];
        /** 2.使用SDAutoLayOut适配*/
        [self setUpSDAutoLayOutView];
        
    }
    return self;
}
- (void)setUpSDAutoLayOutView{
    self.backgroundColor = [UIColor whiteColor];
    //账号
    UILabel * title1 = [[UILabel alloc]init];
    title1.text = @"账号";
    title1.font = [UIFont systemFontOfSize:15];
    
    _usernameTextfield = [[UITextField alloc]init];
    [_usernameTextfield setAutocorrectionType:UITextAutocorrectionTypeNo];
    [_usernameTextfield setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    _usernameTextfield.keyboardType = UIKeyboardTypeASCIICapable;
    
    UIView * line1 = [[UIView alloc]init];
    line1.backgroundColor = BASE_CELL_LINE_COLOR;

    //密码
    UILabel * title2 = [[UILabel alloc]init];
    title2.text = @"密码";
    title2.font = [UIFont systemFontOfSize:15];
    _passwordTextfield = [[UITextField alloc]init];
    [_passwordTextfield setAutocorrectionType:UITextAutocorrectionTypeNo];
    [_passwordTextfield setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    _passwordTextfield.keyboardType = UIKeyboardTypeASCIICapable;
    
    UIView * line2 = [[UIView alloc]init];
    line2.backgroundColor = BASE_CELL_LINE_COLOR;
    
    //登陆
    _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_loginBtn setTitle:@"登陆" forState:UIControlStateNormal];
    [_loginBtn setBackgroundColor:BASE_GREEN_COLOR];
    _loginBtn.clipsToBounds = YES;
    _loginBtn.layer.cornerRadius = 3;
    _loginBtn.tag = KButtonTypeLogin;
    [_loginBtn addTarget:self action:@selector(loginIn) forControlEvents:UIControlEventTouchUpInside];
    //注册
    _signInBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_signInBtn setTitle:@"注册" forState:UIControlStateNormal];
    [_signInBtn setBackgroundColor:BASE_GREEN_COLOR];
    _signInBtn.clipsToBounds = YES;
    _signInBtn.layer.cornerRadius = 3;
    _signInBtn.tag = KButtonTypeSignIn;
    [_signInBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    //忘记密码?
    _forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_forgetBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    _forgetBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [_forgetBtn setBackgroundColor:[UIColor whiteColor]];
    [_forgetBtn setTitleColor:BASE_6_COLOR forState:UIControlStateNormal];
    _forgetBtn.clipsToBounds = YES;
    _forgetBtn.layer.cornerRadius = 3;
    _forgetBtn.tag = KButtonTypeForget;
    [_signInBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:title1];
    [self addSubview:line1];
    
    [self addSubview:title2];
    [self addSubview:line2];
    
    [self addSubview:_usernameTextfield];
    [self addSubview:_passwordTextfield];
    [self addSubview:_loginBtn];
    [self addSubview:_signInBtn];
    [self addSubview:_forgetBtn];
    
//    title1.frame = CGRectMake(10, 60, 40, 20);
   
    //账号
    title1.sd_layout
    .leftSpaceToView(self,10)
    .widthIs(40)
    .topSpaceToView(self,60)
    .heightIs(20);
    
    //账号输入框
    _usernameTextfield.sd_layout
    .leftSpaceToView(title1,10)
    .widthIs(SCREEN_WIDTH - CGRectGetMaxX(title1.frame))
    .topSpaceToView(self,60)
    .heightIs(20);
    
    //线1
    line1.sd_layout
    .leftSpaceToView(title1,0)
    .widthIs(_usernameTextfield.frame.size.width - 20)
    .topSpaceToView(_usernameTextfield,0)
    .heightIs(0.7);
    
    
    //密码
    title2.sd_layout
    .leftSpaceToView(self,10)
    .widthIs(40)
    .topSpaceToView(title1,10)
    .heightIs(20);
    
    //密码输入框
    _passwordTextfield.sd_layout
    .leftSpaceToView(title2,10)
    .widthIs(SCREEN_WIDTH - CGRectGetMaxX(title2.frame))
    .topSpaceToView(title1,10)
    .heightIs(20);
    
    //线2
    line2.sd_layout
    .leftSpaceToView(title2,0)
    .widthIs(SCREEN_WIDTH - CGRectGetMaxX(title2.frame) - 20)
    .topSpaceToView(_passwordTextfield,0)
    .heightIs(0.7);
    

    //按钮
    _loginBtn.sd_layout
    .leftSpaceToView(self,10)
    .widthIs(SCREEN_WIDTH - 20)
    .topSpaceToView(title2,20)
    .heightIs(30);
    
    _signInBtn.sd_layout
    .leftSpaceToView(self,10)
    .widthIs(SCREEN_WIDTH - 20)
    .topSpaceToView(_loginBtn,20)
    .heightIs(30);

    _forgetBtn.sd_layout
    .leftSpaceToView(self,10)
    .widthIs(SCREEN_WIDTH - 20)
    .topSpaceToView(_signInBtn,20)
    .heightIs(30);


}
- (void)buttonClicked:(UIButton *)button{
    
    [self delegateOperation:button];
}
- (void)loginIn{
    if (self.usernameTextfield.text.length < 1 || self.passwordTextfield.text.length < 1) {
        [MBProgressHUD showError:@"用户名或密码错误" toView:nil];
        return;
    }
    NSString * deviceToken = [ZXCommens fetchDeviceToken];
    NSDictionary *dic = [[NSDictionary alloc] init];
    dic = [ZXCommens factionaryParams:@{
                                        @"username":_usernameTextfield.text,
                                        @"password":_passwordTextfield.text,
                                        @"device_token":deviceToken ? deviceToken : @""}
                  WithServerAndMethod:@{
                                        @"service":@"user",
                                        @"method":@"login"
                                        }];
    [MBProgressHUD showHUDAddedTo:self animated:YES];
    ZXRequest * request = [[ZXRequest alloc] initWithRUrl:Host_Server andRMethod:YTKRequestMethodPost andRArgument:dic];
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

/** 容错处理代理方法*/
- (void)delegateOperation:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(LSLoginViewButtonClicked:)]) {
        [self.delegate LSLoginViewButtonClicked:button];
    }
}
@end
