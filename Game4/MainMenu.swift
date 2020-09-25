//
//  MainMenu.swift
//  Game4
//
//  Created by Michał Przywuski on 25/09/2020.
//  Copyright © 2020 Michał Przywuski. All rights reserved.
//

import SpriteKit

class MainMenu: SKScene {

/* UI Connections */
var buttonPlay: MSButtonNode!

    override func didMove(to view: SKView) {
        
    
        buttonPlay = self.childNode(withName: "buttonPlay") as? MSButtonNode

        buttonPlay.selectedHandler = {
        self.loadGame()
        }
    }
    func loadGame() {
        
        guard let skView = self.view as SKView? else {
            print("Could not get Skview")
            return
        }

        
        guard let scene = GameScene(fileNamed:"GameScene") else {
            print("Could not make GameScene, check the name is spelled correctly")
            return
        }

        
        scene.scaleMode = .aspectFill

        /* Show debug */
//        skView.showsPhysics = true
//        skView.showsDrawCount = true
//        skView.showsFPS = true

       
        skView.presentScene(scene)
        
    }

}


