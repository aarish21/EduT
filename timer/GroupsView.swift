//
//  GroupsView.swift
//  timer
//
//  Created by Aarish on 04/10/23.
//

import SwiftUI
import Firebase
struct GroupsView: View {
    @State private var groupName = ""
    @EnvironmentObject var viewModel: AuthViewModel
    @State var groupExists = false
    @State private var addNewGroup = false
    @EnvironmentObject var groupsViewModel : GroupsViewModel
    var body: some View {
        ZStack {
            VStack {
                if groupsViewModel.groupID != "" {
                    GroupTimer()
                } else {
                    createGroup
                }
                
               
            }
            .sheet(isPresented: $addNewGroup) {
                AddNewGroup()
            }
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Button {
                        addNewGroup.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.black)
                    }
                }
                .padding()
            }
            
          
        }
        
        .onAppear {
           
        }
        
    }
    
}

struct GroupsView_Previews: PreviewProvider {
    static var previews: some View {
        GroupsView()
            .environmentObject(AuthViewModel())
            .environmentObject(GroupsViewModel())
    }
}

extension GroupsView {
   
    var createGroup: some View {
        VStack {
            Image(systemName: "person.3")
                .font(Font.system(size: 40, design: .monospaced))
                .padding()

            Spacer()

            TextField("Join with Group ID", text: $groupName)
                .autocapitalization(.none)
                .autocorrectionDisabled(true)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(.secondary, lineWidth: 0.5)
                )

            Button(action: {
                groupsViewModel.joinGroupByGroupID(groupID: groupName, userID: viewModel.userSession?.uid)
            }) {
                Text("Join Group")
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
    }
}
