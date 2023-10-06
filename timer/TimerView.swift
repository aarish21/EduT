//import SwiftUI
//
import SwiftUI


struct TimerView: View {
    @State private var timeElapsed: TimeInterval = 0
    @State private var isRunning = false
    @State private var timer: Timer?
    @EnvironmentObject var groupsViewModel : GroupsViewModel
    @EnvironmentObject var viewModel : AuthViewModel
    var formattedTime: String {
        let hours = Int(timeElapsed) / 3600
        let minutes = Int(timeElapsed) / 60 % 60
        let seconds = Int(timeElapsed) % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }

    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text(formattedTime) // Display the formatted time
                        .font(Font.system(size: 50, design: .monospaced))
                        .padding()
                    
                    Button(action: startStopwatch) {
                        Image(systemName: isRunning ? "pause.circle.fill" : "play.circle.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.white)
                    }
                }
                .padding()
                Spacer()
                HStack {
                    Text("Subjects")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.trailing)
                        .foregroundColor(.secondary)
                   
                    Spacer()
                    Button {
                        
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(.black)
                    }
                }
                .padding(.horizontal,30)
                LazyVGrid(columns: [GridItem(), GridItem()]) {
                    CustomGroup(count: "01:35:08", label: "DSA")
                    CustomGroup(count: "00:30:57", label: "OS")
                    CustomGroup(count: "00:45:50", label: "DBMS")
                    CustomGroup(count: "01:00:07", label: "OOPS")
                    CustomGroup(count: "02:30:10", label: "Aptitude")
                }.padding()
                
                Form {
                    Section(header: Text("Tools")) {
                        NavigationLink("Your Notes", destination: Text("Notes"))
                        NavigationLink("Study  Material", destination: Text("Notes"))
                        NavigationLink("Analytics", destination: Text("Notes"))
                    }
                    
                    
                }.frame(height: 200)
//                .scrollContentBackground(.hidden)
//                .listStyle(PlainListStyle())
//                .background(Color.white)
                
            }
        }
        
    }

    func startStopwatch() {
        if isRunning {
            timer?.invalidate()
        } else {
            timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                timeElapsed += 0.1
                groupsViewModel.updateTimeElapsed(newTimeElapsed: timeElapsed, userID: viewModel.userSession!.uid)
            }
        }
        isRunning.toggle()
    }

}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
