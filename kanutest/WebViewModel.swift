//
//  WebViewModel.swift
//  kanu
//
//  Created by Soongyu Kwon on 3/23/24.
//

import Foundation
import Combine

class WebViewModel: ObservableObject {    
    var profileSheet = PassthroughSubject<Bool, Never>()
    var profileSheetData = PassthroughSubject<String, Never>()
    
    var matchingStackView = PassthroughSubject<Bool, Never>()
    var matchingStackViewData = PassthroughSubject<String, Never>()
}
