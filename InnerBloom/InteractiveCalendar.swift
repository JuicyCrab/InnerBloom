import SwiftUI

struct InteractiveCalendar: View {
    let safeAreaInsets: EdgeInsets
    @State private var selectedDate = Date()
    @State private var sheetOffset: CGFloat = UIScreen.main.bounds.height * 0.5
    @State private var isSheetExpanded = false
    @State private var items: [String] = ["Journal Entry 1", "Workout 1", "Workout 2", "Journal Entry 2"]
    @State private var isAddMenuOpen = false

    var body: some View {
        ZStack {
            // Main Calendar
            VStack {
                DatePicker(
                    "Choose a date",
                    selection: $selectedDate,
                    displayedComponents: [.date]
                )
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()
                Spacer()
            }
            .background(Color.yellow)

            // Swipe-Up Bottom Sheet
            BottomSheet(
                sheetOffset: $sheetOffset,
                isSheetExpanded: $isSheetExpanded,
                safeAreaInsets: safeAreaInsets
            ) {
                VStack(spacing: 20) {
                    Text("Completed Items")
                        .font(.headline)
                    
                    ScrollView {
                        VStack(alignment: .leading, spacing: 10) {
                            ForEach(items, id: \.self) { item in
                                Text(item)
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(Color.black.opacity(0.2))
                                    .cornerRadius(10)
                            }
                        }
                        .padding(.horizontal)
                    }
                    .frame(height: max(200, UIScreen.main.bounds.height - safeAreaInsets.top - safeAreaInsets.bottom - sheetOffset))
                }
                .padding()
            }

            // Floating Add Button with Options
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    AddMenu(isAddMenuOpen: $isAddMenuOpen, items: $items, safeAreaInsets: safeAreaInsets)
                }
            }
        }
    }
}

// Floating Add Button and Menu
struct AddMenu: View {
    @Binding var isAddMenuOpen: Bool
    @Binding var items: [String]
    let safeAreaInsets: EdgeInsets

    var body: some View {
        ZStack {
            if isAddMenuOpen {
                VStack(spacing: 15) {
                    Button(action: {
                        addItem(type: "Journal")
                    }) {
                        HStack {
                            Image(systemName: "book.fill")
                                .foregroundColor(.white)
                            Text("Add Journal")
                                .foregroundColor(.white)
                        }
                        .padding()
                        .background(Color.purple)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    }

                    Button(action: {
                        addItem(type: "Workout")
                    }) {
                        HStack {
                            Image(systemName: "figure.walk")
                                .foregroundColor(.white)
                            Text("Add Workout")
                                .foregroundColor(.white)
                        }
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    }
                }
                .transition(.scale)
            }

            // Main Add Button
            Button(action: {
                withAnimation {
                    isAddMenuOpen.toggle()
                }
            }) {
                Image(systemName: isAddMenuOpen ? "xmark" : "plus")
                    .font(.system(size: 24, weight: .bold))
                    .frame(width: 60, height: 60)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .clipShape(Circle())
                    .shadow(color: .gray.opacity(0.4), radius: 10, x: 0, y: 5)
            }
        }
        .padding(.bottom, safeAreaInsets.bottom + 20)
        .padding(.trailing, 20)
    }

    private func addItem(type: String) {
        let newItem = "\(type) Entry \(items.count + 1)"
        items.append(newItem)
        withAnimation {
            isAddMenuOpen = false
        }
    }
}

// Bottom Sheet Component
struct BottomSheet<Content: View>: View {
    @Binding var sheetOffset: CGFloat
    @Binding var isSheetExpanded: Bool
    let safeAreaInsets: EdgeInsets
    let content: Content

    init(sheetOffset: Binding<CGFloat>, isSheetExpanded: Binding<Bool>, safeAreaInsets: EdgeInsets, @ViewBuilder content: () -> Content) {
        self._sheetOffset = sheetOffset
        self._isSheetExpanded = isSheetExpanded
        self.safeAreaInsets = safeAreaInsets
        self.content = content()
    }

    var body: some View {
        GeometryReader { proxy in
            let height = proxy.size.height
            let dragLimit = height * 0.3 // Adjust limit for expanded view

            VStack {
                Capsule()
                    .frame(width: 40, height: 6)
                    .foregroundColor(.gray)
                    .padding(10)
                content
            }
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 5)
            .offset(y: max(sheetOffset, dragLimit))
            .gesture(
                DragGesture()
                    .onChanged { value in
                        let newOffset = sheetOffset + value.translation.height
                        if newOffset > dragLimit && newOffset < height - safeAreaInsets.bottom {
                            sheetOffset = newOffset
                        }
                    }
                    .onEnded { value in
                        let dragDistance = value.translation.height
                        withAnimation {
                            if dragDistance < -50 { // Adjust to prevent auto-close
                                sheetOffset = dragLimit
                                isSheetExpanded = true
                            } else if dragDistance > 50 { // Adjust for smoother down-swipe
                                sheetOffset = height - safeAreaInsets.bottom
                                isSheetExpanded = false
                            }
                        }
                    }
            )
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    InteractiveCalendar(safeAreaInsets: EdgeInsets())
}

