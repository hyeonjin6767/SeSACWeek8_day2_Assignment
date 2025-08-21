//
//  NumberViewModel.swift
//  SeSACWeek8_day2_Assignment
//
//  Created by 박현진 on 8/21/25.
//

import Foundation
import RxSwift
import RxCocoa

class NumberViewModel {
    
    struct Input {
        
        let getNumber1: ControlProperty<String>
        let getNumber2: ControlProperty<String>
        let getNumber3: ControlProperty<String>
    }
    
    struct Output {
        let tossTotal: BehaviorSubject<String>
    }
    
    private let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        
        let total = BehaviorSubject(value: "")
        
        Observable
            .combineLatest (
                input.getNumber1,
                input.getNumber2,
                input.getNumber3,
            ).bind(with: self) {owner, value in
                let change = (Int(value.0) ?? 0) + (Int(value.1) ?? 0) + (Int(value.2) ?? 0)
                total.onNext(String(change))
            }
            .disposed(by: disposeBag)
        
        return Output(tossTotal: total)

    }
}
