import DIServiceAPI

public struct PasswordRoute: Route {
    public static let identifier: String = "login_feature_password"
    public let cpf: String
    
    public init(cpf: String) {
        self.cpf = cpf
    }
}
