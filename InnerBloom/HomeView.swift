import SwiftUI

struct HomeView: View {
    let motivationalQuotes = [
        "Believe in yourself and all that you are.",
        "The only way to do great work is to love what you do.",
        "Success is not the key to happiness. Happiness is the key to success.",
        "The best way to predict the future is to create it."
    ]
    
    let religiousQuotes = [
        "Christian": "Faith is taking the first step even when you don't see the whole staircase.",
        "Islam": "With God, all things are possible.",
        "Judaism": "Trust in the Lord with all your heart.",
    ]
    
    let randomQuestions = [
        "What are you grateful for today?",
        "What is one thing you want to accomplish this week?",
        "How do you define success?",
        "What motivates you to keep going?"
    ]
    
    @State private var randomQuestion: String = "What are you grateful for today?"
    @State private var displayedQuote: String? = nil
    @State private var selectedReligion: String? = nil
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Scrollable Content
                ScrollView {
                    VStack(spacing: 25) {
                        // Profile Image and Greeting Section
                        HStack {
                            VStack(alignment: .leading, spacing: 20) {
                                Image("ProfilePic1")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 70, height: 100)
                                    .clipShape(Circle())
                                    .shadow(radius: 5)
                                
                                Text("Good morning, Eyasu")
                                    .font(.system(size: 24, weight: .semibold))
                                    .foregroundColor(.black)
                                    .padding(.top, -10)
                                
                                Text("Welcome Back")
                                    .font(.system(size: 17, weight: .regular))
                                    .foregroundStyle(.secondary)
                                    .offset(x: 20, y: -15)
                            }
                            .padding(.leading, 20)
                            
                            Spacer()
                            
                            HStack {
                                Button(action: {
                                    // Add action for settings
                                }) {
                                    Image(systemName: "gearshape.fill")
                                        .foregroundColor(.black)
                                        .font(.title)
                                }
                                
                                Button(action: {
                                    // Add action for notifications
                                }) {
                                    Image(systemName: "bell.fill")
                                        .foregroundColor(.black)
                                        .font(.title)
                                }
                            }
                            .padding(.trailing, 20)
                        }
                        
                        // Calendar Section
                        SectionHeader(title: "Your Calendar")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        CalendarView() // Embedding the CalendarView here
                            .frame(height: 300) // Adjust height if needed
                        
                        // Today's Ponder Section
                        VStack {
                            ZStack {
                                Rectangle()
                                    .fill(Color.yellow)
                                    .frame(width: 370, height: 80)
                                    .cornerRadius(20)
                                
                                Text("Today's Ponder")
                                    .font(.system(size: 22))
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                            }
                            
                            ZStack {
                                Rectangle()
                                    .fill(Color.white)
                                    .frame(width: 370, height: 80)
                                    .overlay(
                                        Rectangle()
                                            .stroke(Color.yellow, lineWidth: 4)
                                            .cornerRadius(20)
                                    )
                                
                                Text(randomQuestion)
                                    .foregroundColor(.black)
                                    .font(.system(size: 16))
                                    .lineLimit(3)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 10)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .padding(.top, -20)
                            
                            Button(action: {
                                randomQuestion = randomQuestions.randomElement() ?? "What are you grateful for today?"
                            }) {
                                Text("Get a New Question")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.black)
                                    .cornerRadius(15)
                                    .shadow(radius: 5)
                            }
                            .padding(.top, 20)
                        }
                        
                        // Motivational and Religious Quotes Sections
                        MotivationalQuoteSection(displayedQuote: $displayedQuote, quotes: motivationalQuotes)
                        
                        ReligiousQuoteSection(
                            religiousQuotes: religiousQuotes,
                            selectedReligion: $selectedReligion
                        )
                    }
                    .padding(.bottom, 100)
                }
                .navigationTitle("")
                .navigationBarHidden(true)
            }
        }
    }
}

struct SectionHeader: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.title2)
            .fontWeight(.bold)
            .foregroundColor(.black)
            .padding(.horizontal, 20)
            .padding(.top, 30)
    }
}

struct MotivationalQuoteSection: View {
    @Binding var displayedQuote: String?
    let quotes: [String]
    
    var body: some View {
        SectionHeader(title: "Daily Motivational Quote")
            .frame(maxWidth: .infinity, alignment: .leading)
        
        ZStack {
            Rectangle()
                .fill(Color.yellow)
                .frame(width: 370, height: 150)
                .cornerRadius(20)
                .shadow(radius: 5)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.yellow, lineWidth: 3)
                )
            
            VStack(spacing: 15) {
                if let quote = displayedQuote {
                    Text(quote)
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                        .transition(.opacity)
                } else {
                    Text("Press the button below to get inspired!")
                        .font(.body)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                }
            }
            .frame(width: 350, height: 130, alignment: .center)
        }
        
        Button(action: {
            withAnimation(.easeInOut(duration: 0.5)) {
                displayedQuote = quotes.randomElement()
            }
        }) {
            Text("Need a Motivational Quote")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(Color.black)
                .cornerRadius(15)
                .shadow(radius: 5)
        }
        .padding(.top, 10)
    }
}

struct ReligiousQuoteSection: View {
    let religiousQuotes: [String: String]
    @Binding var selectedReligion: String?
    
    var body: some View {
        SectionHeader(title: "Religious Quotes")
            .frame(maxWidth: .infinity, alignment: .leading)
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(religiousQuotes.keys.sorted(), id: \.self) { religion in
                    VStack {
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                selectedReligion = religion
                            }
                        }) {
                            ZStack {
                                Color.yellow
                                    .cornerRadius(20)
                                    .shadow(radius: 10)
                                
                                Text(religiousQuotes[religion] ?? "")
                                    .font(.body)
                                    .foregroundColor(.black)
                                    .multilineTextAlignment(.center)
                                    .padding(10)
                                    .frame(width: 180, height: 100)
                            }
                        }
                        
                        Text(religion)
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding(.top, 10)
                    }
                    .frame(width: 200)
                }
            }
            .padding(.horizontal, 20)
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
    }
}

