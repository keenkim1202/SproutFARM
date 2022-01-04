//
//  PostListViewController.swift
//  SproutFARM
//
//  Created by KEEN on 2022/01/03.
//

import UIKit
import SnapKit

class PostListViewController: BaseViewController {
  
  // MARK: - UI
  let tableView = UITableView()
  
  // MARK: - View Life-Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.title = "새싹 농장"
    
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(PostListCell.self, forCellReuseIdentifier: PostListCell.identifier)
    setConstaints()
  }
  
  // MARK: - Configure
  func setConstaints() {
    view.addSubview(tableView)
    tableView.snp.makeConstraints {
      $0.edges.equalToSuperview()
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
    let cell = tableView.dequeueReusableCell(withIdentifier: PostListCell.identifier, for: indexPath)
    return cell
  }
}
