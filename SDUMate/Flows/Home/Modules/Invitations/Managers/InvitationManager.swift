//
//  InvitationManager.swift
//  SDUMate
//
//  Created by Damir Aliyev on 25.03.2024.
//

import Foundation
import FirebaseFirestore
import PromiseKit

final class InvitationManager {
    
    static let shared = InvitationManager()
    
    private init() {}
    
    private let invitationsCollection = Firestore.firestore().collection("invitations")
    private let usersCollection = Firestore.firestore().collection("users")
    private let announcementsCollection = Firestore.firestore().collection("announcements")
    private let sessionsCollection = Firestore.firestore().collection("sessions")
    
    private func fetchRecievedInvitations(userId: String) -> Promise<[Invitation]>{
        return Promise { seal in
            invitationsCollection.whereField("announcer_id", isEqualTo: userId).getDocuments { snapshot, error in
                guard let documents = snapshot?.documents, error == nil else {
                    seal.reject(error ?? URLError(.badServerResponse))
                    return
                }
                var invitations: [Invitation] = []
                for document in documents {
                    let invitation = Invitation(dict: document.data())
                    invitations.append(invitation)
                }
                seal.fulfill(invitations)
            }
        }
    }
    
    private func fetchSentInvitations(userId: String) -> Promise<[Invitation]>{
        return Promise { seal in
            invitationsCollection.whereField("respondent_id", isEqualTo: userId).getDocuments { snapshot, error in
                guard let documents = snapshot?.documents, error == nil else {
                    seal.reject(error ?? URLError(.badServerResponse))
                    return
                }
                var invitations: [Invitation] = []
                for document in documents {
                    let invitation = Invitation(dict: document.data())
                    invitations.append(invitation)
                }
                seal.fulfill(invitations)
            }
        }
    }
    
    private func getUser(userId: String) -> Promise<DBUser> {
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
    
    private func getAnnouncement(announcementId: String) -> Promise<Announcement> {
        return Promise { seal in
            announcementsCollection.whereField("id", isEqualTo: announcementId).getDocuments { snapshot, error in
                guard let document = snapshot?.documents.first, error == nil else {
                    seal.reject(error ?? URLError(.badServerResponse))
                    return
                }
                let announcement = Announcement(dict: document.data())
                seal.fulfill(announcement)
            }
        }
    }
    
    func fetchCompleteInvitations(userId: String) -> Promise<[Invitation]> {
        return Promise { seal in
            firstly {
                let sent = fetchSentInvitations(userId: userId)
                let received = fetchRecievedInvitations(userId: userId)
                return when(fulfilled: sent, received)
            } .then { invitations -> Promise<([Invitation])> in
                let allInvitations = invitations.0 + invitations.1
                let updatedInvitationsWithRespondent = allInvitations.map { invitation in
                    self.getUser(userId: invitation.respondentId).then { user in
                        var updatedInvitation = invitation
                        updatedInvitation.respondent = user
                        return Promise.value(updatedInvitation)
                    }
                }
                return when(fulfilled: updatedInvitationsWithRespondent)
            }.then { invitations -> Promise<[Invitation]> in
                let updatedInvitationsWithAnnouncer = invitations.map { invitation in
                    self.getUser(userId: invitation.announcerId).then { user in
                        var updatedInvitation = invitation
                        updatedInvitation.announcer = user
                        return Promise.value(updatedInvitation)
                    }
                }
                return when(fulfilled: updatedInvitationsWithAnnouncer)
            }.then { invitations -> Promise<[Invitation]> in
                let updatedWithAnnouncement = invitations.map { invitation in
                    self.getAnnouncement(announcementId: invitation.announcementId).then { announcement in
                        var updatedInvitation = invitation
                        updatedInvitation.announcement = announcement
                        return Promise.value(updatedInvitation)
                    }
                }
                return when(fulfilled: updatedWithAnnouncement)
            } .done { invitations in
                seal.fulfill(invitations)
            } .catch { error in
                seal.reject(error)
            }
        }
    }
    
    func acceptInvitation(withId id: String) -> Promise<Void> {
        return Promise { seal in
            let invitationRef = invitationsCollection.document(id)
            invitationRef.updateData(["status": InvitationStatus.accepted.rawValue]) { error in
                if let error = error {
                    seal.reject(error)
                    return
                }
                seal.fulfill(())
            }
        }
    }
    
    func rejectInvitation(withId id: String) -> Promise<Void> {
        return Promise { seal in
            let invitationRef = invitationsCollection.document(id)
            invitationRef.updateData(["status": InvitationStatus.rejected.rawValue]) { error in
                if let error = error {
                    seal.reject(error)
                    return
                }
                seal.fulfill(())
            }
        }
    }
    
    func createSession(invitation: Invitation) -> Promise<Void> {
        return Promise { seal in
            let documentRef = sessionsCollection.document()
            let session = Session(id: "", announcerId: invitation.announcerId, respondentId: invitation.respondentId, announcementId: invitation.announcementId, announceType: invitation.announcement?.type ?? .request, status: .active)
            documentRef.setData(session.makeDictionary()) { error in
                if let error = error {
                    seal.reject(error)
                } else {
                    seal.fulfill(())
                }
            }
        }
    }
    
    func establishSession(announcementId: String) -> Promise<Void> {
        return Promise { seal in
            let announcementRef = announcementsCollection.document(announcementId)
            announcementRef.updateData(["is_session_established": true, "session_established_date": Date().toString()]) { error in
                if let error = error {
                    seal.reject(error)
                    return
                }
                seal.fulfill(())
            }
        }
    }
    
    func withdrawInvitation(invitationId: String) -> Promise<Void> {
        return Promise { seal in
            let invitationRef = invitationsCollection.document(invitationId)
            invitationRef.delete { error in
                if let error = error {
                    seal.reject(error)
                    return
                }
                seal.fulfill(())
            }
        }
    }
}
