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
    static let leadingTrailingInset: CGFloat = 20
    static let textFieldHeight: CGFloat = 35
    static let buttonWidth: CGFloat = 55
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
  
  let doneButton: UIButton = {
    let b = UIButton()
    b.setTitle("작성", for: .normal)
    b.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
    b.tintColor = .white
    b.backgroundColor = .mainGreenColor
    b.layer.cornerRadius = 15
    b.addTarget(self, action: #selector(onDone), for: .touchUpInside)
    return b
  }()
  
  // MARK: - View Life-Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
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
    toolbar.addSubview(commentTextField)
    toolbar.addSubview(doneButton)
    tableView.snp.makeConstraints {
      $0.leading.trailing.top.equalToSuperview()
      $0.bottom.equalTo(toolbar.snp.top)
    }
    
    toolbar.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalTo(view.safeAreaLayoutGuide)
      $0.height.equalTo(Metric.toolbarHeight)
    }
    
    commentTextField.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(Metric.leadingTrailingInset)
      $0.trailing.equalTo(doneButton.snp.leading).offset(-5)
      $0.centerY.equalTo(toolbar.snp.centerY)
      $0.height.equalTo(Metric.textFieldHeight)
    }
    
    doneButton.snp.makeConstraints {
      $0.leading.equalTo(commentTextField.snp.trailing).offset(5)
      $0.trailing.equalToSuperview().offset(-Metric.leadingTrailingInset)
      $0.centerY.equalTo(toolbar.snp.centerY)
      $0.height.equalTo(Metric.textFieldHeight)
      $0.width.equalTo(Metric.buttonWidth)
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
  
  @objc func onDone(_ sender: UIButton) {
    commentTextField.resignFirstResponder()
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
      let cell = tableView.dequeueReusableCell(withIdentifier: CommentListCell.identifier, for: indexPath)
      cell.selectionStyle = .none
      return cell
    }
  }
}
