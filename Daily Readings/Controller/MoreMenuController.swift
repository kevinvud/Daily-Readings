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
private let footerCellId = "footerCell"

class MoreMenuController: UICollectionViewController, MFMailComposeViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.alwaysBounceVertical = true
        let attrs = [
            NSAttributedStringKey.font: UIFont(name: "AvenirNext-DemiBold", size: 22)!
        ]
        navigationController?.navigationBar.titleTextAttributes = attrs
        navigationItem.title = "Thông Tin"
        collectionView?.backgroundColor = UIColor.rgb(red: 234, green: 237, blue: 240)

        // Register cell classes
        self.collectionView!.register(MoreMenuCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView?.register(FooterCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: footerCellId)
    }
    
    func configuredMailComposeVC() -> MFMailComposeViewController{
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["kevinvud@gmail.com"])
        mailComposerVC.setSubject("Trợ Giúp / Góp Ý Ứng Dụng Tín Thác (iOS)")
        let systemVersion = UIDevice.current.systemVersion
        let model = UIDevice.current.model
        mailComposerVC.setMessageBody("/// Xin vui lòng viết dưới dòng này. ///\n\n\n\n\n\n\n /// Xin vui lòng đừng xoá thông tin duới này.\nSystem Version: \(systemVersion)\n Device Model: \(model)\n ///", isHTML: false)
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
        if indexPath.item == DataService.instance.getMenuItem().count - 1{
            cell.lineSeparator.isHidden = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 70)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerCellId, for: indexPath) as! FooterCell
        return footer
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 140)
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            let appId = "id1315378723"
//            let appStoreUrl = "https://itunes.apple.com/us/app/t%C3%ADn-thác/id1315378723?ls=1&mt=8&action=write-review"
            let appStoreUrl = "itms-apps://itunes.apple.com/app/" + appId
            let appUrl = URL(string: appStoreUrl)!
            print(appUrl)
            UIApplication.shared.open(appUrl, options: [:], completionHandler: { (complete) in
                print(complete)
            })
//            if #available(iOS 10.3, *) {
//                SKStoreReviewController.requestReview()
//            } else {
//                // show alert
//            }
        }else if indexPath.item == 1 {
            guard let url = URL(string: "https://www.facebook.com/T%C3%ADn-Th%C3%A1c-1775364552475010/") else {return}
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            
        }else if indexPath.item == 2 {
            let activityController = UIActivityViewController(activityItems: ["Lời Chúa hằng ngày, ngày lễ, và more...tất cả chỉ trong 1 ứng dụng\n\nhttps://itunes.apple.com/us/app/t%C3%ADn-thác/id1315378723?ls=1&mt=8"], applicationActivities: nil)
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
        else if indexPath.item == 3 {
            let alarmVC = AlarmVC()
            DispatchQueue.main.async {
                alarmVC.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(alarmVC, animated: true)
                self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Trở Về", style: .plain, target: nil, action: nil)
            }
        }
            
        else if indexPath.item == 4 {
            let url = "https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=VRM6KF2K3EA7Q"
            guard let linkUrl = URL(string: url) else {return}
            UIApplication.shared.open(linkUrl, options: [ : ], completionHandler: nil)
    
        }
        else if indexPath.item == 5{
            let mailComposedVC = configuredMailComposeVC()
            if MFMailComposeViewController.canSendMail(){
                self.present(mailComposedVC, animated: true, completion: nil)
            } else {
                //                self.showSendMailErrorAlert()
            }
            
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView?.collectionViewLayout.invalidateLayout()
    }
}

