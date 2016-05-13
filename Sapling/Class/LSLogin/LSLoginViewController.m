//
//  LSLoginViewController.m
//  Sapling
//
//  Created by sport on 16/4/20.
//  Copyright © 2016年 光前. All rights reserved.
//

#import "LSLoginViewController.h"
#import "LSLoginView.h"
#import "LSSignInViewController.h"

@interface LSLoginViewController ()<LSLoginViewDelegate>
@end

@implementation LSLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"登录";
   
    LSLoginView * LoginView = [[LSLoginView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    LoginView.delegate = self;
    [self.view addSubview:LoginView];

    // Do any additional setup after loading the view.
}
/** 代理方法*/
- (void)LSLoginViewButtonClicked:(UIButton *)button{
    if(button.tag == KButtonTypeLogin){
        
    }
    if(button.tag == KButtonTypeSignIn){
        LSSignInViewController * LSSignInVC = [[LSSignInViewController alloc]init];
        [self.navigationController pushViewController:LSSignInVC animated:YES];
        
    }
    if(button.tag == KButtonTypeForget){
        
    }
}

/** 取消编辑*/
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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

@end
