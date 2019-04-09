# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'

target 'arquitetura-mvvm' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'Alamofire'

  # Pods for arquitetura-mvvm

  target 'arquitetura-mvvmTests' do
    inherit! :search_paths
    pod 'Mockingjay'
    pod 'RxBlocking'
    pod 'RxSwift'
    pod 'RxCocoa'
    # Pods for testing
  end
  
  target 'arquitetura-mvvmUITests' do
      pod 'KIF', :configurations => ['Debug']
  end

end
