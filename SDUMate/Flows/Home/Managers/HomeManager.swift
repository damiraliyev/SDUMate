//
//  HomeManager.swift
//  SDUMate
//
//  Created by Damir Aliyev on 25.03.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import PromiseKit

final class HomeManager {
    
    static let shared = HomeManager()
    private init() {}
    
    private let announcementsCollection = Firestore.firestore().collection("announcements")
    private let usersCollection = Firestore.firestore().collection("users")
    
    private let encoder: Firestore.Encoder = {
        let encoder = Firestore.Encoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
    
    func getAllAnnouncements() -> Promise<[Announcement]> {
        return Promise<[Announcement]> { seal in
            announcementsCollection.getDocuments { snapshot, error in
                guard let documents = snapshot?.documents, error == nil else {
                    seal.reject(error ?? URLError(.badServerResponse))
                    return
                }
                var announcements: [Announcement] = []
                for document in documents {
                    let announcement = Announcement(dict: document.data())
                    if !announcement.isSessionEstablished {
                        announcements.append(announcement)
                    }
                }
                seal.fulfill(announcements)
            }
        }
    }
    
    func getUser(userId: String) -> Promise<DBUser> {
        return Promise<DBUser> { seal in
            usersCollection.whereField("user_id", isEqualTo: userId).getDocuments { snapshot, error in
                guard let document = snapshot?.documents.first, error == nil else {
                    seal.reject(error ?? URLError(.badServerResponse))
                    return
                }
                if let dbUser = DBUser(dictionary: document.data()) {
                    seal.fulfill(dbUser)
                } else {
                    seal.reject(SMError.decodingError)
                }
            }
        }
    }
    
    func fetchCompleteAnnouncements() -> Promise<[Announcement]> {
        return Promise { seal in
            firstly {
                getAllAnnouncements()
            }.then { announcements -> Promise<[Announcement]> in
                let usersFetchPromises = announcements.map { announcement in
                    self.getUser(userId: announcement.announcerId).then { user in
                        var updatedAnnouncement = announcement
                        updatedAnnouncement.announcer = user
                        return Promise.value(updatedAnnouncement)
                    }
                }
                return when(fulfilled: usersFetchPromises)
            } .done { updatedAnnouncements in
                seal.fulfill(updatedAnnouncements)
            } .catch { error in
                seal.reject(error)
            }
        }
        
    }
}
