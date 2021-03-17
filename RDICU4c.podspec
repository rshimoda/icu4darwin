Pod::Spec.new do |s|
  s.name         = 'RDICU4c'
  s.version      = '64.2-xcframework.1'
  s.summary      = 'International Components for Unicode.'
  s.homepage     = 'http://icu-project.org/'
  s.license      = { :type => 'BSD', :text => '' }
  s.author       = 'IBM'
  s.source = { :git => 'git@github.com:readdle/icu4c-bin.git', :commit => '0b4603141da844da5bd9e5ea202c7d82795c1402' }
  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.9'
  s.vendored_frameworks = 'XCFramework/RDICU4c.xcframework'
  s.xcconfig = { 'HEADER_SEARCH_PATHS' => '"${PODS_XCFRAMEWORKS_BUILD_DIR}/RDICU4c/RDICU4c.framework/Headers"' }
end

