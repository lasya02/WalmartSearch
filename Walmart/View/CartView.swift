//
//  CartView.swift
//  Walmart
//
//  Created by Lasya Kambhampati on 2/4/24.
//

import SwiftUI

struct CartView: View {
    @ObservedObject var cm: CartViewModel
    @State var inCart = false
    
    var body: some View {
         NavigationStack {
            VStack(alignment: .leading) {
                ForEach(cm.inCart) { product in
                    VStack(alignment: .leading) {
                        NavigationLink {
                            DetailView(name: product, cm: cm)
                        } label: {
                            HStack(spacing: 20){
                                AsyncImage(url: URL(string: product.images[0]))
                                { image in image.resizable() } placeholder: { Color.white } .frame(width: 100, height: 100) .clipShape(RoundedRectangle(cornerRadius: 0))
                                
                                VStack(alignment: .leading, spacing: 8){
                                    HStack(spacing: 2){
                                        Text("Now $\(product.price * (100 - product.discountPercentage) / 100.0, specifier: "%.2f")")
                                            .font(.title2)
                                            .foregroundStyle(.green)
                                            .bold()
                                        Text(" $\(product.price, specifier: "%.2f")")
                                            .strikethrough()
                                            .foregroundStyle(.gray)
                                            .font(.subheadline)
                                    }
                                    
                                    Text("\(product.title)")
                                        .font(.body)
                                    HStack{
                                        StarRating(rating: .constant(product.rating), maxRating: 5)
                                        Text("\(Int.random(in: 1..<10000))")
                                            .font(.subheadline)
                                        
                                    }
                                    HStack(spacing:0){
                                        Text("Save with W+")
                                            .font(.caption)
                                            .foregroundStyle(.blue)
                                            .bold()
                                        Image(systemName: "staroflife")
                                            .foregroundStyle(.yellow)
                                    }
                                    
                                    Group {
                                        Text("Free Shipping, arrives in ")
                                            .foregroundStyle(.gray)
                                            .font(.footnote) +
                                        Text("**2 days**")
                                            .foregroundStyle(.black)
                                            .font(.footnote)
                                    }
                                    
                                    Button {
                                        inCart.toggle()
                                        cm.removeFromCart(product: product)
                                    } label: {
                                        Text("Remove From Cart")
                                    }
                                    .foregroundStyle(.white)
                                    .frame(maxWidth: .infinity, alignment: .center).padding(10)
                                    .background(Color.blue).cornerRadius(20)
                                    
                                }
                                
                            }
                            
                            
                            
                        }
                        
                        
                    }
                    
                    
                    
                }
                
            }
            .navigationTitle("Cart")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.blue)
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    VStack{
                        HStack{
                            Text("Estimated Total: " )
                            Text("\(cm.totalPrice, specifier: "%.2f")")
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        Button {
                            
                        } label: {
                           Text("Continue to Checkout")
                        }
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, alignment: .center).padding(10)
                        .background(Color.blue).cornerRadius(20)
                    }
                    
                }
        }
        }
    }
}



#Preview {
    CartView(cm: CartViewModel())
}
