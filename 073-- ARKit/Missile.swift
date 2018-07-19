//
//  Missile.swift
//  073-- ARKit
//
//  Created by 顾雪飞 on 2018/7/18.
//  Copyright © 2018年 顾雪飞. All rights reserved.
//

import Foundation
import ARKit
import SceneKit

class Missile: SCNNode {
    
    private var scene: SCNScene!
    
    init(scene: SCNScene) {
        super.init()
        self.scene = scene
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(missileNode: SCNScene) {
        super.init()
        setup()
    }
    
    private func setup() {
        
//        guard let missileNode = self.scene.rootNode.childNode(withName: "missile2", recursively: true), let smokeNode = self.scene.rootNode.childNode(withName: "smoke", recursively: true) else { return }
        
        let smoke = SCNParticleSystem(named: "smoke", inDirectory: nil)
        self.scene.rootNode.childNode(withName: "smoke", recursively: true)?.addParticleSystem(smoke!)
        
        self.addChildNode(self.scene.rootNode.childNode(withName: "missile2", recursively: true)!)
        self.addChildNode(self.scene.rootNode.childNode(withName: "smoke", recursively: true)!)
    }
    
}

