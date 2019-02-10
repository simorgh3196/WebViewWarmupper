Pod::Spec.new do |spec|
  spec.name          = 'WebViewWarmuper'
  spec.version       = '1.0.0'
  spec.license       = { :type => "MIT", :file => "LICENSE" }
  spec.homepage      = 'https://github.com/simorgh3196/WebViewWarmuper'
  spec.authors       = { 'Tomoya Hayakawa' => 'simorgh3196@gmail.com' }
  spec.summary       = 'Warmup WKWebViewInstance'
  spec.source        = { :git => 'https://github.com/simorgh3196/WebViewWarmuper', :tag => 'v1.0.0' }
  spec.swift_version = '4.2'

  spec.ios.deployment_target  = '9.0'
  spec.osx.deployment_target  = '10.10'

  spec.source_files  = 'Sources/**/*.swift'

  spec.ios.framework = 'WebKit'
end
