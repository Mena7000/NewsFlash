//
//  TopHeadlinesVC.swift
//  NewsFlash
//
//  Created by Mena Maher on 8/26/25.
//

import UIKit

class TopHeadlinesVC: BaseVC {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var headlinesTable: UITableView!
    
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
        headlinesTable.registerCellNib(withIdentifier: "HeadlineCell")
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

extension TopHeadlinesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HeadlineCell", for: indexPath) as? HeadlineCell else { return UITableViewCell() }
       
        let data = HeadlineListData(img: "https://www.lemanbleu.ch/Htdocs/Images/IF_Facebook/puid_dd4e93e3-33d8-433d-a99f-0dd42aec8fe1_20250826193802404.jpg",
                                    title: "Nucléaire: l'Iran appelle les Européens à faire \" le bon choix \"",
                                    souce: "Léman Bleu",
                                    publishDate: "2025-08-26T17:37:00Z")
        cell.data = data
        
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
}
