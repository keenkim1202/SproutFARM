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
  var keyHeight: CGFloat?
  var user: User?
  var post: Post?
  var commentList: [Comment] = []
  var isKeyboardAppear: Bool = false
  
  // MARK: - UI
  let tableView: UITableView = {
    let t = UITableView()
    t.cellLayoutMarginsFollowReadableWidth = false
    t.keyboardDismissMode = .onDrag
    t.separatorInset.left = 0
    return t
  }()
  
  let toolbar: DetailToolbar = {
    let t = DetailToolbar()
    t.doneButton.addTarget(self, action: #selector(onWrite), for: .touchUpInside)
    return t
  }()
  
  // MARK: - View Life-Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setNagivationBar()
    setTableView()
    setConstaints()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.addKeyboardNotifications()
    
    fetchComments()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    self.removeKeyboardNotifications()
  }

  
  // MARK: - Configure
  func setNagivationBar() {
    self.navigationController?.setNavigationBarHidden(false, animated: true)
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .plain, target: self, action: #selector(onEditPost))
  }
  
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
      $0.leading.trailing.top.equalTo(view.safeAreaLayoutGuide)
      $0.bottom.equalTo(toolbar.snp.top)
    }
    
    toolbar.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalTo(view.safeAreaLayoutGuide)
      $0.height.equalTo(Metric.toolbarHeight)
    }
  }
  
  func addKeyboardNotifications() {
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(self.keyboardWillShow),
      name: UIResponder.keyboardWillShowNotification
      ,object: nil)
  
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(self.keyboardWillHide),
      name: UIResponder.keyboardWillHideNotification,
      object: nil)
  }
  
  func removeKeyboardNotifications() {
    NotificationCenter.default.removeObserver(
      self,
      name: UIResponder.keyboardWillShowNotification,
      object: nil)
  
    NotificationCenter.default.removeObserver(
      self,
      name: UIResponder.keyboardWillHideNotification,
      object: nil)
  }

  // MARK: - HTTP Networking
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
    } else {
      UIAlertController.showAlert(self, contentType: .etc, message: "해당 포스트가 존재하지 않습니다..")
    }
  }
  
  func writeComment(comment: String) {
    if let user = user, let post = post {
      APIService.writeComment(token: user.jwt, comment: comment, postID: post.id) { error in
        guard error == nil else {
          UIAlertController.showAlert(self, contentType: .failToWrite, message: "댓글 작성에 실패하였습니다.\n다시 시도해 주세요.")
          return
        }
      }
      
      self.toolbar.commentTextField.text = ""
      self.fetchComments()
    }
  }
  
  func deleteComment(token: String, commentID: Int) {
    APIService.deleteComment(token: token, commentID: commentID) { error in
      guard error == nil else {
        UIAlertController.showAlert(self, contentType: .failToDelete, message: "댓글 삭제에 실패하였습니다.\n다시시도 해주세요.")
        return
      }
    }
    
    UIAlertController.showAlert(self, contentType: .success, message: "댓글 삭제 완료!") { _ in 
      self.fetchComments()
    }
  }
  
  // MARK: - Keyboard
  @objc private func keyboardWillShow(_ notification: NSNotification) {
    print(#function)
    if !isKeyboardAppear {
      if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
      
        self.view.frame.origin.y -= keyboardHeight
      }
      
      isKeyboardAppear = true
    }
  }
  
  @objc private func keyboardWillHide(_ notification: NSNotification) {
    print(#function)
    if isKeyboardAppear {
      if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
      
        self.view.frame.origin.y += keyboardHeight
      }
      
      isKeyboardAppear = false
    }
  }
  
  // MARK: - Actions
  @objc func onWrite(_ sender: UIButton) {
    let text = toolbar.commentTextField.text!

    writeComment(comment: text)
    toolbar.commentTextField.resignFirstResponder()
    
  }
  
  @objc func onEditPost() {
    let vc = PostViewController()
    vc.viewType = .update
    vc.user = user
    vc.post = post
    
    if let user = user, let post = post, user.user.id == post.user.id { // 본인이 작성한 포스트일 경우
      showAlertMenu(message: "포스트 관리", vc: vc) {
        APIService.deletePost(token: user.jwt, postID: post.id) { error in
          
          guard error == nil else {
            UIAlertController.showAlert(self, contentType: .failToDelete, message: "삭제에 실패하였습니다.\n다시시도 해주세요.")
            return
          }
        }
        
        UIAlertController.sucessAlert(self, contentType: .success, message: "포스트 삭제가 완료되었습니다.")
      }
    } else {
      UIAlertController.showAlert(self, contentType: .etc, message: "본인이 작성한 포스트가 아닙니다.")
    }
  }
}

// MARK: - Extension
extension DetailPostViewController: UITableViewDelegate, UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
      return 3
    } else {
      return commentList.count
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.section == 0 {
      if indexPath.row == 0 { // profile
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileCell.identifier, for: indexPath) as? ProfileCell else { return UITableViewCell() }
        
        if let post = post {
          if post.user.username.isEmpty {
            cell.nicknameLabel.text = "(이름 없음)"
          } else {
            cell.nicknameLabel.text = post.user.username
          }

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
        
        if !commentList.isEmpty {
          cell.label.text = "댓글 \(commentList.count)"
        }
        
        cell.selectionStyle = .none
        return cell
      } else {
        return UITableViewCell()
      }
    } else { // comment content
      guard let cell = tableView.dequeueReusableCell(withIdentifier: CommentListCell.identifier, for: indexPath) as? CommentListCell else { return UITableViewCell() }
      let comment = commentList[indexPath.row]
      
      if comment.user.username.isEmpty {
        cell.nicknameLabel.text = "(이름 없음)"
      } else {
        cell.nicknameLabel.text = comment.user.username
      }
      
      cell.contentLabel.text = comment.comment
      
      let date = DateFormatter().toString(date: comment.updatedAt)
      cell.dateLabel.text = date
      cell.selectionStyle = .none
      return cell
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.section == 1 {
      let seletedComment = commentList[indexPath.row]
      
      if let user = user, user.user.id == seletedComment.user.id { // 본인이 댓글 작성자일 경우
        let vc = EditCommentViewController()
        vc.user = user
        vc.comment = seletedComment
        
        showAlertMenu(message: "댓글 관리", vc: vc) {
          self.deleteComment(token: user.jwt, commentID: seletedComment.id)
        }
      } else {
        UIAlertController.showAlert(self, contentType: .etc, message: "본인이 작성한 댓글만 수정할 수 있습니다.")
      }
    }
  }
}
