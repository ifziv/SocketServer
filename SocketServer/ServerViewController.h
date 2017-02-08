//
//  ServerViewController.h
//  SocketServer
//
//  Created by zivInfo on 16/8/5.
//  Copyright © 2016年 xiwangtech.com. All rights reserved.
//

// OSI(开放式系统互联), 由ISO(国际化标准组织)制定
// 1. 应用层
// 2. 表示层
// 3. 会话层
// 4. 传输层
// 5. 网络层
// 6. 数据链接层
// 7. 物理层

// TCP/IP, 由美国国防部制定
// 1. 应用层, HTTP, FTP, SMTP, DNS
// 2. 传输层, TCP, UDP
// 3. 网络层, IP
// 4. 链路层, ARP, RARP

// HTTP(短连接)
// 1. 建立链接, 三次握手
// 2. 断开链接, 四次挥手

// 数据报文->数据包->数据帧->比特流(二进制)-->比特流->数据帧->数据包->数据报文

// socket, "插口", "套接字", 长连接, 存在于应用层和传输层之间, 提供一种封装, 方便进行通信

#import <UIKit/UIKit.h>

#import "GCDAsyncUdpSocket.h"

@interface ServerViewController : UIViewController <GCDAsyncUdpSocketDelegate,UITextFieldDelegate>

@property (nonatomic, strong) GCDAsyncUdpSocket *serverSocket;
@property (weak, nonatomic) IBOutlet UITextField *IPTF;
@property (weak, nonatomic) IBOutlet UITextField *portTF;
@property (weak, nonatomic) IBOutlet UITextField *msgTF;
@property (weak, nonatomic) IBOutlet UILabel *getMsgL;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property (weak, nonatomic) IBOutlet UIButton *jtBtn;

- (IBAction)jtAction:(id)sender;
- (IBAction)sendAction:(id)sender;


@end
