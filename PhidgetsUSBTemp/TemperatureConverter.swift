//
//  TemperatureConverter.swift
//  PhidgetsUSBTemp
//
//  Created by Jeff Terry on 3/23/21.
//

import Foundation
import SwiftUI


class TemperatureConverter: NSObject {
    
    /// Convert Temperature from Fahrenheit To Celsius
    //
    //        5.0
    // C  =   ---  * (F  -  32.0)
    //        9.0
    //
    /// - Parameter Temp: Temperature in Fahrenheit
    /// - Returns: Temperature in Celsius
    func convertFToC(Temp: Double) -> Double {
        
        let tempCelsius = 5.0/9.0 * (Temp - 32.0)
        
        return(tempCelsius)
        
    }
    
    
    /// Convert Temperature from Celsius To Fahrenheit
    //
    //        9.0
    // F  =   ---  * C  +  32.0
    //        5.0
    //
    /// - Parameter Temp: Temperature in Celsius
    /// - Returns: Temperature in Fahrenheit
    func convertCToF(Temp: Double) -> Double {
        
        let tempFahrenheit = 9.0/5.0 * Temp + (32.0)
        
        return(tempFahrenheit)
        
    }
    
    
    /// Convert Temperature from Celsius To Kelvin
    //
    // K  =   C  +  273.15
    //
    /// - Parameter Temp: Temperature in Celsius
    /// - Returns: Temperature in Kelvin
    func convertCToK(Temp: Double) -> Double {
        
        let tempKelvin = Temp + 273.15
        
        return(tempKelvin)
        
    }
  
    /// Convert Temperature from Kelvin To Celsius
    //
    // C  =   K  -  273.15
    //
    /// - Parameter Temp: Temperature in Celsius
    /// - Returns: Temperature in Kelvin
    func convertKToC(Temp: Double) -> Double {
        
        let tempCelsius = Temp - 273.15
        
        return(tempCelsius)
        
    }

    /// Convert Temperature from Fahrenheit To Rankine
    //
    // R  =   F  +  459.67
    //
    /// - Parameter Temp: Temperature in Fahrenheit
    /// - Returns: Temperature in Rankine
    func convertFToR(Temp: Double) -> Double {
        
        let tempRankine = Temp + 459.67
        
        return(tempRankine)
        
    }
    
    /// Convert Temperature from Rankine To Fahrenheit
    //
    // F  =   R  -  459.67
    //
    /// - Parameter Temp: Temperature in Rankine
    /// - Returns: Temperature in Fahrenheit
    func convertRToF(Temp: Double) -> Double {
        
        let tempFahrenheit = Temp - 459.67
        
        return(tempFahrenheit)
        
    }



}
