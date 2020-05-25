//
//  YourlistViewController.swift
//  filmnia
//
//  Created by Lucas Rodrigues Dias on 21/05/20.
//  Copyright © 2020 lucrodrigs. All rights reserved.
//

import UIKit

class YourlistViewController: UIViewController {
    
    @IBOutlet weak var namelist: UILabel!
    @IBOutlet weak var descriptionlist: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: YourlistViewModel?
    var resultRequest: DetailsList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.getDetailsList()
        viewModel?.delegate = self
    }
    
    init(viewModel: YourlistViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func listName() {
        namelist.text = viewModel?.detailslist?.name
    }
    
    func descriptionList() {
        descriptionlist.text = viewModel?.detailslist?.description
    }
    
    func closeDetails() {
        self.dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func closeButtonAction(_ sender: UIButton) {
        closeDetails()
    }
    
}

extension YourlistViewController: DetailsListDelegate {
    
    func detailsList() {
        listName()
        descriptionList()
    }
    
    func showImagePosters(resultPoster: DetailsList) {
        resultRequest = resultPoster
        collectionView.reloadData()
    }
    
}
