//
//  PlayerView.swift
//  MusicPlayer
//
//  Created by 康明浩 on 2022/11/27.
//

import SwiftUI

struct PlayerView: View {
    @EnvironmentObject var audioManager: AudioManager
    var musicVM: MusicViewModel
    var isPreview: Bool = false
    @State private var value: Double = 0.0
    @State private var isEditing: Bool = false
    @Environment(\.dismiss) var dismiss
    
    let timer = Timer
        .publish(every: 0.5, on: .main, in: .common)
        .autoconnect()
    
    var body: some View {
        ZStack {
            Rectangle()
                .background(.thinMaterial)
                .opacity(0.25)
                .ignoresSafeArea()
            
            Image(musicVM.music.image)
                .resizable()
                .scaledToFit()
                .frame(height: UIScreen.main.bounds.width)
                .ignoresSafeArea()
            
            
            VStack(spacing: 32) {
                
                HStack() {
                    Button {
                        audioManager.stop()
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 36))
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                }
                
                Text(musicVM.music.title)
                    .font(.title)
                    .foregroundColor(.black)
            
                Spacer()
                
                if let player = audioManager.player {
                    VStack(spacing: 5) {
                        Slider(value: $value, in: 0...player.duration) { editing in
                            
                            isEditing = editing
                            
                            if !editing {
                                player.currentTime = value
                            }
                        }
                        .accentColor(.gray)
                        
                        HStack {
                            Text(DateComponentsFormatter.positional.string(from: player.currentTime) ?? "0:00")
                            
                            Spacer()
                            
                            Text(DateComponentsFormatter.positional.string(from: player.duration - player.currentTime) ?? "0:00")
                        }
                        .font(.caption)
                        .foregroundColor(.black)
                    }
                    
                    HStack {
                        
                        let color: Color = audioManager.isLooping ? .blue : .black
                        PlaybackControlButton(systemName: "repeat", color: color) {
                            audioManager.toggleLoop()
                        }
                        
                        Spacer()
                        
                        PlaybackControlButton(systemName: "gobackward.10") {
                            audioManager.player?.currentTime -= 10
                        }
                        
                        Spacer()
                        
                        PlaybackControlButton(systemName: audioManager.isPlaying ? "pause.circle.fill" : "play.circle.fill", fontSize: 44) {
                            audioManager.playPause()
                        }
                        
                        Spacer()
                        
                        PlaybackControlButton(systemName: "goforward.10") {
                            audioManager.player?.currentTime += 10
                        }
                        
                        Spacer()
                        
                        PlaybackControlButton(systemName: "stop.fill") {
                            audioManager.stop()
                            dismiss()
                        }
                    }
                }
                
            }
            .padding(20)
        }
        .onAppear {
            // AudioManager.shared.startPlayer(track: musicVM.music.track, isPreview: isPreview)
            audioManager.startPlayer(track: musicVM.music.track, isPreview: isPreview)
        }
        .onReceive(timer) { _ in
            guard let player = audioManager.player, !isEditing else { return }
            value = player.currentTime
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    static let musicVM = MusicViewModel(music: Music.data)
    static var previews: some View {
        PlayerView(musicVM: musicVM, isPreview: true)
            .environmentObject(AudioManager())
    }
}
