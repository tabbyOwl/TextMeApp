//
//  LoginFormViewController.swift
//  TextMeApp
//
//  Created by jane on 20.03.2022.
//

import UIKit

class LoginFormViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginInput: UITextField!
    
    @IBOutlet weak var passwordInput: UITextField!
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
    // Проверяем данные
    let checkResult = checkUserData()
    // Если данные не верны, покажем ошибку
    if !checkResult { showLoginError()
    }
    // Вернем результат
    return checkResult
    }
    
    func checkUserData() -> Bool {
    guard let login = loginInput.text,
    let password = passwordInput.text else { return false }
    if login == "" && password == "" { return true
    } else {
    return false
    }
    }
    
    func showLoginError() { // Создаем контроллер
    let alter = UIAlertController(title: "Ошибка", message: "Введены не верные данные пользователя", preferredStyle: .alert)
    // Создаем кнопку для UIAlertController
    let action = UIAlertAction(title: "OK", style: .cancel, handler: nil) // Добавляем кнопку на UIAlertController
    alter.addAction(action)
    // Показываем UIAlertController
    present(alter, animated: true, completion: nil)
        
    }
    
//    @IBAction func loginButtonPressed(_ sender: Any) {
//        guard let login = loginInput.text else { return }
//        guard let password = passwordInput.text else { return }
//        if login == "admin" && password == "123456" {
//            print("успешная авторизация")
//        } else {
//            print("неуспешная авторизация")
//        }
//    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.5499269366, green: 0.5484815836, blue: 0.8414153457, alpha: 1)
        
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
    }
    
    @objc func keyboardWasShown(notification: Notification) {
        
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillBeHidden(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func hideKeyboard() {
        
        self.scrollView?.endEditing(true)
    }
    
}
