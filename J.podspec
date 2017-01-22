Pod::Spec.new do |s|
  s.name             = "J"
  s.version          = "0.5.1"
  s.summary          = "A shinier JSON parsing library in Swift"
  s.description      = "A shiny JSON parsing library in Swift. Features include mapping JSON to objects, mapping objects to JSON, handling of nested objects and custom transformations."
  s.homepage         = "https://github.com/arkverse/J"
  s.license          = { :type => "MIT", :file => "LICENSE" }
  s.author           = { "Zaid Daghestani" => "zaid@arkverse.com" }
  s.social_media_url = "http://twitter.com/arkverse"
  s.source           = { :git => "https://github.com/arkverse/J.git", :tag => s.version.to_s }

  s.platforms     = { :ios => "8.0", :osx => "10.9", :tvos => "9.0", :watchos => "2.0" }
  s.requires_arc = true

  s.source_files     = 'Sources/*.{swift}'

end
