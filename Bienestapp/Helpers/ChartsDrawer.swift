//
//  ChartsDrawer.swift
//  Bienestapp
//
//  Created by alumnos on 05/02/2020.
//  Copyright © 2020 Víctor. All rights reserved.
//
import Charts

class  ChartsDrawer {
    
    func pieChartDrawer(pieChart: PieChartView) {
        
        var charValue: [Double] = []
        var tiempoTotal = 0
        
        for values in totalArray {
            tiempoTotal += values.numberOfSeconds()
        }
        
        for times in totalArray {
            let timeInHours: Double = Double(times.numberOfSeconds()) * 100 / Double(tiempoTotal)
            
            charValue.append(Double(timeInHours))
        }
        
        // 1. Set ChartDataEntry
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<nameArray.count {
            let dataEntry = PieChartDataEntry(value: charValue[i], label: nameArray[i], data: nameArray[i] as AnyObject)
            
            dataEntries.append(dataEntry)
        }
        // 2. Set ChartDataSet
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
        
        pieChartDataSet.colors = colorsOfCharts(numbersOfColor: nameArray.count)
        // 3. Set ChartData
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        
        let format = NumberFormatter()
        
        format.numberStyle = .none
        
        let formatter = DefaultValueFormatter(formatter: format)
        
        pieChartData.setValueFormatter(formatter)
        // 4. Assign it to the chart’s data
        pieChart.data = pieChartData
    }
    
    func barChart(barchart: BarChartView, chartArray: Array<String>) {
        
        var values: [Double] = []
        
        for times in chartArray {
            
            let timeInHours: Double = Double(times.numberOfSeconds())
            
            values.append(Double(timeInHours))
        }
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<nameArray.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(values[i]))
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Each color represents an app")
        
        chartDataSet.colors = colorsOfCharts(numbersOfColor: nameArray.count)
        
        let chartData = BarChartData(dataSet: chartDataSet)
        
        barchart.backgroundColor = UIColor.white
        
        barchart.animate(xAxisDuration: 1.0, yAxisDuration: 1.0)
        
        barchart.xAxis.valueFormatter = IndexAxisValueFormatter(values:nameArray)
        //Also, you probably would want to add:
        
        barchart.xAxis.granularity = 1
        
        barchart.data = chartData
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
}
