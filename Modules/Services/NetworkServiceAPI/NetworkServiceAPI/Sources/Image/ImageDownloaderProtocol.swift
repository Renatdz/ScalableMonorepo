import Foundation
import UIKit.UIImage

public protocol ImageDownloaderProtocol {
    init(session: URLSessionProtocol, thread: DispatchQueue)
    
    @discardableResult
    func downloadImage(
        from url: URL,
        completion: @escaping (Result<UIImage, ImageDownloadError>) -> Void
    ) -> URLSessionDataTask?
}
