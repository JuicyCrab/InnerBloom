import SwiftUI

struct HomeTab: View {
    // State variables to manage the interaction
    @State private var showPonderQuestion = false
    @State private var showMotivationalQuotes = false
    @State private var showReligiousQuotes = false
    
    var body: some View {
        NavigationView {
            ScrollView {
            
                VStack(alignment: .leading) {
                    // Bell Icon and Profile Image (aligned on the top-left)
                    HStack {
                        Image(systemName: "bell.fill")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .foregroundColor(.gray) // Soft gray for the bell icon
                            .font(.title)
                            .padding(.trailing, 10)
                        
                        Image("ProfilePic1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70, height: 100)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                            .padding(.trailing, 20)
                    }
                    
                    // Text aligned to the left
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Welcome Home,")
                            .font(.title2)
                            .foregroundColor(.black)
                        Text("Eyasu")
                            .font(.title2)
                            .foregroundColor(.black)
                    }
                    .padding(.leading, 10)
                    .padding(.top, -80)
                  
                    // Rectangular Header (Soft Pastel Yellow)
                    Rectangle()
                        .fill(Color.orange.opacity(0.3)) // Light, soft yellow
                        .frame(height: 50)
                        .cornerRadius(20)
                        .padding(.horizontal, 80)
                        .overlay(
                            HStack {
                                Text("Today")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .padding(.leading, 120)
                                
                                Spacer()
                                
                                Text("Weekly")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .padding(.trailing, 120)
                            }
                        )
                        .padding(.top, 20)
                    
                    // 2x2 Grid Layout (Using light colors for each box)
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 20) {
                        ForEach(0..<4) { index in
                            Rectangle()
                                .fill(Color.blue.opacity(0.2)) // Light blue for each box
                                .frame(height: 130)
                                .cornerRadius(10)
                                .overlay(
                                    Text(getBoxName(for: index))
                                        .foregroundColor(.black)
                                        .font(.headline)
                                )
                        }
                    }
                    .padding(20)
                    
                    // Daily Love Section with Boxes
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Daily Love and More")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding(.leading, 20)
                        
                        // Ponder of the Day Box (Soft Green)
                        Rectangle()
                            .fill(showPonderQuestion ? Color.black : Color.green.opacity(0.2)) // Soft green
                            .frame(height: 130)
                            .cornerRadius(10)
                            .overlay(
                                VStack {
                                    if showPonderQuestion {
                                        Text("What is the most meaningful thing in your life?")
                                            .foregroundColor(.white)
                                            .font(.headline)
                                    } else {
                                        Text("Ponder of the Day")
                                            .foregroundColor(.black)
                                            .font(.headline)
                                    }
                                }
                            )
                            .onTapGesture {
                                withAnimation {
                                    showPonderQuestion.toggle()
                                }
                            }
                        
                        // Quotes Box (Soft Lavender)
                        Rectangle()
                            .fill(Color.purple.opacity(0.2)) // Light lavender
                            .frame(height: 130)
                            .cornerRadius(10)
                            .overlay(
                                VStack {
                                    Text("Quotes")
                                        .foregroundColor(.black)
                                        .font(.headline)
                                    
                                    if showMotivationalQuotes {
                                        Text("Motivational Quotes")
                                            .foregroundColor(.black)
                                            .font(.subheadline)
                                    }
                                    if showReligiousQuotes {
                                        Text("Religious Quotes")
                                            .foregroundColor(.black)
                                            .font(.subheadline)
                                    }
                                }
                            )
                            .onTapGesture {
                                withAnimation {
                                    showMotivationalQuotes.toggle()
                                    showReligiousQuotes.toggle()
                                }
                            }
                    }
                    .padding(20)
                    
                    // Section Header for Additional Stats (Neutral Gray)
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Additional Stats")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding(.leading, 20)
                        Divider()
                            .padding(.leading, 20)
                    }
                    
                    Spacer() // Push content to the top
                }
                .font(.system(size: 20, weight: .semibold, design: .default))
            }
            .overlay(
                VStack {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2)) // Light gray for the border
                        .frame(height: 2) // Border thickness
                        .edgesIgnoringSafeArea(.top)
                }
                , alignment: .top
            )
        }
    }
    
    // Helper function to return box names
    func getBoxName(for index: Int) -> String {
        switch index {
        case 0:
            return "Journal Streak"
        case 1:
            return "Available Love Sparks"
        case 2:
            return "Exercises Completed"
        case 3:
            return "More Stats"
        default:
            return ""
        }
    }
}

