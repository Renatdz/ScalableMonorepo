// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
public typealias AssetColorTypeAlias = ColorAsset.Color

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum Colors {
  public static let brandColorDarker = ColorAsset(name: "brandColorDarker")
  public static let brandColorPrimary = ColorAsset(name: "brandColorPrimary")
  public static let brandColorSecondary = ColorAsset(name: "brandColorSecondary")
  public static let brandColorThird = ColorAsset(name: "brandColorThird")
  public static let brandGradientBackgroundEnd = ColorAsset(name: "brandGradientBackgroundEnd")
  public static let brandGradientBackgroundStart = ColorAsset(name: "brandGradientBackgroundStart")
  public static let brandGradientEndColor02 = ColorAsset(name: "brandGradientEndColor02")
  public static let brandGradientPrimaryStart = ColorAsset(name: "brandGradientPrimaryStart")
  public static let brandGradientSecondaryEnd = ColorAsset(name: "brandGradientSecondaryEnd")
  public static let brandGradientSecondaryStart = ColorAsset(name: "brandGradientSecondaryStart")
  public static let brandGradientStartColor02 = ColorAsset(name: "brandGradientStartColor02")
  public static let brandSupport01 = ColorAsset(name: "brandSupport01")
  public static let brandSupport02 = ColorAsset(name: "brandSupport02")
  public static let brandSupport03 = ColorAsset(name: "brandSupport03")
  public static let brandSupport04 = ColorAsset(name: "brandSupport04")
  public static let brandSupport05 = ColorAsset(name: "brandSupport05")
  public static let brandSupport06 = ColorAsset(name: "brandSupport06")
  public static let brandSupport07 = ColorAsset(name: "brandSupport07")
  public static let brandSupport08 = ColorAsset(name: "brandSupport08")
  public static let brandSupport09 = ColorAsset(name: "brandSupport09")
  public static let brandSupport10 = ColorAsset(name: "brandSupport10")
  public static let brandSupport11 = ColorAsset(name: "brandSupport11")
  public static let brandSupport14 = ColorAsset(name: "brandSupport14")
  public static let brandSupport15 = ColorAsset(name: "brandSupport15")
  public static let brandSupport16 = ColorAsset(name: "brandSupport16")
  public static let brandSupport17 = ColorAsset(name: "brandSupport17")
  public static let brandSupport18 = ColorAsset(name: "brandSupport18")
  public static let brandSupportGreen = ColorAsset(name: "brandSupportGreen")
  public static let colorPrimaryAccentBlue = ColorAsset(name: "colorPrimaryAccentBlue")
  public static let lightYellow = ColorAsset(name: "lightYellow")
  public static let neutralColorBackground = ColorAsset(name: "neutralColorBackground")
  public static let neutralColorMediumEmphasis = ColorAsset(name: "neutralColorMediumEmphasis")
  public static let neutralColorWhite = ColorAsset(name: "neutralColorWhite")
  public static let neutralDarkest = ColorAsset(name: "neutralDarkest")
  public static let neutralGrey01 = ColorAsset(name: "neutralGrey01")
  public static let neutralGrey02 = ColorAsset(name: "neutralGrey02")
  public static let neutralGrey03 = ColorAsset(name: "neutralGrey03")
  public static let neutralGrey04 = ColorAsset(name: "neutralGrey04")
  public static let neutralGrey05 = ColorAsset(name: "neutralGrey05")
  public static let neutralGrey06 = ColorAsset(name: "neutralGrey06")
  public static let neutralGrey07 = ColorAsset(name: "neutralGrey07")
  public static let neutralText = ColorAsset(name: "neutralText")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public final class ColorAsset {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  public private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  fileprivate init(name: String) {
    self.name = name
  }
}

public extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = UIHelperResources.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}
