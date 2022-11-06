//
//  ProfileView.swift
//  GeoMatcher
//
//  Created by Matthias on 2022/11/6.
//

import SwiftUI

/// The `View` that either shows or handles editting of a profile, depending on the mode.
struct ProfileView: View {
    @Environment(\.editMode) var editMode
    @EnvironmentObject var game: GeoMatcherViewModel
    @State private var draftProfile = Profile.default
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                EditButton()
                Spacer()
            }
            
            if editMode?.wrappedValue == .inactive {
                ProfileShow(profile: game.profile)
            } else {
                ProfileEditor(profile: $draftProfile)
                    .onAppear {
                        draftProfile = game.profile
                    }
                    .onDisappear {
                        game.profile = draftProfile
                    }
            }
        }
        .padding()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(GeoMatcherViewModel())
    }
}
