//
//  CreateQuoteViewController.swift
//  Quo
//
//  Created by Federico Trimboli on 04/03/2018.
//

import UIKit

class CreateQuoteViewController: UIViewController {
    
    @IBOutlet weak var quoteTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icClose"), style: .plain, target: self, action: #selector(closeButtonTapped))
        
//        quoteTextField.text = ""
//        quoteTextField.placeholder = "blah"
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShowOrHide(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShowOrHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        quoteTextField.becomeFirstResponder()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func closeButtonTapped() {
        quoteTextField.resignFirstResponder()
        dismiss(animated: true, completion: nil)
    }

}

// MARK: - Keyboard Hooks
extension CreateQuoteViewController {
    
    @objc private func keyboardDidShowOrHide(notification: Notification) {
        guard let userInfo = notification.userInfo,
            let animationDuration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval,
            let animationCurveInt = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? Int,
            let animationCurve = UIViewAnimationCurve(rawValue: animationCurveInt),
            let keyboardEndFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? CGRect else {
                return
        }
        
        let keyboardFrameInView = view.convert(keyboardEndFrame, from: nil)
        let safeAreaFrame = view.safeAreaLayoutGuide.layoutFrame.insetBy(dx: 0, dy: -additionalSafeAreaInsets.bottom)
        let intersection = safeAreaFrame.intersection(keyboardFrameInView)
        additionalSafeAreaInsets.bottom = intersection.height
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(animationDuration)
        UIView.setAnimationCurve(animationCurve)
        view.layoutIfNeeded()
        UIView.commitAnimations()
    }
    
}

