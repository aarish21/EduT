//
//  HomeScreenView.swift
//  timer
//
//  Created by Aarish on 04/10/23.
//

import SwiftUI

struct HomeScreenView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State var selection = 1
    var body: some View {
        TabView {
            TimerView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }.tag(0)
            GroupsView()
                .tabItem {
                    Label("Group", systemImage: "person.3")
                }.tag(1)
            LeaderboardView()
                .tabItem {
                    Label("Ranking", systemImage: "chart.bar.fill")
                }.tag(2)
            ExpertView()
                .tabItem {
                    Label("Expert", systemImage: "person.line.dotted.person")
                }.tag(3)
            
        }
        .navigationBarTitle(selection == 0 ? "" : (selection == 1 ? "" : "Leaderboard"))
            
        .toolbar {
            Button {
                viewModel.signOut()
            } label: {
                Text("Logout")
                    .foregroundColor(.white)
            }
        }
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
            .environmentObject(AuthViewModel())
    }
}
