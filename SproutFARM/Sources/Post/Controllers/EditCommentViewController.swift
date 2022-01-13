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
      UIAlertController.showAlert(self, contentType: .etc, message: "해당 댓글을 불러올 수 없습니다.\n다시 시도해 주세요.")
    }
  }
  
  // MARK: - Configure
  private func setConstraints() {
    view.addSubview(editCommentView)
    editCommentView.snp.makeConstraints {
      $0.edges.equalTo(view.safeAreaLayoutGuide)
    }
  }
  
  // MARK: - Action
  @objc func onDone() {
    if let user = user, let comment = comment {
      APIService.updateComment(token: user.jwt, comment: editCommentView.textView.text, postID: comment.post.id, commentID: comment.id) { error in
        
        guard error == nil else {
          UIAlertController.showAlert(self, contentType: .etc, message: "해당 댓글이 존재하지 않습니다.")
          return
        }
      }
      
      UIAlertController.sucessAlert(self, contentType: .success, message: "댓글 수정 완료!")
    } else {
      UIAlertController.showAlert(self, contentType: .failToUpdate, message: "댓글 변경에 실패하였습니다.\n다시 시도해 주세요.")
    }
  }
}

extension EditCommentViewController: UITextViewDelegate {
  
}
