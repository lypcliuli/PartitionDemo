Pod::Spec.new do |s|

  s.name         = "MePartition"
  s.version      = "1.0.3"
  s.summary      = "MePartition模块"
  s.description  = <<-DESC
  MePartition模块MePartition模块MePartition模块MePartition模块MePartition模块MePartition模块MePartition模块MePartition模块
                   DESC

  s.homepage     = "https://github.com/lypcliuli/PartitionDemo"
  
  s.license          = { :type => 'MIT', :file => 'LICENSE' }

  s.author             = { "lypcliuli" => "lypcliuli@163.com" }

  s.source       = { :git => "https://github.com/lypcliuli/PartitionDemo.git", :tag => s.version }
  s.ios.deployment_target = '9.0'

  s.subspec 'Controller' do |vc|
      vc.source_files = 'MePartition/Controller/*'
      vc.public_header_files = 'MePartition/Controller/*.h'
  end

  s.subspec 'Target_MePartition' do |t|
      t.source_files = 'MePartition/Target_MePartition/*'
      t.public_header_files = 'MePartition/Target_MePartition/*.h'
      t.dependency 'MePartition/Controller'
  end

  s.frameworks = 'UIKit'

end
