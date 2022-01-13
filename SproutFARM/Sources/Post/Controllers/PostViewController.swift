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
  var user: User?
  
  // MARK: - UI
  let textView: UITextView = {
    let t = UITextView()
    t.font = .systemFont(ofSize: 13, weight: .bold)
    t.layer.borderWidth = 1
    t.layer.borderColor = UIColor.lightGray.cgColor
    t.layer.cornerRadius = 5
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
  

  
  // MARK: - Configure
  private func setConstraints() {
    view.addSubview(textView)
    textView.snp.makeConstraints {
      $0.leading.top.equalTo(view.safeAreaLayoutGuide).offset(20)
      $0.trailing.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
    }
  }
  
  // MARK: - HTTP Networking
  func writePost() {
    if let user = user {
      APIService.writePost(token: user.jwt, text: textView.text) { error in
        guard error == nil else {
          UIAlertController.showAlert(self, contentType: .failToWrite, message: "포스트 작성에 실패하였습니다.\n다시 시도 해주세요.")
          return
        }
      }
      
      UIAlertController.sucessAlert(self, contentType: .success, message: "포스트 작성 완료!")
    }
  }
  
  // MARK: - Action
  @objc func onDone(_ sender: UIBarButtonItem) {
    // TODO: 포스트 작성하기
    self.textView.endEditing(true)
    self.navigationController?.popViewController(animated: true)
  }
}
