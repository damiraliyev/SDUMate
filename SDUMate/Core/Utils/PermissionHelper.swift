//
//  PermissionHelper.swift
//  SDUMate
//
//  Created by Damir Aliyev on 16.03.2024.
//

import Foundation
import PhotosUI

enum MicrophoneAccessStatus {
    case grantedPreviously
    case grantedAfterwards
    case deniedAfterAskingAccess
    case deniedPreviously
}

final class PermissionsHelper {
    func requestCameraAccess(permissionCallback: @escaping ((Bool) -> Void)) {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .authorized:
            DispatchQueue.main.async {
                permissionCallback(true)
            }
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    permissionCallback(granted)
                }
            }
        default:
            DispatchQueue.main.async {
                permissionCallback(false)
            }
        }
    }
    
    func requestLibraryAccess(permissionCallback: @escaping ((Bool) -> Void)) {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            DispatchQueue.main.async {
                permissionCallback(true)
            }
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { status in
                DispatchQueue.main.async {
                    permissionCallback(status == .authorized)
                }
            }
        default:
            DispatchQueue.main.async {
                permissionCallback(false)
            }
        }
    }
    
    func requestMicrophoneAccess(permissionCallback: @escaping ((MicrophoneAccessStatus) -> Void)) {
        let status = AVAudioSession.sharedInstance().recordPermission
        switch status {
        case .undetermined:
            AVAudioSession.sharedInstance().requestRecordPermission { granted in
                if granted {
                    DispatchQueue.main.async {
                        permissionCallback(.grantedAfterwards)
                    }
                } else {
                    DispatchQueue.main.async {
                        permissionCallback(.deniedAfterAskingAccess)
                    }
                }
            }
        case .granted:
            permissionCallback(.grantedPreviously)
        case .denied:
            permissionCallback(.deniedPreviously)
        @unknown default:
            break
        }
    }
}
