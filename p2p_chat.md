# 讲一讲我前段时间做的一个点对点加密聊天软件
## 版权声明
本文章**仅在**本人github pages发布,  
转载给爷**标上源链接**, 敢在某些平台转载投自制的**你\*\**!**  
CC BY-NC-SA

## 使用到的技术
- UDP socket
- 进程(这里指beam虚拟机的进程)
- GenServer
- ETS键值存储(Erlang Term Storage)(类似redis, 也是在内存中的)
- escript编译成可执行文件
- rsa非对称加密

## 大体架构
整个思路来源都是从这两个视频来的, UDP打洞  
[with netcat](https://www.youtube.com/watch?v=s_-UCmuiYW8)[with python](https://www.youtube.com/watch?v=IbzGL_tjmv4)  
我的理解就是通过发送UDP包打开一个端口来让远程电脑能知道你的端口映射到了公网IP的哪个端口,  
然后将两个需要发消息的客户端相互告诉对方各自的公网IP以及映射到的端口, 就能实现p2p通信.  

客户端使用GenServer来实现后端接口和网络通信, 在CLI模块处理用户输入调用GenServer.  
服务端可以很简单, 就是收到两个IP然后相互发送对方的地址让客户端能够相互通信,  
但是为了能够接受多对客户端以及非阻塞等待客户端, 就用ETS存储客户端的信息,  
为了让客户端不乱配对, 就需要增加一个注册功能, 也使用ETS实现.  

## 客户端实现
内容比较多, 所以我不会讲的很全, 代码不会都放出来
项目目录大概是这样
```sh
├── client
│   ├── lib
│   │   ├── client
│   │   │   ├── cli.ex          # 和用户交互, 调用GenServer后端, escript入口点
│   │   │   ├── connect.ex      # 处理与服务器发送和接受的二进制字符串
│   │   │   ├── crypto.ex       # rsa加密解密
│   │   │   └── register.ex     # 仅生成注册时需要发送的二进制字符串
│   │   └── client.ex           # 客户端核心程序, 包含GenServer和socket通信
│   ├── mix.exs
│   └── mix.lock
```

注意这里只在核心程序处理socket, cli模块处理用户交互, 使项目分层化

### escript
客户端要编译成可执行文件, 要在mix.exs里加入escript 
```elixir
defmodule Client.MixProject do
  use Mix.Project

  def project do
    [
      app: :client,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      escript: escript()
    ]
  end

  defp escript do
    [main_module: Client.CLI]
  end

  def application do
    [
      extra_applications: [:logger, :crypto]
    ]
  end

  defp deps do
    []
  end
end
```
main\_module指定了程序的入口点main函数, extra\_applications加入erlang库:crypto因为后续需要使用加密

### GenServer和socket

### 用户交互CLI
首先使用OptionParser解析命令行参数, 如果解析成功就启动GenServer
```elixir
def main(args \\ []) do
  {opts, args, invalid} = OptionParser.parse(args, strict: [
    port: :integer,
  ])
  if opts == [] or (args != [] && invalid != []) do
    IO.puts "usage: client --port <port>"
  else
    Client.start_link(opts[:port])
    main_cli()
  end
end
```
然后main\_cli()就处理用户的输入, 没什么好讲的.  
这里主要说一下输入密码的部分:  
erlang的:io.get_password()函数在mix中不管用, 所以就需要自己写一个清空用户输入的小东西
```elixir
def gets_passwd(prompt) do
	pid = spawn(fn -> clear_input(prompt) end)
	value = IO.gets("")
	send(pid, :stop)
	value
end

def clear_input(prompt) do
	IO.write(IO.ANSI.clear_line() <> "\r" <> prompt)   #\r用于回到行首
	:timer.sleep(10)
	receive do
		:stop -> IO.write("\r")
	after
		0 -> clear_input(prompt)
	end
end
```
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
