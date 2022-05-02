//
//  AccountSummaryViewController.swift
//  Bankiii
//
//  Created by Johel Zarco on 24/04/22.
//

import UIKit

class AccountSummaryViewController: UIViewController {
    
    var accounts : [AccountSummaryCell.ViewModel] = []
    
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
        fetchData()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        // app background
        tableView.backgroundColor = appColor// so when you drag down the table there is no white gap
        // register cell to tableView
        tableView.register(AccountSummaryCell.self, forCellReuseIdentifier: AccountSummaryCell.reuseID)
        tableView.rowHeight = AccountSummaryCell.rowHeight
        tableView.tableFooterView = UIView() // define NO footer view
        
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
        guard !accounts.isEmpty else { return UITableViewCell()}
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.reuseID, for: indexPath) as! AccountSummaryCell
        let account = accounts[indexPath.row]
        cell.configure(with: account)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }
}

extension AccountSummaryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}

extension AccountSummaryViewController {
    private func fetchData() {
        let savings = AccountSummaryCell.ViewModel(accountType: .Banking, accountName: "Basic Savings", balance: 929466.23)
        let chequing = AccountSummaryCell.ViewModel(accountType: .Banking, accountName: "No-Fee All-In Chequing", balance: 17562.44)
        let visa = AccountSummaryCell.ViewModel(accountType: .CreditCard, accountName: "Visa Avion Card", balance: 412.83)
        let masterCard = AccountSummaryCell.ViewModel(accountType: .CreditCard, accountName: "Student Mastercard", balance: 50.83)
        let investment1 = AccountSummaryCell.ViewModel(accountType: .Investment, accountName: "Tax-Free Saver", balance: 2000.00)
        let investment2 = AccountSummaryCell.ViewModel(accountType: .Investment, accountName: "Growth Fund", balance: 15000.00)

        accounts.append(savings)
        accounts.append(chequing)
        accounts.append(visa)
        accounts.append(masterCard)
        accounts.append(investment1)
        accounts.append(investment2)
    }
}
