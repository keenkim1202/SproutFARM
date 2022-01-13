//
//  EditCommentViewController.swift
//  SproutFARM
//
//  Created by KEEN on 2022/01/03.
//

import UIKit

class EditCommentViewController: BaseViewController {
  
  // MARK: - Properties
  var user: User?
  var post: Post?
  var comment: Comment?
  
  // MARK: - UI
  let editCommentView = EditCommentView()
  
  // MARK: - View Life-Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    editCommentView.textView.delegate = self
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(onDone))
    setConstraints()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    if let comment = comment {
      editCommentView.textView.text = comment.comment
    } else {
      print("comment 없음")
    }

  }
  
  // MARK: - Configure
  private func setConstraints() {
    view.addSubview(editCommentView)
    editCommentView.snp.makeConstraints {
      $0.edges.equalTo(view.safeAreaLayoutGuide)
    }
  }
  
  @objc func onDone() {
    guard
      let user = user,
      let comment = comment
    else { return }
    print(comment)
    
    APIService.updateComment(token: user.jwt, comment: editCommentView.textView.text, postID: comment.post.id, commentID: comment.id) { error in
      guard error == nil else {
        UIAlertController.showAlert(self, contentType: .failToUpdate, message: "댓글 변경에 실패하였습니다.\n다시시도 해주세요.", completion: nil)
        return
      }
    }
    
    UIAlertController.sucessAlert(self, contentType: .success, message: "댓글 수정 완료!")
  }
}

extension EditCommentViewController: UITextViewDelegate {
  
}
