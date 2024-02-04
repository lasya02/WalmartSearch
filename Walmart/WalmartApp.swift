//
//  WalmartApp.swift
//  Walmart
//
//  Created by Lasya Kambhampati on 2/3/24.
//

import SwiftUI

@main
struct WalmartApp: App {
    @StateObject var cm = CartViewModel()
    @StateObject var vm = SearchViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView(vm: vm, cm: cm)
        }
    }
}
