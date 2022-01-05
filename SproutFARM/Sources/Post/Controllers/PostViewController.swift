//
//  PostViewController.swift
//  SproutFARM
//
//  Created by KEEN on 2022/01/03.
//

import UIKit
import SnapKit

class PostViewController: BaseViewController {
  
  // MARK: - UI
  let rightBarButton: UIBarButtonItem = {
    let b = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(onDone))
    return b
  }()
  
  let textView: UITextView = {
    let t = UITextView()
    t.font = .systemFont(ofSize: 13, weight: .bold)
    return t
  }()
  
  // MARK: - View Life-Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.title = "새싹농장 글쓰기"
    self.navigationItem.rightBarButtonItem = self.rightBarButton
    setConstraints()
  }
  
  // MARK: - Configure
  private func setConstraints() {
    view.addSubview(textView)
    textView.snp.makeConstraints {
      $0.leading.top.equalToSuperview().offset(20)
      $0.trailing.bottom.equalToSuperview().offset(-20)
    }
  }
  
  // MARK: - Action
  @objc func onDone() {
    print("onDone")
  }
}
