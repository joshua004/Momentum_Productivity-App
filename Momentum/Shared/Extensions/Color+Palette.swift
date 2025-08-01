//
//  Color+Palette.swift
//  Momentum
//
//  Created by Josh Tienda on 31/07/25.
//

import SwiftUI

extension Color {
    // Primary app colors - using computed properties to avoid conflicts with auto-generated symbols
    static var momentumBoneBackground: Color {
        Color("BoneBackground")
    }
    
    static var momentumAccentBlue: Color {
        Color("AccentBlue")
    }
    
    static var momentumAccentOrange: Color {
        Color("AccentOrange")
    }
    
    // Fallback colors if assets are not found
    static let boneBackgroundFallback = Color(red: 0.98, green: 0.97, blue: 0.95) // #FAF7F2
    static let accentBlueFallback = Color(red: 0.26, green: 0.52, blue: 0.96) // #4285F4
    static let accentOrangeFallback = Color(red: 1.0, green: 0.60, blue: 0.20) // #FF9933
    
    // Custom initializer for hex colors
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
