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
    var player = SKSpriteNode()
    var piratka = SKSpriteNode()
    var player_health: Int = 3
    var piratka_health: Int = 5
    
    
    var healthBar = SKSpriteNode()
    var test = SKSpriteNode()
    var  health :  CGFloat  =  1.0  {
      didSet  {
    healthBar.xScale = health
        
        if health > 1.0 { health = 1.0 }
      }
    }

    let cam = SKCameraNode()
    
    //var  healthpoint :  SKSpriteNode
    
    let playerCategory: UInt32 =  0x00000001 << 0
    let enemy1Category: UInt32 =  0x00000001 << 2
    let playermieczCategory: UInt32 =  0x0000001 << 1
    let piratkaCategory: UInt32 = 0x0000001 << 3
    
    
    
    
    
    
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
        cam.addChild(button)
        //self.addChild(button)
        
        
        }
    func backbutton() {
         let backbutton = SKSpriteNode(imageNamed: "previousbutton.png")
            backbutton.position = CGPoint(x: -300, y: 120)
        backbutton.zRotation = .pi / 1
            backbutton.name = "backButton"
        backbutton.size = CGSize(width: 84.123, height: 93.571)
            //self.addChild(backbutton)
          cam.addChild(backbutton)
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
           // self.addChild(jumpbutton)
        cam.addChild(jumpbutton)
        }
    
    func attackbutton() {
           let attackbutton = SKSpriteNode(imageNamed: "previousbutton.png")
              attackbutton.position = CGPoint(x: 300, y: -100)
          attackbutton.zRotation = .pi / 2
              attackbutton.name = "attackButton"
          attackbutton.size = CGSize(width: 84.123, height: 93.571)
             // self.addChild(attackbutton)
        cam.addChild(attackbutton)
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
           
           player.position = CGPoint(x: -1050, y: -90 )
          
        //player.setScale(0.090)
        player.size = CGSize(width: 170, height: 120)
        player.physicsBody = SKPhysicsBody(rectangleOf:CGSize(width: 55, height: 100) )
       
        player.physicsBody?.allowsRotation =  false
        player.physicsBody?.categoryBitMask = playerCategory
        player.physicsBody?.collisionBitMask = enemy1Category
        //player.physicsBody?.contactTestBitMask = enemy1Category
        
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
            
            // enemy1.physicsBody?.collisionBitMask = playerCategory
            enemy1.physicsBody = SKPhysicsBody(rectangleOf:CGSize(width: 25, height: 100) )
            enemy1.xScale = abs(enemy1.xScale) * -1
            enemy1.physicsBody?.categoryBitMask = enemy1Category
            enemy1.physicsBody?.contactTestBitMask = playerCategory
            enemy1.physicsBody?.contactTestBitMask = playermieczCategory
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
        func create_piratka() {
            
                piratka = SKSpriteNode(imageNamed: "piratka")
                piratka.position = CGPoint(x: -850, y: -90 )
            piratka.size = CGSize(width: 170, height: 120)
            piratka.physicsBody = SKPhysicsBody(rectangleOf:CGSize(width: 55, height: 100) )
            piratka.physicsBody?.allowsRotation =  false
            piratka.physicsBody?.categoryBitMask = piratkaCategory
            
            piratka.physicsBody?.contactTestBitMask = playerCategory
            piratka.xScale = abs(piratka.xScale) * -1
                
          //  self.addChild(piratka)
            
            healthBar = SKSpriteNode(imageNamed: "healthbar")
          
           // healthBar.position = CGPoint(x: piratka.position.x, y: pozycja_paskay)
            healthBar.position = CGPoint(x: 30, y: 50)
            healthBar.size = CGSize(width: 100, height: 10)
            healthBar.anchorPoint = CGPoint(x: 1.0, y: 1.0)
            piratka.addChild(healthBar)
            
           // test = SKSpriteNode(imageNamed: "healthbar")
           // test.position = CGPoint(x: 10, y: self.size.height / 2)
           // test.size = CGSize(width: 40, height: 60)
           // piratka.addChild(test)
            addChild(piratka)
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
            print("COLLISION") }
        
            else {
                //print("Brak Kolizji" )
            }
        if collison == playermieczCategory | enemy1Category {
            print("miecz")
            
        }
        
        if collison == playermieczCategory | piratkaCategory {
            print("miecz_Piratka")
            health -= 0.2
         //   piratka.isHidden = true
            
    
            }
        if collison == playerCategory | piratkaCategory{
            if piratka_health >= 1 {
                print("dobrze") }}
            
            
               
               else {
                 // print("malo zycia")
               }
            }
        

    
    
    override func didMove(to view: SKView) {
     self.physicsWorld.contactDelegate = self
    
        
  //     var healthBar = self.childNode(withName: "healthBar") as? SKSpriteNode
        
    if let planko = self.childNode(withName: "planko") as? SKSpriteNode{
     planko.color = UIColor.green
    
        
        }
        
        
    if let element = self.childNode(withName: "element") as? SKSpriteNode{
               element.color = UIColor.green
        self.physicsWorld.contactDelegate = self
        physicsBody = SKPhysicsBody(rectangleOf:CGSize (width: 40, height: 40))
       
        self.camera = cam
        addChild(cam)

        create_enemy()
        createPlayer()
        animateplayer_idle()
        button()
        backbutton()
        jumpbutton()
        attackbutton()
        create_piratka()

        
        }
        
        
    
       
       
          }
    
    
    override func update(_ currentTime: TimeInterval) {
           // Called before each frame is rendered
       let location2 = player.position
               let dx2 = (location2.x) + 130
               //let dy2 = (location2.y) + 130
        cam.position.x = dx2
        cam.position.y = 0
        
       // health -= 0.001
       // print(health)
        if health < 0 {
      //      gameOver()
           // print("GameOver")
            piratka.isHidden = true
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
                  player.physicsBody = SKPhysicsBody(rectangleOf:CGSize(width: 40, height: 100) )
                  player.physicsBody?.allowsRotation =  false
                    player.physicsBody?.categoryBitMask = playermieczCategory
                    player.physicsBody?.collisionBitMask = enemy1Category
                   piratka.physicsBody?.contactTestBitMask = playermieczCategory
                 }
            }
        }
        
       
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        player.removeAllActions()
        playerMoveEnded()
        animateplayer_idle()
        player.physicsBody = SKPhysicsBody(rectangleOf:CGSize(width: 35, height: 100) )
        player.physicsBody?.allowsRotation =  false
        player.physicsBody?.categoryBitMask = playerCategory
        player.physicsBody?.collisionBitMask = enemy1Category
        piratka.physicsBody?.contactTestBitMask = playerCategory
        print(health)
        
    }
    }


