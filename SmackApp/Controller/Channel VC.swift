//
//  Channel VC.swift
//  SmackApp
//
//  Created by Admin on 3/10/19.
//  Copyright © 2019 NanoSoft. All rights reserved.
//

import UIKit

class Channel_VC: UIViewController , UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var menuProfileImage: RoundedImage!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK:- tableView dataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MassegeDataService.instance.channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath) as? ChannelCell
        {
            cell.conFigureCell(channel: MassegeDataService.instance.channels[indexPath.row])
            return cell
        }else{
            return ChannelCell()
        }
    }
    
    
    //MARK:- view
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.revealViewController()?.rearViewRevealWidth = self.view.frame.width - 60
        NotificationCenter.default.addObserver(self, selector: #selector(Channel_VC.userDataDidChanged(_:)), name: NOTIFY_USER_DATA_CHANGED, object: nil)
        
        ///get channel by SocketIO
        SocketService.instance.getChannel { (Success) in
            if (Success)
            {
                self.tableView.reloadData()
            }
        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        setUserInfo()
      
    }
    
    ///MARK:- helper Methods
    @objc func userDataDidChanged (_ notifi:Notification){
        
        setUserInfo()
    }
    
    func setUserInfo(){
        if AuthService.instance.islogIn {
            menuProfileImage.image = UIImage(named:UserDataService.instance.avatarName)
            loginBtn.setTitle(UserDataService.instance.name, for: .normal)
            menuProfileImage.backgroundColor = UserDataService.instance.returnColor(avatarColorString: UserDataService.instance.avatarColor)
            

            
            
        }else{
            menuProfileImage.image = UIImage (named: "menuProfileIcon")
            loginBtn.setTitle("Login", for: .normal)
            menuProfileImage.backgroundColor = UIColor.clear
        }
        
    }
    
    //MARK:- IBActions
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        if AuthService.instance.islogIn {
            let profileVC = Profile()
            profileVC.modalPresentationStyle = .custom
            present(profileVC, animated: true, completion: nil)
        }else{
            performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }
        
    }
    @IBAction func prepareUnWindSegue(segue:UIStoryboardSegue){}
    
    
    @IBAction func addChannelBtnPressed(_ sender: Any) {
        let addChannelVCC = AddChannel()
        addChannelVCC.modalPresentationStyle = .custom
        present(addChannelVCC, animated: true, completion: nil)

    }
    
}
