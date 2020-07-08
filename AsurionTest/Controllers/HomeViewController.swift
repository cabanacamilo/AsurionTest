//
//  ViewController.swift
//  AsurionTest
//
//  Created by Camilo Cabana on 8/07/20.
//  Copyright © 2020 Camilo Cabana. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {
    
    let cellID = "HomeCell"
    let petsManager = PetsManager()
    let settingsManager = SettingsManager()
    var petsInformation = [Pet]()
    var settingsInformation: Settings?
    let alert = Alert()

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setTableView()
        setPetsManager()
        setSettingsManager()
    }
    
    func setNavigationBar() {
        navigationItem.title = "Home"
    }
    
    func setTableView() {
        sizeHeaderToFit()
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: cellID)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petsInformation.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = HomeHeader()
        if let settings = settingsInformation {
            header.configure(settings: settings)
            header.callButton.addTarget(self, action: #selector(workHoursMessage), for: .touchUpInside)
            header.chatButton.addTarget(self, action: #selector(workHoursMessage), for: .touchUpInside)
        }
        return header
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! HomeTableViewCell
        cell.configure(pet: petsInformation[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let petInformationController = PetInformationViewController()
        petInformationController.petInformation = petsInformation[indexPath.row]
        navigationController?.pushViewController(petInformationController, animated: true)
    }
    
    func setPetsManager() {
        petsManager.loadData { [weak self] (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.alert.newAlert(self ?? UITableViewController(), title: "System", messege: "Error: \(error)")
                }
            case .success(let pets):
                self?.petsInformation = pets
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    func setSettingsManager() {
        settingsManager.loadData { [weak self] (result) in
            switch result {
            case .failure(let error):
                print(error)
                DispatchQueue.main.async {
                    self?.alert.newAlert(self ?? UITableViewController(), title: "System", messege: "Error: \(error)")
                }
            case .success(let settings):
                self?.settingsInformation = settings
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    @objc func workHoursMessage() {
        let currentTime = Calendar.current.component(.hour, from: Date())
        if currentTime >= 9 && currentTime <= 18 {
            alert.newAlert(self, title: "Message", messege: "Thank you for getting in touch with us. We’ll get back to you as soon as possible")
        } else {
            alert.newAlert(self, title: "Message", messege: "Work hours has ended. Please contact us again on the next work day")
        }
    }
}
