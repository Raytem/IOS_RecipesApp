//
//  AppearanceManager.swift
//  RecipeBook
//
//  Created by Daniil on 8.01.25.
//

import SwiftUI

struct AppearanceManager {
    static func configure() {
        // UISearchBar
        UISearchBar.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).tintColor = .toolbarItemAccent
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = .backgroundSearch
//        UISearchBar.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).setImage(<your search image, e.g., magnifyingGlassImage>, for: .search, state: .normal)
//        UISearchBar.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).setImage(<your clear image, e.g., closeImage>, for: .clear, state: .normal)
//        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(.neaturalWhite)]
       
//        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .red
        
//        UISearchTextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: "Search", attributes: [.foregroundColor: Color(.red)])
        
                
        // UIAlertController
        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = UIColor(Color.primary50)
        
        // Segmented picker
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(.primary50)], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(.primary50)], for: .normal)
    }
}

extension UINavigationController {
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        // Hide back button text
        navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
