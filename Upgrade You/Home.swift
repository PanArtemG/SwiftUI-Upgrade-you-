//
//  Home.swift
//  Upgrade You
//
//  Created by Artem Panasenko on 24.10.2020.
//

import SwiftUI

struct Home: View {
    @State var showProfile = false
    @State var viewState = CGSize.zero
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
                .edgesIgnoringSafeArea(.all) // раздвинуть на весь экран
            HomeView(showProfile: $showProfile)
                .padding(.top, 44)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
                .offset(y: showProfile ? -450 : 0)
                .rotation3DEffect(Angle(degrees: showProfile ? Double(viewState.height  / 10) - 10 : 0),
                                  axis: (x: 10, y: 0, z: 0)
                )
                .scaleEffect( showProfile ? 0.9 : 1)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .edgesIgnoringSafeArea(.all)
            
            MenuView()
                .background(Color.black.opacity(0.001))
                .offset(y: showProfile ? 0 : screen.height)
                .offset(y: viewState.height)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                // скрываем карточку по тапу где угодно (зависимость от  .background(Color.black.opacity(0.001)))
                .onTapGesture {
                    self.showProfile.toggle()
                }
                // сдвигаем карточку по жесту
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            self.viewState = value.translation
                            // по драгу вниз убираем карточку
                            if self.viewState.height > 50 {
                                self.showProfile = false
                            }
                        }
                        .onEnded { _ in
                            self.viewState = .zero
                        }
                )
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct AvatarView: View {
    @Binding var showProfile: Bool
    
    var body: some View {
        Button(action: {
            self.showProfile.toggle()
        }) {
            Image("avatar")
                .renderingMode(.original)
                .resizable()
                .frame(width: 36, height: 36, alignment: .center)
                .clipShape(Circle())
        }
    }
}

let screen = UIScreen.main.bounds
