//
//  GraphicsController.swift
//  Bienestapp
//
//  Created by Víctor Agulló on 2/2/20.
//  Copyright © 2020 Víctor. All rights reserved.
//

import Charts
import UIKit

class GraphicsController: UIViewController {
    
    
    @IBOutlet weak var pieChart: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var charValue: [Double] = [0]
        let dateFormatter = DateFormatter()
        for times in timeValues {
            dateFormatter.dateFormat = "HH':'mm':'ss"
            let date = dateFormatter.date(from: times)
            charValue.append(Double((date?.timeIntervalSince1970)!))
        }
        
        customizeChart(dataPoints: timeKeys, values: charValue)
    }
    
    func customizeChart(dataPoints: [String], values: [Double]) {
        
        // 1. Set ChartDataEntry
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data: dataPoints[i] as AnyObject)
            dataEntries.append(dataEntry)
        }
        // 2. Set ChartDataSet
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
        pieChartDataSet.colors = colorsOfCharts(numbersOfColor: dataPoints.count)
        // 3. Set ChartData
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        let format = NumberFormatter()
        format.numberStyle = .none
        let formatter = DefaultValueFormatter(formatter: format)
        pieChartData.setValueFormatter(formatter)
        // 4. Assign it to the chart’s data
        pieChart.data = pieChartData
    }
    
    private func colorsOfCharts(numbersOfColor: Int) -> [UIColor] {
        var colors: [UIColor] = []
        for _ in 0..<numbersOfColor {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        return colors
    }
    
    /*
     func customizeChart(dataPoints: [String], values: [Double]) {
     
     var dataEntries: [BarChartDataEntry] = []
     
     for i in 0..<dataPoints.count {
     let dataEntry = BarChartDataEntry(x: Double(i), y: Double(values[i]))
     dataEntries.append(dataEntry)
     }
     
     let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Bar Chart View")
     
     let chartData = BarChartData(dataSet: chartDataSet)
     
     barChart.data = chartData
     }
     */
}
