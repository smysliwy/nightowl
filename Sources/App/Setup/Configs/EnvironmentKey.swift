enum EnvironmentKey {
    enum Project {
        static let name = "PROJECT_NAME"
        static let url = "PROJECT_URL"
    }

    enum MySQL {
        static let url = "127.0.0.1"
        static let hostname = "localhost"
        static let username = "root"
        static let password = "Mrkitty6"
        static let database = "xoc.cable.db"
    }

    enum Redis {
        static let url = "REDIS_URL"
        static let hostname = "REDIS_HOSTNAME"
        static let database = "REDIS_DATABASE"
    }

    enum Mailgun {
        static let apiKey = "MAILGUN_PASSWORD"
        static let domain = "MAILGUN_DOMAIN"
        static let region = "MAILGUN_REGION"
    }

    enum JWTKeychain {
        static let accessTokenSignerKey = "JWT_ACCESS_SIGNER_KEY"
        static let refreshTokenSignerKey = "JWT_REFRESH_SIGNER_KEY"
    }

    enum AdminPanel {
        static let signerKey = "ADMIN_PANEL_RESET_PASSWORD_SIGNER_KEY"
        static let setPasswordSignerKey = "ADMIN_PANEL_SET_PASSWORD_SIGNER_KEY"
    }

    enum Reset {
        static let signerKey = "RESET_SIGNER_KEY"
        static let setPasswordSignerKey = "RESET_SET_PASSWORD_SIGNER_KEY"
    }

    enum NodesSSO {
        static let url = "PROJECT_URL"
        static let redirectURL = "NODES_SSO_REDIRECT_URL"
        static let salt = "NODES_SSO_SALT"
    }

    enum Bugsnag {
        static let key = "BUGSNAG_API_KEY"
    }


}
