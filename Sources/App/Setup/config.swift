import AdminPanel
import Bugsnag
import FluentMySQL
import JWTKeychain
import Leaf
import NMeta
import NodesSSO
import Paginator
import Redis
import Reset
import Sugar
import Vapor

extension AdminPanelConfig where U == AdminPanelUser {
    static func current(_ environment: Environment) -> AdminPanelConfig<AdminPanelUser> {
        return AdminPanelConfig(
            name: ProjectConfig.current.name,
            baseURL: ProjectConfig.current.url,
            views: AdminPanelViews(
                login: AdminPanelViews.Login(index: ViewPath.AdminPanel.Login.index),
                dashboard: AdminPanelViews.Dashboard(index: ViewPath.AdminPanel.Dashboard.index)
            ),
            sidebarMenuPathGenerator: { role in
                guard let role = role else { return "" }
                switch role {
                case .superAdmin: return ViewPath.AdminPanel.Layout.Sidebars.superAdmin
                case .admin: return ViewPath.AdminPanel.Layout.Sidebars.admin
                case .user: return ViewPath.AdminPanel.Layout.Sidebars.user
                }
            },
            resetSigner: .hs256(
                key: env(EnvironmentKey.AdminPanel.signerKey, "secret-reset-admin")),
            environment: environment
        )
    }
}

extension BugsnagConfig {
    static func current(_ environment: Environment) -> BugsnagConfig {
        return BugsnagConfig(
            apiKey: env(EnvironmentKey.Bugsnag.key, ""),
            releaseStage: environment.name
        )
    }
}

extension CORSMiddleware.Configuration {
    static var current: CORSMiddleware.Configuration {
        return CORSMiddleware.Configuration(
            allowedOrigin: .all,
            allowedMethods: [.GET, .POST, .PUT, .OPTIONS, .DELETE, .PATCH],
            allowedHeaders: [
                .accept,
                .accessControlAllowOrigin,
                .authorization,
                .contentType,
                .origin,
                .userAgent,
                .xRequestedWith,
                HTTPHeaderName(NMetaConfig.current.headerKey)
            ]
        )
    }
}



extension MySQLDatabaseConfig {
    static var current: MySQLDatabaseConfig {
        guard
            let url = env(EnvironmentKey.MySQL.url),
            let config = try? MySQLDatabaseConfig(url: url)
        else {
            return MySQLDatabaseConfig(
                hostname: env(EnvironmentKey.MySQL.hostname, "127.0.0.1"),
                username: env(EnvironmentKey.MySQL.username, "root"),
                password: env(EnvironmentKey.MySQL.password, "Mrkitty6"),
                database: env(
                    EnvironmentKey.MySQL.database,
                    ProjectConfig.current.name.lowercased()
                )
            )
        }

        return config
    }
}

extension NMetaConfig {
    static var current: NMetaConfig {
        return NMetaConfig(
            exceptPaths: [
                // favicons
                "/apple-touch-icon-precomposed.png",
                "/apple-touch-icon.png",
                "/favicon.ico",
                "/favicons/*",

                "/AdminPanel/*",
                "/NodesSSO/*",
                "/Reset/*",
                "/admin*",
                "/api/users/reset-password/*",
                "/css/*",
                "/images/*",
                "/js/*",
                "/robots.txt"
            ]
        )
    }
}

extension NodesSSOConfig where U == AdminPanelUser {
    static func current(
        _ middlewares: [Middleware],
        environment: Environment
    ) -> NodesSSOConfig<AdminPanelUser> {
        return NodesSSOConfig(
            projectURL: ProjectConfig.current.url,
            loginPath: "/admin/sso/login",
            redirectURL: env(EnvironmentKey.NodesSSO.redirectURL, ""),
            callbackPath: "/admin/sso/callback",
            salt: env(EnvironmentKey.NodesSSO.salt, ""),
            middlewares: middlewares,
            environment: environment,
            skipSSO: environment.name == "local"
        )
    }
}

extension OffsetPaginatorConfig {
    static var current: OffsetPaginatorConfig {
        return  OffsetPaginatorConfig(
            perPage: 25,
            defaultPage: 1
        )
    }
}

extension ProjectConfig {
    static var current: ProjectConfig {
        return ProjectConfig(
            name: env(EnvironmentKey.Project.name, "NodesTemplate"),
            url: env(EnvironmentKey.Project.url, "http://localhost:8080"),
            resetPasswordEmail: .init(
                fromEmail: "no-reply@like.st",
                subject: "Reset Password"
            ),
            setPasswordEmail: .init(
                fromEmail: "no-reply@like.st",
                subject: "Set Password"
            ),
            newUserRequestEmail: .init(
                fromEmail: "no-reply@like.st",
                toEmail: "test+user@nodes.dk",
                subject: "New User Request"
            ),
            newAppUserSetPasswordSigner: ExpireableJWTSigner(
                expirationPeriod: 30.daysInSecs,
                signer: .hs256(
                    key: env(
                        EnvironmentKey.Reset.setPasswordSignerKey, "secret-reset"
                    ).convertToData()
                )
            )
        )
    }
}

extension RedisClientConfig {
    static var current: RedisClientConfig {
        guard
            let urlString = env(EnvironmentKey.Redis.url),
            let url = URL(string: urlString)
        else {
            var components = URLComponents()
            components.host = env(EnvironmentKey.Redis.hostname, "127.0.0.1")
            components.port = 6379
            components.scheme = "redis"
            components.path = "/" + env(EnvironmentKey.Redis.database, "0")

            if let url = components.url {
                return .init(url: url)
            } else {
                return .init()
            }
        }

        return RedisClientConfig(url: url)
    }
}




