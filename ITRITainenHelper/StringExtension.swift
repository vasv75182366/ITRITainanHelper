//
//  StringExtension.swift
//  ITRITainenHelper
//
//  Created by Oslo on 3/25/17.
//  Copyright © 2017 uscc. All rights reserved.
//

import Foundation

extension String {
    
    func localized(language: String) -> String {
        let path = Bundle.main.path(forResource: language, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
    
}
