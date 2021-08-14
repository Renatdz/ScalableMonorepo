import Foundation
import NetworkServiceAPI
import UIKit.UIImage

struct ImageDownloader: ImageDownloaderProtocol {
    private let session: URLSessionProtocol
    private let thread: DispatchQueue
    
    init(session: URLSessionProtocol = URLSession.shared, thread: DispatchQueue = DispatchQueue.main) {
        self.session = session
        self.thread = thread
    }
    
    @discardableResult
    func downloadImage(
        from url: URL,
        completion: @escaping (Result<UIImage, ImageDownloadError>) -> Void
    ) -> URLSessionDataTask? {
        let task = session.dataTask(with: url) { data, _, error in
            self.thread.async {
                if let error = error {
                    completion(.failure(.generic(error)))
                    return
                }
                
                guard
                    let data = data,
                    let image = UIImage(data: data)
                else {
                    completion(.failure(.decodeError))
                    return
                }
                
                completion(.success(image))
            }
        }
        
        task.resume()
        return task
    }
}
