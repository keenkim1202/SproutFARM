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
  var keyHeight: CGFloat = 0
  var user: User?
  var post: Post?
  var commentList: [Comment] = []
  var isKeyboardAppear: Bool = false
  
  // MARK: - UI
  let commentListView = CommentListView()
  
  // MARK: - View Life-Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setNagivationBar()
    setCommentListView()
    setConstraints()
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
  
  func setCommentListView() {
    commentListView.tableView.delegate = self
    commentListView.tableView.dataSource = self
    commentListView.toolbar.doneButton.addTarget(self, action: #selector(onWrite), for: .touchUpInside)
    // TODO: tableview cell에 editComment() addtarget 하기
  }
  
  func setConstraints() {
    view.addSubview(commentListView)
    
    commentListView.snp.makeConstraints {
      $0.edges.equalTo(view.safeAreaLayoutGuide)
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
          self.commentListView.tableView.reloadData()
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
      
      self.commentListView.toolbar.commentTextField.text = ""
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
    // safearea에 제약조건을 설정해서 생기는 문제 같음. 기종에 따라 view를 기준으로 제약조건을 잡으면 해결되지 않을까?
    if !isKeyboardAppear {
      if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = (keyboardRectangle.height - view.safeAreaInsets.bottom)
    
        self.view.frame.origin.y -= keyboardHeight
      }
      
      isKeyboardAppear = true
    }
    
    commentListView.toolbar.commentTextField.layoutIfNeeded()
  }
  
  @objc private func keyboardWillHide(_ notification: NSNotification) {
    if isKeyboardAppear {
      if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = (keyboardRectangle.height  - view.safeAreaInsets.bottom)
      
        self.view.frame.origin.y += keyboardHeight
      }
      
      isKeyboardAppear = false
    }
  }
  
  // MARK: - Actions
  @objc func onWrite(_ sender: UIButton) {
    let text = commentListView.toolbar.commentTextField.text!
    writeComment(comment: text)
    self.commentListView.toolbar.commentTextField.resignFirstResponder()
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
  
  // MARK: - Action
  @objc func onEditComment(sender: UIButton) {
    var superview = sender.superview
    while let view = superview, !(view is UITableViewCell) {
      superview = view.superview
    }
    guard let cell = superview as? UITableViewCell else {
      print("button is not contained in a table view cell")
      return
    }
    
    guard let indexPath = commentListView.tableView.indexPath(for: cell) else {
      print("failed to get index path for cell containing button")
      return
    }
    
    print("button is in row \(indexPath.row)")
    
    let comment = commentList[indexPath.row]
    if let user = user, user.user.id == comment.user.id { // 본인이 댓글 작성자일 경우
      let vc = EditCommentViewController()
      vc.user = user
      vc.comment = comment
    
      showAlertMenu(message: "댓글 관리", vc: vc) {
        self.deleteComment(token: user.jwt, commentID: comment.id)
      }
    } else {
      UIAlertController.showAlert(self, contentType: .etc, message: "본인이 작성한 댓글만 수정할 수 있습니다.")
    }
  }
}
