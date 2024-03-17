//
//  StorageManager.swift
//  SDUMate
//
//  Created by Damir Aliyev on 17.03.2024.
//

import UIKit
import FirebaseStorage

struct StorageMetadataResult: Codable {
    let imagePath: String
    let imageName: String
}

final class StorageManager {
    
    static let shared = StorageManager()
    private init() {}
    
    private let storage = Storage.storage().reference()
    
    private var imagesReference: StorageReference {
        storage.child("images")
    }
    
    private func userReference(userId: String) -> StorageReference {
        storage.child("users").child(userId)
    }
 
    func saveImage(userId: String, data: Data, completion: @escaping (Result<StorageMetadataResult, NetworkError>) -> Void) {
        let meta = StorageMetadata()
        meta.contentType = "image/jpeg"
        let path = "\(UUID().uuidString).jpeg"
        userReference(userId: userId).child(path).putData(data, metadata: meta) { returnedMeta, error in
            guard let returnedMeta = returnedMeta, error == nil else {
                completion(.failure(.badServerResponse))
                return
            }
            guard let returnedPath = returnedMeta.path, let returnedName = returnedMeta.name else {
                completion(.failure(.badServerResponse))
                return
            }
            let result = StorageMetadataResult(imagePath: returnedPath, imageName: returnedName)
            completion(.success(result))
        }
    }
    
    func saveImage(userId: String, image: UIImage, completion: @escaping (Result<StorageMetadataResult, NetworkError>) -> Void) {
        guard let data = image.compressIfNeeded() else {
            completion(.failure(.error))
            return
        }
        return saveImage(userId: userId, data: data, completion: completion)
    }
}
