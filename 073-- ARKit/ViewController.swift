//
//  ViewController.swift
//  073-- ARKit
//
//  Created by 顾雪飞 on 2018/7/18.
//  Copyright © 2018年 顾雪飞. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    /*
     ARKit 四大元素：几何、渲染、节点、手势
     */

    @IBOutlet var sceneView: ARSCNView!
    
    let texture = ["ARKit", "a", "b", "c"]
    
    private var index = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let sceneMissile = SCNScene(named: "art.scnassets/missile2.scn")!
//        let missile = Missile(scene: scene)
        let missile = Missile(scene: sceneMissile)
        missile.name = "missile"
        missile.position = SCNVector3(0, 0, -4)
        
        let scene = SCNScene()
        scene.rootNode.addChildNode(missile)
        // 几何
//        let box = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
//        // 渲染
//        let material = SCNMaterial()
//        material.diffuse.contents = UIImage(named: "ARKit")
//        box.materials = [material]
//        // 节点
//        let node = SCNNode(geometry: box)
//        // 节点位置
//        node.position = SCNVector3(0, 0, -0.5)
//        // 场景添加节点
//        scene.rootNode.addChildNode(node)
        
//        let sphere = SCNSphere(radius: 0.2)
//        let material = SCNMaterial()
//        material.diffuse.contents = UIImage(named: "ARKit")
//        sphere.materials = [material]
//        let node = SCNNode(geometry: sphere)
//        node.position = SCNVector3(0, 0, -0.5)
//        scene.rootNode.addChildNode(node)
        
        // Set the scene to the view
        sceneView.scene = scene
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction(ges:)))
        view.addGestureRecognizer(tap)
    }
    
    @objc func tapAction(ges: UITapGestureRecognizer) {
        
        guard let missileNode = self.sceneView.scene.rootNode.childNode(withName: "missile", recursively: true) else { return }
        guard let smokeNode = self.sceneView.scene.rootNode.childNode(withName: "smoke", recursively: true) else { return }
        
        let fire = SCNParticleSystem(named: "fire.scnp", inDirectory: nil)
        smokeNode.removeAllParticleSystems()
        smokeNode.addParticleSystem(fire!)
        
        missileNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        missileNode.physicsBody?.isAffectedByGravity = false
        missileNode.physicsBody?.damping = 0.0
        missileNode.physicsBody?.applyForce(SCNVector3(0, 100, 0), asImpulse: false)
        
//        let sceneView = ges.view as! SCNView
//        let touchPosition = ges.location(in: sceneView)
//        let hitResults = sceneView.hitTest(touchPosition, options: [:])
//        if !hitResults.isEmpty {
//            if index == texture.count {
//                index = 0
//            }
//            guard let hitResult = hitResults.first else { return } // 判断是否第一次接触
//            let node = hitResult.node
//            node.geometry?.firstMaterial?.diffuse.contents = UIImage(named: texture[index])
//            index += 1
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
}
