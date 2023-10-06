//
//  LeaderBoardView.swift
//  timer
//
//  Created by Aarish on 06/10/23.
//

import SwiftUI


struct LeaderboardView: View {
    struct LeaderboardItem: Identifiable {
        let id: UUID = UUID()
        let ranking: Int
        let name: String
        let time: String
    }

    let leaderboardData: [LeaderboardItem] = [
        LeaderboardItem(ranking: 1, name: "Vishal 🥇", time: "09:40:06"),
        LeaderboardItem(ranking: 2, name: "Harshit 🥈", time: "07:30:08"),
        LeaderboardItem(ranking: 3, name: "Himanshu 🥉", time: "06:25:09"),
        LeaderboardItem(ranking: 4, name: "Aarish", time: "05:40:06"),
        LeaderboardItem(ranking: 5, name: "Aryan", time: "05:30:08"),
        LeaderboardItem(ranking: 6, name: "Hrithik", time: "04:40:09"),
        // Add more leaderboard items as needed
    ]

    var body: some View {
        
            List(leaderboardData) { item in
                HStack {
                    Text("\(item.ranking)")
                        .font(.title3)
//                        .fontWeight(.bold)
                        .padding(.trailing, 10)
                    
                    Text(item.name)
                        .font(.title2)
                        .bold()
                    Spacer()
                    Text(item.time)
                        .font(.title2)
                        .foregroundColor(.secondary)
                }
                .navigationBarTitle("Leaderboard")
            }
//            .navigationBarHidden(true)
            
        
    }
}

struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView()
    }
}



