//
//  PhidgetsUSBTempTests.swift
//  PhidgetsUSBTempTests
//
//  Created by Jeff Terry on 3/22/21.
//

import XCTest
@testable import PhidgetsUSBTemp

class PhidgetsUSBTempTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFToC() throws {
        
        let temperatureConverter = TemperatureConverter()
        
        let fahrenheit = 54.4
        
        let celcius = temperatureConverter.convertFToC(Temp: fahrenheit)
        XCTAssertEqual(celcius, 12.444444444444445, accuracy: celcius.ulp)
        
        let returnedFahrenheit = temperatureConverter.convertCToF(Temp: celcius)
        XCTAssertEqual(fahrenheit, returnedFahrenheit, accuracy: fahrenheit.ulp)
        
    }
    
    func testCToF() throws {
        
        let temperatureConverter = TemperatureConverter()
        
        let celcius = -9.0
        
        let fahrenheit = temperatureConverter.convertCToF(Temp: celcius)
        XCTAssertEqual(fahrenheit, 15.8, accuracy: fahrenheit.ulp)
        
        let returnedCelcius = temperatureConverter.convertFToC(Temp: fahrenheit)
        XCTAssertEqual(celcius, returnedCelcius, accuracy: celcius.ulp)
        
    }
    
    func testFToR() throws {
        
        let temperatureConverter = TemperatureConverter()
        
        let fahrenheit = 111.1
        
        let rankine = temperatureConverter.convertFToR(Temp: fahrenheit)
        XCTAssertEqual(rankine, 570.77, accuracy: rankine.ulp)
        
        let returnedFahrenheit = temperatureConverter.convertRToF(Temp: rankine)
        XCTAssertEqual(fahrenheit, returnedFahrenheit, accuracy: (returnedFahrenheit.ulp*2.0))
        
    }
    
    func testRToF() throws {
        
        let temperatureConverter = TemperatureConverter()
        
        let rankine = 350.0
        
        let fahrenheit = temperatureConverter.convertRToF(Temp: rankine)
        XCTAssertEqual(fahrenheit, -109.67000000000002, accuracy: fahrenheit.ulp)
        
        let returnedRankine = temperatureConverter.convertFToR(Temp: fahrenheit)
        XCTAssertEqual(rankine, returnedRankine, accuracy: rankine.ulp)
        
    }

    func testKToC() throws {
        
        let temperatureConverter = TemperatureConverter()
        
        let kelvin = 9.0
        
        let celcius = temperatureConverter.convertKToC(Temp: kelvin)
        XCTAssertEqual(celcius, -264.15, accuracy: celcius.ulp)
        
        let returnedKelvin = temperatureConverter.convertCToK(Temp: celcius)
        XCTAssertEqual(kelvin, returnedKelvin, accuracy: kelvin.ulp)
        
    }
    
    func testCToK() throws {
        
        let temperatureConverter = TemperatureConverter()
        
        let celcius = 1414.3
        
        let kelvin = temperatureConverter.convertCToK(Temp: celcius)
        XCTAssertEqual(kelvin, 1687.45, accuracy: kelvin.ulp)
        
        let returnedCelcius = temperatureConverter.convertKToC(Temp: kelvin)
        XCTAssertEqual(celcius, returnedCelcius, accuracy: celcius.ulp)
        
    }


}
