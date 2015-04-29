# NFAllocInit

The starting point for an iOS app - helper classes and the like. Add this to your project to have access to detailed logs, CGRect shortcuts, quick audio player, date parsers and other handy tidbits.

## Integration instructions

### Via CocoaPods

    pod 'NFAllocInit'

### Via Submodules

1. Add submodule to your project:

    `$ git submodule add git@github.com:NextfazeSD/NFAllocInit.git ThirdParty/NFAllocInit`
    
2. Drag the NFAllocInit.xcodeproj project file from Finder to the ThirdParty folder in your project tree.
3. Add `NFAllocInit` to target's Target Dependencies in Build Phases. 
4. Add `libNFAllocInit.a` in Link Binary with Libraries.
5. Also, in Link Binary with Libraries add `AVFoundation.framework` and `AudioToolbox.framework`.
6. Add to other linker flags `-ObjC`.
7. Add to header search paths `ThirdParty/` with recursive selected.

Optionally, in your pre-compiled header (prefix.pch) add `#import "NFAllocInit.h"` to have access to all the classes throughout your project.


## Contact

[NextFaze](http://nextfaze.com)

## License

NFAllocInit is licensed under the terms of the [Apache License, version 2.0](http://www.apache.org/licenses/LICENSE-2.0.html). Please see the [LICENSE](https://github.com/NextfazeSD/NFAllocInit/blob/master/LICENSE) file for full details.

