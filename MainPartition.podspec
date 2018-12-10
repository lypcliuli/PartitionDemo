Pod::Spec.new do |s|

  s.name         = "MainPartition"
  s.version      = "1.0.0"
  s.summary      = "MainPartition模块"
  s.description  = <<-DESC
  本模块的源码和对应的让外界调用的一个继承机NSObject类，来实现一个创建对象的方法 CTMediator利用runtime自动获取创建方法
                   DESC

  s.homepage     = "https://github.com/lypcliuli/PartitionDemo"
  
  s.license          = { :type => 'MIT', :file => 'LICENSE' }

  s.author             = { "lypcliuli" => "lypcliuli@163.com" }

  s.source       = { :git => "https://github.com/lypcliuli/PartitionDemo.git", :tag => s.version }
  s.ios.deployment_target = '9.0'

  s.source_files  = "MainPartition/**/*.{h,m}"
  
  # s.subspec 'Target_MainPartition' do |t|
  #     t.source_files = 'MainPartition/Target_MainPartition/*'
  #     t.public_header_files = 'MainPartition/**/*.h'
  # end

  s.frameworks = 'UIKit'

end
