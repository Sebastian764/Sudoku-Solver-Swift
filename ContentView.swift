import SwiftUI

class AppState: ObservableObject {
    @Published var selection: String? = nil
}

struct ContentView: View {
    @State private var showStartButton = true
    @State private var navigationLinkActive = false

    init() {
        // Customize the appearance of the navigation bar
        UINavigationBar.appearance().barTintColor = .red
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.red]
        UINavigationBar.appearance().tintColor = .red
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color.red
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    Text("Sudoku \n Solver")
                        .font(.system(size: 70))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()

                    Spacer()

                    if showStartButton {
                        Button(action: {
                            showStartButton = false
                        }) {
                            Text("Start")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                                .padding(.horizontal, 20)
                        }
                        .padding(.bottom, 50)
                    } else {
                        VStack(spacing: 20) {
                            NavigationLink(
                                destination: PlayView(),
                                isActive: $navigationLinkActive,
                                label: {
                                    Text("Play")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(Color.blue)
                                        .cornerRadius(10)
                                        .padding(.horizontal, 20)
                                }
                            )
                            .frame(width: 200)

                            Link("Web Version", destination: URL(string: "https://github.com/Sebastian764")!) // temporary link
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                                .padding(.horizontal, 20)
                                .frame(width: 200)
                        }
                        .padding(.bottom, 50)
                    }
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
                                
                                // Handle "Solve" button action
//                                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//                                   let rootViewController = windowScene.windows.first?.rootViewController {
//                                    CameraManager.shared.presentImagePicker(from: rootViewController) { chosenImage in
//                                        if let image = chosenImage {
//                                            processImageWithPython(image: image)
//                                            // Call your function to handle the chosen image (if needed)
//                                            // For example: yourFunctionToHandleImage(image)
//                                        }
//                                    }
//                                }
  
