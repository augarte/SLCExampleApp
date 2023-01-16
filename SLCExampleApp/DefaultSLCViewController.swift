//
//  ViewController.swift
//  SLCExampleApp
//
//  Created by Aimar Ugarte on 15/1/23.
//

import UIKit
import SimpleLineChart

class DefaultSLCViewController: UIViewController {
    
    let lineChart = SimpleLineChart()
    
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
        lineChart.loadPoints(dataSet: dataSet)
    }
}

private extension DefaultSLCViewController {
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

extension DefaultSLCViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .black
        setupTitle()
        setupButtons()
    }
    
    private func setupTitle() {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = .white
        title.text = "Simple Line Chart"
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
        reloadBtn.backgroundColor = .white
        reloadBtn.setTitleColor(.black, for: .normal)
        view.addSubview(reloadBtn)
        NSLayoutConstraint.activate([
            reloadBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            reloadBtn.topAnchor.constraint(equalTo: lineChart.bottomAnchor, constant: 32),
            reloadBtn.widthAnchor.constraint(equalToConstant: 128)
        ])
        reloadBtn.addTarget(self, action: #selector(reload), for: .touchUpInside)
        
        // Styled SLC Button
        let styledSLCBtn = UIButton()
        styledSLCBtn.translatesAutoresizingMaskIntoConstraints = false
        styledSLCBtn.setTitle("Styled SLC", for: .normal)
        styledSLCBtn.layer.cornerRadius = 8.0
        styledSLCBtn.backgroundColor = .white
        styledSLCBtn.setTitleColor(.black, for: .normal)
        view.addSubview(styledSLCBtn)
        NSLayoutConstraint.activate([
            styledSLCBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            styledSLCBtn.topAnchor.constraint(equalTo: reloadBtn.bottomAnchor, constant: 16),
            styledSLCBtn.widthAnchor.constraint(equalToConstant: 128)
        ])
        styledSLCBtn.addTarget(self, action: #selector(styledSLC), for: .touchUpInside)
    }
    
    @objc private func reload(sender: UIButton?) {
        loadChart()
    }
    
    @objc private func styledSLC(sender: UIButton?) {
        let styledSLCViewController = StyledSLCViewController()
        self.navigationController?.pushViewController(styledSLCViewController, animated: false)
    }
}
