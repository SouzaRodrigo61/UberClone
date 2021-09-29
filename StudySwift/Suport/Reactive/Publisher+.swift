//
//  Publisher+.swift
//  StudySwift
//
//  Created by Rodrigo Santos on 28/09/21.
//

import Combine

extension Publisher {
    public func sink() -> AnyCancellable {
        return self.sink(receiveCompletion: { _ in }, receiveValue: { _ in })
    }
}
