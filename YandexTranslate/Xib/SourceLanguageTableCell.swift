//
//  SourceLanguageTableCell.swift
//  YandexTranslate
//
//  Created by Nikolay Lukyanchikov on 16.02.2020.
//  Copyright © 2020 Nikolay Lukyanchikov. All rights reserved.
//

import UIKit

class SourceLanguageTableCell: UITableViewCell {

    @IBOutlet weak var languageLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configurateWithText(_ text: String, isBold: Bool) {
        
        var strokeTextAttributes = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15)] as [NSAttributedString.Key : Any]
        if isBold {
            strokeTextAttributes = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)]
        }
        languageLabel.attributedText = NSMutableAttributedString(string: text, attributes: strokeTextAttributes)

    }
    
}
