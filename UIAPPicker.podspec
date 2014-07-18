Pod::Spec.new do |s|

  s.name         = "UIAPPicker"
  
  s.version      = "0.0.1"
  
  s.summary      = "show animated UIPicker for selected view"
  
  s.homepage     = "https://github.com/andproff/UIAPPicker"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "andrei_aka_proff" => "and.proff@me.com" }

  s.platform     = :ios, "6.1"

  s.source       = { :git => "https://github.com/andproff/UIAPPicker.git", :tag => s.version.to_s }

  s.source_files  = "Classes", "Classes/**/*.{h,m}"

  s.public_header_files = "Classes/**/*.h"

  s.framework  = "Foundation"

  s.requires_arc = true

end
