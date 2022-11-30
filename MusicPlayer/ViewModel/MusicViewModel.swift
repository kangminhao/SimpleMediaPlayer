//
//  MusicViewModel.swift
//  MusicPlayer
//
//  Created by 康明浩 on 2022/11/27.
//

import Foundation

final class MusicViewModel: ObservableObject {
    private(set) var music: Music
    
    init(music: Music) {
        self.music = music
    }
    
}


struct Music {
    let id = UUID()
    let title: String
    let description: String
    let duration: TimeInterval
    let track: String
    let image: String
    
    static let data = Music(title: "Final Call", description: "", duration: 210, track: "milet-final-call", image: "milet_FinalCall")
}
