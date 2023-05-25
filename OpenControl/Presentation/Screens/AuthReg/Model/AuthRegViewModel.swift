//
//  AuthRegViewModel.swift
//  OpenControl
//
//  Created by Vladislav Panev on 23.05.2023.
//

import Foundation

struct AuthRegViewModel {
    
    let sections: [Section]
    
    struct Section {
        
        let rows: [Row]
        let name: String?
        
        struct Row {
            
            let configurator: TableCellConfiguratorProtocol
           
            var reuseId: String {
                return type(of: configurator).reuseId
            }
        }

        init(rows: [Row], name: String? = nil) {
            self.rows = rows
            self.name = name
        }
    }
    
    init(sections: [Section]) {
        self.sections = sections
    }
}
