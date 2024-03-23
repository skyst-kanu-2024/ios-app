//
//  ProfileHeader.swift
//  kanu
//
//  Created by Soongyu Kwon on 3/23/24.
//

import SwiftUI

struct ProfileHeader: View {
    @State var profileImage: String
    @State var username: String
    
    var body: some View {
        HStack(alignment: .center) {
            AsyncImage(url: URL(string: self.profileImage)!) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                Image(systemName: "person.circle")
                    .resizable()
                    .scaledToFit()
            }
            .frame(width: 36, height: 36)
            .clipShape(Circle())
            .padding(.trailing, 8)

            Text(self.username)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    ProfileHeader(profileImage: "https://avatars.githubusercontent.com/u/41620322?v=4", username: "대충엄청난닉네임")
}
