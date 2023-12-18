import SwiftUI

struct NotificationView: View {
    @StateObject var viewModel = NotificationViewModel()
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationStack {
            ZStack{
                ScrollView {
                    HeaderView()
                    VStack(spacing: 20){
                        Text("Notification Setting")
                            .font(.title)
                            .bold()
                        
                        ForEach(viewModel.toggleStates.indices, id: \.self) { index in
                            ZStack {
                                
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.white)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 70)
                                VStack{
                                    HStack {
                                        Toggle(viewModel.toggleStates[index].title, isOn: $viewModel.toggleStates[index].isOn)
                                            .toggleStyle(SwitchToggleStyle(tint: Color.orange))
                                            .foregroundColor(.black)
                                        
                                    }.padding()
                                    Divider()
                                }
                            }
                        }.foregroundColor(.black)
                        
                    }.padding()
                }.ignoresSafeArea()
                
            }}
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading:
                                    Button(action: {
                
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(.white)
            })
            )
//
    }
}

#Preview {
    NotificationView()
}

