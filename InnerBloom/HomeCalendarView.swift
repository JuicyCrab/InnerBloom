import SwiftUI

struct CalendarView: View {
    @State private var tasks: [Task] = [] // Store tasks
    @State private var journals: [Journal] = [] // Store journals
    @State private var taskToEdit: Task? // Task being edited
    @State private var journalToEdit: Journal? // Journal being edited
    @State private var isPresentingEditTaskView = false // To control presentation of task edit view
    @State private var isPresentingEditJournalView = false // To control presentation of journal edit view
    @State private var currentDate: Date = .init() // Initially set to current date, will change upon user selection
    @State private var displayedDates: [Date] = []
    @State private var monthDisplayDate: Date = .init()

    private var monthFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"  // Displays the month name and year (e.g., January 2025)
        return formatter
    }

    private var weekdayFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"  // Displays the abbreviated weekday name (e.g., Mon, Tue)
        return formatter
    }

    var body: some View {
        NavigationView {
            VStack {
                // Display current month and year
                Text(monthDisplayDate, formatter: monthFormatter)
                    .font(.system(size: 36, weight: .semibold))
                    .padding(.bottom, 10)

                // Horizontal scrollable view for dates
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(displayedDates, id: \.self) { date in
                            VStack {
                                Text(date, formatter: weekdayFormatter)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                
                                Text(date.format("d"))
                                    .font(.system(size: 20))
                                    .frame(width: 50, height: 50)
                                    .background(
                                        isSameDate(date, currentDate) ? Color.black : Color.clear
                                    )
                                    .foregroundColor(isSameDate(date, currentDate) ? .white : .black)
                                    .cornerRadius(15)
                                    .onTapGesture {
                                        withAnimation {
                                            currentDate = date
                                        }
                                    }
                            }
                        }
                    }
                    .padding()
                }

                // List of tasks and journals for the selected day
                List {
                    Section(header: Text("Tasks")) {
                        ForEach(tasks) { task in
                            HStack {
                                Text(task.title)
                                Spacer()
                                Button("Edit") {
                                    taskToEdit = task
                                    isPresentingEditTaskView = true
                                }
                            }
                        }
                        .onDelete(perform: deleteTask)
                    }

                    Section(header: Text("Journals")) {
                        // Filter journals based on the current date
                        ForEach(journals.filter { isSameDate($0.date, currentDate) }) { journal in
                            HStack {
                                Text(journal.title)
                                Spacer()
                                Button("Edit") {
                                    journalToEdit = journal
                                    isPresentingEditJournalView = true
                                }
                            }
                        }
                        .onDelete(perform: deleteJournal)
                    }
                }
                
                Spacer()

                // Show "Add Journal" Button only when a date is selected
                if currentDate != .init() {
                    Button("Add Journal") {
                        journalToEdit = Journal(title: "", caption: "", date: currentDate)
                        isPresentingEditJournalView = true
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.yellow)
                    .font(.system(size: 22))
                    .foregroundColor(.black)
                    .cornerRadius(20)
                }

                if currentDate != .init() {
                    Button("Add Goals") {
                        taskToEdit = Task(title: "", caption: "", tint: .blue)
                        isPresentingEditTaskView = true
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .font(.system(size: 22))
                    .foregroundColor(.black)
                    .cornerRadius(20)
                }
            }
            .background(
                NavigationLink(
                    destination: EditTaskView(task: $taskToEdit, onSave: saveEditedTask),
                    isActive: $isPresentingEditTaskView,
                    label: { EmptyView() }
                )
                .hidden()
            )
            .background(
                NavigationLink(
                    destination: EditJournalView(journal: $journalToEdit, onSave: saveEditedJournal),
                    isActive: $isPresentingEditJournalView,
                    label: { EmptyView() }
                )
                .hidden()
            )
        }
        .onAppear {
            initializeDates()
        }
        .onChange(of: currentDate) { newDate in
            updateMonth(for: newDate)
        }
    }

    // Helper to check if two dates are the same
    private func isSameDate(_ lhs: Date, _ rhs: Date) -> Bool {
        Calendar.current.isDate(lhs, inSameDayAs: rhs)
    }

    // Initialize displayed dates
    private func initializeDates() {
        let startDate = Calendar.current.startOfDay(for: Date())
        displayedDates = (0..<30).compactMap { offset in
            Calendar.current.date(byAdding: .day, value: offset, to: startDate)
        }
        updateMonth(for: currentDate)
    }

    // Update month display
    private func updateMonth(for date: Date) {
        monthDisplayDate = date
    }

    // Save edited task
    func saveEditedTask(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index] = task
        } else {
            tasks.append(task)
        }
        isPresentingEditTaskView = false
    }

    // Save edited journal
    func saveEditedJournal(_ journal: Journal) {
        if let index = journals.firstIndex(where: { $0.id == journal.id }) {
            journals[index] = journal
        } else {
            journals.append(journal)
        }
        isPresentingEditJournalView = false
    }

    // Delete task
    private func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }

    // Delete journal
    private func deleteJournal(at offsets: IndexSet) {
        journals.remove(atOffsets: offsets)
    }
}


