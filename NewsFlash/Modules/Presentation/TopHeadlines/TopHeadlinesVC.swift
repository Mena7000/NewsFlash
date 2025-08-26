//
//  TopHeadlinesVC.swift
//  NewsFlash
//
//  Created by Mena Maher on 8/26/25.
//

import UIKit

class TopHeadlinesVC: BaseVC {
//    @IBOutlet var headlinesTable: UITableView!
    
    var viewModel: TopHeadlinesVM = TopHeadlinesVM()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
//        bindVM()
    }

    deinit {
        print("💰💰💰💰 TopHeadlinesVC deallocated 💰💰💰💰")
    }

    func setupUI() {
//        headlinesTable.register
    }
    
    func bindVM() {
//        viewModel = MovieListVM(movieListUseCase: DependencyContainer.shared.resolveMovieListUseCase(),
//                                movieListType: movieListType)

        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                self?.activityView(isLoading: value)
            }
            .store(in: &viewModel.cancellables)

//        viewModel.$error
//            .receive(on: DispatchQueue.main)
//            .sink { [weak self] value in
//                self?.showToaster(msg: value?.errorDescription ?? "")
//            }
//            .store(in: &viewModel.cancellables)
    }
}
