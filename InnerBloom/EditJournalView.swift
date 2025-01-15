import SwiftUI

struct EditJournalView: View {
    @Binding var journal: Journal? // Binding to the journal being edited
    var onSave: (Journal) -> Void

    @State private var title: String = ""
    @State private var caption: String = ""
    @State private var selectedEmoji: String = "🙂" // Default emoji

    // List of emojis to choose from
    private let emojis = ["🙂", "😀", "😎", "😍", "😊", "🤔", "🙃", "🥳", "😇"]

    var body: some View {
        VStack {
            Form {
                TextField("Title", text: $title)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                TextEditor(text: $caption)
                    .padding()
                    .frame(minHeight: 100)
                    .border(Color.gray, width: 1)

                // Emoji selection picker
                Picker("Select an Emoji", selection: $selectedEmoji) {
                    ForEach(emojis, id: \.self) { emoji in
                        Text(emoji).tag(emoji)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(height: 150)
                .padding()
            }

            HStack {
                Button("Cancel") {
                    journal = nil
                }
                Spacer()
                Button("Save") {
                    if var journal = journal {
                        journal.title = title
                        journal.caption = caption
                        // Save the selected emoji in the journal
                        journal.caption = "\(selectedEmoji) \(caption)"
                        onSave(journal)
                    }
                }
            }
            .padding()
        }
        .onAppear {
            if let journal = journal {
                title = journal.title
                caption = journal.caption
            }
        }
    }
}

