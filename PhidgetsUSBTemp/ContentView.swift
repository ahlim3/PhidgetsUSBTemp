//
//  ContentView.swift
//  PhidgetsUSBTemp
//
//  Created by Jeff Terry on 3/22/21.
//

import SwiftUI
import Phidget22Swift
import CorePlot

typealias plotDataType = [CPTScatterPlotField : Double]

struct ContentView: View {
    
    // Receive the UI Data Model That Is Injected From The app
    @EnvironmentObject var plotDataModel :PlotDataClass
    
    // Instantiate the Measurment Class
    @State var temperatureModel = TemperatureObserverClass()
    @State var huminityModel = HuminityObserverClass()
    
    // Necessary to setup the Temperature Measurement Class the first time for device enumeration
    @State var firstTime = true
    
    @State var logging = false
    @State var buttonLabel = "Collect Data"
    

    var body: some View {
        
        HStack{
            VStack{
                
                // Live Updating Temperature Field
                Text("Huminity (%)")
                    .padding()
                    .font(.largeTitle)
                Text(plotDataModel.UIText)
                    .padding()
                
                // Button To Start/Stop Collecting Data
                Button(action: {
                    // What to perform
                    if (!logging){
                    buttonLabel = "Stop Collecting"
                    logging = true
                    }
                    else{
                        buttonLabel = "Collect Data"
                        logging = false
                    }
                    //Call Function
                    self.toggleMeasurementFromPhidgetsDevice2()
                }) {
                    
                    Text(buttonLabel)
                    
                }
                
                .padding()
          
                // Plot View
                CorePlot(dataForPlot: $plotDataModel.plotData, changingPlotParameters: $plotDataModel.changingPlotParameters)
                    .setPlotPadding(left: 10)
                    .setPlotPadding(right: 10)
                    .setPlotPadding(top: 10)
                    .setPlotPadding(bottom: 10)
                    .padding()
                
                Divider()
                
            }
            
        }
        VStack{
            
            // Live Updating Temperature Field
            Text("Temperature (°F)")
                .padding()
                .font(.largeTitle)
            Text(plotDataModel.UIText)
                .padding()
            
            // Button To Start/Stop Collecting Data
            Button(action: {
                // What to perform
                if (!logging){
                buttonLabel = "Stop Collecting"
                logging = true
                }
                else{
                    buttonLabel = "Collect Data"
                    logging = false
                }
                //Call Function
                self.toggleMeasurementFromPhidgetsDevice()
            }) {
                
                Text(buttonLabel)
                
            }
            
            .padding()
      
            // Plot View
            CorePlot(dataForPlot: $plotDataModel.plotData, changingPlotParameters: $plotDataModel.changingPlotParameters)
                .setPlotPadding(left: 10)
                .setPlotPadding(right: 10)
                .setPlotPadding(top: 10)
                .setPlotPadding(bottom: 10)
                .padding()
            
            Divider()
            
        }
        
    }
    
    
    /// toggle Measurement
    /// First time through sets up the device enumerator
    /// Toggles the Data Collection From the Phidgets Device On and Off
    func toggleMeasurementFromPhidgetsDevice(){
        
        if firstTime {
            
            firstTime = false
            temperatureModel.connectToDevice()
            
        }
        
        temperatureModel.plotDataModel = self.plotDataModel
        
        if logging {
            
            temperatureModel.startMeasuring()
        }
        else {
            

            temperatureModel.stopMeasuring()
            
            
        }
        
        
    }
    func toggleMeasurementFromPhidgetsDevice2(){
    
    if firstTime {
        
        firstTime = false
        huminityModel.connectToDevice()
        
    }
    
        huminityModel.plotDataModel = self.plotDataModel
    
    if logging {
        
        huminityModel.startMeasuring()
    }
    else {
        

        huminityModel.stopMeasuring()
        
        
    }
    
    
}
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
