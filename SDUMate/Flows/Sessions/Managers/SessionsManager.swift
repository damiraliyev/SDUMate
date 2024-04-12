//
//  SessionsManager.swift
//  SDUMate
//
//  Created by Damir Aliyev on 07.04.2024.
//

import Foundation
import PromiseKit
import FirebaseFirestore

final class SessionsManager {
    
    static let shared = SessionsManager()
    private init() {}
    
    private let sessionsCollection = Firestore.firestore().collection("sessions")
    private let usersCollection = Firestore.firestore().collection("users")
    private let announcementsCollection = Firestore.firestore().collection("announcements")
    
    private func fetchSessionsFromFirebase() -> Promise<[Session]> {
        return Promise { seal in
            var sessions: [Session] = []
            sessionsCollection.getDocuments { snapshot, error in
                guard let documents = snapshot?.documents, error == nil else {
                    seal.reject(error ?? URLError(.badServerResponse))
                    return
                }
                for document in documents {
                    guard let session = try? Session.decodeSession(from: document.data()) else {
                        continue
                    }
                    sessions.append(session)
                }
                seal.fulfill(sessions)
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
    
    func fetchCompleteSessions() -> Promise<[Session]> {
        return Promise { seal in
            firstly {
                fetchSessionsFromFirebase()
            }.then { sessions -> Promise<[Session]> in
                let updatedSessionsWithRespondent = sessions.map { session in
                    self.getUser(userId: session.respondentId).then { user in
                        var updatedSession = session
                        updatedSession.respondent = user
                        return Promise.value(updatedSession)
                    }
                }
                return when(fulfilled: updatedSessionsWithRespondent)
            }.then { sessions -> Promise<[Session]> in
                let updatedSessionsWithAnnouncer = sessions.map { session in
                    self.getUser(userId: session.announcerId).then { user in
                        var updatedSession = session
                        updatedSession.announcer = user
                        return Promise.value(updatedSession)
                    }
                }
                return when(fulfilled: updatedSessionsWithAnnouncer)
            }.then { sessions -> Promise<[Session]> in
                let updatedSessionWithAnnouncement = sessions.map { session in
                    self.getAnnouncement(announcementId: session.announcementId).then { announcement in
                        var updatedSession = session
                        updatedSession.announcement = announcement
                        return Promise.value(updatedSession)
                    }
                }
                return when(fulfilled: updatedSessionWithAnnouncement)
            }.done { sessions in
                seal.fulfill(sessions)
            }.catch { error in
                seal.reject(error)
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
    
    func endSession(sessionId: String, newStatus: SessionStatus) -> Promise<Void> {
        return Promise { seal in
            sessionsCollection.document(sessionId).updateData(["status": newStatus.rawValue]) { error in
                if let error = error {
                    seal.reject(error)
                }
                seal.fulfill(())
            }
        }
    }
}
