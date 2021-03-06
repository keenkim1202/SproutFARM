//
//  PostListViewController.swift
//  SproutFARM
//
//  Created by KEEN on 2022/01/03.
//

import UIKit

class PostListViewController: BaseViewController {
  
  // MARK: - Metric
  struct Metric {
    static let buttonHeight: CGFloat = 60
  }
  
  // MARK: - Properties
  var user: User?
  var postList: [Post] = []
  var start: Int = 0
  let limit: Int = 10
  
  // MARK: - UI
  let tableView: UITableView = {
    let t = UITableView()
    t.cellLayoutMarginsFollowReadableWidth = false
    t.separatorInset.left = 0
    return t
  }()
  
  let addButton: UIButton = {
    let b = UIButton()
    b.setImage(UIImage(systemName: "plus"), for: .normal)
    b.tintColor = .white
    b.backgroundColor = .mainGreenColor
    b.layer.cornerRadius = 0.5 * Metric.buttonHeight
    b.layer.shadowOffset = CGSize(width: 2, height: 2)
    b.layer.shadowOpacity = 0.5
    b.addTarget(self, action: #selector(onAdd), for: .touchUpInside)
    return b
  }()
  
  let titleLabel: UILabel = {
    let l = UILabel()
    l.text = "새싹 농장"
    l.font = .systemFont(ofSize: 15, weight: .bold)
    return l
  }()
  
  // MARK: - View Life-Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setNavigationBar()
    setTableView()
    setConstaints()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.postList = []
    fetchPosts()
  }
  
  // MARK: - Configure
  func setNavigationBar() {
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
  }
  
  func setTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.prefetchDataSource = self
    tableView.register(PostListCell.self, forCellReuseIdentifier: PostListCell.identifier)
    tableView.register(PostListCommentCell.self, forCellReuseIdentifier: PostListCommentCell.identifier)
  }
  
  func setConstaints() {
    view.addSubview(tableView)
    view.addSubview(addButton)
    
    tableView.snp.makeConstraints {
      $0.edges.equalTo(view.safeAreaLayoutGuide)
    }
    
    addButton.snp.makeConstraints {
      $0.trailing.bottom.equalToSuperview().offset(-30)
      $0.width.height.equalTo(Metric.buttonHeight)
    }
  }
  
  // MARK: - HTTP Networking
  func fetchPosts(start: Int = 0, limit: Int = 10) {
    guard let user = user else { return }

    DispatchQueue.global().async {
      APIService.fetchPosts(token: user.jwt, start: start, limit: limit) { posts, error in
        guard error == nil else {
          UIAlertController.showAlert(self, contentType: .failToFetch, message: "데이터를 불러오는데 실패하였습니다.\n다시 시도해 주세요.")
          return
        }
        
        guard let posts = posts, !posts.isEmpty else { return }
        self.postList += posts
        self.start += limit
        
        DispatchQueue.main.async {
          self.tableView.reloadData()
        }
      }
    }
  }
  
  // MARK: - Action
  @objc func onAdd() {
    let vc = PostViewController()
    vc.user = user
    self.navigationController?.pushViewController(vc, animated: true)
  }
}

// MARK: - Extension
extension PostListViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return postList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let post = postList[indexPath.row]
    guard let cell = tableView.dequeueReusableCell(withIdentifier: PostListCell.identifier, for: indexPath) as? PostListCell else { return UITableViewCell() }
    
    if post.user.username.isEmpty {
      cell.postView.nicknameLabel.text = "(이름 없음)"
    } else {
      cell.postView.nicknameLabel.text = post.user.username
    }
    
    if !post.comments.isEmpty {
      cell.commentView.label.text = "댓글 \(post.comments.count)"
    }
    
    cell.postView.contentLabel.text = post.text
    
    let date = DateFormatter().toString(date: post.updatedAt)
    cell.postView.dateLabel.text = date
    cell.selectionStyle = .none
    return cell
  }

  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vc = DetailPostViewController()
    vc.post = postList[indexPath.row]
    vc.user = user
    
    self.navigationController?.pushViewController(vc, animated: true)
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if scrollView.contentOffset.y <= 0 {
      self.navigationController?.setNavigationBarHidden(false, animated: true)
    } else {
      self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
  }
}

extension PostListViewController: UITableViewDataSourcePrefetching {
  func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
    for indexPath in indexPaths {
      if (postList.count - 1 == indexPath.row) {
        fetchPosts(start: limit + start)
      }
    }
  }
  
  func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
   // print("최소 - \(indexPaths)")
  }

}
