//
//  ContentView.swift
//  Lab-Based Practical
//
//  Created by Denidu Gamage on 2024-11-23.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("selectedColor") private var selectedColor : String = "#000000"
    var body: some View {
        TabView{
            HomeView().tabItem{
                Label("Guess", systemImage: "checkmark.circle.badge.questionmark.fill")
                    
            }
            SettingsView().tabItem {
                Label("Settings", systemImage: "gear.circle.fill")
            }
        }.accentColor(Color(hex: selectedColor))
    }
}

#Preview {
    ContentView()
}
