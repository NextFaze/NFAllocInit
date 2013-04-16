NFAllocInit
===========

The starting point for an iOS app - helper classes and the like

Integration instructions
========================

1. Add submodule to your project.
    $ git submodule add git@github.com:NextfazeSD/NFAllocInit.git ThirdParty/NFAllocInit
2. Drag the NFAllocInit.xcodeproj project file from Finder to the ThirdParty folder in your project tree.
3. Add `NFAllocInit` to target's Target Dependencies in Build Phases. 
4. Add `libNFAllocInit.a` in Link Binary with Libraries.
5. Also, in Link Binary with Libraries add `AVFoundation.framework` and `AudioToolbox.framework`.
6. Add to target linker flags `-ObjC`.
7. Add to Header Search Paths `ThirdParty/` with recursive selected.