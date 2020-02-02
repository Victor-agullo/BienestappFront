//
//  GraphicsController.swift
//  Bienestapp
//
//  Created by Víctor Agulló on 2/2/20.
//  Copyright © 2020 Víctor. All rights reserved.
//

import UIKit
import Charts

class GraphicsController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let players = ["Ozil", "Ramsey", "Laca", "Auba", "Xhaka", "Torreira"]
        
        let goals = [6, 8, 26, 30, 8, 10]
        
        customizeChart(dataPoints: players, values: goals.map{ Double($0) })
    }
    
    func customizeChart(dataPoints: [String], values: [Double]) {
        
        // 1. Set ChartDataEntry
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data: dataPoints[i] as AnyObject)
            dataEntries.append(dataEntry)
        }
        // 2. Set ChartDataSet
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: nil)
        pieChartDataSet.colors = colorsOfCharts(numbersOfColor: dataPoints.count)
        // 3. Set ChartData
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        let format = NumberFormatter()
        format.numberStyle = .none
        let formatter = DefaultValueFormatter(formatter: format)
        pieChartData.setValueFormatter(formatter)
        // 4. Assign it to the chart’s data
        pieChartView.data = pieChartData
    }
}
