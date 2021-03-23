//
//  PlotDataClass.swift
//  SwiftUICorePlotExample
//  Shared
//
//  Created by Jeff Terry on 12/16/20.
//

import Foundation
import SwiftUI
import CorePlot

class PlotDataClass: NSObject, ObservableObject {
    
    @Published var plotData = [plotDataType]()
    @Published var changingPlotParameters: ChangingPlotParameters = ChangingPlotParameters()
    @Published var calculatedText = ""
    //In case you want to plot vs point number
    @Published var pointNumber = 1.0
    
    // UI updating text
    @Published var UIText = "Not Logging"
    
    init(fromLine line: Bool) {
        
        
        //Must call super init before initializing plot
        super.init()
       
        
        //Intitialize the first plot
        self.plotBlank()
        
       }
    
    
    /// plot Blank
    /// Initializes the Plot View with an Empty Plot
    func plotBlank()
    {
        plotData = []
        
        //set the Plot Parameters
        changingPlotParameters.yMax = 4.0
        changingPlotParameters.yMin = -1.0
        changingPlotParameters.xMax = 4.0
        changingPlotParameters.xMin = -1.0
        changingPlotParameters.xLabel = "x"
        changingPlotParameters.yLabel = "y"
        changingPlotParameters.lineColor = .red()
        changingPlotParameters.title = " y = x"
        
    }
    
    /// zero Data
    /// Removes all the previous data from the plotting array
    func zeroData(){
            
            plotData = []
            pointNumber = 1.0
            
    }
    
    /// append data
    /// appends the next point or array of points ot the plotting data
    /// increments the point number as well if one is plotting the point number
    /// - Parameter dataPoint: x, y data to be added to the plotting array
    func appendData(dataPoint: [plotDataType]){
          
            plotData.append(contentsOf: dataPoint)
            pointNumber += 1.0
            
            
            
    }
    
    

}


