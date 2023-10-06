//
//  GroupTimer.swift
//  timer
//
//  Created by Aarish on 04/10/23.
//
struct CustomGroup:View {
   
    var count = "00:00:00"
    var label = "Aarish"
    var body: some View{
        VStack{
            GroupBox(label:
                        HStack{
                            
                            Text(count)
                                .foregroundColor(.gray)
                                .font(Font.system(size: 28, design: .monospaced))
                                .fontWeight(.bold)
                        }
            ){
                VStack{
                    Text("")
                    HStack{
                        Text(label)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .fontWeight(.semibold)
                            .lineLimit(1)
                        
                    }
                }
            }.cornerRadius(15)
                
            
        }
    }
}
import SwiftUI
struct CopyableTextField: View {
    let text: String
    @State private var isCopied = false

    var body: some View {
        HStack {
            Text(text)
                .padding(.horizontal)
                .onTapGesture {
                    UIPasteboard.general.string = text
                    isCopied.toggle()
                }
            
            if isCopied {
                Text("Copied")
                    .foregroundColor(.green)
            }
        }
        .background(Color.secondary.opacity(0.2))
        .cornerRadius(10)
    }
}
struct GroupTimer: View {
    @EnvironmentObject var groupsViewModel: GroupsViewModel
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var userTimes: [String: Double] = [:]
    @State private var groupID = ""
    @State private var timeElapsed: Double = 0
    var formattedTime: String {
        let hours = Int(timeElapsed) / 3600
        let minutes = Int(timeElapsed) / 60 % 60
        let seconds = Int(timeElapsed) % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    var body: some View {
        ScrollView {
            CopyableTextField(text: groupsViewModel.groupID ?? "No group")
                .padding()
            LazyVGrid(columns: [GridItem(), GridItem()]) {
                ForEach(userTimes.sorted(by: { $0.key < $1.key }), id: \.key) { (userID, timeElapsed) in
                    
                    CustomGroup(count: formattedTime(timeElapsed: timeElapsed), label: userID)
                }
            }
            .padding()
//
//            }
        }
        .onAppear {
            groupsViewModel.observeTimeElapsedForAllMembers() { userTimes in
                self.userTimes = userTimes
//
            }
        }
    }
    func formattedTime(timeElapsed: Double) -> String {
        let hours = Int(timeElapsed) / 3600
        let minutes = Int(timeElapsed) / 60 % 60
        let seconds = Int(timeElapsed) % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}

struct GroupTimer_Previews: PreviewProvider {
    static var previews: some View {
        GroupTimer()
            .environmentObject(GroupsViewModel())
            .environmentObject(AuthViewModel())
    }
}
