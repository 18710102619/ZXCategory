
Pod::Spec.new do |s|

  s.name         = "ZXCategory"
  s.version      = "0.0.1"
  s.summary      = "Custom Category used on iOS."

  s.description  = <<-DESC
                   Custom Category used on iOS, which implement by Objective-C.
                   DESC

  s.homepage     = "https://github.com/18710102619/ZXCategory"
  s.license      = "MIT"
  s.author       = { "张玲玉" => "2949820345@qq.com" }
  s.platform     = :ios, '8.0'

  s.source       = { :git => "https://github.com/18710102619/ZXCategory.git", :tag => s.version }

  s.requires_arc = true

  s.subspec 'Category' do |category|
      category.source_files = "ZXCategory/Category/**/*.{h,m,mm,c,cc,cpp}"
  end

  #s.source_files     = 'ZXCategory/**/*'

end
