//
//  ContentView.swift
//  Walmart
//
//  Created by Lasya Kambhampati on 2/3/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var vm: SearchViewModel
    @ObservedObject var cm: CartViewModel
    @State  var name = ""
    
    @ViewBuilder
    private var idleView: some View {
        Text("")
    }
    
    @ViewBuilder
    private var loadingView: some View {
        Text("loading")
    }
    
    @ViewBuilder
    private func productsList(_ products: [Product]) -> some View {
        @State var inCart = false
        
        ForEach(products) { product in
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
                                if inCart{
                                    cm.removeFromCart(product: product)
                                }
                                else{
                                    cm.addToCart(product: product)
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
    }
    
    
    @ViewBuilder
    private func errorView(_ error: Error) -> some View {
        Text(error.localizedDescription)
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Color.blue
                    .frame(height: 150)
                    .ignoresSafeArea()
                    .overlay(alignment: .top){
                        VStack(spacing: 20){
                            HStack(spacing: 15){
                                
                                Image(systemName: "chevron.left")
                                    .foregroundStyle(.white)
                                
                                HStack{
                                    Image(systemName: "magnifyingglass")
                                        .foregroundStyle(.black)
                                    TextField("Search...", text: $vm.searchText)
                                        .foregroundStyle(.black)
                                    
                                    Image(systemName: "barcode.viewfinder")
                                        .foregroundStyle(.black)
                                }
                                .onChange(of: vm.searchText) { value in
                                    async {
                                        await vm.searchSpecificProducts()
                                    }
                                }
                                .background(){
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(.white)
                                        .padding(.all, -10)
                                    
                                }
                                VStack{
                                    NavigationLink(destination: {
                                        CartView(cm: cm)
                                    }, label: {
                                        VStack{
                                            Image(systemName: "cart")
                                                .foregroundStyle(.white)
                                            Text("\(cm.totalPrice, specifier: "%.2f")")
                                                .foregroundStyle(.white)
                                        }
                                        
                                    })
                                    
                                    
                                }
                            }
                            HStack{
                                Spacer()
                                Text("How do you want your items? | 27514")
                                    .foregroundStyle(.white)
                                Spacer()
                                Image(systemName: "chevron.down")
                                    .foregroundStyle(.white)
                                Spacer()
                            }
                        }
                        
                    }
                    .padding(.bottom, -50)
                
                
                
                VStack(alignment: .leading, spacing: 5){
                    
                    Menu("Filter"){
                        Menu("Price"){
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                Text("0-25")
                            })
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                Text("25-50")
                            })
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                Text("50-150")
                            })
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                Text("150-500")
                            })
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                Text("500+")
                            })
                        }
                        Menu("Rating"){
                            Button(action: {
                            }, label: {
                                Text("1+")
                            })
                            
                            Button(action: {
                            }, label: {
                                Text("2+")
                            })
                            Button(action: {
                            }, label: {
                                Text("3+")
                            })
                            Button(action: {
                            }, label: {
                                Text("4+")
                            })
                            
                        }
                    }
                    
                    
                    Text("Results for \"\(vm.searchText)\"")
                        .bold()
                        .font(.title)
                        .multilineTextAlignment(.leading)
                    HStack{
                        Text("Price when purchased online")
                            .font(.subheadline)
                        Image(systemName: "i.circle")
                    }
                    
                }
                .padding(.leading, 5)
                
                List {
                    Section {
                        switch vm.state {
                        case .idle:
                            idleView
                        case .error(let error):
                            errorView(error)
                        case .loading:
                            loadingView
                        case .success(let products):
                            productsList(products)
                        case .successSpecific(let products):
                            productsList(products)
                        }
                    }
                }
                .listStyle(.inset)
                .padding(.top,0)
                .task() {
                    await vm.searchSpecificProducts()
                }
            }
        }
        
    }
    
}

#Preview {
    ContentView(vm: SearchViewModel(), cm: CartViewModel())
}
