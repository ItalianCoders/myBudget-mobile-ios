//
//  MainPieView.swift
//  myBudget
//
//  Created by Ruggiero Altini on 23/04/18.
//  Copyright © 2018 Ruggiero Altini. All rights reserved.
//

import UIKit
import Charts

protocol BaseChartView {
    func set(description: String)
    func add(entry: String)
    func add(entry: String, value: Double, image: UIImage)
    func add(entry: String, value: Double)
    func update()
}

protocol ChartViewCategory {
    var name: String { get }
    var image: UIImage? { get }
}

class PercentFormatter: NSObject, IValueFormatter, IAxisValueFormatter {
    let numberFormatter = NumberFormatter()
    
    override init() {
        super.init()
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.numberStyle = .percent
        
        // localize to your grouping and decimal separator
        numberFormatter.locale = Locale.current
        numberFormatter.maximumFractionDigits = 1
    }
    
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        
        return numberFormatter.string(from: NSNumber(value: value))!
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return numberFormatter.string(from: NSNumber(value: value))!
    }
    
}

class ChartView: UIView {
    private weak var pieChartView: PieChartView?
    private var entries: [PieChartDataEntry] = []
    private var chartDescription: String = ""
    
    private func create() {
        
        let pieView = PieChartView()
        self.addSubview(pieView)
        pieView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets.zero, size: CGSize.zero)
        
        pieChartView = pieView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        create()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        create()
    }
    
    private func setData(for entries: [PieChartDataEntry]) {
        
        let dataSet = PieChartDataSet(values: entries, label: "")
        
        dataSet.sliceSpace = 3
        dataSet.iconsOffset = CGPoint.zero
        dataSet.selectionShift = 5
        dataSet.drawIconsEnabled = true
        
        dataSet.valueLinePart1OffsetPercentage = 0.7
        dataSet.valueLinePart1Length = 0.2
        dataSet.valueLinePart2Length = 0.4
        dataSet.xValuePosition = PieChartDataSet.ValuePosition.outsideSlice
        dataSet.yValuePosition = PieChartDataSet.ValuePosition.outsideSlice
        
        dataSet.colors = Colors.Chart.material // TODO: Randomize(?)
        
        let data = PieChartData(dataSet: dataSet)
        //data.setValueFormatter()
        data.setValueFormatter(PercentFormatter())
        
        data.setValueFont(UIFont.boldSystemFont(ofSize: 11))
        data.setValueTextColor(UIColor.black)
        
        if let pieChartView = pieChartView {
            pieChartView.data = data
            pieChartView.highlightValues(nil)
            
            pieChartView.chartDescription?.text = chartDescription
        }
    }
}

extension ChartView: BaseChartView {
    func add(entry: String) {
        fatalError("Not implemented")
    }
    
    func add(entry: String, value: Double, image: UIImage) {
        entries.append(.init(value: value, label: entry, icon: image))
    }
    
    func add(entry: String, value: Double) {
        entries.append(.init(value: value, label: entry))
    }
    
    func set(description: String) {
        self.chartDescription = description
    }
    
    func update() {
        setData(for: entries)
    }
}
