//
//  DetailPostViewController.swift
//  SproutFARM
//
//  Created by KEEN on 2022/01/03.
//

import UIKit

class DetailPostViewController: BaseViewController {
  
  // MARK: - Metric
  struct Metric {
    static let toolbarHeight: CGFloat = 50
  }
  
  var keyHeight: CGFloat?
  
  // MARK: - UI
  let tableView: UITableView = {
    let t = UITableView()
    t.cellLayoutMarginsFollowReadableWidth = false
    t.separatorInset.left = 0
    return t
  }()
  
  let toolbar = DetailToolbar()
  
  // MARK: - View Life-Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.navigationController?.setNavigationBarHidden(false, animated: true)
    setTableView()
    setConstaints()
    addKeyboardNotification()
  }
  
  // MARK: - Configure
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

    tableView.snp.makeConstraints {
      $0.leading.trailing.top.equalToSuperview()
      $0.bottom.equalTo(toolbar.snp.top)
    }
    
    toolbar.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalTo(view.safeAreaLayoutGuide)
      $0.height.equalTo(Metric.toolbarHeight)
    }

  }
  
  private func addKeyboardNotification() {
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(keyboardWillShow),
      name: UIResponder.keyboardWillShowNotification,
      object: nil
    )
    
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(keyboardWillHide),
      name: UIResponder.keyboardWillHideNotification,
      object: nil
    )
  }
  
  // MARK: - Actions
  @objc private func keyboardWillShow(_ notification: Notification) {
    if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
      let keybaordRectangle = keyboardFrame.cgRectValue
      let keyboardHeight = keybaordRectangle.height
      tableView.frame.origin.y -= keyboardHeight
      toolbar.frame.origin.y -= keyboardHeight
    }
  }
  
  @objc private func keyboardWillHide(_ notification: Notification) {
    if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
      let keybaordRectangle = keyboardFrame.cgRectValue
      let keyboardHeight = keybaordRectangle.height
      tableView.frame.origin.y += keyboardHeight
      toolbar.frame.origin.y += keyboardHeight
    }
  }
  
  func showAlertMenu() {
    let alertMenu = UIAlertController(title: nil, message: "댓글 관리", preferredStyle: .actionSheet)
    
    let updateAction = UIAlertAction(title: "수정", style: .default, handler: {
      (alert: UIAlertAction!) -> Void in
    })
    let deleteAction = UIAlertAction(title: "삭제", style: .destructive, handler: {
      (alert: UIAlertAction!) -> Void in
    })
    let cancelAction = UIAlertAction(title: "취소", style: .cancel)
    
    alertMenu.addAction(updateAction)
    alertMenu.addAction(deleteAction)
    alertMenu.addAction(cancelAction)
    
    self.present(alertMenu, animated: true, completion: nil)
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
      cell.selectionStyle = .none
      return cell
    } else if indexPath.row == 1 { // post content
      let cell = tableView.dequeueReusableCell(withIdentifier: PostListCell.identifier, for: indexPath)
      cell.selectionStyle = .none
      return cell
    } else if indexPath.row == 2 { // comment
      let cell = tableView.dequeueReusableCell(withIdentifier: PostListCommentCell.identifier, for: indexPath)
      cell.selectionStyle = .none
      return cell
    } else { // comment content
      guard let cell = tableView.dequeueReusableCell(withIdentifier: CommentListCell.identifier, for: indexPath) as? CommentListCell else { return UITableViewCell() }
      cell.selectionStyle = .none
      return cell
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.row > 2 {
      showAlertMenu()
    }
  }
}
