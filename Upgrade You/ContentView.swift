//
//  ContentView.swift
//  Upgrade You
//
//  Created by Artem Panasenko on 17.10.2020.
//

import SwiftUI

struct ContentView: View {
    
    @State var show = false
    @State var viewState = CGSize.zero
    @State var showCard = false
    @State var bottomState = CGSize.zero
    @State var showFull = false
    
    var body: some View {
        ZStack {
            TitleView()
                .blur(radius: show ? 20 : 0) //  размытие
                .opacity(showCard ? 0.4 : 1)
                .offset(y: showCard ? -200 : 0)
                .animation(
                    Animation
                        .default
                        .delay(0.1)
//                        .speed(2)
//                        .repeatCount(5, autoreverses: false)
                )
            
            BackCardView()
                .frame(width: showCard ? 300 : 340, height: 220)
                .background(show ? Color(#colorLiteral(red: 1, green: 0.2908928096, blue: 0.6561838984, alpha: 1)) : Color(#colorLiteral(red: 0.3515042067, green: 0.08424700052, blue: 0.7129504681, alpha: 1)))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: show ? -400 : -40)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y:  showCard ? -180 : 0)
                .scaleEffect( showCard ? 1 : 0.9)
                .rotationEffect(.degrees(show ? 0 : 10))
                .rotationEffect(.degrees(showCard ? -10 : 0))
                .rotation3DEffect(
                    .degrees( showCard ? 0 : 10),
                    axis: (x: 10.0, y: 1.0, z: 0.0))
                .blendMode(.hardLight) // прозрачность
                .animation(.easeInOut(duration: 0.5))

            BackCardView()
                .frame(width: 340, height: 220)
                .background(show ? Color(#colorLiteral(red: 0.3515042067, green: 0.08424700052, blue: 0.7129504681, alpha: 1)) : Color(#colorLiteral(red: 1, green: 0.2908928096, blue: 0.6561838984, alpha: 1)))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: show ? -200 : -20)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y:  showCard ? -140 : 0)
                .scaleEffect( showCard ? 1 : 0.95)
                .rotationEffect(.degrees(show ? 0 : 5))
                .rotationEffect(.degrees(showCard ? -5 : 0))
                .rotation3DEffect(
                    .degrees(  showCard ? 0 : 5),
                    axis: (x: 10.0, y: 1.0, z: 0.0))
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.3))

            CardView()
                .frame(width:  showCard ? 375 : 340, height: 220)
                .background(Color.black)
//                .cornerRadius(20)
                .clipShape(RoundedRectangle(cornerRadius: showCard ? 30 : 20, style: .continuous))
                .shadow(radius: 20)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y:  showCard ? -100 : 0)
                .blendMode(.hardLight)
                .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0))
                .onTapGesture {
                    self.showCard.toggle()
                }
                .gesture(
                    DragGesture().onChanged { value in
                        self.viewState = value.translation
                        self.show = true
                    }
                    .onEnded { _ in
                        self.viewState = .zero
                        self.show = false
                    }
                )
            
            BottomCardView()
                .offset(x: 0, y: showCard ? 360 : 1000)
                .offset(y: bottomState.height)
                .blur(radius: show ? 20 : 0) //  размытие
                .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            self.bottomState = value.translation
                            if self.showFull {
                                self.bottomState.height += -300
                            }
                            if self.bottomState.height < -300 {
                                self.bottomState.height = -300
                            }
                        }
                        .onEnded { _ in
                            if self.bottomState.height > 100 {
                                self.showCard = false
                            }
                            
                            if (self.bottomState.height < -100 && !self.showFull) || (self.bottomState.height < 250 && self.showFull) {
                                self.bottomState.height = -300
                                self.showFull = true
                            } else {
                                self.bottomState = .zero
                                self.showFull = false
                            }
                        }
                )

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CardView: View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) { // веравнивание по левому краю
                    Text("Design SwiftIU")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                    Text("Sertificate")
                        .foregroundColor(Color("Primary"))
                }
                
                Spacer() // Раздвигает елементы
                
                Image("Logo SwiftUI")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50)
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            
            Image("2")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 110, alignment: .top)
        }
    }
}

struct BackCardView: View {
    var body: some View {
        VStack {
            Spacer()
        }
    }
}

struct TitleView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Sertificates")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding()
            Spacer()
        }
    }
}

struct BottomCardView: View {
    var body: some View {
        VStack(spacing: 20) {
            Rectangle()
                .frame(width: 40, height: 5)
                .cornerRadius(3)
                .opacity(0.1)
            
            Text("Изучаем особенности разработки адаптивного дизайна в SwiftUI")
                .multilineTextAlignment(.center) // выранивание текста
                .font(.subheadline)
                .lineSpacing(4) // мужстрочный интервал
            Spacer()
        }
        .padding(.top, 8)
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity)
        .background(Color("Background 3"))
        .cornerRadius(30)
        .shadow(radius: 20)
    }
}
