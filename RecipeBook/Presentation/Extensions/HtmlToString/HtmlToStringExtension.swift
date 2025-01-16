//
//  HtmlToStringExtension.swift
//  RecipeBook
//
//  Created by Daniil on 16.01.25.
//

import SwiftUI


extension String {
    func htmlToString() -> String {
        return  try! NSAttributedString(data: self.data(using: .utf8)!,
                                        options: [.documentType: NSAttributedString.DocumentType.html],
                                        documentAttributes: nil).string
    }
}
