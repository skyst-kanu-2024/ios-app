//
//  WebViewModel.swift
//  kanu
//
//  Created by Soongyu Kwon on 3/23/24.
//

import Foundation
import Combine

class WebViewModel: ObservableObject {
    var foo = PassthroughSubject<Bool, Never>()
    var bar = PassthroughSubject<Bool, Never>()
}
