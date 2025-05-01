//
//  StartupViewModel.swift
//  Bartender
//
//  Created by Oleh Zimin on 16.04.2025.
//

import Foundation

@Observable
class StartupViewModel {
    private let repositoryManager = RepositoryManager.shared
    
    private(set) var isShowingSplash = true
    
    func fetchData() async {
        await repositoryManager.fetchNewData()
        isShowingSplash = false
    }
}
