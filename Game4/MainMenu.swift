//
//  MainMenu.swift
//  Game4
//
//  Created by Michał Przywuski on 25/09/2020.
//  Copyright © 2020 Michał Przywuski. All rights reserved.
//

import Foundation
import SpriteKit

class MainMenu: UIViewController {
 
     override func viewDidLoad() {
         let scene = GameScene(size: view.frame.size)
         let skView = view as! SKView
         skView.presentScene(scene)
     }
}
