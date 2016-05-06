//
//  HeaderTableViewCell.swift
//  TestTaskForJQ
//
//  Created by Виталий on 05.05.16.
//  Copyright © 2016 kvakvit. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var capture: UIImageView!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var kindSale: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var kind: UILabel!
    @IBOutlet weak var area: UILabel!
    @IBOutlet weak var bedrooms: UILabel!
    @IBOutlet weak var condition: UILabel!
    @IBOutlet weak var updateAt: UILabel!
    @IBOutlet weak var location: UILabel!
    
    var object: JQApi.Object? {
        didSet {
            if let setObjext = object {
                
                id.text = "ID: " + String(setObjext.id)
                if setObjext.kindSale == "direct_sell" {
                    kindSale.text = "Продажа"
                    price.text = "Цена: " + String(setObjext.price) + " руб"
                } else {
                    kindSale.text = "Аренда"
                    price.text = "Цена: " + String(setObjext.rentPrice) + " руб/месяц"
                }
                
                kind.text = "Тип: " + setObjext.kind
                area.text = "Площадь: " + String(setObjext.area)
                bedrooms.text = "Комнат: " + String(setObjext.bedrooms)
                condition.text = "Состояние: " + setObjext.condition               
                updateAt.text = "Обновлено: " + setObjext.updateAt
                location.text = setObjext.location
                if let url = NSURL(string: setObjext.capture) {
                    capture.setImageWithURL(url)
                }
                
            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
