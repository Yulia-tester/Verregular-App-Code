//
//  SelectVerbsViewController.swift
//  Verregular App-Code
//
//  Created by Юлия Дегтярева on 2025-04-19.
//

import UIKit

final class SelectVerbsViewController: UITableViewController {
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        tableView.register(SelectVerbTableViewCell.self,
                           forCellReuseIdentifier: "SelectVerbTableViewCell")
    }
}

// MARK: - UITableViewDataSource
extension SelectVerbsViewController {
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SelectVerbTableViewCell",
                                                 for: indexPath) as? SelectVerbTableViewCell else {
            return UITableViewCell() }
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SelectVerbsViewController {
    
}
