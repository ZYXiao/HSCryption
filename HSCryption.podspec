Pod::Spec.new do |s|
  s.name         = "HSCryption"

  s.version      = "1.0.0"

  s.summary      = "encode&decode component."

  s.homepage     = "https://github.com/ZYXiao/HSCryption"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author       = { "ZYXiao" => "304983615@qq.com" }

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/ZYXiao/HSCryption.git", :tag => "1.0.0" }

  s.source_files  = "HSCryption/*.{h,m}"

  s.frameworks    = 'Foundation', 'Security'

  s.requires_arc = true
end
