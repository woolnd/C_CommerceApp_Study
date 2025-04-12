//
//  CPColor.swift
//  Cproject
//
//  Created by wodnd on 3/30/25.
//

import UIKit
import SwiftUI

enum CPColor { }

extension  CPColor {
    enum UIKit {
        static var bk: UIColor = UIColor(named: "bk")!
        static var wh: UIColor = UIColor(named: "wh")!
        static var coral: UIColor = UIColor(named: "coral")!
        static var yellow: UIColor = UIColor(named: "yellow")!
        static var keyColorRed: UIColor = UIColor(named: "key-color-red")!
        static var keyColorRed2: UIColor = UIColor(named: "key-color-red-2")!
        static var keyColorBlue: UIColor = UIColor(named: "key-color-blue")!
        static var keyColorBlueTrans: UIColor = UIColor(named: "key-color-blue-trans")!
        static var darkGreen: UIColor = UIColor(named: "dark-green")!
        static var gray1: UIColor = UIColor(named: "gray-1")!
        static var gray2: UIColor = UIColor(named: "gray-2")!
        static var gray3: UIColor = UIColor(named: "gray-3")!
        static var gray4: UIColor = UIColor(named: "gray-4")!
        static var gray5: UIColor = UIColor(named: "gray-5")!
        static var gray6: UIColor = UIColor(named: "gray-6")!
        static var gray7: UIColor = UIColor(named: "gray-7")!
    }
}

extension CPColor {
    enum SwiftUI{
        static var bk: Color = Color("bk", bundle: nil)
        static var wh: Color = Color("wh", bundle: nil)
        static var coral: Color = Color("coral", bundle: nil)
        static var yellow: Color = Color("yellow", bundle: nil)
        static var keyColorRed: Color = Color("key-color-red", bundle: nil)
        static var keyColorRed2: Color = Color("key-color-red-2", bundle: nil)
        static var keyColorBlue: Color = Color("key-color-blue", bundle: nil)
        static var keyColorBlueTrans: Color = Color("key-color-blue-trans", bundle: nil)
        static var darkGreen: Color = Color("dark-green", bundle: nil)
        static var gray1: Color = Color("gray-1", bundle: nil)
        static var gray2: Color = Color("gray-2", bundle: nil)
        static var gray3: Color = Color("gray-3", bundle: nil)
        static var gray4: Color = Color("gray-4", bundle: nil)
        static var gray5: Color = Color("gray-5", bundle: nil)
        static var gray6: Color = Color("gray-6", bundle: nil)
        static var gray7: Color = Color("gray-7", bundle: nil)
    }
}
