//
//  ChartsDrawer.swift
//  Bienestapp
//
//  Created by alumnos on 05/02/2020.
//  Copyright © 2020 Víctor. All rights reserved.
//
import Charts

class  ChartsDrawer {
    
    // referencias a los controladores necesarios en esta pantalla
    var retrieved: serverRetriever?
    
    // método que dibuja un grafico de sectores conforme al porcentaje de uso de las apps
    func pieChartDrawer(pieChart: PieChartView) {
        
        var charValue: [Double] = []
        var tiempoTotal = 0
        var dataEntries: [ChartDataEntry] = []
        
        // sumatorio de todos los tiempos
        for values in (retrieved?.totalArray)! {
            tiempoTotal += values.numberOfSeconds()
        }
        
        // obtención del porcentaje de cada app
        for times in (retrieved?.totalArray)! {
            let timeInHours: Double = Double(times.numberOfSeconds()) * 100 / Double(tiempoTotal)
            
            charValue.append(Double(timeInHours))
        }
        
        // genera los valores necesarios para las entradas de datos
        for i in 0..<(retrieved?.nameArray.count)! {
            let dataEntry = PieChartDataEntry(value: charValue[i], label: retrieved?.nameArray[i], data: retrieved?.nameArray[i] as AnyObject)
            
            dataEntries.append(dataEntry)
        }
        
        // con las entradas de datos crea el set que usará la función
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
        
        // se añaden los colores distintos para cada sector
        pieChartDataSet.colors = colorsOfCharts(numbersOfColor: (retrieved?.nameArray.count)!)
        
        // usa el dataset creado para dibujar la gráfica
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        
        // le da un formato a los números para que coincidan todos
        let format = NumberFormatter()
        
        // se le da el formato porcentual
        format.numberStyle = .percent
        
        // aplicado del formateo
        let formatter = DefaultValueFormatter(formatter: format)
        pieChartData.setValueFormatter(formatter)
        
        // efectua la gráfica
        pieChart.data = pieChartData
    }
    
    
    func barChart(barchart: BarChartView, chartArray: Array<String>) {
        
        var values: [Double] = []
        var dataEntries: [BarChartDataEntry] = []
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Each color represents an app")

        // preparación de todos los valores numéricos obtenidos en el array de valores
        for times in chartArray {
            let timeInHours: Double = Double(times.numberOfSeconds())
            
            values.append(Double(timeInHours))
        }
        
        // orden de los valores en x e y con los nombres y el máximo de valores en i
        for i in 0..<(retrieved?.nameArray.count)! {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(values[i]))
            
            dataEntries.append(dataEntry)
        }
        
        // llamada a la función que le da un color distinto a cada valor
        chartDataSet.colors = colorsOfCharts(numbersOfColor: (retrieved?.nameArray.count)!)
        
        // encapsulación de lo necesario para el setter de la grafica
        let chartData = BarChartData(dataSet: chartDataSet)
        barchart.backgroundColor = UIColor.white
        barchart.animate(xAxisDuration: 1.0, yAxisDuration: 1.0)
        barchart.xAxis.valueFormatter = IndexAxisValueFormatter(values: (retrieved?.nameArray)!)
        barchart.xAxis.granularity = 1
        
        // lanzamiento del chart
        barchart.data = chartData
    }
    
    // método que genera un array de colores aleatorios cuando se le llama
    private func colorsOfCharts(numbersOfColor: Int) -> [UIColor] {
        
        var colors: [UIColor] = []
        
        // se genera un array con el número de colores que se pidan
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
