import SwiftUI

struct ContentView: View {
    @State var selectedTab = 1 // Default selected tab (Calendar)
   

    var body: some View {
        NavigationView {
            TabView(selection: $selectedTab) {
                HomeTab()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                    .tag(0)
                
    
                InteractiveCalendar(safeAreaInsets: EdgeInsets())
                    .tabItem {
                        Image(systemName: "book.closed")
                        Text("Ponders")
                    }
                    .tag(1)
                
                Text("Exercises")
                    .tabItem {
                        Image(systemName: "chart.line.uptrend.xyaxis")
                        Text("Progress")
                    }
                    .tag(2)
                
                Text("Resources")
                    .tabItem {
                        Image(systemName: "heart.fill")
                        Text("resources")
                    }
                    .tag(3)
            }
            
            }
        }
    }

#Preview {
    ContentView()
}




    

