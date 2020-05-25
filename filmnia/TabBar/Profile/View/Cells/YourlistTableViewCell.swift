//
//  YourlistTableViewCell.swift
//  filmnia
//
//  Created by Lucas Rodrigues Dias on 12/05/20.
//  Copyright © 2020 lucrodrigs. All rights reserved.
//

import UIKit

class YourlistTableViewCell: UITableViewCell {
    
    @IBOutlet weak var listPoster: UIImageView!
    @IBOutlet weak var listName: UILabel!
    @IBOutlet weak var listDescription: UILabel!
    @IBOutlet weak var listItensCount: UILabel!
    @IBOutlet weak var tableViewCell: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cornerRadiusPoster()
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }
    
    func urlShowImage(path: String) {
        if let url = URL(string: path) {
            listPoster.downloadImage(from: url)
        }
    }
    
    func cornerRadiusPoster() {
        listPoster.layer.cornerRadius = listPoster.frame.size.width/7.5
    }
    
    func setup(data: List) {
        listName.text = data.name
        listName.textColor = .white
        listName.font = UIFont(name: "Gilroy-SemiBold", size: listName.font.pointSize)
        listDescription.text = data.resultDescription
        listDescription.textColor = .ColorGrayDefault
        listDescription.font = UIFont(name: "Gilroy-SemiBold", size: listDescription.font.pointSize)
        let count = data.itensCount
        listItensCount.text = "itens in list: " + String(count ?? 0)
        listItensCount.textColor = .ColorLightYellow
        listItensCount.font = UIFont(name: "Gilroy-SemiBold", size: listItensCount.font.pointSize)
    }
    
}
