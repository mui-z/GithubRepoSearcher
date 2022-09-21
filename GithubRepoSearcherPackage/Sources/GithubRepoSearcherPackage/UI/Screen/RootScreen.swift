//
//  SwiftUIView.swift
//  
//
//  Created by osushi on 2022/09/18.
//

import SwiftUI
import Factory

public struct RootScreen: View {
    public init() {
    }

    @StateObject private var flowRouter = SearchFlowRouter.shared
    public var body: some View {
        NavigationStack(path: $flowRouter.navigationPath) {
            SearchScreen()
                .navigationBarTitleDisplayMode(.large)
        }
    }
}
