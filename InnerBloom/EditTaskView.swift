import SwiftUI

struct EditTaskView: View {
    @Binding var task: Task? // Binding to the task being edited
    var onSave: (Task) -> Void

    @State private var title: String = ""
    @State private var caption: String = ""
    @State private var tint: Color = .blue

    var body: some View {
        VStack {
            Form {
                TextField("Title", text: $title)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Caption", text: $caption)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                ColorPicker("Color", selection: $tint)
                    .padding()
            }

            HStack {
                Button("Cancel") {
                    task = nil
                }
                Spacer()
                Button("Save") {
                    if var task = task {
                        task.title = title
                        task.caption = caption
                        task.tint = tint
                        onSave(task)
                    }
                }
            }
            .padding()
        }
        .onAppear {
            if let task = task {
                title = task.title
                caption = task.caption
                tint = task.tint
            }
        }
    }
}

