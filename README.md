![(logo)](https://github.com/niyongsheng/AppDemo/blob/master/logo.png?raw=true)
AppDemo
===
[![](https://img.shields.io/badge/platform-iOS-orange.svg)](https://developer.apple.com/ios/)
[![](http://img.shields.io/travis/CocoaPods/CocoaPods/master.svg?style=flat)](https://travis-ci.org/CocoaPods/AppDemo)
[![](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/niyongsheng/AppDemo/blob/master/LICENSE)
===
* 快速创建一个App。
* Quickly Create An Application.

## <a id="How_About_It:"></a>How About It:
* Framework import：
    * 核心动画 					`CoreAnimation`
    * 加载进度条					`KVO`
    * 音效播放 					`AudioToolbox`
    * 凸起TabBar					`CALayer、UIBezierPath`
    * 高斯模糊					`UIBlurEffect`
    * 关于页						`StoreKit`
    * 自动填充					`Autofill iOS 12.0`
    * IM+推送+分享+支付+第三方登录	`UMeng+Jpush\AliPay+WeChatPay`

## <a id="Application_Instance:"></a>Application Instance:
<!-- ![(RMOV)](https://github.com/niyongsheng/GuessFigure/blob/master/ScreenRecording.mov?raw=true) -->

Screenshot0 | Screenshot1 | Screenshot2 | Screenshot3
------------ | ------------- | ------------- | -------------
<img src="https://github.com/niyongsheng/AppDemo/blob/master/Screenshot/Simulator%20Screen%20Shot%20-%20iPhone%208%20Plus%20-%202018-11-16%20at%2018.14.28.png"> | <img src="https://github.com/niyongsheng/AppDemo/blob/master/Screenshot/Simulator%20Screen%20Shot%20-%20iPhone%208%20Plus%20-%202018-11-16%20at%2018.14.35.png"> | <img src="https://github.com/niyongsheng/AppDemo/blob/master/Screenshot/Simulator%20Screen%20Shot%20-%20iPhone%208%20Plus%20-%202018-11-16%20at%2018.46.30.png"> | <img src="https://github.com/niyongsheng/AppDemo/blob/master/Screenshot/Simulator%20Screen%20Shot%20-%20iPhone%208%20Plus%20-%202018-11-16%20at%2018.38.34.png"> 

SignIn | RPWD | REG
------------ | ------------- | -------------
<img src="https://github.com/niyongsheng/AppDemo/blob/master/Screenshot/Simulator%20Screen%20Shot%20-%20iPhone%208%20Plus%20-%202018-11-16%20at%2018.13.50.png"> | <img src="https://github.com/niyongsheng/AppDemo/blob/master/Screenshot/Simulator%20Screen%20Shot%20-%20iPhone%208%20Plus%20-%202018-11-16%20at%2018.14.00.png"> | <img src="https://github.com/niyongsheng/AppDemo/blob/master/Screenshot/Simulator%20Screen%20Shot%20-%20iPhone%208%20Plus%20-%202018-11-16%20at%2018.14.04.png">

## <a id="Config_Your_App:"></a>Config Your App:
* [PrefixHeader.pch](AppDemo/AppDemo/PrefixHeader.pch)
```shell
#define POSTURL @"http://103.278.225.222:8080/api"
#define APPID @"1438587731"
#define AppStoreURL @"https://itunes.apple.com/cn/app/id1438587731"

// 微信登录
#define WXAPPID @"wxa1ef79a68ee78dc6"
#define APPSECRET @"df13989d289c27b9703ec65ef8d519db"
// QQ登录
#define QQAPPID @"110668133"
#define QQAPPKEY @"PTC8VnALh7zKqKe"
// 支付宝支付
#define AlipayAPPID @"201806196016551"
// 极光推送
#define JPUSH_APPKEY @"dbe5990f07ed34325e34566"
#define JPUSH_CHANNEl @"App Store"
#define isProdution 1
// 融云AppKey
#define RCAPPKEY @"n19jcy5n8fz9"
// 友盟AppKey
#define UMAPPKEY @"5bd4062cf1f556edf600075f"
```

## <a id="AutoFill_Password:"></a>AutoFill Password:
#### 1、设置 TextField ContentType

类目 | UIKit | ContentType | Remark
------------ | ------------- | ------------- | -------------
用户名 | TextField | UserName | no
 密码  | TextField | Password | no
新密码 | TextField | New Password | no
验证码 | TextField | One Time Code | no

<img src="https://github.com/niyongsheng/AppDemo/blob/master/Screenshot/autofill/1542769155284.jpg" width="670" height="400">

#### 2、设置 apple-app-site-association
   > 需要一个支持HTTPS的网站用来存放，apple-app-site-association文件。
   如果没有可以利用GitHub Pages挂载，步骤如下：
   
  * 2.1、Fork我的GitHub Pages
   > https://niyongsheng.github.io
  <img src="https://github.com/niyongsheng/AppDemo/blob/master/Screenshot/autofill/1542767161015.jpg" width="670" height="370">
  
  * 2.2、修改成自己的域名
  <img src="https://github.com/niyongsheng/AppDemo/blob/master/Screenshot/autofill/1542767303721.jpg" width="670" height="370">
  
  * 2.3、验证https://niyongsheng.github.io
  <img src="https://github.com/niyongsheng/AppDemo/blob/master/Screenshot/autofill/WX20181121-115649.png" width="670" height="370">
  
#### 3、修改apple-app-site-association文件
<img src="https://github.com/niyongsheng/AppDemo/blob/master/Screenshot/autofill/1542767468091.jpg" width="670" height="370">
<img src="https://github.com/niyongsheng/AppDemo/blob/master/Screenshot/autofill/1542768385014.jpg" width="670" height="370">

```JSON
{
   "webcredentials":{
      // ${Prefix} Prefix, ${BundleID} Bundle ID ,如果有多个APP依次增加.
      "apps":["${Prefix}.${BundleID}"],
      "apps":["${Prefix1}.${BundleID2}"],
      "apps":["${Prefix2}.${BundleID3}"]
   }
}
```
  
#### 4、设置 Associated Domains
<img src="https://github.com/niyongsheng/AppDemo/blob/master/Screenshot/autofill/1542766863012.jpg" width="670" height="370">
  
#### 5、设置 Associated Domains
<img src="https://github.com/niyongsheng/AppDemo/blob/master/Screenshot/autofill/1542766863012.jpg" width="670" height="370">
   
#### 6、官方文档
<img src="https://github.com/niyongsheng/AppDemo/blob/master/Screenshot/autofill/1542768418585.jpg" width="670" height="370">
https://developer.apple.com/library/archive/documentation/General/Conceptual/AppSearch/UniversalLinks.html

<!--
* Step 1.Add Shell
```shell

```
* Step 2.AppDelegate.m
```objc

```
-->
## Remind
- [x] ARC
- [x] iOS >= 10.0
- [x] iPhone \ iPad

## Contribution
Reward[:lollipop:](+8618853936112)  Encourage[:heart:](https://github.com/niyongsheng/AppDemo/stargazers)

## Contact Me [:octocat:](https://niyongsheng.github.io)
* E-mail: niyongsheng@Outlook.com
* Weibo: [@Ni永胜](https://weibo.com/u/2198015423)
