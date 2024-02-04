//
//  DetailView.swift
//  Walmart
//
//  Created by Lasya Kambhampati on 2/4/24.
//

import SwiftUI

struct DetailView: View {
    let name: Product
    let images = ["circle", "square", "cart"]
    @State private var selection = 1
    
    var body: some View {
        ZStack {
            Color.blue.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 20){
                Spacer()
                Text("\(name.title)!")
                    .font(.title)
                    .padding(.leading, 10)
                
                TabView(selection: $selection){
                    ForEach(name.images, id: \.self) { image in
                        AsyncImage(url: URL(string: image))
                        { image in image.resizable() } placeholder: { Color.red }
                            .scaledToFill()
                    }
                    }   
                    .tabViewStyle(.page(indexDisplayMode: .always))
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                    .frame(height: 250)
    
                Text("\(name.description)")
                    .font(.title2)
                Spacer()
            }
        }
            
            
        }
    }
    
    
    
    #Preview {
        DetailView(name: example)
    }
