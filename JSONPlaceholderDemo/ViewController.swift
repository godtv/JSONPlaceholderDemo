 
//
//  ViewController.swift
//  JSONPlaceholderDemo
//
//  Created by ko on 2021/1/23.
//

import UIKit
import SnapKit
import RxSwift
import Moya
import Moya_ObjectMapper
import RxCocoa


class ViewController: UIViewController {
    
    private var searchController:UISearchController? = nil
    
    private var viewModel:PhotoViewmodel!
    private let disposeBag = DisposeBag()
    var cellID = "cellid"
    lazy var tableView: UITableView! = {
        let view = UITableView.init(frame: .zero, style: .plain)
        view.rowHeight = UITableView.automaticDimension
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.viewModel = PhotoViewmodel()
        
        viewModel.photoModel
            .asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items(cellIdentifier: cellID, cellType: ItemCell.self)) { (_, photo, cell) in
                cell.setCell(data: photo)
            }
            .disposed(by: disposeBag)
        
        setupTableView()
        
        setupSearchController()
    }
    
    private func setupTableView() {
        tableView.register(ItemCell.self, forCellReuseIdentifier: cellID)
        
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) -> Void in
            make.edges.equalToSuperview()
        }
        
        self.tableView.rx.itemSelected.subscribe(onNext:{ indexPath in
            
        }).disposed(by: disposeBag)
        
        Observable.zip(tableView.rx.itemSelected, tableView.rx.modelSelected(PhotoModel.self))
            .bind { [weak self] indexPath, item in
              print("\(item)")
            }
            .disposed(by: disposeBag)
 
        
    }
    
    private func setupSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController?.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        searchController?.isActive = true
        searchController?.searchBar.becomeFirstResponder()
        
        
        searchController?.searchBar.rx.text
            .orEmpty
            .throttle(RxTimeInterval.milliseconds(1000), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .bind(to: viewModel.keywords)
            .disposed(by: disposeBag)
        
        
    }
}


