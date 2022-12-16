//
//  GameView.swift
//  Granchio
//
//  Created by Nunzio Ricci on 13/12/22.
//

import SwiftUI
import SpriteKit

struct GameView: View {
    func onLose(points: Int) {
        
    }
    
    var scene: GameScene {
        let scene = GameScene{ points, game in
            
        }!
        scene.scaleMode = .aspectFill
        return scene
    }
    
    var body: some View {
        SpriteView(scene: scene)
            .ignoresSafeArea()
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .previewLayout(.device)
            .previewDevice(.init(rawValue: "iPhone 13"))
            .previewInterfaceOrientation(.landscapeRight)
    }
}
