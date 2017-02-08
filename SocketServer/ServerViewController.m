//
//  ServerViewController.m
//  SocketServer
//
//  Created by zivInfo on 16/8/5.
//  Copyright © 2016年 xiwangtech.com. All rights reserved.
//

#import "ServerViewController.h"

@interface ServerViewController ()
{
    int tag;
    NSString *ipStr;
    NSString *portStr;
    NSString *msgStr;
    NSData   *macData;
}

@end

@implementation ServerViewController

@synthesize serverSocket;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    tag = 0;
    serverSocket = [[GCDAsyncUdpSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    
    [self initView];
}

- (void)initView
{
    self.IPTF.tag = 100001;
    self.IPTF.placeholder = @"请输入IP地址..";
    self.IPTF.returnKeyType = UIReturnKeyDone;
    self.IPTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.portTF.tag = 100002;
    self.portTF.placeholder= @"请输入端口号..";
    self.portTF.returnKeyType = UIReturnKeyDone;
    self.portTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.msgTF.tag = 100003;
    self.msgTF.placeholder = @"请输入要发送的消息..";
    self.msgTF.returnKeyType = UIReturnKeyDone;
    self.msgTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.jtBtn.layer.masksToBounds = YES;
    self.jtBtn.layer.cornerRadius = 4.0;
    self.jtBtn.layer.borderWidth = 1.0;
    self.jtBtn.layer.borderColor = [UIColor colorWithRed:73.0/255.0 green:189.0/255.0 blue:204.0/255.0 alpha:1.0].CGColor;
    
    self.sendBtn.layer.masksToBounds = YES;
    self.sendBtn.layer.cornerRadius = 4.0;
    self.sendBtn.layer.borderWidth = 1.0;
    self.sendBtn.layer.borderColor = [UIColor colorWithRed:73.0/255.0 green:189.0/255.0 blue:204.0/255.0 alpha:1.0].CGColor;
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didReceiveData:(NSData *)data fromAddress:(NSData *)address withFilterContext:(id)filterContext
{
    NSString *msg = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    NSString *ipMac = [[NSString alloc] initWithData:address encoding:NSUTF8StringEncoding];
//    NSLog(@"===================");
//    NSLog(@"address => %@", ipMac);
    
    if (msg) {
        /* If you want to get a display friendly version of the IPv4 or IPv6 address, you could do this:
         
         NSString *host = nil;
         uint16_t port = 0;
         [GCDAsyncUdpSocket getHost:&host port:&port fromAddress:address];
         
         */
        
//        NSLog(@"msg==>%@", msg);
        /*
         2016-09-22 10:26:42.039 SocketServer[3162:60b] msg==>open270
         2016-09-22 10:26:42.041 SocketServer[3162:60b] msg==>htem270
         2016-09-22 10:26:52.061 SocketServer[3162:60b] msg==>wtem320
         2016-09-22 10:26:52.071 SocketServer[3162:60b] msg==>film280
         */
        NSString *msgNum = [msg substringWithRange:NSMakeRange(0,4)];
        int temp = [[msg substringWithRange:NSMakeRange(4,3)] intValue] / 10;
        
        if ([msgNum isEqualToString:@"open"]) {
            NSLog(@"open ==> %d°C", temp);
        }
        else if ([msgNum isEqualToString:@"htem"]) {
            NSLog(@"室温 ==> %d°C", temp);
        }
        else if ([msgNum isEqualToString:@"film"]) {
            NSLog(@"膜温 ==> %d°C", temp);
        }
        else if ([msgNum isEqualToString:@"wtem"]) {
            NSLog(@"设置 ==> %d°C", temp);
        }
        else if ([msgNum isEqualToString:@"clos"]) {
            NSLog(@"关闭 ==> %d°C", temp);
        }
        else {
            NSLog(@"msg==>%@", msg);
        }
        
        self.getMsgL.text = msg;
        
    }
    else {
        NSLog(@"Error converting received data into UTF-8 String");
    }
    

    macData = address;
//    [serverSocket sendData:data toAddress:address withTimeout:-1 tag:0];
}

-(void)jtAction:(id)sender
{
    NSError *error = nil;
    
    if (![serverSocket bindToPort:[portStr intValue] error:&error])
    {
        NSLog(@"Error starting server (bind): %@", error);
        return;
    }
    if (![serverSocket beginReceiving:&error])
    {
        [serverSocket close];
        NSLog(@"Error starting server (recv): %@", error);
        return;
    }
    [serverSocket localPort];
}

-(void)sendAction:(id)sender
{
    NSString *msg = msgStr;
    NSData *data = [msg dataUsingEncoding:NSUTF8StringEncoding];
    [serverSocket sendData:data toAddress:macData withTimeout:-1 tag:0];

    tag ++;
}

#pragma mark -
#pragma mark -
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"text:%@", textField.text);
    if (textField.tag == 100001)
        ipStr = textField.text;
    else if (textField.tag == 100002)
        portStr = textField.text;
    else if (textField.tag == 100003)
        msgStr = textField.text;
}

//按下Done按钮的调用方法，我们让键盘消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
