//
//  PostViewController.swift
//  SproutFARM
//
//  Created by KEEN on 2022/01/03.
//

import UIKit

class PostViewController: BaseViewController {
  
  // MARK: = Enum
  enum ViewType {
    case add
    case update
  }
  
  // MARK: - Properties
  var viewType: ViewType = .add
  
  // MARK: - UI
  let textView: UITextView = {
    let t = UITextView()
    t.font = .systemFont(ofSize: 13, weight: .bold)
    t.backgroundColor = .systemGray4
    return t
  }()
  
  // MARK: - View Life-Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if viewType == .add {
      self.title = "새싹농장 글쓰기"
    } else {
      self.title = "글 수정하기"
    }
    
    self.navigationController?.setNavigationBarHidden(false, animated: true)
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(onDone))
    setConstraints()
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
  
  // MARK: - Configure
  private func setConstraints() {
    view.addSubview(textView)
    textView.snp.makeConstraints {
      $0.leading.top.equalTo(view.safeAreaLayoutGuide).offset(20)
      $0.trailing.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
    }
  }
  
  // MARK: - Action
  @objc func onDone(_ sender: UIBarButtonItem) {
    self.textView.endEditing(true)
    self.navigationController?.popViewController(animated: true)
  }
}
