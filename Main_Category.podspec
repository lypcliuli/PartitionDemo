Pod::Spec.new do |s|

  s.name         = "Main_Category"
  s.version      = "1.0.2"
  s.summary      = "Main_Category"
  s.description  = <<-DESC
  Main_CategoryMain_CategoryMain_CategoryMain_CategoryMain_CategoryMain_CategoryMain_Category
                   DESC

  s.homepage     = "https://github.com/lypcliuli/PartitionDemo"
  
  s.license          = { :type => 'MIT', :file => 'LICENSE' }

  s.author             = { "lypcliuli" => "lypcliuli@163.com" }

  s.source       = { :git => "https://github.com/lypcliuli/PartitionDemo.git", :tag => s.version }
  s.ios.deployment_target = '9.0'

  s.source_files  = "Main_Category/**/*.{h,m}"
  s.dependency 'CTMediator'
  
end
