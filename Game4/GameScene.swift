//
//  GameScene.swift
//  Game4
//
//  Created by Michał Przywuski on 16/04/2020.
//  Copyright © 2020 Michał Przywuski. All rights reserved.
//

import SpriteKit
import GameplayKit


class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private var playerWalkingFrames: [SKTexture] = []
    private var playerWalkingFrames_idle: [SKTexture] = []
    private var playerWalkingFrames_jump: [SKTexture] = []
    private var playerWalkingFrames_attack: [SKTexture] = []
    var player: SKSpriteNode = SKSpriteNode()
    
    let playerCategory: UInt32 =  0x00000001 << 0
    let enemy1Category: UInt32 =  0x0000001 << 1
    

    
    
    
    
    func goRight() {
                 let go = SKAction.moveBy(x: 3, y: 0, duration: 0.01)
                 let repeatAction = SKAction.repeatForever(go)
        player.run(repeatAction)
        player.xScale = abs(player.xScale) * 1
        
    }
    func goLeft() {
             let go = SKAction.moveBy(x: -3, y: 0, duration: 0.01)
             let repeatAction = SKAction.repeatForever(go)
    player.run(repeatAction)
    player.xScale = abs(player.xScale) * -1
    }
        
    func button() {
         let button = SKSpriteNode(imageNamed: "previousbutton.png")
            button.position = CGPoint(x: -300, y: -120)
            button.name = "previousButton"
        button.size = CGSize(width: 84.123, height: 93.571)
            self.addChild(button)
        }
    func backbutton() {
         let backbutton = SKSpriteNode(imageNamed: "previousbutton.png")
            backbutton.position = CGPoint(x: -300, y: 120)
        backbutton.zRotation = .pi / 1
            backbutton.name = "backButton"
        backbutton.size = CGSize(width: 84.123, height: 93.571)
            self.addChild(backbutton)
        }
    func jump() {

        player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 150))
    }
    
    func jumpbutton() {
         let jumpbutton = SKSpriteNode(imageNamed: "previousbutton.png")
            jumpbutton.position = CGPoint(x: 300, y: 0)
        jumpbutton.zRotation = .pi / 2
            jumpbutton.name = "jumpButton"
        jumpbutton.size = CGSize(width: 84.123, height: 93.571)
            self.addChild(jumpbutton)
        }
    
    func attackbutton() {
           let attackbutton = SKSpriteNode(imageNamed: "previousbutton.png")
              attackbutton.position = CGPoint(x: 300, y: -100)
          attackbutton.zRotation = .pi / 2
              attackbutton.name = "attackButton"
          attackbutton.size = CGSize(width: 84.123, height: 93.571)
              self.addChild(attackbutton)
          }
    
    
    
    
   func playerMoveEnded() {
      player.removeAllActions()
    }
    
    func createPlayer() {
        
        var walkFrames: [SKTexture] = []
        var walkFrames2: [SKTexture] = []
        var walkFrames3: [SKTexture] = []
        var walkFrames4: [SKTexture] = []
        
        let playerAnimatedAtlas = SKTextureAtlas(named: "walk")
        let playerAnimatedAtlas_idle = SKTextureAtlas(named: "idle")
        let playerAnimatedAtlas_jump = SKTextureAtlas(named: "jump")
        let playerAnimatedAtlas_attack = SKTextureAtlas(named: "attack")
        var _: [SKTexture] = []
        
        
        for i in 0...6 {
          let playerTextureName = "1_entity_000_WALK_00\(i).png"
          walkFrames.append(playerAnimatedAtlas.textureNamed(playerTextureName))
        }
        
        for z in 0...6 {
          let playerTextureName_idle = "1_entity_000_IDLE_00\(z).png"
          walkFrames2.append(playerAnimatedAtlas_idle.textureNamed(playerTextureName_idle))
        }
        
        for p in 0...6 {
          let playerTextureName_jump = "1_entity_000_JUMP_00\(p).png"
          walkFrames3.append(playerAnimatedAtlas_jump.textureNamed(playerTextureName_jump))
        }
        for k in 0...6 {
          let playerTextureName_attack = "1_entity_000_ATTACK_00\(k).png"
    walkFrames4.append(playerAnimatedAtlas_attack.textureNamed(playerTextureName_attack))
        }
        
        playerWalkingFrames = walkFrames
        let firstFrameTexture = playerWalkingFrames[0]
           player = SKSpriteNode(texture: firstFrameTexture)
           player.position = CGPoint(x: -150, y: -90 )
          
        //player.setScale(0.090)
        player.size = CGSize(width: 170, height: 120)
        player.physicsBody = SKPhysicsBody(rectangleOf:CGSize(width: 55, height: 100) )
        player.physicsBody?.allowsRotation =  false
        player.physicsBody?.categoryBitMask = playerCategory
        player.physicsBody?.collisionBitMask = enemy1Category
        playerWalkingFrames_idle = walkFrames2
        playerWalkingFrames_jump = walkFrames3
        playerWalkingFrames_attack = walkFrames4
        
        self.addChild(player)
    }
    
    func animateplayer() {
      player.run(SKAction.repeatForever(
        SKAction.animate(with: playerWalkingFrames,
                         timePerFrame: 0.05,
                         resize: false,
                         restore: true)),
        withKey:"walkingInPlaceBear")
        
    }
    func animateplayer_idle() {
       player.run(SKAction.repeatForever(
         SKAction.animate(with: playerWalkingFrames_idle,
                          timePerFrame: 0.07,
                          resize: false,
                          restore: true)),
         withKey:"walkingInPlaceBear2")
    }
    
    func animateplayer_jump() {
       player.run(SKAction.repeatForever(
         SKAction.animate(with: playerWalkingFrames_jump,
                          timePerFrame: 0.07,
                          resize: false,
                          restore: true)),
         withKey:"walkingInPlaceBear3")
    }
    
    func animateplayer_attack() {
       player.run(SKAction.repeatForever(
         SKAction.animate(with: playerWalkingFrames_attack,
                          timePerFrame: 0.07,
                          resize: false,
                          restore: true)),
         withKey:"walkingInPlaceBear4")
    }
    
    func create_enemy() {
       
        if let enemy1 = self.childNode(withName: "enemy1") as? SKSpriteNode{
            
            enemy1.color = UIColor.green
            enemy1.size = CGSize(width: 170, height: 120)
            enemy1.position = CGPoint(x: -150, y: -130 )
            enemy1.physicsBody?.allowsRotation =  false
            enemy1.physicsBody?.categoryBitMask = enemy1Category
            enemy1.physicsBody?.contactTestBitMask = playerCategory
            enemy1.physicsBody = SKPhysicsBody(rectangleOf:CGSize(width: 25, height: 100) )
            enemy1.xScale = abs(enemy1.xScale) * -1
        }
        
        }
    func create_floor() {
        var floor: SKSpriteNode?
           
           
               floor = SKSpriteNode(imageNamed: "planko")
        floor?.position = CGPoint(x: 100, y: -200)
               floor?.size = CGSize(width: 4000, height: 20)
        floor?.physicsBody = SKPhysicsBody(rectangleOf:CGSize (width: 4000, height: 100) )
        floor?.physicsBody?.isDynamic = false
        self.addChild(floor!)
        
               
        
    }
    
    func dead_player() {
        let location = player.position
        let dx = (location.x)
        let dy = (location.y) - 40
       
        let ogien = CGPoint(x: dx, y: dy)
        player.removeAllActions()
        player.isHidden = true
        
        let fire = SKEmitterNode(fileNamed: "fire")
        fire?.position = (ogien)
        self.addChild(fire!)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1) ) {
                   self.removeChildren(in: [fire!])
    }
    }
      
    func didBegin(_ contact: SKPhysicsContact) {
        let collison: UInt32 = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if collison == playerCategory | enemy1Category{
            print("COLLISION")
            
        }
    }
    override func didMove(to view: SKView) {
    if let planko = self.childNode(withName: "planko") as? SKSpriteNode{
     planko.color = UIColor.green
       //physicsBody = SKPhysicsBody(rectangleOf:CGSize (width: 40, height: 40) )
        }
        
    if let element = self.childNode(withName: "element") as? SKSpriteNode{
               element.color = UIColor.green
        self.physicsWorld.contactDelegate = self
        physicsBody = SKPhysicsBody(rectangleOf:CGSize (width: 40, height: 40))
        
        create_enemy()
        createPlayer()
        animateplayer_idle()
        button()
        backbutton()
        jumpbutton()
        attackbutton()
    
    
        
        }
        
        
    
        func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
       
          }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         if let touch = touches.first {
                let location = touch.location(in: self)
                let nodesarray = nodes(at: location)
                 
                for node in nodesarray {
                    if node.name == "previousButton" {
                         print("klik")
                               goRight()
                        
                                animateplayer()
                     }
                }
            for node in nodesarray {
                if node.name == "backButton" {
                     print("kliku kliku")
                    goLeft()
                    
                    animateplayer()
                 }
            }
            for node in nodesarray {
                if node.name == "jumpButton" {
                     print("kliku kliku kliku")
                    jump()
                    animateplayer_jump()
                 }
            }
            for node in nodesarray {
                if node.name == "attackButton" {
                     print("kliku kliku kliku kliku")
                    animateplayer_attack()
                 }
            }
        }
        
       
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        player.removeAllActions()
        playerMoveEnded()
        animateplayer_idle()
    }
    }


