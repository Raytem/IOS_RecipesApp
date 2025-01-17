//
//  OnNotificationExtension.swift
//  RecipeBook
//
//  Created by Daniil on 17.01.25.
//

import Foundation
import SwiftUI

extension View {
    func onNotification(_ name: NSNotification.Name, perform action: @escaping () -> Void) -> some View {
        self.onReceive(NotificationCenter.default.publisher(for: name)) { _ in
            action()
        }
    }
}
