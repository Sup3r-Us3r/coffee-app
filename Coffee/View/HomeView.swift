//
//  HomeView.swift
//  Coffe
//
//  Created by Mayderson Mello on 03/07/24.
//

import SwiftUI

struct HomeView: View {
  @State var offsetY: CGFloat = 0
  @State var currentIndex: CGFloat = 0

  var body: some View {
    GeometryReader {
      let size = $0.size
      // Since card size is the size of the screen width
      let cardSize = size.width

      // Bottom gradient background
      LinearGradient(
        colors: [.clear, Color.brown.opacity(0.2), Color.brown.opacity(0.45), Color.brown],
        startPoint: .top,
        endPoint: .bottom
      )
      .frame(height: 300)
      .frame(maxHeight: .infinity, alignment: .bottom)
      .ignoresSafeArea()

      // Header view
      HeaderView()

      VStack(spacing: 0) {
        ForEach(Array(coffees.enumerated()), id: \.offset) { index, coffee in
          CoffeView(coffee: coffee, size: size)
            .blur(radius: currentIndex != CGFloat(index) ? 2 : 0)
        }
      }
      .frame(width: size.width)
      .padding(.top, size.height - cardSize)
      .offset(y: offsetY)
      .offset(y: -currentIndex * cardSize)
    }
    .coordinateSpace(name: "SCROLL")
    .contentShape(Rectangle())
    .gesture(
      DragGesture()
        .onChanged({ value in
          // Showing Down the Gesture
          offsetY = value.translation.height
        })
        .onEnded({ value in
          let translation = value.translation.height

          withAnimation(.easeInOut) {
            if translation > 0 {
              // 250 -> Update it for your own usage
              if currentIndex > 0 && translation > 250 {
                currentIndex -= 1
              }
            } else {
              if currentIndex < CGFloat(coffees.count - 1) && -translation > 250 {
                currentIndex += 1
              }
            }

            offsetY = .zero
          }
        })
    )
    .preferredColorScheme(.light)
  }

  @ViewBuilder
  func HeaderView() -> some View {
    VStack {
      HStack {
        Button {

        } label: {
          Image(systemName: "chevron.left")
            .font(.title2.bold())
            .foregroundColor(.black)
        }

        Spacer()

        Button {

        } label: {
          Image(systemName: "cart")
            .resizable()
            .renderingMode(.template)
            .aspectRatio(contentMode: .fit)
            .frame(width: 30, height: 30)
            .foregroundColor(.black)
        }
      }

      // Animated slider
      GeometryReader {
        let size = $0.size

        HStack(spacing: 0) {
          ForEach(coffees) { coffee in
            VStack(spacing: 15) {
              Text(coffee.title)
                .font(.title.bold())
                .multilineTextAlignment(.center)

              Text(coffee.price)
                .font(.title)
            }
            .frame(width: size.width)
          }
        }
        .offset(x: currentIndex * -size.width)
        .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.8, blendDuration: 0.8), value: currentIndex)
      }
      .padding(.top, -5)
    }
    .padding(15)
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}

struct CoffeView: View {
  var coffee: Coffee
  var size: CGSize
  var body: some View {
    // If you want to decrease the size of the image, then change it's card size
    let cardSize = size.width * 1
    // Since i want to show three max cards on the display
    // Since we used scaling to decrease the view size and add extra one
    let maxCardsDisplaySize = size.width * 4

    GeometryReader{proxy in
      let _size = proxy.size
      // Scaling Animation
      // Current card offset
      let offset = proxy.frame(in: .named("SCROLL")).minY - (size.height - cardSize)
      let scale = offset <= 0 ? (offset / maxCardsDisplaySize) : 0
      let reducedScale = 1 + scale
      let currentCardScale = offset / cardSize

      Image(coffee.imageName)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: _size.width, height: _size.height)
      // To avoid warning
      // Updating anchor based on the current card scale
        .scaleEffect(reducedScale < 0 ? 0.001 : reducedScale, anchor: .init(x: 0.5, y: 1 - (currentCardScale / 2.4)))
      // When it's coming from bottom animating the scale from large to actual
        .scaleEffect(offset > 0 ? 1 + currentCardScale : 1, anchor: .top)
      // To remove the excess next view using offset to move the view in real time
        .offset(y: offset > 0 ? currentCardScale * 200 : 0)
      // Making it more compact
        .offset(y: currentCardScale * -140)
    }
    .frame(height: cardSize)
  }
}
