//
//  AccountSummaryViewController.swift
//  Bankiii
//
//  Created by Johel Zarco on 24/04/22.
//

import UIKit

class AccountSummaryViewController: UIViewController {
    
    let games = [
        "Pacman",
        "Space Invaders",
        "Space Patrol",
        "Call of Duty",
        "Pong"
    ]
    
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension AccountSummaryViewController {
    private func setup() {
        setupTableView()
        setupTableHeaderView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        // pin to every edge
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupTableHeaderView(){
        // Initially created with zero size
        let header = AccountSummaryHeaderView(frame: .zero) // CGRect(x: 0, y: 0, width: 0, height: 0)
        // size is like a tuple(width, height). .systemLayoutSizeFitting() Returns the optimal size of the view based on its current constraints.
        var size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)// The option to use the smallest possible size.
        // width take from current device
        size.width = UIScreen.main.bounds.width
        // header height comes was defined on intrinsic content size method, 144 points
        header.frame.size = size
        //  .tableHeaderView is a pre defined property of UITableView()
        tableView.tableHeaderView = header
        // Use this property to specify a header view for your entire table.
        // The header view is the first item to appear in the table's view's scrolling content,
        // and it is separate from the header views you add to individual sections
    }
}

extension AccountSummaryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = games[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
}

extension AccountSummaryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
