//
//  File.swift
//  
//
//  Created by osushi on 2022/09/18.
//

import Foundation
import Combine
import Factory
import SwiftUI

@MainActor
class SearchScreenViewModel: ObservableObject {
    @Published var githubRepos = [GithubRepo]()
    @Published var searchedKeyword = ""
    @Published var isLoading = false

    private var router = SearchFlowRouter.shared

    private var useCase = Container.githubRepoSearchUseCase()

    func searchRepos(keyword: String) {
        Task {
            isLoading = true
            let result = await useCase.searchGithubRepos(keyword: keyword)
            switch result {
            case .success(let repo):
                githubRepos = repo
            case .failure(_):
                githubRepos = []
            }

            searchedKeyword = keyword
            isLoading = false
        }
    }

    func triggerTransition(route: SearchFlowRouter.PushRoute) {
        router.triggerScreenTransition(route: route)
    }

    func nextScreen() -> some View {
        router.nextTransitionScreen()
    }
}
