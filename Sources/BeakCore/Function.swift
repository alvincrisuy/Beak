import Foundation

public struct Function: Equatable {

    public let name: String
    public let params: [Param]
    public let throwing: Bool
    public let description: String?

    public init(name: String, params: [Param] = [], throwing: Bool = false, description: String? = nil) {
        self.name = name
        self.params = params
        self.throwing = throwing
        self.description = description
    }

    public struct Param: Equatable {
        public let name: String
        public let type: ParamType
        public let optional: Bool
        public let defaultValue: String?
        public let description: String?

        public var required: Bool {
            return defaultValue == nil
        }

        public init(name: String, type: ParamType, optional: Bool = false, defaultValue: String? = nil, description: String? = nil) {
            self.name = name
            self.type = type
            self.optional = optional
            self.defaultValue = defaultValue
            self.description = description
        }

        public static func == (lhs: Param, rhs: Param) -> Bool {
            return lhs.name == rhs.name
                && lhs.type.string == rhs.type.string
                && lhs.optional == rhs.optional
                && lhs.defaultValue == rhs.defaultValue
                && lhs.description == rhs.description
        }

        public enum ParamType: CustomStringConvertible, ExpressibleByStringLiteral {
            case bool
            case int
            case string
            case other(String)

            public init(stringLiteral value: String) {
                self.init(stringLiteral: value)
            }

            public init(string: String) {
                switch string {
                case "Bool": self = .bool
                case "Int": self = .int
                case "String": self = .string
                default: self = .other(string)
                }
            }

            public var description: String {
                return string
            }

            public var string: String {
                switch self {
                case .bool: return "Bool"
                case .int: return "Int"
                case .string: return "String"
                case let .other(type): return type
                }
            }
        }

        public var optionalType: String {
            return type.string + (optional ? "?" : "")
        }
    }

    public static func == (lhs: Function, rhs: Function) -> Bool {
        return lhs.name == rhs.name
            && lhs.params == rhs.params
    }
}
