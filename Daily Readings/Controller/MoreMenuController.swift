//
//  MoreMenuController.swift
//  Daily Readings
//
//  Created by PoGo on 11/14/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit
import MessageUI
import StoreKit

private let reuseIdentifier = "Cell"

class MoreMenuController: UICollectionViewController, MFMailComposeViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.alwaysBounceVertical = true
        navigationItem.title = "Thông Tin"
        collectionView?.backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240)
        // Register cell classes
        self.collectionView!.register(MoreMenuCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    func configuredMailComposeVC() -> MFMailComposeViewController{
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["myemail@email.com"])
        mailComposerVC.setSubject("Trợ Giúp / Góp Ý")
        let systemVersion = UIDevice.current.systemVersion
        let model = UIDevice.current.model
        
        mailComposerVC.setMessageBody("/// Xin vui lòng viết dưới dòng này ///\n\n\n\n\n\n /// Xin vui lòng đừng xoá thông tin duới này.\nSystem Version: \(systemVersion)\n Device Model: \(model)\n ///", isHTML: false)
        return mailComposerVC
    }
//    func showSendMailErrorAlert() {
//        let sendMailErrorAlert = UIAlertController(title: "Could Not Send Email", message: "Your device could not send email", preferredStyle: .alert)
//        sendMailErrorAlert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { (action) in
//            sendMailErrorAlert.dismiss(animated: true, completion: nil)
//        }))
//        self.present(sendMailErrorAlert, animated: true, completion: nil)
//
//    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result.rawValue{
        case MFMailComposeResult.cancelled.rawValue:
            print("cancelled mail")
        case MFMailComposeResult.sent.rawValue:
            print("Mail Sent")
        default:
            break
        }
        self.dismiss(animated: true, completion: nil)
    }
}

extension MoreMenuController: UICollectionViewDelegateFlowLayout {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataService.instance.getMenuItem().count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MoreMenuCell
        cell.data = DataService.instance.getMenuItem()[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 70)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            SKStoreReviewController.requestReview()
        }else if indexPath.item == 1 {
            let mailComposedVC = configuredMailComposeVC()
            if MFMailComposeViewController.canSendMail(){
                self.present(mailComposedVC, animated: true, completion: nil)
            } else {
//                self.showSendMailErrorAlert()
            }
        }else{
            let activityController = UIActivityViewController(activityItems: ["Tín Thác App"], applicationActivities: nil)
            activityController.completionWithItemsHandler = {(activityType: UIActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
                if !completed {
                    print("user cancelled")
                    return
                }
                print("completed sharing")
            }
            activityController.popoverPresentationController?.sourceView = self.view
            present(activityController, animated: true, completion: nil)
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView?.collectionViewLayout.invalidateLayout()
    }
}

