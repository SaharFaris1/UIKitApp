
import SwiftUI

struct PreviousOrderView: View {
 @StateObject var vmm = PreviousOrdersViewModel()
    @State var isDeliverd : Bool = true
    @Environment(\.presentationMode) var presentationMode
    func formatDateToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
    func refreshData() async {
        
        try? await Task.sleep(nanoseconds: 3_000_000_000)
    }
    var body: some View {
        NavigationStack{
            ZStack{
                ScrollView{
                    VStack{
                        Text("Orders Delivered")
                            .font(.title)
                            .bold()
                            .foregroundColor(.orange2)
                        ForEach(vmm.previousOrders) { order in
                            ZStack{
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(lineWidth: 1)
                                    .foregroundColor(.orange2)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 150)
                                HStack(spacing: 25){
                                    
                                    Text("\(order.restaurant)")
                                        .bold()
                                        .font(.title3)
                                    VStack(spacing: 10){
                                        Text("\(order.userName) ****")
                                        
                                        Text("\(order.meal)")
                                        
                                        Text("\(order.price)sr")
                                    }
                                    VStack(spacing: 10){
                                        Text("\(order.date)")
                                        Text("")
                                        Image(systemName: "checkmark.rectangle")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 40)
                                            .foregroundStyle(Color.green)
                                        
                                    }}
                                
                            }.padding()
                        }}
                }
            }
        }.onAppear {
            vmm.fetchOrders()
        } .foregroundColor(.black)
            .navigationBarItems(leading:
                                                Button(action: {
                            
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                        })
                        )

    }
}

#Preview {
    PreviousOrderView()
}
