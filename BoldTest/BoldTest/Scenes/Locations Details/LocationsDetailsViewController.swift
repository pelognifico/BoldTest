//
//  LocationsDetailsViewController.swift
//  BoldTest
//
//  Created by Carlos Villamizar on 9/3/22.
//

import UIKit

protocol LocationsDetailsDisplayLogic: AnyObject {
    func displayLocationsDetails(viewModel: LocationsDetailsModel.GetLocationsDetails.ViewModel, on queu: DispatchQueue)
    func displayError(viewModel: SearchLocationModel.Error.ViewModel, on queu: DispatchQueue)
}

class LocationsDetailsViewController: BaseViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var weatherNameLabel: UILabel!

    var dataLocationFromHome: SearchLocationModel.GetSearchLocationQuery.Response?
    var dataDetailsLocations: LocationsDetails?
    var woeid: Int?

    var interactor: LocationsDetailsBusinessLogic?
    var router: (NSObjectProtocol & LocationsDetailsRoutingLogic & LocationsDetailsDataPassing)?

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
        let interactor = LocationsDetailsInteractor()
        let presenter = LocationsDetailsPresenter()
        let router = LocationsDetailsRouter()
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
        setupBackButton()
        loadInitialData()
    }
    
    // MARK: - Methods
    @objc func loadInitialData() {
        showLoading()
        getLocationsDetails(woeid: woeid ?? 0)
        if dataDetailsLocations?.parent?.woeid == dataLocationFromHome?.woeid {
            titleLabel.text = dataDetailsLocations?.title
        }
    }
    
    func getLocationsDetails(woeid: Int) {
        let request = LocationsDetailsModel.GetLocationsDetails.Request(woeid: woeid)
        interactor?.getLocationsDetails(request: request)
    }

}

// MARK: - LocationsDetailsDisplayLogic
extension LocationsDetailsViewController: LocationsDetailsDisplayLogic {
    func displayLocationsDetails(viewModel: LocationsDetailsModel.GetLocationsDetails.ViewModel, on queu: DispatchQueue = .main) {
        hideLoading()
        dataDetailsLocations = viewModel.dataLocationsDetails
        woeid = dataLocationFromHome?.woeid
    }
    
    func displayError(viewModel: SearchLocationModel.Error.ViewModel, on queu: DispatchQueue = .main) {
        hideLoading()
        displaySimpleAlert(with: "Error", message: viewModel.error.description)
    }
}
