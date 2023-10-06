//
//  UsersModel.swift
//  timer
//
//  Created by Aarish on 04/10/23.
//

import Foundation
import Firebase
struct User {
    var name: String
    var timer: Double
}

struct Group {
    var groupName: String
    var users: [User]
}

class GroupsViewModel: ObservableObject {
    
    @Published var groupID: String?
    @Published var timeElapsed: TimeInterval = 0
    init() {
        groupID = ""
    }
    func createChatGroup(groupName: String, memberUserIDs: [String]) {
        // Get a reference to the Firebase Realtime Database
        let ref = Database.database().reference()

        // Create a new group node with a unique ID
        let newGroupRef = ref.child("groups").childByAutoId()
        guard let keyValue = newGroupRef.key else {
            print("Failed to obtain group ID.")
            return
        }

        // Set the group name
        newGroupRef.child("groupName").setValue(groupName)

        // Add members to the group in Realtime Database
        for userID in memberUserIDs {
            newGroupRef.child("members").child(userID).setValue(true) { (error, _) in
                if let error = error {
                    print("Error adding member to Realtime Database: \(error.localizedDescription)")
                } else {
                    print("Member added to Realtime Database successfully.")
                }
            }
            self.groupID = keyValue
            // Update user data in Firestore
            Firestore.firestore().collection("users").document(userID).updateData(["groupID": keyValue]) { (error) in
                if let error = error {
                    print("Error updating user data in Firestore: \(error.localizedDescription)")
                } else {
                    print("User data updated in Firestore successfully.")
                }
            }
        }
    }

    
    func fetchGroupIDForCurrentUser(userID: String?, completion: @escaping (String?) -> Void) {
        guard let userId = userID else { return }
        let firestoreDB = Firestore.firestore()
        let userDocRef = firestoreDB.collection("users").document(userID!)

        userDocRef.getDocument { (document, error) in
            if let error = error {
                print("Error fetching user data from Firestore: \(error.localizedDescription)")
                completion(nil)
            } else if let document = document, document.exists {
                if let groupID = document.data()?["groupID"] as? String {
                    completion(groupID)
                } else {
                    // User data doesn't contain a group ID
                    completion("")
                }
            } else {
                // User document doesn't exist
                completion("")
            }
        }
    }
    func updateTimeElapsed(newTimeElapsed: TimeInterval,userID: String?) {
        guard let userID = userID else {return}
        if groupID == "" {
            return
        }
        self.timeElapsed = newTimeElapsed
//        print(groupID)
           // Update the Realtime Database with the new timeElapsed value
        
        let ref = Database.database().reference()
        let groupRef = ref.child("groups").child(groupID!).child("members")
        groupRef.child(userID).setValue(newTimeElapsed.magnitude) { error,_  in
            if let error = error {
                print("there is error in updating \(error.localizedDescription)")
            } else {
                print("success")
            }
        }
        print(newTimeElapsed)
       }
    func observeTimeElapsedForAllMembers(completion: @escaping ([String: TimeInterval]) -> Void) {
//            guard let userId = userID else { return }
            guard let groupID = groupID else {
                completion([:])
                return
            }

            let ref = Database.database().reference()
        let groupRef = ref.child("groups").child(groupID).child("members")

            groupRef.observe(.value) { snapshot in
                guard let value = snapshot.value as? [String: Double] else {
                    completion(["":0])
                    return
                }
                completion(value)
            }
        }
    func fetchGroupData(groupID: String, completion: @escaping ([String: Any]) -> Void) {
            let ref = Database.database().reference()
            let groupRef = ref.child("groups").child(groupID)
            
            groupRef.observeSingleEvent(of: .value) { snapshot in
                if let value = snapshot.value as? [String: Any] {
                    completion(value)
                } else {
                    // Handle error or no data
                    completion([:])
                }
            }
        }
    func joinGroupByGroupID(groupID: String?, userID: String?){
        guard let userID = userID else { return }
        guard let groupID = groupID else { return }
        let ref = Database.database().reference()
        let groupRef = ref.child("groups").child(groupID).child("members")
        groupRef.observeSingleEvent(of: .value) { snapshot in
            if snapshot.exists() {
                groupRef.child(userID).setValue(0) { (error, result) in
                      if let error = error {
                          print("Error adding data: \(error)")
                      } else {
                          print("Data added successfully to group \(result)")
                          self.groupID = groupID
                      }
                  }
            } else {
                print("Group with ID \(groupID) does not exist.")
            }
        }
        
        Firestore.firestore().collection("users").document(userID).updateData(["groupID": groupID]) { (error) in
            if let error = error {
                print("Error updating user data in Firestore: \(error.localizedDescription)")
            } else {
                print("User data updated in Firestore successfully.")
            }
        }
      
    }

}
