//
//  ContentView.swift
//  PerceptibleSquare
//
//  Created by Inna Chystiakova on 12/05/2024.
//

import SwiftUI

struct ContentView: View {
    @State var position = CGPoint(x: 0, y: 0)
    @State var lastPosition = CGSize(width: 128, height: 290)
    
    var body: some View {
        ZStack(alignment: .center) {
            VStack(spacing: 0) {
                BackgroundView(bgColor: .white)
                BackgroundView(bgColor: .pink)
                BackgroundView(bgColor: .yellow)
                BackgroundView(bgColor: .black)
            }
            .ignoresSafeArea()
            VStack(spacing: 0) {
                BackgroundView(bgColor: .black)
                BackgroundView(bgColor: .white)
                BackgroundView(bgColor: .black)
                BackgroundView(bgColor: .white)
            }
            .ignoresSafeArea()
            .clipShape(RectShape(position:
                    .init(
                        x: lastPosition.width + position.x,
                        y: lastPosition.height + position.y
                    )
            ))
            .gesture(DragGesture()
                .onChanged { value in
                    position = .init(
                        x: value.translation.width,
                        y: value.translation.height
                    )
                }
                .onEnded({ value in
                    position = .zero
                    lastPosition.width += value.translation.width
                    lastPosition.height += value.translation.height
                })
            )
        }
    }
}

struct BackgroundView: View {
    var bgColor: Color
    
    var body: some View {
        Color(bgColor).frame(minWidth: 0, maxWidth: .infinity)
    }
}

struct RectShape: Shape {
    var position: CGPoint
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.addRoundedRect(
            in: CGRect(x: position.x, y: position.y, width: 150, height: 150),
            cornerSize: CGSize(width: 20, height: 20)
        )
        return path
    }
}

#Preview {
    ContentView()
}
