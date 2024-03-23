//
//  NearbyNotAvailable.swift
//  kanu
//
//  Created by Soongyu Kwon on 3/23/24.
//

import SwiftUI

struct NearbyNotAvailable: View {
    var body: some View {
        Text("Nearby Interaction is not available on this device.")
            .multilineTextAlignment(.center)
            .padding()
    }
}

#Preview {
    NearbyNotAvailable()
}
