//
//  ViewController.swift
//  ProjectOne
//
//  Created by Timur Israilov on 04/09/21.
//

import UIKit
import SnapKit
import WidgetKit

final class MainViewController: UIViewController {
    // MARK: - UIElemets
    private let tableView = UITableView()
    private let welcomeLabel = UILabel()
    private lazy var refreshControll: UIRefreshControl = {
        let controll = UIRefreshControl()
        controll.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
        return controll
    }()
    let gradientLayer = CAGradientLayer()

    // MARK: - Data Variable
    var nutrionData: [String: String]?
    var nowNutrionData: [String: String]?
    var productsData: [ProductCoreData]?

    // MARK: - Dependences
    var presenter: MainPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewDidLoadSetup()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewDidAppearSetup()
    }
    // MARK: - Private
    private func viewDidLoadSetup() {
        view.backgroundColor = .white
        configureNavgationView()
        configureWelcomeLabel()
        configureTableView()
        configureStandartNavBar()
    }

    private func viewDidAppearSetup() {
        nutrionData = presenter.getUserNutrionInfo()
        if let userName = nutrionData?["userName"] {
            title = userName
        }
        productsData = presenter.getProducts()?.reversed()
        nowNutrionData = presenter.getDayliNutrion()
        let userDefaults = UserDefaults(suiteName: "group.timis.Healthtify.Widget")
        let dayliFats = nutrionData?["fats"] ?? "0"
        let dayliCarbs = nutrionData?["carbs"] ?? "0"
        let dayliProtein = nutrionData?["protein"] ?? "0"
        let nowFats = nowNutrionData?["fats"] ?? "0"
        let nowCarbs = nowNutrionData?["carbs"] ?? "0"
        let nowProtein = nowNutrionData?["protein"] ?? "0"
        let dayliCallories = nutrionData?["callories"] ?? "0"
        let nowCallories = nowNutrionData?["callories"] ?? "0"

        let widgetData = WidgetModel(
            dayliFats: dayliFats,
            nowFats: nowFats,
            dayliCarbs: dayliCarbs,
            nowCarbs: nowCarbs,
            dayliProtein: dayliProtein,
            nowProtein: nowProtein,
            nowCallories: nowCallories,
            dayliCallories: dayliCallories
        )

        guard let data = try? JSONEncoder().encode(widgetData) else { return }

        userDefaults?.set(data, forKey: "dailyInfo")

        if #available(iOS 14.0, *) {
            WidgetCenter.shared.reloadAllTimelines()
        }
        tabBarController?.tabBar.selectedItem?.title = R.string.locales.mainMain()
        tableView.reloadData()
    }

    private func configureTableView() {
        view.addSubview(tableView)

        tableView.refreshControl = refreshControll
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CardCell.self, forCellReuseIdentifier: String(describing: CardCell.self))
        tableView.register(CalloriesViewCell.self, forCellReuseIdentifier: String(describing: CalloriesViewCell.self))
        tableView.register(FoodEatViewCell.self, forCellReuseIdentifier: String(describing: FoodEatViewCell.self))

        tableView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

    private func configureWelcomeLabel() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: welcomeLabel)
        welcomeLabel.text = "Good morning"
        welcomeLabel.textColor = UIColor(red: 0.769, green: 0.769, blue: 0.769, alpha: 1)
    }

    private func configureNavgationView() {
        configureStandartNavBar()
        navigationController?.navigationBar.prefersLargeTitles = true
        let addBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addProductAction)
        )
        navigationItem.rightBarButtonItem = addBarButtonItem
    }
}

private extension MainViewController {
    // MARK: - Actions
    @objc func addProductAction() {
        presenter.goToAddProduct()
    }

    @objc func refreshAction() {
        nutrionData = presenter.getUserNutrionInfo()
        if let userName = nutrionData?["userName"] {
            title = userName
        }
        productsData = presenter.getProducts()?.reversed()
        nowNutrionData = presenter.getDayliNutrion()
        tableView.reloadData()
        refreshControll.endRefreshing()
    }
}

extension MainViewController: MainViewProtocol {
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }

        if section == 1 {
            return productsData?.count ?? 0
        }

        return 0
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let label = UILabel()
            label.textColor = .gray
            label.font = .systemFont(ofSize: 18)
            label.text = R.string.locales.mainLastDishes()
            return label
        }

        return nil
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                return createCardCell(tableView, indexPath: indexPath)
            } else {
                return createCalloriesViewCell(tableView, indexPath: indexPath)
            }
        }

        if indexPath.section == 1 {
            return createFoodEatViewCell(tableView, indexPath: indexPath)
        }

        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return UITableView.automaticDimension
        }
        return 0
    }

    private func createCardCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: CardCell.self),
            for: indexPath
        ) as? CardCell {
            let dayliFats = nutrionData?["fats"]
            let dayliCarbs = nutrionData?["carbs"]
            let dayliProtein = nutrionData?["protein"]
            let nowFats = nowNutrionData?["fats"] ?? "0"
            let nowCarbs = nowNutrionData?["carbs"] ?? "0"
            let nowProtein = nowNutrionData?["protein"] ?? "0"

            cell.setData(
                dayliFats: dayliFats ?? "",
                nowFats: nowFats,
                dayliCarbs: dayliCarbs ?? "",
                nowCarbs: nowCarbs,
                dayliProtein: dayliProtein ?? "",
                nowProtein: nowProtein
            )
            return cell
        }
        return UITableViewCell()
    }

    private func createCalloriesViewCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: CalloriesViewCell.self),
            for: indexPath
        ) as? CalloriesViewCell {
            let dayliCallories = nutrionData?["callories"] ?? "0"
            let nowCallories = nowNutrionData?["callories"] ?? "0"
            cell.setData(rateCallories: "", dayliCallories: dayliCallories, nowCallories: nowCallories)
            return cell
        }

        return UITableViewCell()
    }

    private func createFoodEatViewCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: FoodEatViewCell.self),
            for: indexPath
        ) as? FoodEatViewCell {
            let callories = productsData?[indexPath.row].callorie ?? 0
            let date = productsData?[indexPath.row].date ?? Date()
            let productName = productsData?[indexPath.row].name ?? ""

            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "dd.MMMM.yy  HH:mm"
            let stringDate = dateFormater.string(from: date)
            cell.setData(callories: Int(callories), productName: productName, date: stringDate)
            return cell
        }

        return UITableViewCell()
    }
}
