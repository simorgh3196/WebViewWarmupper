Pod::Spec.new do |spec|
  spec.name          = 'WebViewWarmupper'
  spec.version       = '0.1.0'
  spec.license       = { :type => "MIT", :file => "LICENSE" }
  spec.homepage      = 'https://github.com/simorgh3196/WebViewWarmupper'
  spec.authors       = { 'Tomoya Hayakawa' => 'simorgh3196@gmail.com' }
  spec.summary       = 'Warmup WKWebViewInstance'
  spec.source        = { :git => 'https://github.com/simorgh3196/WebViewWarmupper.git', :tag => "#{spec.version}" }
  spec.swift_version = '4.2'

  spec.ios.deployment_target  = '8.0'

  spec.source_files  = 'Sources/**/*.swift'

  spec.ios.framework = 'WebKit'
end
