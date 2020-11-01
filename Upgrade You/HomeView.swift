//
//  HomeView.swift
//  Upgrade You
//
//  Created by Artem Panasenko on 24.10.2020.
//

import SwiftUI

struct HomeView: View {
    @Binding var showProfile: Bool
    
    var body: some View {
        VStack {
            HStack {
                AvatarView(showProfile: $showProfile)
                Spacer()
            }
            .padding(.horizontal)
            .padding(.leading, 14)
            .padding(.top, 30)
            
            ScrollView(.horizontal, showsIndicators: false) { // showsIndicators - убираем индикатор прокрутки
                HStack(spacing: -40) {
                    ForEach(sectionDate) { item in
                        GeometryReader { geometry in
                            SectionView(sextion: item)
                                .rotation3DEffect(Angle(degrees: Double(geometry.frame(in: .global).minX - 30) / -20),
                                    axis: (x: 0.0, y: 10.0, z: 0.0))
                        }
                        .frame(width: 275, height: 275)
                    }
                    .padding(30)
                    .padding(.bottom, 30)
                }
            }
            
            Spacer()
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showProfile: .constant(false))
    }
}

struct SectionView: View {
    var sextion: Section
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text(sextion.title)
                    .font(.system(size: 20, weight: .bold))
                    .frame(width: 160, alignment: .leading)
                    .foregroundColor(.white)
                Spacer()
                Image(sextion.logo)
            }
            Text(sextion.text .uppercased())
                .frame(maxWidth: .infinity, alignment: .leading)
            sextion.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 210)
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .frame(width: 275, height: 275)
        .background(sextion.color)
        .cornerRadius(30)
        .shadow(color: sextion.color.opacity(0.3), radius: 20, x: 0, y: 20)
    }
}

struct Section: Identifiable {
    var id = UUID()
    var title: String
    var text: String
    var logo = "Logo SwiftUI"
    var image: Image
    var color: Color
}

let sectionDate = [
    Section(title: "Design in SwiftUI", text: "50 lessons", image: Image("1"), color: Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1))),
    Section(title: "SwiftUI Basics", text: "30 lessons", image: Image("2"), color: Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1))),
    Section(title: "Solving problems in the Swift language", text: "35 lessons", image: Image("4"), color: Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)))]
