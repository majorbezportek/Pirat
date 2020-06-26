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
    private var czarnyWalkingFrames: [SKTexture] = []
    var player = SKSpriteNode()
    var piratka = SKSpriteNode()
    var player_health: Int = 3
    var piratka_health: Int = 5
    var playerhealthbar = SKSpriteNode()
    var healthactualbar = SKSpriteNode()
    var czarny = SKSpriteNode()
    private var updateTime: Double = 0
    private var updateTime2: Double = 10
    private var updateTime3: Double = 5
    var czas = 0
    var piratkaczas = 0
   
    var healthBar = SKSpriteNode()
    var healthBarczarny = SKSpriteNode()
    var test = SKSpriteNode()
    var  health :  CGFloat  =  1.0  {
     
        
        
        didSet  {
    healthBar.xScale = health
        
        if health > 1.0 { health = 1.0 }
      }
    }

    
    
    var  playerhealth :  CGFloat  =  1.0  {
         didSet  {
       healthactualbar.xScale = playerhealth
           
           if playerhealth > 1.0 { playerhealth = 1.0 }
         }
       }
    
    var  czarnyhealth :  CGFloat  =  1.0  {
      didSet  {
    healthBarczarny.xScale = czarnyhealth
        
        if czarnyhealth > 1.0 { czarnyhealth = 1.0 }
      }
    }
    
    let cam = SKCameraNode()
    
    
    
    let playerCategory: UInt32 =  0b100000
    let enemy1Category: UInt32 =  0b10000
    let playermieczCategory: UInt32 =  0b10
    let piratkaCategory: UInt32 = 0b100
    let czarnyCategory: UInt32 = 0b1000
    
    
    
    
    
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
        
        
       // let spaceShipTexture = SKTexture(imageNamed: "p2.png")
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
        
        
        player.size = CGSize(width: 170, height: 120)
       
        let spaceShipTexture = SKTexture(imageNamed: "p2.png")
        let texturedSpaceShip = SKSpriteNode(texture: spaceShipTexture)
        player.physicsBody = SKPhysicsBody(texture: spaceShipTexture , size: CGSize(width: player.size.width,
                                                                                    height: player.size.height));
        player.physicsBody?.usesPreciseCollisionDetection = true
        
        player.physicsBody?.allowsRotation =  false
        player.physicsBody?.categoryBitMask = playerCategory
        player.physicsBody?.collisionBitMask = piratkaCategory
        player.physicsBody?.contactTestBitMask = piratkaCategory
       
        
        playerWalkingFrames_idle = walkFrames2
        playerWalkingFrames_jump = walkFrames3
        playerWalkingFrames_attack = walkFrames4
        

        self.addChild(player)
    }
    
    func healthbar_player() {
        
               playerhealthbar = SKSpriteNode(imageNamed: "BarBackground")
                playerhealthbar.position = CGPoint(x: -100, y: 230)
                playerhealthbar.size = CGSize(width: 210, height: 150)
                playerhealthbar.zPosition = -10
                playerhealthbar.anchorPoint = CGPoint(x: 0.0, y: 1.0)
                healthactualbar = SKSpriteNode(imageNamed: "RedBar")
                healthactualbar.position = CGPoint(x: -100, y: 230)
                healthactualbar.size = CGSize(width: 200, height: 150)
                healthactualbar.anchorPoint = CGPoint(x: 0.0, y: 1.0)
                healthactualbar.zPosition = 2
                
        cam.addChild(healthactualbar)
       cam.addChild(playerhealthbar)
      // self.addChild(playerhealthbar)
             
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
                piratka.position = CGPoint(x: -550, y: -90 )
            piratka.size = CGSize(width: 170, height: 120)
            piratka.physicsBody = SKPhysicsBody(rectangleOf:CGSize(width: 35, height: 100) )
            piratka.physicsBody?.allowsRotation =  false
        //piratka.physicsBody?.collisionBitMask = playermieczCategory
            piratka.physicsBody?.categoryBitMask = piratkaCategory
            piratka.physicsBody?.contactTestBitMask = playerCategory
           
            piratka.xScale = abs(piratka.xScale) * -1
                
       
            healthBar = SKSpriteNode(imageNamed: "healthbar")
          
           // healthBar.position = CGPoint(x: piratka.position.x, y: pozycja_paskay)
            healthBar.position = CGPoint(x: 30, y: 50)
            healthBar.size = CGSize(width: 100, height: 10)
            healthBar.anchorPoint = CGPoint(x: 1.0, y: 1.0)
            piratka.addChild(healthBar)

           // piratka.addChild(test)
            addChild(piratka)
            piratka.isHidden = false
    }
    
    func create_czarny() {
                
        var czarnywalkFrames: [SKTexture] = []
        let czarnyAnimatedAtlas = SKTextureAtlas(named: "czarny_walk")
       
        for pp in 0...6 {
          let czarnyTextureName = "3_3-PIRATE_WALK_00\(pp).png"
          czarnywalkFrames.append(czarnyAnimatedAtlas.textureNamed(czarnyTextureName))
        }
        
        czarnyWalkingFrames = czarnywalkFrames
        let firstFrameTexture = czarnyWalkingFrames[0]
        
        
                czarny = SKSpriteNode(imageNamed: "enemy1")
                czarny.position = CGPoint(x: -1000, y: -90 )
                czarny.size = CGSize(width: 170, height: 120)
                czarny.physicsBody = SKPhysicsBody(rectangleOf:CGSize(width: 35, height: 100) )
                czarny.physicsBody?.allowsRotation =  false
               
                czarny.physicsBody?.categoryBitMask = czarnyCategory
                czarny.physicsBody?.contactTestBitMask = playerCategory
                
                czarny.xScale = abs(czarny.xScale) * -1
                
                czarnyWalkingFrames = czarnywalkFrames

                
                healthBarczarny = SKSpriteNode(imageNamed: "healthbar")
              

                healthBarczarny.position = CGPoint(x: 30, y: 50)
                healthBarczarny.size = CGSize(width: 100, height: 10)
                healthBarczarny.anchorPoint = CGPoint(x: 1.0, y: 1.0)
                czarny.addChild(healthBarczarny)
                
                addChild(czarny)
//               czarny.isHidden = true
    
    }
    func czarnywalk() {
          czarny.run(SKAction.repeatForever(
            SKAction.animate(with: czarnyWalkingFrames,
                             timePerFrame: 0.07,
                             resize: false,
                             restore: true)),
            withKey:"walkingInPlaceBear2")
    
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
        let collison2: UInt32 = contact.bodyA.collisionBitMask | contact.bodyB.collisionBitMask
        
       if collison ==  czarnyCategory | playermieczCategory{
        czarnyhealth -= 0.5
        }
        
        //print(piratkaCategory)
        //  print(playerCategory)
        //  print(czarnyCategory)
        
        
        if piratkaczas == 5 {

              }
              else {
                  if collison ==  piratkaCategory | playerCategory{
                  
                  piratka.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 150))
                  piratkaczas = 5
                  playerhealth -= 0.03
                  print("HIT3_p")
                  updateTime3 = 0
                  if collison == nil {return}
                  
                  
              }
        }
        
