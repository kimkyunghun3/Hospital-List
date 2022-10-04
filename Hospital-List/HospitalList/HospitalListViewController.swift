//
//  HospitalListViewController.swift
//  Hospital-List
//
//  Created by Eddy on 2022/10/04.
//

import UIKit

import RxCocoa
import RxSwift

final class HospitalListViewController: UIViewController {
    private let hostpitalViewModel: HospitalViewModel
    private let disposeBag = DisposeBag()

    override func loadView() {
        super.loadView()
        self.view = HospitalListView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }

    init(hospitalViewModel: HospitalViewModel) {
        self.hostpitalViewModel = hospitalViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func bind() {
        guard let mainView = view as? HospitalListView else { return }
        hostpitalViewModel.hospitals
            .bind(to: mainView.tableView.rx.items) { tableView, indexPath, element in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: HospitalListCell.identifer) as? HospitalListCell else {
                    return UITableViewCell()
                }
                cell.configure(element)

                return cell
            }
            .disposed(by: disposeBag)

        mainView.exitButton.rx.tap
            .withUnretained(self)
            .bind { wself, _ in
                wself.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
    }
}
