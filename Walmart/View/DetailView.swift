//
//  DetailView.swift
//  Walmart
//
//  Created by Lasya Kambhampati on 2/4/24.
//

import SwiftUI

struct DetailView: View {
    let name: Product
    @State private var selection = 1
    
    @ObservedObject var cm: CartViewModel
    @State private var inCart = false
    
    var body: some View {
        NavigationStack {
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20){
                    Spacer()
                    Text("\(name.brand)")
                        .font(.caption)
                        .underline()
                        .padding(.leading,10)
                    HStack{
                        Text("\(name.title)!")
                            .font(.title)
                            .padding(.leading, 10)
                        Spacer()
                        ShareLink("",
                                  item: name.images[0],
                                  subject: Text(name.title),
                                  message: Text("What do you think about this?"),
                                  preview: SharePreview(name.title, image: name.images[0]))
                    }
                    
                    
                    TabView(selection: $selection){
                        ForEach(name.images, id: \.self) { image in
                            AsyncImage(url: URL(string: image))
                            { image in image.resizable() } placeholder: { Color.white }
                                .scaledToFill()
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .always))
                    .frame(height: 250)
                    
                    HStack(spacing: 2){
                        Text("**Now $\(name.price * (100 - name.discountPercentage) / 100.0, specifier: "%.2f")**")
                            .font(.title3)
                            .foregroundStyle(.green)
                            .bold()
                        Text(" $\(name.price, specifier: "%.2f")")
                            .strikethrough()
                            .foregroundStyle(.gray)
                            .font(.subheadline)
                        
                    }
                    .padding(.leading, 10)
                    
                    HStack(){
                        StarRating(rating: .constant(name.rating), maxRating: 5)
                        Text("(\(name.rating, specifier: "%.2f"))  \(Int.random(in: 1..<10000))")
                            .font(.subheadline)
                    }
                    .padding(.leading, 10)
                    
                    Text("\(name.description)")
                        .font(.title2)
                        .padding(.leading, 10)
                }
                
            }
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button("Buy Now") {
                        print("Pressed")
                    }
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .center).padding(10)
                    .background(Color.black).cornerRadius(20)
                    
                    
                    Button {
                        inCart.toggle()
                        if inCart{
                            cm.addToCart(product: name)
//                            cm.removeFromCart(product: name)
                        }
                        else{
                            cm.addToCart(product: name)
                        }
                    } label: {
                        if inCart{
                            Text("Remove From Cart")
                        }
                        else{
                            Text("Add to Cart")
                        }
                    }
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .center).padding(10)
                    .background(Color.blue).cornerRadius(20)
                }
            }
        }
    }
    
    
}




#Preview {
    DetailView(name: example, cm: CartViewModel())
}
