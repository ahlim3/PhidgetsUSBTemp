//
//  PhidgetsUSBTempApp.swift
//  PhidgetsUSBTemp
//
//  Created by Jeff Terry on 3/22/21.
//

import SwiftUI

@main
struct PhidgetsUSBTempApp: App {
    
    // plotDataModel contains everything necessary to update the User Interface (UI)
    @StateObject var plotDataModel = PlotDataClass(fromLine: true)
    
    var body: some Scene {
        WindowGroup {
            TabView {
                ContentView()
                    .environmentObject(plotDataModel)
                    .tabItem {
                        Text("Plot")
                    }
                TextView()
                    .environmentObject(plotDataModel)
                    .tabItem {
                        Text("Text")
                    }
                            
                            
            }
            
        }
    }
}
