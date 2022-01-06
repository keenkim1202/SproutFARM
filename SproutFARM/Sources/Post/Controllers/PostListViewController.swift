//
//  PostListViewController.swift
//  SproutFARM
//
//  Created by KEEN on 2022/01/03.
//

import UIKit

// TODO: Pagination 구현하기

class PostListViewController: BaseViewController {
  
  // MARK: - Metric
  struct Metric {
    static let buttonHeight: CGFloat = 60
  }
  
  // MARK: - Properties
  // private var viewModel = PostViewModel()
  var user: User?
  var postList: [FramPost] = []
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
  
  // MARK: - View Life-Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let label = UILabel()
    label.text = "새싹 농장"
    label.font = .systemFont(ofSize: 15, weight: .bold)
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: label)
    setTableView()
    setConstaints()
    
    // self.viewModel.user = user
    // self.viewModel.fetchPosts()
    //
    // viewModel.post?.bind { post in
    //   self.tableView.reloadData()
    // }
    guard let user = user else { return }
    print("user OK")
    APIService.fetchPosts(token: user.jwt, start: start, limit: limit) { post, error in
      guard error == nil else {
        print("ERROR -\(error)")
        UIAlertController.showAlert(self, contentType: .failToFetch, message: "데이터를 불러오는데 실패하였습니다.\n다시 시도해 주세요.")
        return
      }
    
      guard let post = post else {
        print("post 없음")
        return
      }

      // postList.append(post)
    }
  }

  // MARK: - Configure
  func setTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(PostListCell.self, forCellReuseIdentifier: PostListCell.identifier)
    tableView.register(PostListCommentCell.self, forCellReuseIdentifier: PostListCommentCell.identifier)
  }
  
  func setConstaints() {
    view.addSubview(tableView)
    view.addSubview(addButton)
    
    tableView.snp.makeConstraints {
      $0.edges.equalTo(view.snp.edges)
    }
    
    addButton.snp.makeConstraints {
      $0.trailing.bottom.equalToSuperview().offset(-30)
      $0.width.height.equalTo(Metric.buttonHeight)
    }
  }
  
  // MARK: - Action
  @objc func onAdd() {
    self.navigationController?.pushViewController(PostViewController(), animated: true)
  }
}

// MARK: - Extension
extension PostListViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 20
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.row % 2 == 0 {
      let cell = tableView.dequeueReusableCell(withIdentifier: PostListCell.identifier, for: indexPath)
      cell.selectionStyle = .none
      return cell
    } else {
      let cell = tableView.dequeueReusableCell(withIdentifier: PostListCommentCell.identifier, for: indexPath)
      cell.selectionStyle = .none
      return cell
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.navigationController?.pushViewController(DetailPostViewController(), animated: true)
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
      if scrollView.contentOffset.y <= 0 {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
      } else {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
      }
  }
}
