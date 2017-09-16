Pod::Spec.new do |spec|

  spec.name         = "Kreds"
  spec.version      = "1.0.0.alpha.1"
  spec.license      = "MIT"

  spec.summary      = "Easily generate strong typed and autocompleted properties"
  spec.description  = <<-DESC
                   Kreds is a tool to generate a Swift struct and corresponding Objective-C constants from a supplied
                   plist file containing groups and properties.
                   * One place for all your credentials, tokens, constants.
                   * Build-time generation making it possible to generate from different plists depending on target.
                   DESC
  spec.homepage     = "https://github.com/amnell/Kreds"

  spec.author             = { "Mathias Amnell" => "mathias@apping.se" }
  spec.social_media_url   = "https://twitter.com/amnell"

  spec.requires_arc = true
  spec.source = { :http => "https://github.com/amnell/Kreds/releases/download/v#{spec.version}/kreds-v#{spec.version}.zip" }

  spec.ios.deployment_target     = '9.0'
  spec.tvos.deployment_target    = '9.0'

  spec.preserve_paths = "kreds"

end
