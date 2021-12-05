//
//  DashboardViewController.swift
//  Expense Tracker
//
//  Created by Andy Nguyen on 29/11/21.
//

import UIKit
import Charts


class DashboardViewController: UIViewController, BaseViewProtocol {

    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var monthlyTitleLabel: UILabel!
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var expensesByCategoryLabel: UILabel!
    @IBOutlet weak var last7DaysChartTitleLabel: UILabel!
    @IBOutlet weak var last7dayChartViewContainer: UIView!
    @IBOutlet weak var spendAmountThisMonthLabel: UILabel!
    @IBOutlet weak var difCompareToLastMonthLabel: UILabel!
    private var viewModel : DashBoardModel!

    private let addNewRecordButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 20
        button.setImage(UIImage(named: "plus-circle-solid"), for: .normal)
        button.tintColor = Theme.shared.selectedItemColor
        button.addTarget(self, action: #selector(showAddNewRecordScreen), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpViewModel()
        self.customUI()
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.refreshData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.addNewRecordButton.frame = CGRect(x: view.frame.size.width - 60, y: view.frame.size.height - 135, width: 40, height: 40)
    }
    
    private func refreshData() {
        self.todayLabel.text = Date().toStringWithEdMMMFormat()
        self.spendAmountThisMonthLabel.text = String(format: "$%.2f", viewModel.getSumExpenseOfMonth(date: Date()))
        self.updateSpendingTrendChart()
        self.updateTrendingPieChart()
        let analyticCopy = viewModel.getComparisionWithLastMonthCopy(date: Date())
        self.difCompareToLastMonthLabel.text = analyticCopy.0
        self.difCompareToLastMonthLabel.textColor = analyticCopy.1
    }
    
    func setUpViewModel() {
        viewModel = DashBoardModel()
    }
    
    func updateSpendingTrendChart() {
        self.setLineChartData(data: viewModel.getDataForSpendingTrend())
    }
    
    func updateTrendingPieChart() {
        self.setPieChartData(chartData: viewModel.getDataForPieChartCategoryTrend())
    }
    
    func customUI() {
        //Custom View
        self.view.addSubview(self.addNewRecordButton)
        self.last7dayChartViewContainer.backgroundColor = Theme.shared.chartBackgroundColor
        self.last7dayChartViewContainer.layer.cornerRadius = 10
        self.expensesByCategoryLabel.textColor = Theme.shared.subtextOnLightBackgroundColor
        self.monthlyTitleLabel.textColor = Theme.shared.subtextOnLightBackgroundColor
        self.spendAmountThisMonthLabel.textColor = Theme.shared.highlightText
        self.todayLabel.textColor = Theme.shared.subtextOnLightBackgroundColor
        self.last7DaysChartTitleLabel.textColor = Theme.shared.subtextOnLightBackgroundColor
        //Custom 3rd elements
        self.customLineChart(last7daysChartView: self.lineChartView)
        self.customPieChart(pieChartView: self.pieChartView)
    }
    
    @objc func showAddNewRecordScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "NewRecordViewController")  as! NewRecordViewController
        viewController.delegate = self
        viewController.modalPresentationStyle = UIModalPresentationStyle.popover
        self.present(viewController, animated: true, completion: nil)
    }
    
    private func customLineChart(last7daysChartView: LineChartView) {
        last7daysChartView.extraRightOffset = CGFloat(20)
        last7daysChartView.extraTopOffset = CGFloat(20)
        last7daysChartView.extraLeftOffset = CGFloat(20)
        last7daysChartView.extraBottomOffset = CGFloat(20)
        last7daysChartView.backgroundColor = Theme.shared.chartBackgroundColor
        last7daysChartView.drawGridBackgroundEnabled = false
        last7daysChartView.xAxis.drawGridLinesEnabled = false
        last7daysChartView.rightAxis.axisLineColor = .clear
        last7daysChartView.xAxis.enabled = false
        last7daysChartView.xAxis.labelPosition = .top
        last7daysChartView.rightAxis.enabled = false
        last7daysChartView.leftAxis.enabled = false
        last7daysChartView.legend.enabled = false
        let yAxis = last7daysChartView.rightAxis
        yAxis.labelFont = UIFont(name: "HelveticaNeue-Light", size:16)!
        yAxis.setLabelCount(6, force: false)
        yAxis.labelTextColor = .clear
        yAxis.labelPosition = .insideChart
        yAxis.axisLineColor = .clear
        last7daysChartView.rightAxis.enabled = false
        last7daysChartView.legend.enabled = false
    }
    
    private func customPieChart(pieChartView chartView: PieChartView) {
        chartView.usePercentValuesEnabled = true
        chartView.drawSlicesUnderHoleEnabled = false
        chartView.holeRadiusPercent = 0.58
        chartView.transparentCircleRadiusPercent = 0.61
        chartView.drawEntryLabelsEnabled = true
        chartView.setExtraOffsets(left: 5, top: 10, right: 5, bottom: 5)
        chartView.drawCenterTextEnabled = true
        chartView.drawHoleEnabled = true
        chartView.extraTopOffset = -15
        chartView.rotationEnabled = true
        chartView.highlightPerTapEnabled = false
        let pieDescriptions = chartView.legend
        pieDescriptions.formSize = 12
        pieDescriptions.horizontalAlignment = .left
        pieDescriptions.verticalAlignment = .top
        pieDescriptions.orientation = .horizontal
        pieDescriptions.drawInside = false
        pieDescriptions.xEntrySpace = 7
        pieDescriptions.yEntrySpace = 4
        pieDescriptions.xOffset = 12
    }
    
    private func setLineChartData(data:[Double]) {
        var records = [ChartDataEntry]()
        for (index,value) in data.enumerated() {
            let record = ChartDataEntry(x: Double(index), y: Double(value))
            records.append(record)
        }
        let lineDataSet = LineChartDataSet(entries: records, label: nil)
        lineDataSet.setColors(UIColor.white)
        lineDataSet.mode = LineChartDataSet.Mode.cubicBezier
        lineDataSet.setCircleColor(.white)
        lineDataSet.lineWidth = 2
        let data = LineChartData.init(dataSets: [lineDataSet])
        data.setValueTextColor(.white)
        data.setValueFont(.systemFont(ofSize: 12))
        self.lineChartView.data = data
    }
    
    private func setPieChartData(chartData: [String:Double]) {
        let titles = Array(chartData.keys)
        let entries = (0..<titles.count).map { (i) -> PieChartDataEntry in
            return PieChartDataEntry(value: chartData[titles[i]] ?? 0,
                                     label: titles[i])
        }
        let set = PieChartDataSet(entries: entries, label: nil)
        set.drawIconsEnabled = false
        set.sliceSpace = 2
        set.colors = Theme.shared.pieChartColorSet
        let data = PieChartData(dataSet: set)
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        pFormatter.percentSymbol = " %"
        data.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
        data.setValueFont(.systemFont(ofSize: 11, weight: .light))
        data.setValueTextColor(.black)
        pieChartView.data = data
        lineChartView.highlightValues(nil)
    }
}

extension DashboardViewController : NewRecordViewControllerDelegate {
    func newRecordAdded() {
        self.refreshData()
    }
}