//        if collison ==  piratkaCategory | playerCategory{
//        print("HIT PIRATKA")
//        health -= 0.3
//        }
        
        if czas == 10 {

        }
        else {
            if collison ==  czarnyCategory | playerCategory{
            
            czarny.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 150))
            czas = 10
            playerhealth -= 0.03
            print("HIT3")
            updateTime2 = 0
            if collison == nil {return}
            
            
        }
    }
    }
    



    
    
    override func didMove(to view: SKView) {
     self.physicsWorld.contactDelegate = self
    
        

        
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
        healthbar_player()
       create_czarny()
        czarnywalk()
        
        }

          }

    
    
    override func update(_ currentTime: TimeInterval) {
           // Called before each frame is rendered
       let location2 = player.position
               let dx2 = (location2.x) + 130
               let dy2 = (location2.y) + 130
        cam.position.x = dx2
        cam.position.y = 0
       

        if updateTime2 == 0 {
            updateTime2 = currentTime
        }
        if updateTime3 == 0 {
            updateTime3 = currentTime
        }
        if currentTime - updateTime2 < 10 {
            czas = 10
             
            }
        else {
            czas = 0
          player.isHidden = false
        }


        let czarnyfollow = (location2.x) - (czarny.position.x)
 
        
//        if health < 0 {
//      //      gameOver()
//
//            piratka.isHidden = true
//       }
        
        if playerhealth < 0 {
            player.isHidden = true
        }
        
        if czarnyhealth < 0 {
            czarny.isHidden = true
            
        }
        
        
        
        let go = SKAction.moveTo(x: location2.x, duration: 10)
                 let repeatAction = SKAction.repeatForever(go)
        czarny.run(repeatAction)
        if czarnyfollow > 1 {
            czarny.xScale = abs(czarny.xScale) * 1
            
        }
        else {
            czarny.xScale = abs(czarny.xScale) * -1
        }

    }
    
  
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         if let touch = touches.first {
                let location = touch.location(in: self)
                let nodesarray = nodes(at: location)
                 
                for node in nodesarray {
                    if node.name == "previousButton" {
                //         print("klik")
                        
                               goRight()
                                animateplayer()
                     }
                }
            for node in nodesarray {
                if node.name == "backButton" {
                    
                //     print("kliku kliku")
                    goLeft()
                    
                    animateplayer()
                   
                 }
            }
            for node in nodesarray {
                if node.name == "jumpButton" {
                //     print("kliku kliku kliku")
                    jump()
                    animateplayer_jump()
                 }
            }
            for node in nodesarray {
                if node.name == "attackButton" {
                    animateplayer_attack()
           
               // player.physicsBody?.applyImpulse(CGVector(dx: 5, dy: 0))
                  player.physicsBody?.allowsRotation =  false
                    player.physicsBody?.categoryBitMask = playermieczCategory
                   
                    
                    piratka.physicsBody?.contactTestBitMask = playermieczCategory
                    czarny.physicsBody?.contactTestBitMask = playermieczCategory
                  

                 }
            }
        }
       
       
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        player.removeAllActions()
        playerMoveEnded()
        animateplayer_idle()
     
      
        player.physicsBody?.allowsRotation =  false
        player.physicsBody?.categoryBitMask = playerCategory
        player.physicsBody?.collisionBitMask = enemy1Category
        piratka.physicsBody?.contactTestBitMask = playerCategory
        czarny.physicsBody?.contactTestBitMask = playerCategory
       
        
        
        print(health)
        print(playerhealth)
        
    }
    }


