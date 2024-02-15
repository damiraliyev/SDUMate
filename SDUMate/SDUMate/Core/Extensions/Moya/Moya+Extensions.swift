//
//  Moya+Extensions.swift
//  BePRO
//
//  Created by Nurkanat Klimov on 04.09.2023.
//

import Foundation
import Moya

protocol PdfTargetType: TargetType {
    var fileName: String? { get }
    var localLocation: URL { get }
}

private enum Constants {
    static let downloads = "/Downloads"
}

extension PdfTargetType {
    var localLocation: URL {
        guard let name = fileName else { fatalError("fileName not provided in Api file") }
        let directory: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(Constants.downloads)
        let _name = name.replacingOccurrences(of: "/", with: "")
        let cleanedName = (_name as NSString).deletingPathExtension
        return directory.appendingPathComponent(cleanedName).appendingPathExtension(for: .pdf)
    }

    var downloadDestination: DownloadDestination {
        return { _, _ in return (localLocation, [.removePreviousFile, .createIntermediateDirectories]) }
    }
}
