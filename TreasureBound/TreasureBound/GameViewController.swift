//
//  GameViewController.swift
//  TreasureBound
//
//  Created by PTz on 2019-03-11.
//  Copyright © 2019 BrokeAssGames. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    @IBOutlet weak var background: UIImageView!
    
    @IBOutlet weak var titleName: UITextField!
    
    @IBOutlet weak var carGameButton: UIButton!
    @IBOutlet weak var puzzleButton: UIButton!
    @IBOutlet weak var runnerButton: UIButton!
    @IBOutlet weak var matcherButton: UIButton!
    @IBOutlet weak var spaceButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                //scene.size = view.bounds.size
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    @IBAction func launchPuzzleSwipe(_ sender: Any) {
        performSegue(withIdentifier: "launchPuzzleSwipe", sender: self)
    }
    
    @IBAction func launchCarGame(_ sender: Any) {
        if let scene = SKScene(fileNamed: "CarsGameMenu"){
            let view = self.view as! SKView
            view.ignoresSiblingOrder = true
            scene.scaleMode = .resizeFill
            scene.size = view.bounds.size
            background.isHidden = true;
            titleName.isHidden = true;
            carGameButton.isHidden = true;
            puzzleButton.isHidden = true;
            runnerButton.isHidden = true;
            matcherButton.isHidden = true;
            spaceButton.isHidden = true;
            view.presentScene(scene)
        }
    }
    
    @IBAction func launchEndlessRunner(_ sender: Any) {
        if let scene = SKScene(fileNamed: "EndlessRunnerMenuScene"){
            let view = self.view as! SKView
            view.ignoresSiblingOrder = true
            scene.scaleMode = .aspectFill
            scene.size = view.bounds.size
            background.isHidden = true;
            titleName.isHidden = true;
            carGameButton.isHidden = true;
            puzzleButton.isHidden = true;
            runnerButton.isHidden = true;
            matcherButton.isHidden = true;
            spaceButton.isHidden = true;
            view.presentScene(scene)
        }
    }
    
    @IBAction func launchTileMatcher(_ sender: Any) {
        performSegue(withIdentifier: "launchTileMatcher", sender: self)
    }
    
    @IBAction func launchSpaceGame(_ sender: Any) {
        if let scene = SKScene(fileNamed: "SpaceGameGameScene"){
            let view = self.view as! SKView
            view.ignoresSiblingOrder = true
            scene.scaleMode = .aspectFill
            scene.size = view.bounds.size
            background.isHidden = true;
            titleName.isHidden = true;
            carGameButton.isHidden = true;
            puzzleButton.isHidden = true;
            runnerButton.isHidden = true;
            matcherButton.isHidden = true;
            spaceButton.isHidden = true;
            view.presentScene(scene)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
