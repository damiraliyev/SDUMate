// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetColorTypeAlias = ColorAsset.Color
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal static let accentColor = ColorAsset(name: "AccentColor")
  internal static let b = ColorAsset(name: "b")
  internal static let icTabHome = ImageAsset(name: "ic_tab_home")
  internal static let icTabNew = ImageAsset(name: "ic_tab_new")
  internal static let icTabProfile = ImageAsset(name: "ic_tab_profile")
  internal static let icTabRating = ImageAsset(name: "ic_tab_rating")
  internal static let icTabSessions = ImageAsset(name: "ic_tab_sessions")
  internal static let authBackground = ImageAsset(name: "auth_background")
  internal static let eyeOpen = ImageAsset(name: "eye_open")
  internal static let gradientButton = ImageAsset(name: "gradient_button")
  internal static let ic3Dots = ImageAsset(name: "ic_3_dots")
  internal static let icAboutUs = ImageAsset(name: "ic_about_us")
  internal static let icAcceptCheckmark = ImageAsset(name: "ic_accept_checkmark")
  internal static let icArrowRight = ImageAsset(name: "ic_arrow_right")
  internal static let icArrowRightGray = ImageAsset(name: "ic_arrow_right_gray")
  internal static let icAvatarPlaceholder = ImageAsset(name: "ic_avatar_placeholder")
  internal static let icBackButton = ImageAsset(name: "ic_back_button")
  internal static let icCalendar = ImageAsset(name: "ic_calendar")
  internal static let icCheckedBox = ImageAsset(name: "ic_checked_box")
  internal static let icClock = ImageAsset(name: "ic_clock")
  internal static let icCloseX = ImageAsset(name: "ic_close_x")
  internal static let icContactsBlur = ImageAsset(name: "ic_contacts_blur")
  internal static let icDelete = ImageAsset(name: "ic_delete")
  internal static let icDocument = ImageAsset(name: "ic_document")
  internal static let icEnvelop3d = ImageAsset(name: "ic_envelop_3d")
  internal static let icEnvelope = ImageAsset(name: "ic_envelope")
  internal static let icEyeClosed = ImageAsset(name: "ic_eye_closed")
  internal static let icFilter = ImageAsset(name: "ic_filter")
  internal static let icGreenCamera = ImageAsset(name: "ic_green_camera")
  internal static let icHat = ImageAsset(name: "ic_hat")
  internal static let icHatClear = ImageAsset(name: "ic_hat_clear")
  internal static let icHeaderBell = ImageAsset(name: "ic_header_bell")
  internal static let icImagePlaceholder = ImageAsset(name: "ic_image_placeholder")
  internal static let icLock = ImageAsset(name: "ic_lock")
  internal static let icLoupe = ImageAsset(name: "ic_loupe")
  internal static let icMath = ImageAsset(name: "ic_math")
  internal static let icPaperplane = ImageAsset(name: "ic_paperplane")
  internal static let icProfileLavender = ImageAsset(name: "ic_profile_lavender")
  internal static let icQuestion = ImageAsset(name: "ic_question")
  internal static let icRangeChoice = ImageAsset(name: "ic_range_choice")
  internal static let icRejectX = ImageAsset(name: "ic_reject_x")
  internal static let icSduLogo = ImageAsset(name: "ic_sdu_logo")
  internal static let icStar = ImageAsset(name: "ic_star")
  internal static let icSuitcase = ImageAsset(name: "ic_suitcase")
  internal static let icUncheckedBox = ImageAsset(name: "ic_unchecked_box")
  internal static let icXCloseBold = ImageAsset(name: "ic_x_close_bold")
  internal static let lock = ImageAsset(name: "lock")
  internal static let person = ImageAsset(name: "person")
  internal static let sduLogo = ImageAsset(name: "sdu_logo")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal final class ColorAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  internal private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if os(iOS) || os(tvOS)
  @available(iOS 11.0, tvOS 11.0, *)
  internal func color(compatibleWith traitCollection: UITraitCollection) -> Color {
    let bundle = BundleToken.bundle
    guard let color = Color(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }
  #endif

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  internal private(set) lazy var swiftUIColor: SwiftUI.Color = {
    SwiftUI.Color(asset: self)
  }()
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

internal extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
internal extension SwiftUI.Color {
  init(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }
}
#endif

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, macOS 10.7, *)
  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if os(iOS) || os(tvOS)
  @available(iOS 8.0, tvOS 9.0, *)
  internal func image(compatibleWith traitCollection: UITraitCollection) -> Image {
    let bundle = BundleToken.bundle
    guard let result = Image(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
  #endif

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  internal var swiftUIImage: SwiftUI.Image {
    SwiftUI.Image(asset: self)
  }
  #endif
}

internal extension ImageAsset.Image {
  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, *)
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
internal extension SwiftUI.Image {
  init(asset: ImageAsset) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }

  init(asset: ImageAsset, label: Text) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: ImageAsset) {
    let bundle = BundleToken.bundle
    self.init(decorative: asset.name, bundle: bundle)
  }
}
#endif

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
