//
//  AddItemListViewController.swift
//  filmnia
//
//  Created by UserTQI on 27/05/20.
//  Copyright © 2020 lucrodrigs. All rights reserved.
//

import UIKit

class AddItemListViewController: UIViewController {
    
    @IBOutlet weak var tableViewList: UITableView!
    @IBOutlet weak var titleAddItem: UILabel!
    
    var viewModel: AddItemListViewModel?
    var profileDelegate: ProfileViewDelegate?
    var didAddToListDelegate: AddItemToListDelegate?
    var resultsList = ResultList(results: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        titleView()
        viewModel?.profileDelegate = self
        viewModel?.delegateAlert = self
        tableViewList.dataSource = self
        tableViewList.delegate = self
        viewModel?.showYourlists()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundOriginal")!)
        self.tableViewList.backgroundColor = .clear
    }
    
    init(viewModel: AddItemListViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupTableView() {
        tableViewList.register(UINib(nibName: "YourlistTableViewCell", bundle: nil), forCellReuseIdentifier: "YourlistTableViewCell")
    }
    
    func titleView() {
        titleAddItem.font = UIFont(name: "Gilroy-SemiBold", size: titleAddItem.font.pointSize)
        titleAddItem.textColor = .white
    }
    
    func closeDetails() {
        self.dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }

    @IBAction func closeAction(_ sender: Any) {
        closeDetails()
    }
    
}

extension AddItemListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsList.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewList.dequeueReusableCell(withIdentifier: "YourlistTableViewCell") as? YourlistTableViewCell
        cell?.setup(data: resultsList.results[indexPath.row])
        cell?.backgroundColor = .clear
        return cell ?? TableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let lists = resultsList.results[indexPath.row]
        viewModel?.addItemToList(selectedList: lists.id ?? 0)
    }
    
}

extension AddItemListViewController: ProfileViewDelegate, AlertDelegate {

    func alertMarks(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: closeAction(_:)))
        self.present(alert, animated: true, completion: nil)
    }
    
    func reloadLists() {}
    
    func showImagePosters(resultPoster: ResultsGeneral) {}
    
    func detailsProfile() {}
    
    func showLists(list: ResultList) {
        self.resultsList = list
        tableViewList.reloadData()
    }
    
}
