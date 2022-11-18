//
//  BaseViewController.swift
//  TestTask
//
//  Created by Илья on 16/11/2022.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.resignFirstResponder()
    }
    
    func showError(_ error: String) {
        let alert = UIAlertController(title: "ERROR", message: error, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .destructive)
        alert.addAction(alertAction)
        present(alert, animated: true)
    }

}
