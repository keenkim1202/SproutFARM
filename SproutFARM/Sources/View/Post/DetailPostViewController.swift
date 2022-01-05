//
//  DetailPostViewController.swift
//  SproutFARM
//
//  Created by KEEN on 2022/01/03.
//

import UIKit

class DetailPostViewController: BaseViewController {
  
  let tableView: UITableView = {
    let t = UITableView()
    t.cellLayoutMarginsFollowReadableWidth = false
    t.separatorInset.left = 0
    return t
  }()
  
  let toolbar: UIToolbar = {
    let t = UIToolbar()
    t.barTintColor = .systemBackground
    return t
  }()
  let commentTextField: UITextField = {
    let t = UITextField()
    t.placeholder = "댓글을 입력해주세요"
    t.borderStyle = .none
    t.font = .systemFont(ofSize: 14, weight: .bold)
    t.layer.cornerRadius = 15
    t.backgroundColor = .systemGray6
    t.addLeftPadding()
    return t
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setTableView()
    setConstaints()
  }
  
  func setTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(ProfileCell.self, forCellReuseIdentifier: ProfileCell.identifier)
    tableView.register(PostListCell.self, forCellReuseIdentifier: PostListCell.identifier)
    tableView.register(PostListCommentCell.self, forCellReuseIdentifier: PostListCommentCell.identifier)
    tableView.register(CommentListCell.self, forCellReuseIdentifier: CommentListCell.identifier)
  }
  
  func setConstaints() {
    view.addSubview(tableView)
    view.addSubview(toolbar)
    toolbar.addSubview(commentTextField)
    tableView.snp.makeConstraints {
      $0.leading.trailing.top.equalToSuperview()
      $0.bottom.equalToSuperview().offset(-50)
    }
    
    toolbar.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalTo(view.safeAreaLayoutGuide)
      $0.height.equalTo(50)
    }
    
    commentTextField.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
      $0.centerY.equalTo(toolbar.snp.centerY)
      $0.height.equalTo(35)
    }
  }
  
}

// MARK: - Extension
extension DetailPostViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10 // test
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.row == 0 { // profile
      let cell = tableView.dequeueReusableCell(withIdentifier: ProfileCell.identifier, for: indexPath)
      return cell
    } else if indexPath.row == 1 { // post content
      let cell = tableView.dequeueReusableCell(withIdentifier: PostListCell.identifier, for: indexPath)
      return cell
    } else if indexPath.row == 2 { // comment
      let cell = tableView.dequeueReusableCell(withIdentifier: PostListCommentCell.identifier, for: indexPath)
      return cell
    } else { // comment content
      let cell = tableView.dequeueReusableCell(withIdentifier: CommentListCell.identifier, for: indexPath)
      return cell
    }
  }
}
