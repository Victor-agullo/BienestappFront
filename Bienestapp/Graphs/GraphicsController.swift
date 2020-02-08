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
    
    // referencias a los controladores necesarios en esta pantalla
    var retrieved: serverRetriever?
    
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
        
        // función que compone el gráfico de sectores que representa
        //el uso de las aplicaciones en un porcentaje
        drawer.pieChartDrawer(pieChart: pieChart)
    }
    
    // botón segmentado en tres partes que, según la parte seleccionada,
    // dibujará un gráfico con las medias de las aplicaciones por día,
    // semana y mes.
    @IBAction func segmented(_ sender: UISegmentedControl) {
        
        switch segmentedObject.selectedSegmentIndex {
            
        case 0:
            
            // función que compone el gráfico de barras que representa
            //el uso medio de las aplicaciones por día
            drawer.barChart(barchart: barchart, chartArray: (retrieved?.dayAvgArray)!)
            break
        case 1:
            
            // función que compone el gráfico de barras que representa
            //el uso medio de las aplicaciones por semana
            drawer.barChart(barchart: barchart, chartArray: (retrieved?.weekAvgArray)!)
            break
        case 2:
            
            // función que compone el gráfico de barras que representa
            //el uso medio de las aplicaciones por mes
            drawer.barChart(barchart: barchart, chartArray: (retrieved?.monthAvgArray)!)
            break
        default:
            
            // por defecto se mostrará la primera gráfica de media por día
            drawer.barChart(barchart: barchart, chartArray: (retrieved?.dayAvgArray)!)
            break
        }
    }
}
