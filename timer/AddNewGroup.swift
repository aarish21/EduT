//
//  AddNewGroup.swift
//  timer
//
//  Created by Aarish on 05/10/23.
//

import SwiftUI

struct AddNewGroup: View {
    @State private var groupName = ""
    @EnvironmentObject var viewModel: AuthViewModel
    @State var groupExists = false
    @EnvironmentObject var groupsViewModel : GroupsViewModel
    var body: some View {
        VStack {
            Text("Create New Group")
                .font(Font.system(size: 30, design: .monospaced))
                
            TextField("Group Name", text: $groupName)
                .autocapitalization(.none)
                .autocorrectionDisabled(true)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(.secondary, lineWidth: 0.5)
                )
            
            
            Button(action: {
                groupsViewModel.createChatGroup(groupName: "\(groupName)", memberUserIDs: ["\( viewModel.userSession!.uid)"])
            }) {
                Text("Create New Group")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    .cornerRadius(10)
            }
            .padding(.top)
            Spacer()
        }
        .padding()
        .padding(.top,100)
    }
}

struct AddNewGroup_Previews: PreviewProvider {
    static var previews: some View {
        AddNewGroup()
    }
}
