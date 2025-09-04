//
//  HeadLineCellUI.swift
//  NewsFlash
//
//  Created by Mena Maher on 9/4/25.
//

import SwiftUI

struct HeadLineCellUI: View {
    var body: some View {
        
        VStack {
            Text("Headline")
                .font(.headline)
            Text("Subheadline")
                .font(.caption)
        }
    }
}

#Preview {
    HeadLineCellUI()
}
