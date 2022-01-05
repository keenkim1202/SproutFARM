//
//  PostListViewController.swift
//  SproutFARM
//
//  Created by KEEN on 2022/01/03.
//

import UIKit
import SnapKit

class PostListViewController: BaseViewController {
  
  // MARK: - Metric
  struct Metric {
    static let buttonHeight: CGFloat = 60
  }
  
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
    return b
  }()
  
  // MARK: - View Life-Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.title = "새싹 농장"

    setTableView()
    setConstaints()
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
      $0.edges.equalToSuperview()
    }
    
    addButton.snp.makeConstraints {
      $0.trailing.bottom.equalToSuperview().offset(-30)
      $0.width.height.equalTo(Metric.buttonHeight)
    }
  }
  
  // MARK: - Action
  
}

// MARK: - Extension
extension PostListViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10 // test
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
}
