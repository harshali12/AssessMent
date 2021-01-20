//
//  ViewController.swift
//  Assessment
//
//  Created by APPLE on 14/01/21.
//

import UIKit

class ListingViewController: UIViewController {

    //MARK:-IBOutlets
    @IBOutlet weak var listingTblView: UITableView!
    @IBOutlet weak var schorchersBtn: UIButton!
    @IBOutlet weak var schorchersLbl: UILabel!
    @IBOutlet weak var heatBtn: UIButton!
    @IBOutlet weak var heatLbl: UILabel!

    //ListingViewModel
    lazy var listVm:ListingViewModel = {
        return ListingViewModel()
    }()
    
    private var teamIndex = 0
   
    
    //MARK:- View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        callListingAPI()
        // Do any additional setup after loading the view.
    }
    
    //MARK:- Private Methods
    private func configureUI() {
        listingTblView.tableFooterView = UIView()
        listingTblView.register(UINib(nibName: ListingTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ListingTableViewCell.reuseIdentifier)
    }
    
    private func configureTeamData() {
        heatBtn.setTitle(listVm.teams?[0].nameFull, for: .normal)
        schorchersBtn.setTitle(listVm.teams?[1].nameFull, for: .normal)
        setTeamsBtn(schorchersBtn)
    }
    
    
    private func setTeamsBtn(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            schorchersBtn.setTitleColor(.white, for: .normal)
            schorchersLbl.backgroundColor = .white
            heatBtn.setTitleColor(.lightGray, for: .normal)
            heatLbl.backgroundColor = .lightGray
        case 1:
            schorchersBtn.setTitleColor(.lightGray, for: .normal)
            schorchersLbl.backgroundColor = .lightGray
            heatBtn.setTitleColor(.white, for: .normal)
            heatLbl.backgroundColor = .white
        default:
            break
        }
        
        teamIndex = sender.tag
        listVm.configureTeamData(teamIndex: teamIndex)
        listingTblView.reloadData()
    }
    
    //MARK:- IBAction
    @IBAction func clickOnschorchersHeatBtn(_ sender: UIButton) {
        teamIndex = sender.tag
        listVm.configureTeamData(teamIndex: teamIndex)
        listingTblView.reloadData()
        setTeamsBtn(sender)
    }
    
}

//MARK:- API Calls

extension ListingViewController {
   private func callListingAPI() {
        listVm.getListData { (success) in
            if success {
                self.configureTeamData()
                DispatchQueue.main.async {
                    self.listingTblView.reloadData()
                }
            }
        }
    }
}

//MARK:- UITableViewDataSource Method
extension ListingViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listVm.getPlayerCount(index: teamIndex)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListingTableViewCell.reuseIdentifier) as? ListingTableViewCell
        cell?.configureTeamData(data: listVm.configurePlayerData(playerIndex: indexPath.row))
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
