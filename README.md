# PartitionDemo
## PartitionDemo 模块化、组件化 、CTMediator

*本demo集成了CTMediator做了一个简单的组件化演示，具体可以看官方的demo，后续会继续出使用用url、protocol等形式的组件化交互方案演示，大家一起学习。

为了不扩散太多分支，也是因为我懒，所有的模块拆分我都在这一个项目里做了，下载项目之后一定先pod update一下，然后打开项目看路径是很干净的。
模拟了三个模块：MainPartition、MePartition、TempPart，其中MainPartition、MePartition做个公有仓库（建议做成私有仓库 我懒才这么干的），TempPart模块没有抽成组件，而是放本地了文件了。

每个模块的组成：
1、每个模块都是一个UIViewController；
2、创建一个Target_action,继承自NSObject，因为CTMediator内部主要通过runtime机制实现（可以看源码，几百行）；
3、创建一个分类Category，通过Category解耦（个人理解词汇）；



