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
    
    @IBOutlet weak var barchart: BarChartView!
    
    @IBOutlet weak var segmentedObject: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        var charValue: [Double] = []
        var tiempoTotal = 0
        
        for values in totalArray {
            
            tiempoTotal += values.numberOfSeconds()
        }
        
        for times in totalArray {
            
            let timeInHours: Double = Double(times.numberOfSeconds()) * 100 / Double(tiempoTotal)
            
            charValue.append(Double(timeInHours))
        }
        
        customizeChart(dataPoints: nameArray, values: charValue)
    }
    
    func customizeChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(values[i]))
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Each color represents an app")
        
        chartDataSet.colors = ChartColorTemplates.colorful()
        
        let chartData = BarChartData(dataSet: chartDataSet)
        
        barchart.backgroundColor = UIColor.white
        
        barchart.xAxis.valueFormatter = IndexAxisValueFormatter(values:nameArray)
        //Also, you probably we want to add:
        
        barchart.xAxis.granularity = 1
        
        barchart.data = chartData
    }
    
    @IBAction func segmented(_ sender: UISegmentedControl) {
        switch segmentedObject.selectedSegmentIndex {
        case 0:
            var charValue: [Double] = []
            
            for times in totalArray {
                
                let timeInHours: Double = Double(times.numberOfSeconds()) / (Double(60 * 60 * 24))
                
                charValue.append(Double(timeInHours))
            }
            
            customizeChart(dataPoints: nameArray, values: charValue)
            break
        case 1:
            var charValue: [Double] = []
            
            for times in totalArray {
                
                let timeInHours: Double = Double(times.numberOfSeconds()) / (Double(60 * 60 * 24 * 7))
                
                charValue.append(Double(timeInHours))
            }
            
            customizeChart(dataPoints: nameArray, values: charValue)
            break
        case 2:
            var charValue: [Double] = []
            
            for times in totalArray {
                
                let timeInHours: Double = Double(times.numberOfSeconds()) / (Double(60 * 60 * 24 * 7 * 4))
                
                charValue.append(Double(timeInHours))
            }
            
            customizeChart(dataPoints: nameArray, values: charValue)
            break
        default:
            break
        }
    }
    
}
