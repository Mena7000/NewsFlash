//
//  TopHeadlinesVC.swift
//  NewsFlash
//
//  Created by Mena Maher on 8/26/25.
//

import UIKit
import Combine

class TopHeadlinesVC: BaseVC {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var headlinesTable: UITableView!
    
    var viewModel: TopHeadlinesVM = TopHeadlinesVM()
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindVM()
    }
    
    deinit {
        print("💰💰💰💰 TopHeadlinesVC deallocated 💰💰💰💰")
    }
    
    func setupUI() {
        headlinesTable.registerCellNib(withIdentifier: "HeadlineCell")
        setupSearchUI()
    }
    
    func bindVM() {
        searchBar.textDidChangePublisher
            .debounce(for: .milliseconds(700), scheduler: RunLoop.main)
            .removeDuplicates()
            .assign(to: \.searchKeyword, on: viewModel)
            .store(in: &cancellables)
    
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
    
    func setupSearchUI() {
        searchBar.searchTextField.backgroundColor = UIColor(white: 0.97, alpha: 1.0)
        searchBar.searchTextField.layer.cornerRadius = 10
        searchBar.searchTextField.clipsToBounds = true
        searchBar.searchTextField.backgroundColor = .white
        searchBar.delegate = self
        
        searchBar.searchTextField.font = UIFont.systemFont(ofSize: 16)
        searchBar.searchTextField.textColor = UIColor.darkGray
        searchBar.searchTextField.leftView?.tintColor = UIColor.systemGray

        // Optional: Remove border
        searchBar.backgroundImage = UIImage()
        searchBar.layer.borderWidth = 0
        searchBar.layer.borderColor = UIColor.clear.cgColor

        // Optional: Add subtle border like your screenshot
        searchBar.searchTextField.layer.borderColor = UIColor(hex: "E0E0E0").cgColor
        searchBar.searchTextField.layer.borderWidth = 1
        
//        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(
//            string: "hintSearch".localizedString,
//            attributes: [.foregroundColor: UIColor(hex: "71838E"), .font: UIFont(name: AppFontName.medium, size: 13)!]
//        )
    }
    
    @IBAction func selectCountryBtnTapped(_ sender: Any) {
        
    }
}

extension TopHeadlinesVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print(indexPath)
    }
}
