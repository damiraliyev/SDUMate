//
//  AnnouncementDetailsManager.swift
//  SDUMate
//
//  Created by Damir Aliyev on 25.03.2024.
//

import Foundation
import FirebaseFirestore
import PromiseKit

final class AnnouncementDetailsManager {
    
    static let shared = AnnouncementDetailsManager()
    
    private init() {}
    
    private let invitationsCollection = Firestore.firestore().collection("invitations")
    
    func sendInvitation(invitation: Invitation) -> Promise<Void> {
        return Promise<Void> { seal in
            invitationsCollection.addDocument(data: invitation.makeDictionary()) { error in
                guard error == nil else {
                    seal.reject(error!)
                    return
                }
                seal.fulfill(())
            }
        }
    }
}
