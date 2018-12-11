Pod::Spec.new do |s|

  s.name         = "Me_Category"
  s.version      = "1.0.3"
  s.summary      = "Me_Category"
  s.description  = <<-DESC
  Me_CategoryMe_CategoryMe_CategoryMe_CategoryMe_CategoryMe_CategoryMe_CategoryMe_CategoryMe_Category
                   DESC

  s.homepage     = "https://github.com/lypcliuli/PartitionDemo"
  
  s.license          = { :type => 'MIT', :file => 'LICENSE' }

  s.author             = { "lypcliuli" => "lypcliuli@163.com" }

  s.source       = { :git => "https://github.com/lypcliuli/PartitionDemo.git", :tag => s.version }
  s.ios.deployment_target = '9.0'

  s.source_files  = "Me_Category/**/*.{h,m}"
  
  s.dependency 'CTMediator'
  
  s.frameworks = 'UIKit'

end
