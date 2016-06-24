# 当文本框在在scrollview里时会有问题，还有其他未知bug。。。请慎用。。

# LJWKeyboardHandler

监听键盘的小助手，帮你的TextField，TextView闪避键盘的攻击，在ViewController里注册下就能用了哟~

非常环保，跟随试图控制器的销毁而销毁~

可以在不同的ViewController里设置不同的辅助移动高度,也可以为每个view设置不同的移动高度，两个高度会叠加~

可以设置单个视图是否需要闪避键盘；

添加了Keyboard的ToolBar支持上蹿下跳和收回键盘；

支持CocoaPods了哟~~~

#CocoaPods

pod 'LJWKeyboardHandler', '~> 1.0.3'

#How to use

Just one line code.

[self registerLJWKeyboardHandler];







