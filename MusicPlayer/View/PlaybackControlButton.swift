//
//  PlaybackControlButton.swift
//  MusicPlayer
//
//  Created by 康明浩 on 2022/11/27.
//

import SwiftUI

struct PlaybackControlButton: View {
    var systemName: String = "play"
    var fontSize: CGFloat = 24
    var color: Color = .black
    var action: () -> Void
    
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: systemName)
                .font(.system(size: fontSize))
                .foregroundColor(color)
        }

    }
}

struct PlaybackControlButton_Previews: PreviewProvider {
    static var previews: some View {
        PlaybackControlButton(action: {})
            .preferredColorScheme(.dark)
    }
}
