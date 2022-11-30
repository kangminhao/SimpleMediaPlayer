//
//  MusicPlayerApp.swift
//  MusicPlayer
//
//  Created by 康明浩 on 2022/11/27.
//

import SwiftUI

@main
struct MusicPlayerApp: App {
    @StateObject var audioManager = AudioManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(audioManager)
        }
    }
}
