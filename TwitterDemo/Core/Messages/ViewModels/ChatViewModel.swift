//
//  ChatViewModels.swift
//  TwitterDemo
//
//  Created by Igor Kononov on 08.08.2022.
//
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestore


class ChatViewModel: ObservableObject {
    @Published var chatTexte = ""
    @Published var errorMessage = ""
    @Published var chatMessages: [ChatMessages] = []
    @Published var recentMessages: [ChatRowMessages] = []
//    let userService = UserService()
    let user: Usert?
    
    init(user: Usert?) {
        self.user = user
        feachMessages()
        fetchRecentMessages()
    }
    
    
    
    
    // сортировка сообщений
     func feachMessages() {
        guard let fromId = Auth.auth().currentUser?.uid else { return }
        
         guard let toId = user?.id else { return }
        Firestore.firestore().collection("messages")
            .document(fromId)
            .collection(toId)
            .addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else { return }
                
                self.chatMessages = documents.compactMap { document -> ChatMessages? in
                    do {
                        return try document.data(as: ChatMessages.self)
                    } catch {
                        return nil
                    }
                }
                
                
                self.chatMessages.sort { $0.timestamp.dateValue() < $1.timestamp.dateValue() }
//                print(self.recentMessages)
            }
    }
    
    func fetchRecentMessages() {
            guard let uid = Auth.auth().currentUser?.uid else { return }
//            guard let toId = user?.id else { return }

           Firestore.firestore().collection("recent_messages")
                .document(uid)
                .collection("messages")
                .addSnapshotListener { querySnapshot, error in
                    if let error = error {
                        print(error)
                        return
                    }
                    guard let documents = querySnapshot?.documents else { return }

                    self.recentMessages = documents.compactMap { document -> ChatRowMessages? in
                        
                        
                        do {
                            return try document.data(as: ChatRowMessages.self)
                        } catch {
                            return nil
                        }
                    }
//
                }
    }
    
   // отправка последнего сообщения в ChatView
    func persistRecentMessage() {
        guard let user = user else { return }

        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        guard let toId = user.id else { return }
        
       let document = Firestore.firestore().collection("recent_messages")
            .document(uid)
            .collection("messages")
            .document(toId)
        
        let data = ["timestamp": Timestamp(), "text": self.chatTexte, "fromId": uid, "toId": toId, "username": user.username, "fullname": user.fullname, "profileImageUrl": user.profileImageUrl] as [String : Any]
        
        document.setData(data) { error in
            if let error = error {
                self.errorMessage = "Filed \(error)"
                return
            }
        }
    }
    
   // отправка сообщения
    func handleChat() {
        print(chatTexte)
        guard let fromId = Auth.auth().currentUser?.uid else { return }
        
        guard let toId = user?.id else { return }
       let document = Firestore.firestore().collection("messages")
            .document(fromId)
            .collection(toId)
            .document()
        
        let messageData = ["fromId": fromId, "toId": toId, "text": self.chatTexte, "timestamp": Timestamp()] as [String : Any]
        
        document.setData(messageData) { error in
            if let error = error {
                self.errorMessage = "Filed error \(error)"
                return
            }
            self.persistRecentMessage()
            
            self.chatTexte = ""
        }
        let recipiantMessageDocument = Firestore.firestore().collection("messages")
             .document(toId)
             .collection(fromId)
             .document()
        
        recipiantMessageDocument.setData(messageData) { error in
            if let error = error {
                self.errorMessage = "Filed error \(error)"
                return
                
            }
        }
    }
}
