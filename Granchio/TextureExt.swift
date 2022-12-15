//
//  TextureExt.swift
//  Granchio
//
//  Created by Nunzio Ricci on 13/12/22.
//

import SpriteKit

extension SKTexture {
    convenience init(pixelart: String) {
        self.init(imageNamed: pixelart)
        filteringMode = .nearest
    }
}
