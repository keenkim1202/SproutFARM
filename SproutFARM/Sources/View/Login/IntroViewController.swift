//
//  IntroViewController.swift
//  SproutFARM
//
//  Created by KEEN on 2022/01/03.
//

import UIKit
import SnapKit

class IntroViewController: BaseViewController {
  
  // MARK: - UI
  var introView = IntroView()
  
  // MARK: - View Life-Cycle
  override func viewDidLoad() {
    super.viewDidLoad()

    setConstraints()
    introView.startButton.addTarget(self, action: #selector(onStart), for: .touchUpInside)
    introView.loginButton.addTarget(self, action: #selector(onLogin), for: .touchUpInside)
  }
  
  // MARK: - Configure
  
  private func setConstraints() {
    view.addSubview(introView)
    introView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
  // MARK: - Actions
  @objc func onStart() {
    print("start")
  }
  
  @objc func onLogin() {
    print("login")
    self.navigationController?.pushViewController(RegisterViewController(), animated: true)
  }

}
