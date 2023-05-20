//
//  ImageCache.swift
//  AwGeez
//
//  Created by Tony Dэ on 27.04.2023.
//

import Foundation

extension StartupConfigurator {
    
    func setupImageCache() {
        ImageLoader.Cache.memoryCountLimit = 100
        ImageLoader.Cache.diskSizeLimit = 200
    }

    func resetCacheIfNeeded() {
        if needResetImageCache {
            ImageLoader.Cache.clear()
        }
    }
}
