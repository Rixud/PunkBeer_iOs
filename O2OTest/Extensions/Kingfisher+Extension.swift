//
//  Kingfisher+Extension.swift
//  O2OTest
//
//  Created by Luis Guerra on 10/6/21.
//


import Foundation
import Kingfisher
import Gifu

extension KingfisherWrapper where Base: UIImageView {
    @discardableResult
    func setImageWithRetry(
            with resource: URL?,
            placeholder: Placeholder? = nil,
            options: KingfisherOptionsInfo? = [.retryStrategy(DelayRetryStrategy(maxRetryCount: 3, retryInterval: .seconds(3)))],
            progressBlock: DownloadProgressBlock? = nil,
            completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil) -> DownloadTask? {

        let downloadTask = setImage(with: resource,
                                    placeholder: placeholder,
                                    options: options, progressBlock: progressBlock)
        return downloadTask
    }
}

class GifImageView: UIImageView, GIFAnimatable {
  public lazy var animator: Animator? = {
    return Animator(withDelegate: self)
  }()

  override public func display(_ layer: CALayer) {
    updateImageIfNeeded()
  }
}
