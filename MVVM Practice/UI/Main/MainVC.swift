//
//  MainVC.swift
//  MVVM Practice
//
//  Created by UHP Mac 3 on 27/11/2018.
//  Copyright © 2018 UHP. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import MBProgressHUD

class MainVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyListLabel: UILabel!
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var confirmBtn: UIButton!
    
    private let viewModel: MainVM
    private let disposeBag = DisposeBag()
    
    private var progressHud: MBProgressHUD?
    
    init(viewModel: MainVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindViewModel()
    }
    
    private func setupViews() {
        tableView.register(UINib(nibName: "TableItemCell", bundle: nil), forCellReuseIdentifier: "TableItemCell")
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    private func bindViewModel() {
        let inputs = MainVM.Input(searchText: searchBar.rx.text.orEmpty.asDriver())
        let outputs = viewModel.transform(input: inputs)
        
        outputs.dataLoading
            .drive(onNext: { [unowned self] isLoading in
                if isLoading {
                    self.showLoading()
                } else {
                    self.hideLoading()
                }
            })
            .disposed(by: disposeBag)
        
        outputs.dataError
            .drive(onNext: { [unowned self] error in
                if let errorMessage = error?.errorMessage {
                    self.showError(errorMessage: errorMessage)
                }
            })
            .disposed(by: disposeBag)
        
        outputs.dataItems
            .drive(tableView.rx.items(cellIdentifier: "TableItemCell", cellType: TableItemCell.self)) { _, item, cell in
                cell.configureCell(item: item)
            }
            .disposed(by: disposeBag)
        
        outputs.emptyList
            .drive(onNext: { [unowned self] isEmpty in
                self.tableView.isHidden = isEmpty
                self.emptyListLabel.isHidden = !isEmpty
            })
            .disposed(by: disposeBag)
    }
    
    func showLoading() {
        hideLoading()
        progressHud = MBProgressHUD.showAdded(to: self.view, animated: true)
        progressHud!.mode = .indeterminate
        progressHud!.removeFromSuperViewOnHide = true
    }
    
    func hideLoading() {
        if progressHud != nil {
            progressHud?.hide(animated: true)
            progressHud = nil
        }
    }
    
    func showError(errorMessage: String) {
        print("Error: \(errorMessage)")
    }
    
}

extension MainVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
