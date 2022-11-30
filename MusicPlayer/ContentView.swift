//
//  ContentView.swift
//  MusicPlayer
//
//  Created by 康明浩 on 2022/11/27.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
           MusicView(musicVM: MusicViewModel(music: Music.data))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AudioManager())
    }
}
