//
//  Extensions.swift
//  Think360
//
//  Created by admin on 14/04/19.
//  Copyright © 2019 AcknoTech. All rights reserved.
//

import UIKit

//StackView Function
func stackViews(views:[UIView])->UIStackView{
    let stackView = UIStackView(arrangedSubviews: views)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
}
