//
//  ExpertView.swift
//  timer
//
//  Created by Aarish on 06/10/23.
//

import SwiftUI

struct ExpertView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Experts")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.trailing)
                    .foregroundColor(.secondary)
               
                Spacer()
                
            }
            .padding(.top,40)
            .padding(.horizontal,30)
            LazyVGrid(columns: [GridItem(), GridItem()]) {
                CustomGroup(count: "Harshit Jha", label: "DSA")
                CustomGroup(count: "Himanshu Shukla", label: "OS")
                CustomGroup(count: "Vishal Jha", label: "Aptitude")
                
            }.padding()
            Spacer()
        }
    }
}

struct ExpertView_Previews: PreviewProvider {
    static var previews: some View {
        ExpertView()
    }
}
