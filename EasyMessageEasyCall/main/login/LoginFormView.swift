//
//  LoginFormView.swift
//  EasyMessageEasyCall
//
//  Created by Thiem Jason on 4/28/21.
//

import UIKit

class LoginFormView: UIView {
    @IBOutlet var view: UIView!
    @IBOutlet weak var textFieldUsername: UITextField!
    
    @IBOutlet weak var textFieldPass : UITextField!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialView()
    }
    
    private func initialView() {
        Bundle.main.loadNibNamed("LoginFormView", owner: self, options: nil)
        self.view.frame = self.bounds
        self.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.addSubview(view)
    }
}
