//
//  Humidity.swift
//  PhidgetsUSBTemp
//
//  Created by Anthony Lim on 3/26/21.
//

import Foundation
import SwiftUI
import CorePlot
import Phidget22Swift

class HuminityObserverClass: ObservableObject {
    
    var plotDataModel: PlotDataClass? = nil
    
    //@Published var temperatureValue: String = "Not Measuring"
    
    // Instantiate temperatureSensor
    //let temperatureSensor = TemperatureSensor()
      let humiditySensor = HumiditySensor()
    // Instantiate temperatureConverter to convert between units
    //let temperatureConverter = TemperatureConverter()
    
    // Manager allows for enumerating devices
    let man = Manager()
    
    
    
    /// Connect To Device Sets Up The Ability To Enumerate All Phidget Channels and Devices As They Are Attached and Detached
    func connectToDevice() {
        
        //temperatureValue = "Not Logging"
        
        // Print address of self for debugging
        print(Unmanaged.passUnretained(self).toOpaque())
        
        do {
            
            // Register for event before calling open
            let _ = man.attach.addHandler(onAttach)
            let _ = man.detach.addHandler(onDetach)
            
            try man.open()
            
        } catch let err as PhidgetError {
            print (err)
        }catch{
            print(error)
        }
    }
    
    /// OnAttach Enumerates All Phidget Channels and Devices As They Are Attached
    func onAttach(sender: Manager, channel: Phidget) {
        print("Channel: \(channel)")
    }
    
    /// OnAttach Enumerates All Phidget Channels and Devices As They Are Detached
    func onDetach(sender: Manager, channel: Phidget) {
        print("Channel: \(channel)")
    }
    
    
    /// onTemperatureChange is the Event Handler that Records the Temperature Sent From the Phidgets Device
    /// - Parameters:
    ///   - sender: Temperature Sensor
    ///   - temperature: Measured Temperature in Units of Celsius
    func onTemperatureChange(sender:HumiditySensor, huminity: Double){
        
        // Convert Temperature from C To F
        // Doing this for no real good reason other than I can
        //let degreeF = temperatureConverter.convertCToF(Temp: temperature)
        let huminityM = huminity
        // Send User Interface (UI) updates to the main thread
        DispatchQueue.main.async {
            
            //Use your Phidgets
            
            let hString = String(format: "%3.2f", huminity) + " %"
            
            //This code will update the temperature label in the UI with the latest temperature data.
            // plotDataModel holds all of the UI data.
            self.plotDataModel!.UIText = hString
            
            // Print address of self for debugging
            //print(Unmanaged.passUnretained(self).toOpaque())
            
            // Get the time and format it properly
            let now = Date()
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "y-MM-dd H:m:ss.SSSS"
            
            let time = timeFormatter.string(from: now) // -> "2021-03-23 16:43:01.2310"
            
            // Add The Time To The UI Text Data
            // Again All UI data held in plotDataModel
            self.plotDataModel!.calculatedText += String(format: "%d\t", UInt32(self.plotDataModel!.pointNumber )) + "\t" + time + "\t" + hString + "\n"
            
            
            // Add The Point To the Plot
            // Again All UI data held in plotDataModel
            let dataPoint: plotDataType = [.X: self.plotDataModel!.pointNumber, .Y: huminityM]
            
            self.plotDataModel!.appendData(dataPoint: [dataPoint])
            
            if (self.plotDataModel!.pointNumber > self.plotDataModel!.changingPlotParameters.xMax) {
                
                self.plotDataModel!.changingPlotParameters.xMax  = self.plotDataModel!.pointNumber + 10
            }
            
            // Adjust the scale of the plot if necessary
            
            if (huminityM > self.plotDataModel!.changingPlotParameters.yMax) {
                
                self.plotDataModel!.changingPlotParameters.yMax  = huminityM + 2.0
            }
            
            if (huminityM < self.plotDataModel!.changingPlotParameters.yMin) {
                
                self.plotDataModel!.changingPlotParameters.yMin  = huminityM - 2.0
            }
            
        }
        
    }
    
    
    /// start Measuring allows the Phidget Device to start collecting data
    func startMeasuring() {
        
        // Delete any text held in the plotDataModel
        self.plotDataModel!.calculatedText = ""
        
        do{
            //Subscribe to event
            
            let _ = humiditySensor.humidityChange.addHandler(onTemperatureChange)
            
            //Open | Open establishes a connection between your object and your physical Phidget.
            
            try humiditySensor.open()
            
            plotDataModel!.zeroData()
            
            //set the Plot Parameters
            plotDataModel!.changingPlotParameters.yMax = 0.0
            plotDataModel!.changingPlotParameters.yMin = 100.0
            plotDataModel!.changingPlotParameters.xMax = 40.0
            plotDataModel!.changingPlotParameters.xMin = -5.0
            plotDataModel!.changingPlotParameters.xLabel = "Time"
            plotDataModel!.changingPlotParameters.yLabel = "Huminity (%)"
            plotDataModel!.changingPlotParameters.lineColor = .red()
            plotDataModel!.changingPlotParameters.title = "Huminty"
            
            
        }catch{
            print(error)
        }
    }
    
    /// stop Measuring commands the Phidget Device to halt data collection and remove the Event Handler
    func stopMeasuring() {
        
        
        do{
            
            //Close | Close ends a connection between your object and your physical Phidget.
            
            try self.humiditySensor.close()
            
            //Unsubscribe to event
            
            self.humiditySensor.humidityChange.removeAllHandlers()
            
            DispatchQueue.main.async {
                // Update the UI to indicate that Data Collection has ended.
                // plotDataModel holds all of the UI data.
                self.plotDataModel!.UIText = "Not Logging"
                
            }
            
        }catch{
            print(error)
        }
        
        
        
    }
    
}
