require 'json'
pjson = JSON.parse(File.read('package.json'))

Pod::Spec.new do |s|

  s.name            = pjson["name"]
  s.version         = pjson["version"]
  s.homepage        = "https://github.com/mincedmit/react-native-vpn-detect"
  s.summary         = pjson["description"]
  s.license         = pjson["license"]
  s.author          = { "Dmitri Vasiliev" => "dvasiliev@gagosian.com" }
  s.platform        = :ios, "12.0"
  s.source          = { :git => "https://github.com/mincedmit/react-native-vpn-detect", :tag => "v#{s.version}" }
  s.source_files    = 'RNVPNDetect/*.{h,m}'
  
  s.dependency 'React'

end
