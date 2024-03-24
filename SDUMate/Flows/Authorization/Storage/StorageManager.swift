//
//  StorageManager.swift
//  SDUMate
//
//  Created by Damir Aliyev on 17.03.2024.
//

import UIKit
import FirebaseStorage
import PromiseKit

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
 
    func saveImage(userId: String, data: Data, completion: @escaping (Swift.Result<StorageMetadataResult, NetworkError>) -> Void) {
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
    
    func saveImage(userId: String, image: UIImage, completion: @escaping (Swift.Result<StorageMetadataResult, NetworkError>) -> Void) {
        guard let data = image.compressIfNeeded() else {
            completion(.failure(.error))
            return
        }
        return saveImage(userId: userId, data: data, completion: completion)
    }
    
    func saveImage(userId: String, data: Data) -> Promise<StorageMetadataResult> {
        return Promise { seal in
            let meta = StorageMetadata()
            meta.contentType = "image/jpeg"
            let path = "\(UUID().uuidString).jpeg"
            userReference(userId: userId).child(path).putData(data, metadata: meta) { returnedMeta, error in
                guard let returnedMeta = returnedMeta, error == nil else {
                    seal.reject(NetworkError.badServerResponse)
                    return
                }
                guard let returnedPath = returnedMeta.path, let returnedName = returnedMeta.name else {
                    seal.reject(NetworkError.badServerResponse)
                    return
                }
                let result = StorageMetadataResult(imagePath: returnedPath, imageName: returnedName)
                seal.fulfill(result)
            }
        }
    }
    
    func getImageData(userId: String, path: String, completion: @escaping (Swift.Result<Data, Error>) -> Void) {
        storage.child(path).getData(maxSize: 3 * 1024 * 1024) { result in
            completion(result)
         }
//        userReference(userId: userId).child(path).getData(maxSize: 3 * 1024 * 1024) { result in
//           completion(result)
//        }
    }
    
    func getUrlForImage(path: String, completion: @escaping (Swift.Result<URL, Error>) -> Void) {
        Storage.storage().reference(withPath: path).downloadURL { result in
            completion(result)
        }
    }
    
    func getUrlForImage(path: String) -> Promise<URL> {
        return Promise { seal in
            Storage.storage().reference(withPath: path).downloadURL { url, error in
                guard let url = url, error == nil else {
                    seal.reject(NetworkError.badServerResponse)
                    return
                }
                seal.fulfill(url)
            }
        }
    }
    
    func deleteImage(path: String, completion: @escaping ((Error?) -> Void)) {
        print("PATH", path)
        Storage.storage().reference(withPath: path).delete { error in
            completion(error)
        }
    }
    
    func deleteImage(path: String) -> Promise<Void> {
        return Promise { seal in
            Storage.storage().reference(withPath: path).delete { error in
                guard error == nil else {
                    seal.reject(error!)
                    return
                }
                seal.fulfill(())
            }
        }
    }
}
