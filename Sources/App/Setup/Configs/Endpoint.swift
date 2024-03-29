import AdminPanel
import JWTKeychain
import Reset

struct Endpoint {
    enum API {}
    enum Backend {}
}

// MARK: API

extension Endpoint.API {
    private static let api = "/api"

    enum Users {
        private static let users = api + "/users"
        static let login = users + "/login"
        static let me = users + "/me"
        static let register = users
        static let token = users + "/token"
        static let update = users + "/me"

        
    }
}

// MARK: Backend

extension Endpoint.Backend {
    private static let backend = "/admin"
    // Add your backend endpoints here
}

// MARK: JWTKeychain

extension JWTKeychainEndpoints {
    static var apiPrefixed: JWTKeychainEndpoints {
        return .init(
            login: Endpoint.API.Users.login,
            me: Endpoint.API.Users.me,
            register: Endpoint.API.Users.register,
            token: Endpoint.API.Users.token,
            update: Endpoint.API.Users.update
        )
    }
}

// MARK: Reset


