//
//  SettingsView.swift
//  Lab-Based Practical
//
//  Created by Denidu Gamage on 2024-11-23.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("selectedFontSize") private var selectedFontSize : Double = 0.0
    @AppStorage("selectedColor") private var selectedColor : String = "#000000"
    
    var body: some View {
        NavigationView {
            VStack{
                Section(header:Text("Font Size")){
                    HStack {
                        Slider(value: $selectedFontSize, in: 12...30)
                            .padding()
                        
                        Text("Font Size \(String(format: "%.1f", selectedFontSize)) px")
                            .padding()
                            .font(.system(size: selectedFontSize))
                    }.overlay{
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray, lineWidth: 2)
                    }.padding()
                }
                
                Section(header: Text("System Color")){
                    HStack{
                        Rectangle()
                            .fill(Color(hex: selectedColor))
                            .frame(width: 30, height: 30)
                            .cornerRadius(5)
                            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))
                            .padding()
                        ColorPicker("System Color", selection: Binding(
                            get: {
                                Color(hex: selectedColor)
                            },
                            set: { newColor in
                                selectedColor = newColor.toHex()
                            }
                        )).padding()
                        
                    }
                }.navigationTitle("Settings")
            }
        }
    }
}
extension Color {
    // Convert a hex string (e.g., "#FF0000") to a Color
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r = Double((int >> 16) & 0xFF) / 255.0
        let g = Double((int >> 8) & 0xFF) / 255.0
        let b = Double(int & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }

    // Convert a Color to a hex string (e.g., "#FF0000")
    func toHex() -> String {
        let components = UIColor(self).cgColor.components ?? [0, 0, 0]
        let r = Int(components[0] * 255)
        let g = Int(components[1] * 255)
        let b = Int(components[2] * 255)
        return String(format: "#%02lX%02lX%02lX", r, g, b)
    }
}


#Preview {
    SettingsView()
}
