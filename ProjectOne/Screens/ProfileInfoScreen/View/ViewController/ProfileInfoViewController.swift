//
//  ProfileInfoViewController.swift
//  ProjectOne
//
//  Created by Timur Israilov on 19/09/21.
//

import UIKit

class ProfileInfoViewController: UIViewController {
    private let tableView = UITableView()

    var userName: String?
    var userWeight: String?
    var userHeight: String?
    var userBirthDate: String?
    var isMale: Bool?
    var physicalState: Int?

    var presenter: ProfileInfoPresenterProtocol!
    var isShowAfterOnbording: Bool?

    init(isShowAfterOnbording: Bool) {
        super.init(nibName: nil, bundle: nil)
        self.isShowAfterOnbording = isShowAfterOnbording
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = R.string.locales.profileTitleFillForm()
        configureTableView()
        configureStandartNavBar()
    }

    private func configureTableView() {
        view.addSubview(tableView)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.register(NameViewCell.self, forCellReuseIdentifier: String(describing: NameViewCell.self))
        tableView.register(AgeViewCell.self, forCellReuseIdentifier: String(describing: AgeViewCell.self))
        tableView.register(
            AdditionalInfoViewCell.self,
            forCellReuseIdentifier: String(describing: AdditionalInfoViewCell.self)
        )
        tableView.register(
            StartButtonViewCell.self,
            forCellReuseIdentifier: String(describing: StartButtonViewCell.self)
        )

        tableView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension ProfileInfoViewController: ProfileInfoViewProtocol {
}

extension ProfileInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return createNameCell(tableView, indexPath: indexPath, type: .name)

        case 1:
            return createAgeCell(tableView, indexPath: indexPath)

        case 2:
            return createNameCell(tableView, indexPath: indexPath, type: .weight)

        case 3:
            return createNameCell(tableView, indexPath: indexPath, type: .height)

        case 4:
            return createAdditionalInfoCell(tableView, indexPath: indexPath)

        case 5:
            return createButtonCell(tableView, indexPath: indexPath)

        default:
            return UITableViewCell()
        }
    }
    private func createNameCell(_ tableView: UITableView, indexPath: IndexPath, type: TextType) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: NameViewCell.self),
            for: indexPath
        ) as? NameViewCell {
            cell.setType(type: type)
            cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }

    private func createButtonCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: StartButtonViewCell.self),
            for: indexPath
        ) as? StartButtonViewCell {
            cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }

    private func createAgeCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: AgeViewCell.self),
            for: indexPath
        ) as? AgeViewCell {
            cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }

    private func createAdditionalInfoCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: AdditionalInfoViewCell.self),
            for: indexPath
        ) as? AdditionalInfoViewCell {
            cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }
}

extension ProfileInfoViewController: NameViewCellProtocol, AgeViewCellProtocol, StartButtonViewCellProtocol {
    func startButtonDidTouch() {
        guard let userName = userName else { return }
        guard let userBirthDate = userBirthDate else { return }
        guard let userWeight = userWeight else { return }
        guard let userHeight = userHeight else { return }
        guard let physicalState = physicalState else { return }

        presenter.setUser(
            name: userName,
            birthDate: userBirthDate,
            isMale: isMale ?? true,
            physicalState: physicalState,
            weight: Int(userWeight)!,
            height: Int(userHeight)!
        )
    }

    func sendData(birthDate: String) {
        userBirthDate = birthDate
    }

    func sendData(text: String, cellType: TextType) {
        switch cellType {
        case .name:
            userName = text

        case .weight:
            let weight = text.removeCharacters(from: CharacterSet.decimalDigits.inverted)
            userWeight = weight

        case .height:
            let height = text.removeCharacters(from: CharacterSet.decimalDigits.inverted)
            userHeight = height
        }
    }
}

extension ProfileInfoViewController: AdditionalInfoViewCelDelegate {
    func sendPhysicalState(data: PhysicalStateModel) {
        physicalState = data.id
    }

    func sendSex(isMale: Bool) {
        self.isMale = isMale
    }

    func textEditDidChange(_ text: String) {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}

enum TextType {
    case name
    case weight
    case height
}
