//
//  ViewController.swift
//  System_View_Controllers
//
//  Created by Миронов Влад on 20/04/2019.
//  Copyright © 2019 Миронов Влад. All rights reserved.
//

import UIKit
import SafariServices
import MessageUI

class ViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func shareAction(_ sender: Any) {
        guard let image = imageView.image else { return }
        
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(activityController, animated: true)
    }
    
    @IBAction func safariAction(_ sender: Any) {
        guard let url = URL(string: "https://yandex.ru") else { return }
        let safariViewController = SFSafariViewController(url: url)
        
        present(safariViewController, animated: true)

    
    }
    
    @IBAction func cameraAction(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let alertController = UIAlertController(title: "Chouse sourse", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "camera", style: .default) { (_) in
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true)
            }
            
            alertController.addAction(cameraAction)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let photoLibrary = UIAlertAction(title: "photoLibrary", style: .default) { (_) in
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true)
            }
            
            alertController.addAction(photoLibrary)
        }
        
        alertController.addAction(cancelAction)
        present(alertController, animated: true)

    }
    
    @IBAction func mailAction(_ sender: Any) {
        guard MFMailComposeViewController.canSendMail() else { return }
        
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        mailComposer.setToRecipients(["vladislav14141@yandex.ru"])
        mailComposer.setSubject("Please help me with app")
        mailComposer.setMessageBody("I have trouble with the mail composer", isHTML: false)
        
        present(mailComposer, animated: true)
    }
    
    @IBAction func messageAction(_ sender: Any) {
        let messageComposer = MFMessageComposeViewController()
        messageComposer.messageComposeDelegate = self
        messageComposer.body = "Ваши коллекторы не дают мне покоя😡"
        messageComposer.recipients = ["88005553535"]
        
        present(messageComposer, animated: true)
    }
    
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let data = info[UIImagePickerController.InfoKey.originalImage] else { return }
        let image = data as? UIImage
        imageView.image = image
        dismiss(animated: true)
    }
    
}

// MARK: - MFMailComposeViewControllerDelegate
extension ViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true, completion: nil)
    }
}


// MARK: - MFMessageComposeViewControllerDelegate
extension ViewController: MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        dismiss(animated: true, completion: nil)
    }
    
}
