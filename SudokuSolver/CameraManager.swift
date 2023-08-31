//
//  CameraManager.swift
//  SudokuSolver
//
//  Created by Sebastian Castro on 8/23/23.
//

import SwiftUI
import UIKit

// declares the CameraManager class. It inherits from NSObject and conforms to both UIImagePickerControllerDelegate and UINavigationControllerDelegate.
class CameraManager: NSObject, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    static let shared = CameraManager() // Singleton instance (only one instance of the class is created and shared throughout the app)
    
    private var imagePicker: UIImagePickerController? // display the camera interface or the photo library
    private var completion: ((UIImage?) -> Void)? // capture a callback to be executed when an image is selected or the picker is canceled.
    
    
    func presentImagePicker(from viewController: UIViewController, completion: @escaping (UIImage?) -> Void) {
        self.completion = completion
        imagePicker = UIImagePickerController()
        imagePicker?.delegate = self
        
        let alertController = UIAlertController(title: "Choose Image Source", message: nil, preferredStyle: .actionSheet)
        
        // a built-in UIKit component for displaying alerts and action sheets.
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alertController.addAction(UIAlertAction(title: "Camera", style: .default) { _ in
                self.imagePicker?.sourceType = .camera
                viewController.present(self.imagePicker!, animated: true, completion: nil)
            })
        }
        
        // checks if the device supports the camera
        alertController.addAction(UIAlertAction(title: "Photo Library", style: .default) { _ in
            self.imagePicker?.sourceType = .photoLibrary
            viewController.present(self.imagePicker!, animated: true, completion: nil)
        })
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        viewController.present(alertController, animated: true, completion: nil)
    }

    // UIImagePickerControllerDelegate methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let chosenImage = info[.originalImage] as? UIImage {
            completion?(chosenImage)
        }
        
        picker.dismiss(animated: true, completion: nil)
        imagePicker = nil
        completion = nil
    }
    
    // dismisses the image picker interface, resets the imagePicker property, and sets the completion closure to nil.
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        imagePicker = nil
        completion = nil
    }
}
