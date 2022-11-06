//
//  ProfileEditor.swift
//  GeoMatcher
//
//  Created by Matthias on 2022/11/6.
//

import SwiftUI

/// The `View` that handles editting a profile.
struct ProfileEditor: View {
    /// The `Profile` being editted.
    @Binding var profile: Profile
    
    var body: some View {
        List {
            HStack {
                Text("Username").bold()
                Divider()
                TextField("Username", text: $profile.username)
            }
        }
    }
}

struct ProfileEditor_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditor(profile: .constant(Profile.default))
    }
}
