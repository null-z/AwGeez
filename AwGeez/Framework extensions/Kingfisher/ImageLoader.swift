//
//  ImageLoader.swift
//  AwGeez
//
//  Created by Tony Dэ on 20.05.2023.
//

import UIKit
import Kingfisher

extension UIImageView {
    /// Sets image from url with default placeholder
    func setImage(with url: URL?, placeholder: UIImage? = R.image.placeholder()) {
        self.kf.setImage(with: url,
                         placeholder: placeholder)
    }
}

enum ImageLoader {
    static func prefetchImages(for urls: [URL]) {
        ImagePrefetcher(urls: urls).start()
    }
}

extension ImageLoader {
    enum Cache {
        static var memoryCountLimit: Int {
            get { ImageCache.default.memoryStorage.config.countLimit }
            set { ImageCache.default.memoryStorage.config.countLimit = newValue }
        }
        
        static var diskSizeLimit: UInt {
            get { ImageCache.default.diskStorage.config.sizeLimit / megabyte }
            set { ImageCache.default.diskStorage.config.sizeLimit = newValue * megabyte }
        }
        
        private static let megabyte: UInt = 1024 * 1024
        
        static func clear() {
            ImageCache.default.clearCache()
        }
    }
}
