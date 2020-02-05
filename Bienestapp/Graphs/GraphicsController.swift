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
    
    // objetos vista de los gráficos
    @IBOutlet weak var barchart: BarChartView!
    @IBOutlet weak var pieChart: PieChartView!
    
    // objeto del botón segmentado
    @IBOutlet weak var segmentedObject: UISegmentedControl!
    
    // referencia a la clase de apoyo para generar gráficos
    let drawer = ChartsDrawer.init()
    
    // al cargarse la pantalla se genera el gráfico sectorial
    // del porcentaje de uso de las apps
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawer.pieChartDrawer(pieChart: pieChart)
    }
    
    // botón segmentado en tres partes que, según la parte seleccionada,
    // dibujará un gráfico con las medias de las aplicaciones por día,
    // semana y mes.
    @IBAction func segmented(_ sender: UISegmentedControl) {
        
        switch segmentedObject.selectedSegmentIndex {
            
        case 0:
            
            drawer.barChart(barchart: barchart, chartArray: dayAvgArray)
            break
        case 1:
            
            drawer.barChart(barchart: barchart, chartArray: weekAvgArray)
            break
        case 2:
            
            drawer.barChart(barchart: barchart, chartArray: monthAvgArray)
            break
        default:
            break
        }
    }
}
