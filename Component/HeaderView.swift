
import SwiftUI

struct HeaderView: View {
    var body: some View {
        UnevenRoundedRectangle(topLeadingRadius: 0, bottomLeadingRadius: 50, bottomTrailingRadius: 50, topTrailingRadius: 0).ignoresSafeArea()
            .foregroundColor(.orange2)
            .frame(height: 150)
    }
}

#Preview {
    HeaderView()
}
