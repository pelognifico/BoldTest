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
    @IBOutlet weak var theTempLabel: UILabel!
    @IBOutlet weak var detailsTableView: UITableView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var imageToDayImageView: UIImageView!
    @IBOutlet weak var toDayLabel: UILabel!
    
    let cellSearchLocationQueryNibName = "LocationDetailsTableViewCell"
    var dataLocationFromHome: SearchLocationModel.GetSearchLocationQuery.Response?
    var dataDetailsLocations: LocationsDetailsModel.GetLocationsDetails.ViewModel?
    var woeid: Int?
    
    var abbrTemp = false

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
        
        self.navigationItem.hidesBackButton = true
        loadInitialData()
        settingTableView()
    }
    
    // MARK: - Methods
    @objc func loadInitialData() {
        showLoading()
        getLocationsDetails(woeid: woeid ?? 0)
    }
    
    func interface() {
        
        if dataDetailsLocations?.consolidatedWeather?.woeid == dataLocationFromHome?.woeid {
            titleLabel.text = dataDetailsLocations?.consolidatedWeather?.title
            weatherNameLabel.text = dataDetailsLocations?.consolidatedWeather?.consolidatedWeather?[0].weather_state_name
            if let theTem = dataDetailsLocations?.consolidatedWeather?.consolidatedWeather?[0].the_temp {
                let theTemInt =  Int(theTem)
                theTempLabel.text = "\(theTemInt)°"
            }
            let abbr = dataDetailsLocations?.consolidatedWeather?.consolidatedWeather?[0].weather_state_abbr
            let logoTemp = dataDetailsLocations?.consolidatedWeather?.consolidatedWeather?[0].weather_state_abbr
            
            imageToDayImageView.setImage(urlString: "https://www.metaweather.com/static/img/weather/png/\(logoTemp ?? "").png", imageView: imageToDayImageView)
            toDayLabel.text = "Today"
            if abbr == "c" || abbr == "lc" {
                backgroundImageView.image = UIImage(named: "sunny")
                titleLabel.textColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
                theTempLabel.textColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
                weatherNameLabel.textColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
                toDayLabel.textColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
                abbrTemp = true
                setupBackButton(backButtonColor: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1))
            } else {
                backgroundImageView.image = UIImage(named: "cloudy")
                titleLabel.textColor = .white
                theTempLabel.textColor = .white
                weatherNameLabel.textColor = .white
                toDayLabel.textColor = .white
                abbrTemp = false
                setupBackButton(backButtonColor: .white)
            }
            
            detailsTableView.reloadData()
        }

    }
    
    // Configure CellView
    private func settingTableView() {
        detailsTableView.register(UINib(nibName: cellSearchLocationQueryNibName, bundle: nil),
                           forCellReuseIdentifier: HomeTableViewCell.reuseIdentifier)
        
        detailsTableView.delegate = self
        detailsTableView.dataSource = self
        detailsTableView.rowHeight = UITableView.automaticDimension
        detailsTableView.reloadData()
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
        dataDetailsLocations = viewModel
        woeid = dataLocationFromHome?.woeid
        interface()
        detailsTableView.reloadData()
    }
    
    func displayError(viewModel: SearchLocationModel.Error.ViewModel, on queu: DispatchQueue = .main) {
        hideLoading()
        displaySimpleAlert(with: "Error", message: viewModel.error.description)
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension LocationsDetailsViewController: UITableViewDelegate, UITableViewDataSource{
    // Show rows of the table depend status variable bool
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    // Show cells of the table depend status variable bool
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationDetailsTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? LocationDetailsTableViewCell else {
                                                        fatalError()
        }
        
        let dataLocationQuery = dataDetailsLocations
        if let dataTemp = dataLocationQuery {
            cell.confiUI(dateTemp: dataTemp, indexArray: indexPath.row, abbr: abbrTemp)
        }
        
        return cell
    }
    
}
