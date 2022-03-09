//
//  BaseViewController.swift
//  BoldTest
//
//  Created by Carlos Villamizar on 8/3/22.
//

import UIKit

class BaseViewController: UIViewController {
    
    var loadingVC: LoadingIndicatorViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.clearBackground()
//        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func setupBackButton() {
        let backButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "backArrow"),
                                                              style: .plain,
                                                              target: self,
                                                              action: #selector(self.backButtonClickedDismiss(sender:)))
        
        self.navigationItem.leftBarButtonItem  = backButtonItem
        self.navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
        
    }
    
    @objc func backButtonClickedDismiss(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }

}

// MARK: - Loading View
extension BaseViewController {
    func showLoading() {
        loadingVC = LoadingIndicatorViewController()
        add(loadingVC!)
        loadingVC?.view.frame = view.bounds
    }

    func showLoading(inside wiew: UIView) {
        loadingVC = LoadingIndicatorViewController()
        add(child: loadingVC!, container: wiew)
        loadingVC?.view.frame = wiew.bounds
    }

    func hideLoading() {
        loadingVC?.remove()
        loadingVC = nil
    }
}

// MARK: - Alert
extension BaseViewController {
    func displaySimpleAlert(with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}
