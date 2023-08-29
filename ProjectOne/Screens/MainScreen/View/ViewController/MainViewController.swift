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
    // MARK: - UI Elemets
    private let tableView = UITableView()
    private let welcomeLabel = UILabel()
    private lazy var refreshControll: UIRefreshControl = {
        let controll = UIRefreshControl()
        controll.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
        return controll
    }()
    let gradientLayer = CAGradientLayer()

    // MARK: - Private propeties
    private var model: MainViewModel = MainViewModel(user: UserModel())

    // MARK: - Private properties
    var presenter: MainPresenterProtocol

    // MARK: - Init
    init(presenter: MainPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDidLoadSetup()
    }

    // MARK: - Private methods
    private func viewDidLoadSetup() {
        view.backgroundColor = .white
        model = presenter.getModel()
        configureNavgationView()
        configureWelcomeLabel()
        configureTableView()
        configureStandartNavBar()
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
        model = presenter.getModel()
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
            return model.todayProducts.count
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
            cell.setData(model)
            return cell
        }
        return UITableViewCell()
    }

    private func createCalloriesViewCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: CalloriesViewCell.self),
            for: indexPath
        ) as? CalloriesViewCell {
            cell.setData(model)
            return cell
        }

        return UITableViewCell()
    }

    private func createFoodEatViewCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: FoodEatViewCell.self),
            for: indexPath
        ) as? FoodEatViewCell {
            cell.setData(model.todayProducts[indexPath.row])
            return cell
        }

        return UITableViewCell()
    }
}
