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
  
  // MARK: - Properties
  // let minimumHeight: CGFloat = 80
  var keyHeight: CGFloat?
  var user: User?
  var post: Post?
  var commentList: [Comment] = []
  
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
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .plain, target: self, action: #selector(onEditPost))
    setTableView()
    setConstaints()
    fetchComments()
    addKeyboardNotification()
  }
  
  // MARK: - Configure
  func setTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(ProfileCell.self, forCellReuseIdentifier: ProfileCell.identifier)
    tableView.register(CommentPostCell.self, forCellReuseIdentifier: CommentPostCell.identifier)
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
  
  // MARK: - Data
  func fetchComments() {
    if let user = user, let post = post {
      APIService.fetchComments(token: user.jwt, postID: post.id) { comments, error in
        guard error == nil else {
          UIAlertController.showAlert(self, contentType: .failToFetch, message: "댓글을 불러오는데 실패하였습니다.\n다시 시도해 주세요.")
          return
        }
        
        guard let comments = comments else { return }
        self.commentList = comments
        
        DispatchQueue.main.async {
          self.tableView.reloadData()
        }
      }
    }
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
  
  @objc func onEditPost() {
    let vc = PostViewController()
    vc.viewType = .update
    self.navigationController?.pushViewController(vc, animated: true)
  }
}

// MARK: - Extension
extension DetailPostViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return commentList.count + 3
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.row == 0 { // profile
      guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileCell.identifier, for: indexPath) as? ProfileCell else { return UITableViewCell() }
      if let post = post {
        cell.nicknameLabel.text = post.user.username
        let date = DateFormatter().toString(date: post.updatedAt)
        cell.dateLabel.text = date
      }
      cell.selectionStyle = .none
      return cell
    } else if indexPath.row == 1 { // post content
      guard let cell = tableView.dequeueReusableCell(withIdentifier: CommentPostCell.identifier, for: indexPath) as? CommentPostCell else { return UITableViewCell() }
      if let post = post {
        cell.postTextLabel.text = post.text
      }
      cell.selectionStyle = .none
      return cell
    } else if indexPath.row == 2 { // comment
      guard let cell = tableView.dequeueReusableCell(withIdentifier: PostListCommentCell.identifier, for: indexPath) as? PostListCommentCell else { return UITableViewCell() }
      cell.selectionStyle = .none
      return cell
    } else { // comment content
      guard let cell = tableView.dequeueReusableCell(withIdentifier: CommentListCell.identifier, for: indexPath) as? CommentListCell else { return UITableViewCell() }
      
      let comment = commentList[indexPath.row]
      cell.nicknameLabel.text = comment.user.username
      cell.contentLabel.text = comment.comment
      cell.selectionStyle = .none
      return cell
    }
  }
  
  // func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
  //   if indexPath.row == 1 { // post content
  //     print(UITableView.automaticDimension)
  //     return (UITableView.automaticDimension < minimumHeight) ? UITableView.automaticDimension : minimumHeight
  //   } else {
  //     return UITableView.automaticDimension
  //   }
  // }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.row > 2 {
      showAlertMenu(message: "댓글 관리")
    }
  }
}
