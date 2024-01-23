//
//  SettingItem.swift
//  LineClone
//
//  Created by 양시관 on 1/24/24.
//

import Foundation



import Foundation

protocol SettingItemable {
    var label: String { get }
}

struct SectionItem: Identifiable {
    let id = UUID()
    let label: String
    let settings: [SettingItem]
}

struct SettingItem: Identifiable {
    let id = UUID()
    let item: SettingItemable
}
