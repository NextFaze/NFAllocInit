NFAllocInit
===========

The starting point for an iOS app - helper classes and the like

Integration instructions
========================

Add submodule to your project.

$ git submodule add git@github.com:NextfazeSD/NFAllocInit.git Frameworks/NFAllocInit

Drag the NFAllocInit.xcodeproj project file from Finder to the Frameworks folder in your project tree.

Add to target's Target Dependencies in Build Phases, and also Link Binary with Libraries.

Also, in Link Binary with Libraries add AVFoundation.framework.

Add to target linker flags '-ObjC'