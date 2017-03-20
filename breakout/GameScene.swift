//
//  GameScene.swift
//  breakout
//
//  Created by Elizabeth on 3/9/17.
//  Copyright © 2017 Elizabeth. All rights reserved.
//
// hello hi bye 

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate
{
    var ball: SKSpriteNode!
    
    var paddle: SKSpriteNode!
    
    var brick : SKSpriteNode!
    
    var brickHit = 0
    
    var brickArray: SKSpriteNode = []
    
    override func didMove(to view: SKView)
    {
        physicsWorld.contactDelegate = self
        
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)//contraint around edge of view
        
        createBackground()
        makeBall()
        makePaddle()
        makeBrick()
        
        ball.physicsBody?.applyImpulse(CGVector(dx: 3, dy: 3))//puts ball in motion
      
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch in touches
        {
            let location = touch.location(in: self)
            paddle.position.x = location.x
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch in touches
        {
            let location = touch.location(in: self)
            paddle.position.x = location.x
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact)
    {
        if contact.bodyA.node?.name == "brick"||contact.bodyB.node?.name == "ball"
        {
            print ("brick hit")
            brickHit += 1
        }
        else if contact.bodyA.node?.name == "loseZone"||contact.bodyB.node?.name == "loseZone"
        {
            print("you lose")
        }
        if brickHit == 1
        {
            brick.removeFromParent()
            
        }
    }
    
    func createBackground() // creates rolling star bacckground
    {
        let stars = SKTexture(imageNamed: "stars")
        
        for i in 0...1
        {
            let starsBackground = SKSpriteNode(texture: stars)
            starsBackground.zPosition = -1
            starsBackground.anchorPoint = CGPoint(x: 1, y: 1)
            starsBackground.position = CGPoint(x: 0, y: (starsBackground.size.height * CGFloat(i) - CGFloat(1 * i)))
            
            addChild(starsBackground)
            
            let moveDown = SKAction.moveBy(x: 0, y: -starsBackground.size.height, duration: 20)
            let moveReset = SKAction.moveBy(x: 0, y: starsBackground.size.height, duration: 0)
            let moveLoop = SKAction.sequence([moveDown, moveReset])
            let moveForever = SKAction.repeatForever(moveLoop)
            
            starsBackground.run(moveForever)
        }
    }
    func makeBall()
    {
        var ballDiameter = frame.width / 20
        ball = SKSpriteNode(color: UIColor.magenta, size: CGSize(width: ballDiameter, height: ballDiameter))
        ball.position = CGPoint(x: frame.midX, y: frame.midY)
        ball.name = "ball"
        
        ball.physicsBody = SKPhysicsBody(rectangleOf: ball.size)
        ball.physicsBody?.isDynamic = true
        ball.physicsBody?.usesPreciseCollisionDetection = true
        ball.physicsBody?.allowsRotation = false
        ball.physicsBody?.affectedByGravity = false
        ball.physicsBody?.friction = 0
        ball.physicsBody?.restitution = 1
        ball.physicsBody?.angularDamping = 0
        ball.physicsBody?.linearDamping = 0
        ball.physicsBody?.contactTestBitMask = (ball.physicsBody?.collisionBitMask)!
        ball.physicsBody?.applyImpulse(CGVector(dx: 3, dy: 3))//puts ball in motion
        addChild(ball)

    }
    
    func makePaddle()
    {
        paddle = SKSpriteNode(color: UIColor.yellow, size: CGSize(width:frame.width/4, height: frame.height/25))
        paddle.position = CGPoint(x: frame.midX, y: frame.minY + 125)
        paddle.name = "paddle"
        paddle.physicsBody = SKPhysicsBody(rectangleOf: paddle.size)
        paddle.physicsBody?.isDynamic = false
        addChild(paddle)
    }
    
    func makeBrick()
    {
        var xPosition = 10
        var yPosition = 20
        
        let brickWidth = (Int)((frame.width - 60)/5)
        let brickHeight = 20
        
        for rows in 1...3
        {
            for columns in 1...5
            {
                let brick = SKSpriteNode(frame: CGRect(x: xPosition, y: yPosition, width: brickWidth, height: brickHeight))
                brick.backgroundColor = UIColor.red()
                view.addSubview(brick)
                
                brickArray.append(brick)
                
                brickCount++
                
                xPosition += (brickWidth + 10)
            }
        }
        brick = SKSpriteNode(color: UIColor.red, size: CGSize(width:frame.width/3, height: frame.height/25))
        brick.position = CGPoint(x: frame.midX, y: frame.maxY - 30)
        brick.name = "brick"
        brick.physicsBody = SKPhysicsBody(rectangleOf: brick.size)
        brick.physicsBody?.isDynamic = false
        addChild(brick)
    }

    func makeLoseZone()
    {
        let loseZone = SKSpriteNode(color: UIColor.purple, size: CGSize(width:frame.width, height: 50))//change color to clear later
        loseZone.position = CGPoint(x: frame.midX, y: frame.minY + 25)
        loseZone.name = "loseZone"
        loseZone.physicsBody = SKPhysicsBody(rectangleOf: loseZone.size)
        loseZone.physicsBody?.isDynamic = false
        addChild(loseZone)
    }
}










