//
//  LoadingVIewController2+Constraints.swift
//  CovidTracker
//
//  Created by Trung Vo on 11/4/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import UIKit
import SnapKit

extension LoadingViewController2 {
    func setupConstraints() {
        imageView.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(200)
        }
    }
}
