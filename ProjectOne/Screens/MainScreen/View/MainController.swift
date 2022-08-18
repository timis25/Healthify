//
//  ViewController.swift
//  ProjectOne
//
//  Created by Timur Israilov on 04/09/21.
//

import UIKit

class MainViewController: UIViewController {

    var presenter: MainPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.show()
    }

}

extension MainViewController: MainViewProtocol {
    func setGreating(a: String) {
        print(a)
    }
}
