// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
public enum LoginFeatureStrings {

  public enum Welcome {
    /// Iniciar sessão
    public static let begin = LoginFeatureStrings.tr("Localizable", "welcome.begin")
    /// Sua Porto Seguro em um só lugar.
    public static let title = LoginFeatureStrings.tr("Localizable", "welcome.title")
    /// versão %@
    public static func version(_ p1: Any) -> String {
      return LoginFeatureStrings.tr("Localizable", "welcome.version", String(describing: p1))
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension LoginFeatureStrings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = LoginFeatureResources.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
// swiftlint:enable all
// swiftformat:enable all
