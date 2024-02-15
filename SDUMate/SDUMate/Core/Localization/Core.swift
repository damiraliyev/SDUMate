// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum CoreL10n {
  /// %@ requested to change of the task deadline from %@ to %@
  internal static func changeDeadlineFromTo(_ p1: Any, _ p2: Any, _ p3: Any) -> String {
    return CoreL10n.tr("Core", "%@ changeDeadline from %@ to %@", String(describing: p1), String(describing: p2), String(describing: p3), fallback: "%@ requested to change of the task deadline from %@ to %@")
  }
  /// Apply
  internal static var apply: String { CoreL10n.tr("Core", "Apply", fallback: "Apply") }
  /// Approve
  internal static var approve: String { CoreL10n.tr("Core", "Approve", fallback: "Approve") }
  /// Are you sure, you want to stop downloading?
  internal static var areYouSureYouWantToStopDownloading: String { CoreL10n.tr("Core", "Are you sure, you want to stop downloading?", fallback: "Are you sure, you want to stop downloading?") }
  /// Localizable.strings
  ///   BePRO
  /// 
  ///   Created by Yessenali Zhanaidar on 20.07.2023.
  internal static var attention: String { CoreL10n.tr("Core", "Attention", fallback: "Attention") }
  /// Cancel
  internal static var cancel: String { CoreL10n.tr("Core", "Cancel", fallback: "Cancel") }
  /// Check your internet connection and try again
  internal static var checkInternet: String { CoreL10n.tr("Core", "checkInternet", fallback: "Check your internet connection and try again") }
  /// Delete
  internal static var delete: String { CoreL10n.tr("Core", "Delete", fallback: "Delete") }
  /// Do you want to finish the day?
  internal static var doYouWantToFinishTheDay: String { CoreL10n.tr("Core", "Do you want to finish the day?", fallback: "Do you want to finish the day?") }
  /// Done
  internal static var done: String { CoreL10n.tr("Core", "Done", fallback: "Done") }
  /// Error
  internal static var error: String { CoreL10n.tr("Core", "Error", fallback: "Error") }
  /// Error occurred while processing
  internal static var errorOccurredWhileProcessing: String { CoreL10n.tr("Core", "Error occurred while processing", fallback: "Error occurred while processing") }
  /// No
  internal static var no: String { CoreL10n.tr("Core", "No", fallback: "No") }
  /// No internet connection
  internal static var noInternet: String { CoreL10n.tr("Core", "no internet", fallback: "No internet connection") }
  /// OK
  internal static var ok: String { CoreL10n.tr("Core", "OK", fallback: "OK") }
  /// PDF download failed
  internal static var pdfDownloadFailed: String { CoreL10n.tr("Core", "PDF download failed", fallback: "PDF download failed") }
  /// Please, wait
  internal static var pleaseWait: String { CoreL10n.tr("Core", "Please, wait", fallback: "Please, wait") }
  /// Something went wrong while recording, please try again later!
  internal static var recordError: String { CoreL10n.tr("Core", "recordError", fallback: "Something went wrong while recording, please try again later!") }
  /// Reject
  internal static var reject: String { CoreL10n.tr("Core", "Reject", fallback: "Reject") }
  /// Retry
  internal static var retry: String { CoreL10n.tr("Core", "Retry", fallback: "Retry") }
  /// Save
  internal static var save: String { CoreL10n.tr("Core", "Save", fallback: "Save") }
  /// Settings
  internal static var settings: String { CoreL10n.tr("Core", "Settings", fallback: "Settings") }
  /// Something went wrong, try again please
  internal static var somethingWentWrongTryAgainPlease: String { CoreL10n.tr("Core", "Something went wrong, try again please", fallback: "Something went wrong, try again please") }
  /// The reason for the refusal
  internal static var theReasonForTheRefusal: String { CoreL10n.tr("Core", "The reason for the refusal", fallback: "The reason for the refusal") }
  /// Try again
  internal static var tryAgain: String { CoreL10n.tr("Core", "Try again", fallback: "Try again") }
  /// User data not found
  internal static var userDataNotFound: String { CoreL10n.tr("Core", "User data not found", fallback: "User data not found") }
  /// Write the reason why you want to refuse
  internal static var writeTheReasonWhyYouWantToRefuse: String { CoreL10n.tr("Core", "Write the reason why you want to refuse", fallback: "Write the reason why you want to refuse") }
  /// Yes
  internal static var yes: String { CoreL10n.tr("Core", "Yes", fallback: "Yes") }
  /// You have successfully completed the day!
  internal static var youHaveSuccessfullyCompletedTheDay: String { CoreL10n.tr("Core", "You have successfully completed the day!", fallback: "You have successfully completed the day!") }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension CoreL10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    // Custom Setup
    if 
       let path = Bundle.main.path(forResource: UserSettings().appLanguage.fileName, ofType: "lproj"),
       let bundle = Bundle(path: path)
       {
            let format = bundle.localizedString(forKey: key, value: value, table: table)
            return String(format: format, arguments: args)
       }
    // Default Setup
    let format = Bundle.main.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

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
