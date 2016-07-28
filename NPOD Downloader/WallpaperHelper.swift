//
//  WallpaperHelper.swift
//  NPOD Downloader
//
//  Created by Giulio Lombardo on 19/07/16.
//  Copyright © 2016 Giulio Lombardo. All rights reserved.
//

import AppKit

class WallpaperHelper {
	class func isRetina(imageData: [String: String]) -> Bool {
		var deviceHasRetinaFeature: Bool = Bool()

		// Now we need to check if the user has at least a Retina display
		// by looping through the displays, if he does not we will exit using
		// the guard statement below since the isRetina func it's useless
		// without a Retina display
		for screen in NSScreen.screens()! {
			if screen.backingScaleFactor < 2 {
				deviceHasRetinaFeature = false
			} else {
				deviceHasRetinaFeature = true
				break
			}
		}

		guard deviceHasRetinaFeature else {
			return false
		}

		let pictureDirectory: NSURL = NSFileManager.defaultManager().URLsForDirectory(.PicturesDirectory, inDomains: .UserDomainMask).first!
		let imageData: NSImage = NSImage(contentsOfURL: pictureDirectory.URLByAppendingPathComponent(imageData["filename"]!))!

		// If the image width and height values are greater than or equal to the
		// double of the mainScreen's width and height values the image is
		// Retina ready
		return imageData.size.width >= (NSScreen.mainScreen()!.frame.width * 2) && imageData.size.height >= (NSScreen.mainScreen()!.frame.height * 2)
	}

	class func setWallpaperWithImageData(imageData: [String: String]) {
		let pictureDirectory: NSURL = NSFileManager.defaultManager().URLsForDirectory(.PicturesDirectory, inDomains: .UserDomainMask).first!

		for screen in NSScreen.screens()! {
			do {
				try NSWorkspace.sharedWorkspace().setDesktopImageURL(pictureDirectory.URLByAppendingPathComponent(imageData["filename"]!), forScreen: screen, options: ["": ""])
			} catch let error as NSError {
				#if DEBUG
					print(error)
				#endif
			}
		}

		NSUserDefaults.standardUserDefaults().setValue(imageData["nodeID"], forKey: "currentNID")
	}
}