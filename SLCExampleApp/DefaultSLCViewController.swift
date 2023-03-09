//
//  ViewController.swift
//  SLCExampleApp
//
//  Created by Aimar Ugarte on 15/1/23.
//

import UIKit
import SimpleLineChart

final class DefaultSLCViewController: UIViewController {
    
    let lineChart = SimpleLineChart()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupChart()
        setupTitle()
        setupButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadChart()
    }
}

private extension DefaultSLCViewController {
    
    func setupChart() {
        lineChart.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lineChart)
        NSLayoutConstraint.activate([
            lineChart.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            lineChart.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lineChart.heightAnchor.constraint(equalToConstant: 300),
            lineChart.widthAnchor.constraint(equalToConstant: view.frame.width - 32)
        ])
    }
    
    func setupTitle() {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = .black
        title.text = "Simple Line Chart"
        title.font = title.font.withSize(24)
        view.addSubview(title)
        NSLayoutConstraint.activate([
            lineChart.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 32),
            title.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
    }
    
    func setupButtons() {
        let reloadBtn = createButton(title: "Reload")
        reloadBtn.addTarget(self, action: #selector(reload), for: .touchUpInside)
        view.addSubview(reloadBtn)
        NSLayoutConstraint.activate([
            reloadBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            reloadBtn.topAnchor.constraint(equalTo: lineChart.bottomAnchor, constant: 32),
            reloadBtn.widthAnchor.constraint(equalToConstant: 128)
        ])
        
        let styledSLCBtn = createButton(title: "Styled SLC")
        styledSLCBtn.addTarget(self, action: #selector(styledSLC), for: .touchUpInside)
        view.addSubview(styledSLCBtn)
        NSLayoutConstraint.activate([
            styledSLCBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            styledSLCBtn.topAnchor.constraint(equalTo: reloadBtn.bottomAnchor, constant: 16),
            styledSLCBtn.widthAnchor.constraint(equalToConstant: 128)
        ])
    }
    
    func createButton(title: String) -> UIButton {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle(title, for: .normal)
        btn.layer.cornerRadius = 8.0
        btn.backgroundColor = .black
        btn.setTitleColor(.white, for: .normal)
        return btn
    }
    
    @objc func reload(sender: UIButton?) {
        loadChart()
    }
    
    @objc func styledSLC(sender: UIButton?) {
        let styledSLCViewController = StyledSLCViewController()
        navigationController?.pushViewController(styledSLCViewController, animated: false)
    }
}

private extension DefaultSLCViewController {
    
    func loadChart() {
        let values: [SLCData] = fetchData()
        let dataSet = SLCDataSet(graphPoints: values)
        lineChart.loadPoints(dataSet: dataSet)
    }
    
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
