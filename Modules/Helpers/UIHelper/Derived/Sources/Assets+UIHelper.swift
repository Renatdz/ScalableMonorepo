// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum UIHelperAsset {
  public enum Assets {
    public static let imagotipoPortoHorizontal = UIHelperImages(name: "imagotipo_porto_horizontal")
    public static let imagotipoPortoVertical = UIHelperImages(name: "imagotipo_porto_vertical")
    public static let logotipoPorto = UIHelperImages(name: "logotipo_porto")
  }
  public enum Colors {
    public static let brandColorDarker = UIHelperColors(name: "brandColorDarker")
    public static let brandColorPrimary = UIHelperColors(name: "brandColorPrimary")
    public static let brandColorSecondary = UIHelperColors(name: "brandColorSecondary")
    public static let brandColorThird = UIHelperColors(name: "brandColorThird")
    public static let brandGradientBackgroundEnd = UIHelperColors(name: "brandGradientBackgroundEnd")
    public static let brandGradientBackgroundStart = UIHelperColors(name: "brandGradientBackgroundStart")
    public static let brandGradientEndColor02 = UIHelperColors(name: "brandGradientEndColor02")
    public static let brandGradientPrimaryStart = UIHelperColors(name: "brandGradientPrimaryStart")
    public static let brandGradientSecondaryEnd = UIHelperColors(name: "brandGradientSecondaryEnd")
    public static let brandGradientSecondaryStart = UIHelperColors(name: "brandGradientSecondaryStart")
    public static let brandGradientStartColor02 = UIHelperColors(name: "brandGradientStartColor02")
    public static let brandSupport01 = UIHelperColors(name: "brandSupport01")
    public static let brandSupport02 = UIHelperColors(name: "brandSupport02")
    public static let brandSupport03 = UIHelperColors(name: "brandSupport03")
    public static let brandSupport04 = UIHelperColors(name: "brandSupport04")
    public static let brandSupport05 = UIHelperColors(name: "brandSupport05")
    public static let brandSupport06 = UIHelperColors(name: "brandSupport06")
    public static let brandSupport07 = UIHelperColors(name: "brandSupport07")
    public static let brandSupport08 = UIHelperColors(name: "brandSupport08")
    public static let brandSupport09 = UIHelperColors(name: "brandSupport09")
    public static let brandSupport10 = UIHelperColors(name: "brandSupport10")
    public static let brandSupport11 = UIHelperColors(name: "brandSupport11")
    public static let brandSupport14 = UIHelperColors(name: "brandSupport14")
    public static let brandSupport15 = UIHelperColors(name: "brandSupport15")
    public static let brandSupport16 = UIHelperColors(name: "brandSupport16")
    public static let brandSupport17 = UIHelperColors(name: "brandSupport17")
    public static let brandSupport18 = UIHelperColors(name: "brandSupport18")
    public static let brandSupportGreen = UIHelperColors(name: "brandSupportGreen")
    public static let colorPrimaryAccentBlue = UIHelperColors(name: "colorPrimaryAccentBlue")
    public static let lightYellow = UIHelperColors(name: "lightYellow")
    public static let neutralColorBackground = UIHelperColors(name: "neutralColorBackground")
    public static let neutralColorMediumEmphasis = UIHelperColors(name: "neutralColorMediumEmphasis")
    public static let neutralColorWhite = UIHelperColors(name: "neutralColorWhite")
    public static let neutralDarkest = UIHelperColors(name: "neutralDarkest")
    public static let neutralGrey01 = UIHelperColors(name: "neutralGrey01")
    public static let neutralGrey02 = UIHelperColors(name: "neutralGrey02")
    public static let neutralGrey03 = UIHelperColors(name: "neutralGrey03")
    public static let neutralGrey04 = UIHelperColors(name: "neutralGrey04")
    public static let neutralGrey05 = UIHelperColors(name: "neutralGrey05")
    public static let neutralGrey06 = UIHelperColors(name: "neutralGrey06")
    public static let neutralGrey07 = UIHelperColors(name: "neutralGrey07")
    public static let neutralText = UIHelperColors(name: "neutralText")
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public final class UIHelperColors {
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

public extension UIHelperColors.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: UIHelperColors) {
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

public struct UIHelperImages {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Image = UIImage
  #endif

  public var image: Image {
    let bundle = UIHelperResources.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
}

public extension UIHelperImages.Image {
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the UIHelperImages.image property")
  convenience init?(asset: UIHelperImages) {
    #if os(iOS) || os(tvOS)
    let bundle = UIHelperResources.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

// swiftlint:enable all
// swiftformat:enable all
