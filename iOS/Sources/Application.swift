//
//  Application.swift
//  hello-application
//
//  Created by Vlad Gorlov on 09.08.19.
//  Copyright © 2019 WaveLabs. All rights reserved.
//

import Foundation
import UIKit

public class Application: UIApplication {

   private let appDelegate = AppDelegate()

   public override init() {
      super.init()
      delegate = appDelegate
   }
}
