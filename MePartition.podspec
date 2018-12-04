Pod::Spec.new do |s|

  s.name         = "MainPartition"
  s.version      = "0.0.1"
  s.summary      = "MePartition模块"
  s.description  = <<-DESC
  MePartition模块MePartition模块MePartition模块MePartition模块MePartition模块MePartition模块MePartition模块MePartition模块
                   DESC

  s.homepage     = "https://github.com/lypcliuli/PartitionDemo"
  
  s.license          = { :type => 'MIT', :file => 'LICENSE' }

  s.author             = { "lypcliuli" => "lypcliuli@163.com" }

  s.source       = { :git => "https://github.com/lypcliuli/PartitionDemo.git", :tag => s.version }
  s.ios.deployment_target = '9.0'

  s.source_files  = "MePartition/**/*.{h,m}"

end
