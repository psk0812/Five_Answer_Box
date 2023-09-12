//
//  MainViewController.swift
//  Five_Answer_Box
//
//  Created by 박서경 on 2023/09/12.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDelegateFlowLayout {

    @IBOutlet var up_label: UILabel!
    
    @IBOutlet var CollectionView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        up_label.numberOfLines=0
        up_label.text="한번은 당해도 \n 두번은 당하지 않겠다"
        up_label.layer.borderWidth=2.0
        up_label.layer.borderColor=UIColor.systemMint.cgColor
        up_label.layer.cornerRadius=up_label.frame.height / 10

        // Do any additional setup after loading the view.
    }
    

 
}
