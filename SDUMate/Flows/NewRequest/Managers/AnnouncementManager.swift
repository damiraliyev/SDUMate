//
//  AnnouncementManager.swift
//  SDUMate
//
//  Created by Damir Aliyev on 04.04.2024.
//

import UIKit
import FirebaseFirestore
import PromiseKit

final class AnnouncementManager {
    static let shared = AnnouncementManager()
    
    private init() {}
    
    private let announcementsCollection = Firestore.firestore().collection("announcements")
    
    func post(announcement: Announcement) -> Promise<Void> {
        var data = announcement.makeDictionary()
        return Promise { seal in
            let docRef = announcementsCollection.document()
            data["id"] = docRef.documentID
            docRef.setData(data) { error in
                if let error = error {
                    seal.reject(error)
                }
                seal.fulfill(())
            }
        }
    }
}
