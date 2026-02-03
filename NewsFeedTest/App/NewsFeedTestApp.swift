//
//  NewsFeedTestApp.swift
//  NewsFeedTest
//
//  Created by Andolsi Ahmed Amine on 02/02/2026.
//

import SwiftUI

@main
struct NewsFeedTestApp: App {
    var body: some Scene {
        WindowGroup {
            let apiClient = APIClient()
            let configurationManager = ConfigurationManager()
            let apiConfiguration = NewsAPIConfiguration(configuration: configurationManager)
            let remoteDataSource = RemoteNewsDataSource(
                apiClient: apiClient,
                apiConfiguration: apiConfiguration
            )
            let repository = NewsRepositoryImpl(dataSource: remoteDataSource)
            let fetchNewsUseCase = FetchNewsUseCaseImpl(repository: repository)
            let viewModel = NewsViewModel(useCase: fetchNewsUseCase)
            NewsRootView(viewModel: viewModel)
        }
    }
}

