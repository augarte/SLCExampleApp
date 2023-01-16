//
//  StyledSLCViewController.swift
//  SLCExampleApp
//
//  Created by Aimar Ugarte on 15/1/23.
//

import UIKit
import SimpleLineChart

class StyledSLCViewController: UIViewController {
    
    let lineChart = SimpleLineChart()
    let lineStyle = SLCLineStyle(lineColor: .black,
                                 lineStroke: 3.0,
                                 circleDiameter: 5.0,
                                 lineShadow: true,
                                 lineShadowgradientStart: .darkGray,
                                 lineShadowgradientEnd: .lightGray)
    let chartStyle = SLCChartStyle(backgroundGradient: false,
                                   solidBackgroundColor: .lightGray)
    override func viewDidLoad() {
        super.viewDidLoad()
        setupChart()
        loadChart()
    }
    
    private func setupChart() {
        lineChart.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lineChart)
        NSLayoutConstraint.activate([
            lineChart.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            lineChart.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lineChart.heightAnchor.constraint(equalToConstant: 300),
            lineChart.widthAnchor.constraint(equalToConstant: view.frame.width - 32)
        ])
    }
    
    private func loadChart() {
        let values: [SLCData] = fetchData()
        let dataSet = SLCDataSet(graphPoints: values)
        dataSet.setLineStyle(lineStyle)
        lineChart.setChartStyle(chartStyle: chartStyle)
        lineChart.loadPoints(dataSet: dataSet)
    }
}

private extension StyledSLCViewController {
    func fetchData() -> [SLCData] {
        var values: [SLCData] = []
        var y = 0.0
        let n = 100
        for i in 0..<n {
            y += (Double.random(in: 0..<1) * 10.0 - 5.0);
            let data = SLCData(x: i - n / 2, y: y)
            values.append(data)
        }
        return values
    }
}

extension StyledSLCViewController {
    
    static func create() -> StyledSLCViewController {
        return super.init(nibName: nil, bundle: nil) as! StyledSLCViewController
    }
}

extension StyledSLCViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .white
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backTapped))
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
        setupTitle()
        setupButtons()
    }
    
    @objc func backTapped(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: false)
    }
    
    private func setupTitle() {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = .black
        title.text = "Simple Line Chart (Styled)"
        title.font = title.font.withSize(24)
        view.addSubview(title)
        NSLayoutConstraint.activate([
            lineChart.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 32),
            title.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
    }
    
    private func setupButtons() {
        // Reload Button
        let reloadBtn = UIButton()
        reloadBtn.translatesAutoresizingMaskIntoConstraints = false
        reloadBtn.setTitle("Reload", for: .normal)
        reloadBtn.layer.cornerRadius = 8.0
        reloadBtn.backgroundColor = .black
        reloadBtn.setTitleColor(.white, for: .normal)
        view.addSubview(reloadBtn)
        NSLayoutConstraint.activate([
            reloadBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            reloadBtn.topAnchor.constraint(equalTo: lineChart.bottomAnchor, constant: 32),
            reloadBtn.widthAnchor.constraint(equalToConstant: 128)
        ])
        reloadBtn.addTarget(self, action: #selector(reload), for: .touchUpInside)
    }
    
    @objc private func reload(sender: UIButton?) {
        loadChart()
    }
}
