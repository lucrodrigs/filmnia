//
//  CreateNewListViewController.swift
//  filmnia
//
//  Created by Lucas Rodrigues Dias on 21/05/20.
//  Copyright © 2020 lucrodrigs. All rights reserved.
//

import UIKit

class CreateNewListViewController: UIViewController {
    
    @IBOutlet weak var namelist: UITextField!
    @IBOutlet weak var descriptionlist: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableViewList: UITableView!
    @IBOutlet weak var buttonCreate: UIButton!
    
    var viewModel: CreateNewListViewModel?
    var resultsList = ResultList(results: [])
    var didSelectDelegate: DetailsSelectDelegate?
    var profileDelegate: ProfileViewDelegate?
    var didCreateDelegate: CreateListDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setupTitle()
        setupTableView()
        buttonDesing()
        tableViewList.dataSource = self
        tableViewList.delegate = self
        viewModel?.profileDelegate = self
        viewModel?.showYourlists()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundOriginal")!)
        self.tableViewList.backgroundColor = .clear
    }
    
    init(viewModel: CreateNewListViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupTableView() {
        tableViewList.register(UINib(nibName: "YourlistTableViewCell", bundle: nil), forCellReuseIdentifier: "YourlistTableViewCell")
    }
    
    func buttonDesing() {
        buttonCreate.layer.cornerRadius = buttonCreate.frame.size.width/9.5
        buttonCreate.titleLabel?.font = UIFont(name: "Gilroy-SemiBold", size: 18)
        buttonCreate.setTitleColor(.ColorGrayDefault, for: .normal)
    }
    
    @IBAction func createListAction(_ sender: UIButton) {
        createNewListAction()
        closeNewList()
    }
    
    func setupTitle() {
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: "Gilroy-SemiBold", size: titleLabel.font.pointSize)
    }
    
    func createNewListAction(){
        let listname: String? = namelist.text
        let listdescription: String? = descriptionlist.text
        viewModel?.createNewList(namelist: listname ?? "", descriptionlist: listdescription ?? "")
    }
    
    @IBAction func closeCreateNewList(_ sender: UIButton) {
        closeNewList()
    }
    
    func closeNewList() {
        self.dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }
    
}

extension CreateNewListViewController: UITableViewDelegate, UITableViewDataSource {
    
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
    
}

extension CreateNewListViewController: ProfileViewDelegate {
    
    func reloadLists() {}
    
    func showImagePosters(resultPoster: ResultsGeneral) {}
    
    func detailsProfile() {}
    
    func showLists(list: ResultList) {
        self.resultsList = list
        tableViewList.reloadData()
    }
    
}
