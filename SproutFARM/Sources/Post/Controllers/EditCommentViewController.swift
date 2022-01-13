//
//  EditCommentViewController.swift
//  SproutFARM
//
//  Created by KEEN on 2022/01/03.
//

import UIKit

class EditCommentViewController: BaseViewController {
  
  // MARK: - Properties
  var comment: Comment?
  
  // MARK: - UI
  let editCommentView = EditCommentView()
  
  // MARK: - View Life-Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
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
  
}
