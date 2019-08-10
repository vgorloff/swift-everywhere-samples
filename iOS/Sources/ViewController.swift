//
//  ViewController.swift
//  hello-application
//
//  Created by Vlad Gorlov on 09.08.19.
//  Copyright © 2019 WaveLabs. All rights reserved.
//

import UIKit
import HelloJNICore

class ViewController: UIViewController {

   private lazy var stackView = UIStackView()
   private lazy var button = UIButton()

   override func viewDidLoad() {
      super.viewDidLoad()
      setupUI()
   }

}

extension ViewController {

   private func setupUI() {
      view.backgroundColor = .blue
      view.addSubview(stackView)

      stackView.translatesAutoresizingMaskIntoConstraints = false
      stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
      stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
      stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
      stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
      stackView.axis = .vertical

      stackView.addArrangedSubview(button)
      stackView.addArrangedSubview(UIView())

      button.setTitle("Get Time", for: .normal)
      button.addTarget(self, action: #selector(getTime), for: .touchUpInside)
   }

   @objc private func getTime() {
      let time = sayHello()
      button.setTitle("\(time)", for: .normal)
   }
}
