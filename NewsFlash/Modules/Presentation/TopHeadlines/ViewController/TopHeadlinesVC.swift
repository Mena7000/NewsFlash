//
//  TopHeadlinesVC.swift
//  NewsFlash
//
//  Created by Mena Maher on 8/26/25.
//

import UIKit
import Combine
import SwiftUI

class TopHeadlinesVC: BaseVC {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var headlinesTable: UITableView!
    @IBOutlet weak var selectedCountryCodeLbl: UILabel!
    @IBOutlet weak var msgView: UIView!
    
    var viewModel: TopHeadlinesVM!
    private var cancellables = Set<AnyCancellable>()

    private var countryPicker = UIPickerView()
    private let pickerContainer = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindVM()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    deinit {
        print("💰💰💰💰 TopHeadlinesVC deallocated 💰💰💰💰")
    }
    
    func setupUI() {
        headlinesTable.registerCellNib(withIdentifier: "HeadlineCell")
        setupSearchUI()
        setupCountryPicker()
    }
    
    func bindVM() {
        viewModel = TopHeadlinesVM(topHeadlinesListUseCase: DependencyContainer.shared.resolveTopHeadlinesListUseCase())

        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                self?.activityView(isLoading: value)
            }
            .store(in: &viewModel.cancellables)
        
        viewModel.$selectedCountry
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                guard let data = data else { return }
                self?.selectedCountryCodeLbl.text = data.value.uppercased()
            }
            .store(in: &viewModel.cancellables)

        viewModel.$error
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                (if value == .noInternet)
                    
                self?.showToaster(msg: value?.errorDescription ?? "")
            }
            .store(in: &viewModel.cancellables)
        
        viewModel.$news
            .sink { [weak self] _ in
                DispatchQueue.main.async {
                    self?.headlinesTable.reloadData()
                }
            }
            .store(in: &viewModel.cancellables)

//        viewModel.fetchNews() // no need to trigger it, as the search keyword already triggers fetching news.
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
        
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Search",
            attributes: [.foregroundColor: UIColor(hex: "71838E"), .font: UIFont.systemFont(ofSize: 13)]
        )
    }
        
    @IBAction func selectCountryBtnTapped(_ sender: Any) {
        showPicker()
    }
}

// MARK: - Search Delegates
extension TopHeadlinesVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        viewModel.searchKeyword = searchText
    }
}

// MARK: - Table Delegates
extension TopHeadlinesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.news.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HeadlineCell", for: indexPath) as? HeadlineCell else { return UITableViewCell() }
       
        let data = viewModel.news[indexPath.row]
        let newsData = HeadlineListData(img: data.image ?? "",
                                        title: data.title ?? "",
                                        souce: data.source?.name ?? "",
                                        publishDate: data.publishedAt ?? "")
        cell.data = newsData
        
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailView = NewsDetailUI(data: viewModel.news[indexPath.row])
        let hostingController = UIHostingController(rootView: detailView)
        navigationController?.pushViewController(hostingController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel.fetchNextPage(indxRow: indexPath.row)
    }
}

// MARK: - Picker Delegates
extension TopHeadlinesVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func setupCountryPicker() {
        pickerContainer.backgroundColor = .systemGroupedBackground
        pickerContainer.layer.shadowOpacity = 0.3
        pickerContainer.layer.shadowRadius = 5
        pickerContainer.isHidden = true
        view.addSubview(pickerContainer)

        pickerContainer.translatesAutoresizingMaskIntoConstraints = false
        countryPicker.translatesAutoresizingMaskIntoConstraints = false
        countryPicker.delegate = self
        countryPicker.dataSource = self

        // Create toolbar with initial frame to avoid width==0 constraint
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 44))
        toolbar.barStyle = .default
        toolbar.isTranslucent = true

        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(hidePicker))
        let flex = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneTapped))
        toolbar.setItems([cancel, flex, done], animated: false)

        pickerContainer.addSubview(toolbar)
        pickerContainer.addSubview(countryPicker)

        toolbar.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            pickerContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pickerContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pickerContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pickerContainer.heightAnchor.constraint(equalToConstant: 250),

            toolbar.topAnchor.constraint(equalTo: pickerContainer.topAnchor),
            toolbar.leadingAnchor.constraint(equalTo: pickerContainer.leadingAnchor),
            toolbar.trailingAnchor.constraint(equalTo: pickerContainer.trailingAnchor),
            toolbar.heightAnchor.constraint(equalToConstant: 44),

            countryPicker.topAnchor.constraint(equalTo: toolbar.bottomAnchor),
            countryPicker.leadingAnchor.constraint(equalTo: pickerContainer.leadingAnchor),
            countryPicker.trailingAnchor.constraint(equalTo: pickerContainer.trailingAnchor),
            countryPicker.bottomAnchor.constraint(equalTo: pickerContainer.bottomAnchor),
        ])
    }

    @objc private func doneTapped() {
        let row = countryPicker.selectedRow(inComponent: 0)
        viewModel.selectedCountry = viewModel.countiesArray[row]
        hidePicker()
    }
    
    @objc private func showPicker() {
        pickerContainer.isHidden = false
    }

    @objc private func hidePicker() {
        pickerContainer.isHidden = true
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        viewModel.countiesArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        viewModel.countiesArray[row].name
    }
}
