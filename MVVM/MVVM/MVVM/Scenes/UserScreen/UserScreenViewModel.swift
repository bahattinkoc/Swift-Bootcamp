//
//  UserScreenViewModel.swift
//  MVVM
//
//  Created by Bahattin Koç on 6.04.2022.
//

import NetworkAPI

// MARK: - PROTOCOLS
protocol UserScreenViewModelProtocol {
    var delegate: UserScreenViewModelDelegate? { get set }
    var userCount: Int { get }
    func loadUsers()
    func user(index: Int) -> User?
}

protocol UserScreenViewModelDelegate: AnyObject {
    func reloadData()
}

// MARK: - CLASS
final class UserScreenViewModel {
    weak var delegate: UserScreenViewModelDelegate?
    private let service: NetworkServiceProtocol
    private var users: [User] = []
    
    init(service: NetworkServiceProtocol) {
        self.service = service
    }
    
    fileprivate func fetchUsers() {
        service.fetchData(urlString: URLs.userURL.rawValue) { [weak self] (response: Result<[User], Error>) in
            guard let self = self else { return }
            if case .success(let users) = response {
                self.users = users
                self.delegate?.reloadData()
            } else if case .failure(let error) = response {
                print("UserScreenViewModel fetchUsers failure. Msg: \(error)")
            }
        }
    }
}

// MARK: - EXTENSIONS
extension UserScreenViewModel: UserScreenViewModelProtocol {
    func user(index: Int) -> User? {
        users.getAt(at: index)
    }
    
    var userCount: Int {
        users.count
    }
    
    func loadUsers() {
        fetchUsers()
    }
}
