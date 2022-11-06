//
//  ProfileShow.swift
//  GeoMatcher
//
//  Created by Matthias on 2022/11/6.
//

import SwiftUI

/// The `View` that displays a profile.
struct ProfileShow: View {
    @EnvironmentObject var game: GeoMatcherViewModel
    /// The `Profile` that is being shown.
    var profile: Profile
    
    var body: some View {
        ScrollView {
            HStack(){
                VStack(alignment: .leading, spacing: 20) {
                    Text("\(profile.username)")
                        .bold()
                        .font(.title)
                    Text("High Score: \(profile.highscore, specifier: "%.2f")")
                }
                .padding()
                Spacer()
            }
        }
    }
}

struct ProfileShow_Previews: PreviewProvider {
    static var previews: some View {
        ProfileShow(profile: Profile.default)
            .environmentObject(GeoMatcherViewModel())
    }
}
