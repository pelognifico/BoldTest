//
//  HomeViewController.swift
//  BoldTest
//
//  Created by Carlos Villamizar on 8/3/22.
//

import UIKit

protocol HomeDisplayLogic: AnyObject {
    func displayLocationQuery(viewModel: SearchLocationModel.GetSearchLocationQuery.ViewModel, on queu: DispatchQueue)
    func displayError(viewModel: SearchLocationModel.Error.ViewModel, on queu: DispatchQueue)
}

class HomeViewController: BaseViewController {

    @IBOutlet weak var searchTextField: BTTextField! {
        didSet {
            searchTextField?.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }
    }
    @IBOutlet weak var locationsTableView: UITableView!
    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    
    
    let cellSearchLocationQueryNibName = "HomeTableViewCell"
    var text: String?
    var dataLocationQuery: [SearchLocationModel.GetSearchLocationQuery.Response]?
    
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .red
        refreshControl.addTarget(self, action: #selector(loadInitialData), for: .valueChanged)
        return refreshControl
    }()
    
    var interactor: HomeBusinessLogic?
    var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?

    // MARK: - Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
  
    // MARK: - Setup
    private func setup() {
        let viewController = self
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadInitialData()
        settingTableView()
    }
    
    // MARK: - Methods
    @objc func loadInitialData() {
        refresher.endRefreshing()
    }
    
    func getSearchLocationQuery(query: String) {
        hideLoading()
        let request = SearchLocationModel.GetSearchLocationQuery.Request(query: query)
        interactor?.getLocationQuery(request: request)
    }
    
    private func settingTableView() {
        locationsTableView.register(UINib(nibName: cellSearchLocationQueryNibName, bundle: nil),
                           forCellReuseIdentifier: HomeTableViewCell.reuseIdentifier)
        
        locationsTableView.delegate = self
        locationsTableView.dataSource = self
        locationsTableView.rowHeight = UITableView.automaticDimension
        locationsTableView.refreshControl = refresher
    }
    
    private func search() {
        if searchTextField.text?.isEmpty == true {
            locationsTableView.isHidden = true
            locationView.isHidden = false
            messageLabel.text = "Find weather locations"
        } else {
            locationsTableView.isHidden = false
            locationView.isHidden = true
            if let text = searchTextField?.text?.lowercased() {
                getSearchLocationQuery(query: text)
                locationsTableView.reloadData()
            }
        }
    }
    
    @objc private func textFieldDidChange(_ textField: BTTextField) {
        search()
    }
    
}

// MARK: - HomeDisplayLogic
extension HomeViewController: HomeDisplayLogic {
    func displayLocationQuery(viewModel: SearchLocationModel.GetSearchLocationQuery.ViewModel, on queu: DispatchQueue = .main) {
        hideLoading()
        dataLocationQuery?.removeAll()
        if viewModel.data.count > 0 {
            dataLocationQuery = viewModel.data
            
            refresher.endRefreshing()
            locationsTableView.reloadData()
        } else {
            dataLocationQuery?.removeAll()
            locationsTableView.reloadData()
            locationsTableView.isHidden = true
            locationView.isHidden = false
            messageLabel.text = "Weather location not found"
        }
    }
    
    func displayError(viewModel: SearchLocationModel.Error.ViewModel, on queu: DispatchQueue = .main) {
        hideLoading()
        displaySimpleAlert(with: "Error", message: viewModel.error.description)
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataLocationQuery?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? HomeTableViewCell else {
                                                        fatalError()
        }
        
        let data = dataLocationQuery?[indexPath.row]
        if let dataLocation = data {
            cell.configUI(locations: dataLocation)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewCtrl = LocationsDetailsViewController()
        
        if let dataLocationQuery = dataLocationQuery?[indexPath.row] {
            viewCtrl.dataLocationFromHome = dataLocationQuery
            viewCtrl.woeid = dataLocationQuery.woeid
            self.navigationController?.pushViewController(viewCtrl, animated: true)
        } else {
            displaySimpleAlert(with: "Error", message: "This location does not have climatological details.")
        }
    }
}
