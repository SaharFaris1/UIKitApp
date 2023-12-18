
import SwiftUI

struct CustomButton: View {
    @State var isAccept: Bool?
    var text: String
    var body: some View {
        Text(text)
            .foregroundColor(.white)
            .background(
             RoundedRectangle(cornerRadius: 8)
                .frame(maxWidth: .infinity)
                .frame( width: 8*15 ,height: 8*5)
                .foregroundColor(isAccept ?? true ? .orange2 : .gray)
            )
    }
}

#Preview {
    CustomButton(text: "")
}
