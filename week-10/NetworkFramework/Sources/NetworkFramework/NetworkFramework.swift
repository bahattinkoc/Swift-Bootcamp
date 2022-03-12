import UIKit

public struct NetworkService {
    public static let shared = NetworkService()
    private init() { }
    
}

public struct ServiceError: Codable {
    var errorKey: String?
    var title: String?
    var status: String?
    var path: String?
    
}

public enum NetworkError: Error {
    public enum ErrorMessageConstant {
        static let defaultErrorMessage = "Geçici bir sorun oluştu"
        static let defaultConnectionErrorMessage = "Internet bağlantısı yok."
    }
    
    case operationFailed
    case connectionError
    case serviceError(ServiceError)
    case error(Error)
    
    public var message: String? {
        switch self {
            
        case .operationFailed:
            return ErrorMessageConstant.defaultErrorMessage
        case .connectionError:
            return ErrorMessageConstant.defaultConnectionErrorMessage
        case .serviceError(let err):
            return err.errorKey
        case .error(let err):
            return err.localizedDescription
        }
    }
}

extension NetworkError {
    static func showAlert(with error: NetworkError) {
        
    }
}
