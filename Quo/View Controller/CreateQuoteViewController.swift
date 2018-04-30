//
//  CreateQuoteViewController.swift
//  Quo
//
//  Created by Federico Trimboli on 04/03/2018.
//

import UIKit

class CreateQuoteViewController: UIViewController {
    
    @IBOutlet weak var quoteTextField: UITextView!
    @IBOutlet weak var charactersCountLabel: UILabel!
    
    private var sendButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle(" Enviar ", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.backgroundColor = UIColor(named: "darkSkyBlue")
        button.layer.cornerRadius = 15
        button.frame = CGRect(x: 0, y: 0, width: 80, height: 24)
        button.addTarget(self, action: #selector(createQuote), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "icClose"), style: .plain, target: self, action: #selector(closeButtonTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: sendButton)
        
        sendButton.isEnabled = false
        sendButton.alpha = 0.5
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShowOrHide(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShowOrHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        quoteTextField.becomeFirstResponder()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func closeButtonTapped() {
        dismiss()
    }
    
    @objc private func createQuote() {
        QuotesService.createQuote(withMessage: quoteTextField.text, author: nil) { _, _  in }
        dismiss()
    }
    
    private func dismiss() {
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

extension CreateQuoteViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        let shouldChangeText = numberOfChars <= 280
        
        if shouldChangeText {
            charactersCountLabel.text = "\(280 - numberOfChars)"
            sendButton.isEnabled = numberOfChars > 0
            sendButton.alpha = numberOfChars > 0 ? 1 : 0.5
        }
        
        return shouldChangeText
    }
    
}
