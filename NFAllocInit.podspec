Pod::Spec.new do |s|
  s.name         			= "NFAllocInit"
  s.version      			= "1.0.2"
  s.summary      			= "Helper classes for iOS App development"
  s.description  			= <<-DESC
                   			  The starting point for an iOS app - helper classes and the like. 
                   			  Add this to your project to have access to detailed logs, CGRect
                   			  shortcuts, quick audio player, date parsers and other handy tidbits.
                   			  DESC

  s.homepage     			= "https://github.com/NextFaze/NFAllocInit"
  s.license      			= 'Apache 2.0'
  s.author       			= { "NextFaze Pty Ltd" => "contact@nextfaze.com" }

  s.platform     			= :ios, "6.0"
  s.source       			= { :git => "https://github.com/NextfazeSD/NFAllocInit.git", :tag => "1.0.2" }
  s.source_files 			= "NFAllocInit", "NFAllocInit/**/*.{h,m}"
  s.frameworks   			= "AVFoundation", "AudioToolbox"
  s.requires_arc 			= true
  s.prefix_header_contents 	= '#import "NFAllocInit.h"'
end