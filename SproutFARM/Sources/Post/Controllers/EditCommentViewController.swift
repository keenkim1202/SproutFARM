//
//  EditCommentViewController.swift
//  SproutFARM
//
//  Created by KEEN on 2022/01/03.
//

import UIKit

class EditCommentViewController: BaseViewController {
  
  // MARK: - Properties
  
  
  // MARK: - UI
  let editCommentView = EditCommentView()
  
  // MARK: - View Life-Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setConstraints()
  }
  
  // MARK: - Configure
  private func setConstraints() {
    view.addSubview(editCommentView)
    editCommentView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
}
