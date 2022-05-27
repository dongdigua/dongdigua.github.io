# 讲一讲我前段树间做的一个点对点加密聊天软件
## 版权声明
本文章**仅在**B站专栏和本人github pages发布,  
转载给爷**标上源链接(github和B站的链接都得标)**, 敢在某些平台转载投自制的**你\*\**!**  

## 使用到的技术
- UDP socket
- 进程(这里指beam虚拟机的进程)
- GenServer
- ets键值存储(类似redis, 也是在内存中的)
- escript编译成可执行文件

## 大体架构

## 客户端实现
### escript
### socket
### GenServer
### 用户交互CLI

## 服务端实现
### socket
### 存储

## 后记
### 分层实现
### elixir/erlang UI?
查了一下, elixir/erlang的基于文本界面(tui)的库好像都得调用C, 有点难受,  
然后:gl官方文档看不懂...
### 感想
### Rust杂谈
正如上文(ui)所说, elixir实现ui总是要调用底层库, 然后OpenGL的支持也没有相关的教程(可能即使实现出来了渲染效率也不高).  
还有就是我想知道是elixir里面的一些数据结构如何存储的, 所以我最近准备学一学Rust这个比较底层的语言.  
现在刚开始学, 在看the book以及B站相关视频, 然后还是在exercism上做练习, Rust学起来有些地方和之前学elixir挺不同的:  
- 静态类型: 我之前一直写动态类型的语言(py, ex, jl), 静态有些不适应, 但其实还好
- 难: 很有挑战性, exercism上的learning exercises没有elixir那么详细
- 现代, 放心, 受限?: Rust编译器是真滴强大, 静态检查很多细节都能检查出来, 而且所有权让内存管理更安全了,  
不像C随便写一些就segfault, 也不用预先定义函数,  
```C
#include <stdio.h>
int ref();
int main(int argc, char *argv){
	int *a = ref();
	printf("%s", *a);
	return 0;
}
int ref(){
	char *s = "haha";
	return &s;
}
```
但是有些地方(暂时这个水平)觉得有点受限, 没有C那么为所欲为, 但这一段我应该看完unsafe rust在下结论233
- 底层: 原生的ncurses之类的库, 也有很多原生ui界面库
