//
//  LocationsDetailsSuccessResponse.swift
//  BoldTestTests
//
//  Created by Carlos Villamizar on 10/3/22.
//

import XCTest
@testable import BoldTest

class LocationsDetailsSuccessResponse: XCTestCase {
    var sut: LocationsDetailsAPI!
    var locationsDetailsServiceProtocolMock: LocationsDetailsWorkerMock!
    
    override func setUp() {
        locationsDetailsServiceProtocolMock = LocationsDetailsWorkerMock()
        sut = LocationsDetailsAPI()
    }
    
    //MARK: -- Test LocationsDetailsSuccess
    func testGetLocationsDetailsSuccess(){
        //Given
        let requestData = LocationsDetailsModel.GetLocationsDetails.Request(woeid: 123)
        let consolidatedWeatherResponseMock : [ConsolidatedWeather] = [.init(id: 123, weather_state_name: "ABC", weather_state_abbr: "ACB", wind_direction_compass: "ABC", created: "ABC", applicable_date: "ABC", min_temp: 1.23, max_temp: 1.2, the_temp: 1.2, wind_speed: 1.2, wind_direction: 1.2, air_pressure: 1.2, humidity: 123, visibility: 1.2, predictability: 123)]
        let sourcesResponseMock : [Sources] = [.init(title: "ABC", slug: "ABC", url: "ABC", crawl_rate: 123)]
        let dataMock = LocationsDetailsModel.GetLocationsDetails.Response(consolidatedWeather: consolidatedWeatherResponseMock, woeid: 123, title: "ABC", sources: sourcesResponseMock)
        let success : LocationsDetailsModel.GetLocationsDetails.Response? = .some(dataMock)
        
        //When
        locationsDetailsServiceProtocolMock.resultGetLocationsDetails = .success(success!)
        
        //Then
        sut.getLocationsDetails(request: requestData, completion: { result in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response)
                XCTAssertNotNil(response.consolidatedWeather)
                XCTAssertNotNil(response.sources)
                XCTAssertEqual(response.consolidatedWeather?.count, dataMock.consolidatedWeather?.count)
                XCTAssertEqual(response.woeid, dataMock.woeid)
                XCTAssertEqual(response.title, dataMock.title)
                XCTAssertEqual(response.sources?.count, dataMock.sources?.count)
            case .failure(_):
                break
            }
        })
    }
}
