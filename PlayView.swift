
import Foundation
import SwiftUI
import UIKit

struct PlayView: View {
    @State private var sudokuBoard: [[Int?]] = Array(repeating: Array(repeating: nil, count: 9), count: 9)
    //    @State private var sudokuBoard: [[Int]] = [[Int]](repeating: [Int](repeating: 0, count: 9), count: 9)
    @State private var selectedCell: (row: Int, col: Int)? = nil
    @State private var showAlert = false
    @State private var alertMessage = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Button(action: {
                showAlert = true
                alertMessage = "Are you sure you want to go back?"
            }) {
                Text("Go Back")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Confirmation"),
                    message: Text(alertMessage),
                    primaryButton: .default(Text("Yes"), action: {
                        if alertMessage == "Are you sure you want to go back?" {
                            presentationMode.wrappedValue.dismiss() // navigate back to the previous view.
                            
                        } else if alertMessage == "Are you sure you want to see the solution?" {
                            solveSudoku()
                        } else if alertMessage == "Are you sure you want to generate a random board? This will clear everything" {
                            generateRandomBoard(0.4)
                        } else {
                            generateRandomBoard(0.05)
                        }
                        showAlert = false
                    }),
                    secondaryButton: .cancel(Text("Cancel"))
                )
            }
            .padding()
            
            VStack(spacing: 0) {
                // generates the sudoku board
                ForEach(0..<9, id: \.self) { row in
                    HStack(spacing: 0) {
                        ForEach(0..<9, id: \.self) { col in
                            //                            CellView(sudokuBoard: $sudokuBoard, row: row, col: col)
                            CellView(sudokuBoard: $sudokuBoard, row: row, col: col)
                                .onTapGesture {
                                    selectedCell = (row: row, col: col)
                                }
                        }
                    }
                }
                // BoldLinesView()
            }
            .padding()
            
            Spacer()
            
            HStack {
                Button(action: {
                    showAlert = true
                    alertMessage = "Are you sure you want to see the solution?"
                }) {
                    Text("Solve")
                        .font(.system(size: 10))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                }
                
                
                Spacer()
                
                Button(action: {
                    showAlert = true
                    alertMessage = "Are you sure you want to generate a random board? This will clear everything"
                }) {
                    Text("Randomize")
                        .font(.system(size: 10))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                }
                
                Spacer()
                Button(action: {
                    showAlert = true
                    alertMessage = "Are you sure you want a hint?"
                }) {
                    Text("Hint")
                        .font(.system(size: 10))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                }
                
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .background(Color.red.edgesIgnoringSafeArea(.all))
    }
    
    func showAlert(title: String, message: String) {
        // Create an alert controller
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // Create an action to dismiss the alert
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        // Get the application's relevant window scene
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            // Get the first window in the window scene
            if let rootViewController = windowScene.windows.first?.rootViewController {
                // Present the alert on the root view controller
                rootViewController.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    func translateBoard()->[[Int]] {
        var board = [[Int]](repeating: [Int](repeating: 0, count: 9), count: 9)
        
        // responsible for "translating" user values
        for row in 0..<9 {
            for col in 0..<9 {
                if let value = sudokuBoard[row][col] {
                    board[row][col] = value
                }
            }
        }
        return board
    }
    func solveSudoku() {
        var board = translateBoard()
        
        let sudoku = SudokuSolver()
        if sudoku.solveSudoku(&board) {
            sudokuBoard = board.map { $0.map { $0 } }
            //            alertMessage = "Sudoku solved!"
//            showAlert(title: "Solution Found!", message: "Board successfully solved.")
        } else {
            //            alertMessage = "No solution found!"
            showAlert(title: "Warning!", message: "Board has no solution.")
        }
        
        showAlert = true
    }
    func generateRandomBoard(_ emptyCellProbability: Double) {
        
        if !(emptyCellProbability < 0.1) {
            // Clear board
            let board = [[Int]](repeating: [Int](repeating: 0, count: 9), count: 9)
            sudokuBoard = board.map { $0.map { $0 } }
            
            let randInt1 = Int(arc4random_uniform(8)) + 1
            let randInt2 = Int(arc4random_uniform(8)) + 1
            let randInt3 = Int(arc4random_uniform(8)) + 1
            
            sudokuBoard[randInt1][randInt2] = randInt3
            solveSudoku()
            print(sudokuBoard)
            
            // Copy some values from the filled board to the playable board
            for row in 0..<9 {
                for col in 0..<9 {
                    if Double.random(in: 0..<1) > emptyCellProbability {
                        sudokuBoard[row][col] = board[row][col]
                    }
                    if sudokuBoard[row][col] == 0 {
                        sudokuBoard[row][col] = nil
                    }
                }
            }
            
        } else {
            let unsolved = sudokuBoard
            solveSudoku()
            let solved = sudokuBoard
            sudokuBoard = unsolved
            
            
        outerLoop: for row in 0..<9 {
                for col in 0..<9 {
                    if sudokuBoard[row][col] == nil {
                        sudokuBoard[row][col] = solved[row][col]
//                        print("this should only print once")
                        break outerLoop
                    }
                }
            }
        }
    }
}

//struct PlayView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlayView()
//    }
//}

struct SudokuSolver {
    func solveSudoku(_ board: inout [[Int]]) -> Bool {
        for row in 0..<9 {
            for col in 0..<9 {
                let cellVal = board[row][col]
                if cellVal != 0 {
                    
                    for i in 0..<9 {
                        if (i != col && board[row][i] == cellVal) || (i != row && board[i][col] == cellVal) {
                            return false
                        }
                    }
                    
                    let startRow = (row / 3) * 3
                    let startCol = (col / 3) * 3
                    
                    for i in 0..<3 {
                        for j in 0..<3 {
                            if board[startRow + i][startCol + j] == cellVal && (startRow + i != row && startCol + j != col) {
                                return false
                            }
                        }
                    }
                    //board is unsolvable if returns false
        
                }
            }
        }
        return solveHelper(&board, 0, 0)
    }
    
    private func solveHelper(_ board: inout [[Int]], _ row: Int, _ col: Int) -> Bool {
        if col == 9 {
            return solveHelper(&board, row + 1, 0)
        }
        
        if row == 9 {
            return true
        }
        
        if board[row][col] != 0 {
            return solveHelper(&board, row, col + 1)
        }
        
        for num in 1...9 {
            if isValidValue(board, row, col, num) {
//                print("Trying number \(num)")
                board[row][col] = num
                if solveHelper(&board, row, col + 1) {
                    return true
                }
                board[row][col] = 0
            }
        }
//        print("Backtracking at row \(row), col \(col)")
        return false
    }
    
    func isValidValue(_ board: [[Int]], _ row: Int, _ col: Int, _ num: Int) -> Bool {
        for i in 0..<9 {
            if board[row][i] == num || board[i][col] == num {
                return false
            }
        }
        
        let startRow = (row / 3) * 3
        let startCol = (col / 3) * 3
        
        for i in 0..<3 {
            for j in 0..<3 {
                if board[startRow + i][startCol + j] == num {
                    return false
                }
            }
        }
        
        return true
    }
}

struct CellView: View {
    @Binding var sudokuBoard: [[Int?]]
    let row: Int
    let col: Int

    var cellValue: Binding<Int?> {
        Binding(
            get: { sudokuBoard[row][col] },
            set: { sudokuBoard[row][col] = $0 }
        )
    }

    var body: some View {
        ZStack {
            if let value = cellValue.wrappedValue {
                Text("\(value)")
                    .font(.system(size: 20))
                    .frame(width: 40, height: 40)
                    .background(Color.white)
                    .overlay(
                        Rectangle()
                            .stroke(Color.black, lineWidth: 1)
                    )
            } else {
                Rectangle()
                    .frame(width: 40, height: 40)
                    .background(Color.white)
                    .foregroundColor(cellValue.wrappedValue == nil ? .gray : .black)
                    .overlay(
                        Rectangle()
                            .stroke(Color.black, lineWidth: 1)
                    )
            }

            TextField("", text: Binding<String>(
                get: { String(cellValue.wrappedValue ?? 0) },
                set: { newValue in
                    if let intValue = Int(newValue), (1...9).contains(intValue) {
                        cellValue.wrappedValue = intValue
                    } else {
                        cellValue.wrappedValue = nil
                    }
                }
            ))
            .font(.system(size: 20))
            .frame(width: 40, height: 40)
            .background(Color.clear)
            .foregroundColor(cellValue.wrappedValue == nil ? .gray : .black)
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            .onTapGesture {
//                if cellValue.wrappedValue == nil {
                cellValue.wrappedValue = nil
//                }
            }
        }
    }
}


struct BoldLinesView: View {
    private let boldLineWidth: CGFloat = 4
    private let gridSize: CGFloat = 9
    private let cellSize: CGFloat = 40
    private let totalSize: CGFloat = 360

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Draw bold horizontal lines
                ForEach(1..<Int(gridSize), id: \.self) { row in
                    Path { path in
                        let y = CGFloat(row) * cellSize
                        path.move(to: CGPoint(x: 0, y: y))
                        path.addLine(to: CGPoint(x: totalSize, y: y))
                    }
                    .stroke(Color.black, lineWidth: isBoldLine(row) ? boldLineWidth : 1)
                }

                // Draw bold vertical lines
                ForEach(1..<Int(gridSize), id: \.self) { col in
                    Path { path in
                        let x = CGFloat(col) * cellSize
                        path.move(to: CGPoint(x: x, y: 0))
                        path.addLine(to: CGPoint(x: x, y: totalSize))
                    }
                    .stroke(Color.black, lineWidth: isBoldLine(col) ? boldLineWidth : 1)
                }
            }
            .frame(width: totalSize, height: totalSize)
            .position(x: geometry.size.width / 2, y: geometry.size.height / 2 - (totalSize/4 + totalSize/2 + 40)) // Raise the grid vertically
        }
    }

    private func isBoldLine(_ position: Int) -> Bool {
        position % 3 == 0
    }
}
