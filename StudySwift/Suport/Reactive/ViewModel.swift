//
//  ViewModel.swift
//  StudySwift
//
//  Created by Rodrigo Santos on 28/09/21.
//

import Combine

public protocol ViewModel {
    associatedtype Input
    associatedtype Output
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output
}
