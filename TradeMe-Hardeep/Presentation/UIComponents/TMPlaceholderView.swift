//
//  TMPlaceholderView.swift
//  TradeMe-Hardeep
//
//  Created by Hardeep Singh on 03/10/25.
//

import SwiftUI

struct TMPlaceholderView: View {
    
    let title: String
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 8.0) {
            Spacer()
            Text(title)
                .foregroundColor(Color.tmTextDark)
                .font(.largeTitle)
                .bold()
            Image(ImageName.primaryBrandLogo)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 30)
                    .offset(CGSize(width: 0, height: 0))
            Spacer()
        }.padding()
        
    }
    
}
#Preview {
    TMPlaceholderView(title: "Placeholder Title")
}
