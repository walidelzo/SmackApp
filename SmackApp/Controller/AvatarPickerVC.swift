//
//  AvatarPicerVC.swift
//  SmackApp
//
//  Created by Admin on 3/13/19.
//  Copyright © 2019 NanoSoft. All rights reserved.
//

import UIKit

class AvatarPickerVC: UIViewController , UICollectionViewDelegate,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout  {
    //MARK:- IBOUTLETS
    //OutLets
    @IBOutlet weak var AvatarCollV: UICollectionView!
    @IBOutlet weak var segemetControl: UISegmentedControl!
    
    var avatarType = AvatarType.dark
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AvatarCollV.dataSource = self
        AvatarCollV.delegate=self
    }
    
    // MARK:- Collection View DataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarCell", for: indexPath) as? avatarCell
        {
            cell.ConfigCell(index: indexPath.item, type: avatarType)
            return cell
        
        }else{
            return avatarCell()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var numberOfcolumn :CGFloat = 3
        if (UIScreen.main.bounds.width > 320 ){
            numberOfcolumn  = 4
        }
        let spaceBetweenCell :CGFloat = 10
        let padding :CGFloat = 40
        
        
        let cellDimension = ((collectionView.bounds.width - padding)  - (numberOfcolumn - 1) * spaceBetweenCell) / numberOfcolumn
        return CGSize(width: cellDimension, height: cellDimension)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if avatarType == .dark {
            UserDataService.instance.setAvatarName(avatarName: "dark\(indexPath.item)")
        }else{
            UserDataService.instance.setAvatarName(avatarName: "light\(indexPath.item)")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    //MARK:- IBACTIONS
    //IBActions
    @IBAction func backBTNPressd(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func segmentControlValueChanged(_ sender: Any) {
        if segemetControl.selectedSegmentIndex == 0
        {
            avatarType = .dark
        }else
        {
        avatarType = .light
        }
        
        AvatarCollV.reloadData()
    
    }
    
}
