//
//  ViewController.swift
//  Think360
//
//  Created by admin on 13/04/19.
//  Copyright © 2019 AcknoTech. All rights reserved.
//

import UIKit

class MainVC: UIViewController{
    
    
    let dataService = DataService.service
    let doctorsUrl = DoctorsUrl.service
    let doctorsApi = DoctorsApi.service
    
    var pageNumber = 1
    
    fileprivate let reusableCell = "CellId"
    
    override func loadView() {
        super.loadView()
        setup()
        navBarViewSetup()
        setupSearchBar()
        addSubviews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableSetup()
        dataService.doctorsData.removeAll()
        retrieveData()
        
    }
    fileprivate lazy var tableViewContainerView:UIView = {
        let view  = UIView()
        //        view.backgroundColor = .orange
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate lazy var tableView:UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = false
        //        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.isHidden = true
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    fileprivate lazy var spinner:UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.hidesWhenStopped = true
        spinner.style = .whiteLarge
        spinner.color = .orange
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    fileprivate lazy var navBarView:UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    fileprivate lazy var headingLabel:UILabel = {
        let label = UILabel()
        label.text = "My Network"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Avenirnext-Medium", size: 20)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    fileprivate lazy var segmentController:UISegmentedControl = {
        let items = ["Connected Docs","New Request","Suggestions"]
        
        let segment = UISegmentedControl(items: items)
        segment.apportionsSegmentWidthsByContent = true
        segment.tintColor = .white
        segment.selectedSegmentIndex = 0
        segment.translatesAutoresizingMaskIntoConstraints = false
        return segment
    }()
    
    fileprivate func setup(){
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 0/255, green: 150/255, blue: 255/255, alpha: 1)
    }
    
    private func navBarViewSetup(){
        
        //Mark: Adding View To navigation Bar
        navBarView.frame = (navigationController?.navigationBar.frame)!
        
        navigationController?.navigationBar.addSubview(navBarView)
        
        NSLayoutConstraint.activate([
            navBarView.centerXAnchor.constraint(equalTo: (navigationController?.navigationBar.centerXAnchor)!),
            navBarView.centerYAnchor.constraint(equalTo: (navigationController?.navigationBar.centerYAnchor)!)
            ])
        
        let stackView = stackViews(views: [headingLabel,segmentController])
        stackView.axis = .vertical
        stackView.spacing = 10
        navBarView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: navBarView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: navBarView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: navBarView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: navBarView.trailingAnchor)
            ])
        segmentController.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width/10).isActive = true
        segmentController.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width - 30).isActive = true
    }
    
    
    private func setupSearchBar(){
        
        let searchController = UISearchController(searchResultsController: nil)
        //        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Doctors"
        searchController.searchBar.sizeToFit()
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        searchController.searchBar.searchFieldBackgroundPositionAdjustment = UIOffset(horizontal: 0, vertical: 5)
        searchController.searchBar.backgroundColor = .white
    }
    
    private func addSubviews(){
        view.addSubview(tableViewContainerView)
        NSLayoutConstraint.activate([
            tableViewContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableViewContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            tableViewContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableViewContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        tableViewContainerView.addSubview(spinner)
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: tableViewContainerView.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: tableViewContainerView.centerYAnchor),
            spinner.widthAnchor.constraint(equalToConstant: 50),
            spinner.heightAnchor.constraint(equalToConstant: 50)
            ])
        
    }
    
    private func tableSetup(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DoctorCell.self, forCellReuseIdentifier: reusableCell)
    }
    
    fileprivate func retrieveData(){
        spinner.startAnimating()
        let request = doctorsUrl.generateApiRequest(pageNumber: pageNumber)
        
        guard let urlRequest = request else { return }
        
        doctorsApi.retriveJsonData(UrlRequest: urlRequest) {[weak self] (finish) in
            guard let self = self else{return}
            if finish{
                print("Completed")
                DispatchQueue.main.async {
                    self.spinner.stopAnimating()
                    self.tableView.reloadData()
                    self.tableView.isHidden = false
                }
            }
            
        }
        
    }
}

extension MainVC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataService.getDoctorsDetails().count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reusableCell, for: indexPath) as? DoctorCell else { return UITableViewCell() }
        cell.loadDatainCell(doctorData: dataService.getDoctorsDetails()[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        loadData()
    }
}


extension MainVC{
    fileprivate func loadData(){
        
        guard let totalCount = dataService.returnTotalCount()?.totalCount else { return  }
        
        if dataService.getDoctorsDetails().count < totalCount{
            pageNumber += 1
            
            let request = doctorsUrl.generateApiRequest(pageNumber: pageNumber)
            guard let urlRequest = request else { return }
            
            doctorsApi.retriveJsonData(UrlRequest: urlRequest) { (finish) in
                if finish{
                    DispatchQueue.main.async {
                        self.perform(#selector(self.loadTable), with: nil, afterDelay: 1.0)
                    }
                }
            }
            
        }
        
        
    }
    
    @objc func loadTable(){
        self.tableView.reloadData()
    }
}
