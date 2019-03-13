//
//  AvatarPicerVC.swift
//  SmackApp
//
//  Created by Admin on 3/13/19.
//  Copyright © 2019 NanoSoft. All rights reserved.
//

import UIKit

class AvatarPicerVC: UIViewController , UICollectionViewDelegate,UICollectionViewDataSource {
    //MARK:- IBOUTLETS
    //OutLets
    @IBOutlet weak var AvatarCollV: UICollectionView!
    @IBOutlet weak var segemetControl: UISegmentedControl!
    
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
            return cell
        }else{
            return avatarCell()
        }
    }
    
    
    //MARK:- IBACTIONS
    //IBActions
    @IBAction func backBTNPressd(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func segmentControlValueChanged(_ sender: Any) {
    }
    
}
