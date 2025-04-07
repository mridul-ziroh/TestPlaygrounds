//
//  RecursiveView.swift
//  App
//
//  Created by mridul-ziroh on 02/04/25.
//


import SwiftUI

struct RecursiveView: View {
    @State var val =  5
    var body: some View {
          VStack {
              AnyView(recursiveView(val))
          }
          .ignoresSafeArea()
      }

      func recursiveView(_ n: Int) -> AnyView {
          if n == 1 {
              return AnyView(view)
          } else {
              let col = Color.random
              return AnyView(CheckerView(content: recursiveView(n - 1), col: col))
          }
      }
    
    var view : some View {
        VStack{
            let col = Color.random
            let col2 = Color.random
            HStack{
                col
                col2
            }
            HStack{
                col2
                col
            }
        }
        .border(.black)
    }
    
}

struct CheckerView<Content: View>: View{
    var content: Content
    var col : Color
    var body: some View {
        buildView()
            .ignoresSafeArea()
    }
    
    @ViewBuilder
    func buildView() -> some View {
        VStack{
            HStack{
                content
                col
            }
            HStack{
                col
                content
            }
        }
        .border(.black)
    }
}

extension Color {
    static var random: Color {
        Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}
