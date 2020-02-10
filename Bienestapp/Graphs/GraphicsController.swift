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
    
    // al cargarse la pantalla se genera el gráfico sectorial
    // del porcentaje de uso de las apps
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // función que compone el gráfico de sectores que representa
        //el total de uso de las aplicaciones en un porcentaje
        ChartsDrawer.pieChartDrawer(pieChart: pieChart)
        
        // por defecto se mostrará la primera gráfica de media por día
        ChartsDrawer.barChart(barchart: barchart, chartArray: serverRetriever.dayAvgArray)
    }
    
    // botón segmentado en tres partes que, según la parte seleccionada,
    // dibujará un gráfico con las medias de las aplicaciones por día,
    // semana y mes.
    @IBAction func segmented(_ sender: UISegmentedControl) {
        
        switch segmentedObject.selectedSegmentIndex {
            
        case 0:
            
            // función que compone el gráfico de barras que representa
            //el uso medio de las aplicaciones por día
            ChartsDrawer.barChart(barchart: barchart, chartArray: serverRetriever.dayAvgArray)
            break
        case 1:
            
            // función que compone el gráfico de barras que representa
            //el uso medio de las aplicaciones por semana
            ChartsDrawer.barChart(barchart: barchart, chartArray: serverRetriever.weekAvgArray)
            break
        case 2:
            
            // función que compone el gráfico de barras que representa
            //el uso medio de las aplicaciones por mes
            ChartsDrawer.barChart(barchart: barchart, chartArray: serverRetriever.monthAvgArray)
            break
        default:
            break
        }
    }
}
