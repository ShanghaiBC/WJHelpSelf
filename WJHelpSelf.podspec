Pod::Spec.new do |s|
s.name         = "WJHelpSelf"    #存储库名称
s.version      = "0.0.1"      #版本号，与tag值一致
s.summary      = "111"  #简介
s.description  = "66666622"  #描述
s.homepage     = "https://github.com/WJVijay/WJHelpSelf"      #项目主页，不是git地址
s.license      = { :type => "MIT", :file => "LICENSE" }   #开源协议
s.author             = { "wj123567" => "wangjunnige@163.com" }  #作者
s.platform     = :ios, "7.0"                  #支持的平台和版本号
s.source       = { :git => "https://github.com/WJVijay/WJHelpSelf.git", :tag => s.version }         #存储库的git地址，以及tag值
s.source_files  =  "WJHelpSelf/*" #需要托管的源代码路径
s.requires_arc = true #是否支持ARC

end
