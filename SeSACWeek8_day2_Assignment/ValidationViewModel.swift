//
//  ValidationViewModel.swift
//  SeSACWeek8_day2_Assignment
//
//  Created by 박현진 on 8/21/25.
//

import Foundation
import RxSwift
import RxCocoa

private let minimalUsernameLength = 5
private let minimalPasswordLength = 5

class ValidationViewModel {
    
    struct Input {
        
        let getUsername: ControlProperty<String>
        let getPassword: ControlProperty<String>
//        let buttonTap: ControlEvent<Void>
      
    }
    
    struct Output {
        
        let usernameValidation: BehaviorSubject<Bool>
        let passwordValidation: BehaviorSubject<Bool>
        let everythingValidation: BehaviorSubject<Bool>
//        let buttonDosomething: BehaviorSubject<Bool>
    }
    
    private let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        
        let nameValid = BehaviorSubject(value: false)
        let passwordValid = BehaviorSubject(value: false)
        let everyValid = BehaviorSubject(value: false)
        
        input.getUsername // usernameOutlet.rx.text.orEmpty
            .map { $0.count >= minimalUsernameLength }
            .bind(with: self) { owner, check in
                nameValid.onNext(check)
                print("아이디 check : ", check)
            }
            .disposed(by: disposeBag)

        input.getPassword // passwordOutlet.rx.text.orEmpty
            .map { $0.count >= minimalPasswordLength }
            .bind(with: self) { owner, check in
                passwordValid.onNext(check)
                print("비번 check : ", check)
            }
            .disposed(by: disposeBag)

      Observable
            .combineLatest(input.getUsername, input.getPassword)
            .map { $0.count >= minimalUsernameLength && $1.count >= minimalPasswordLength }
            .bind(with: self) { owner, check in
                everyValid.onNext(check)
                print("아이디&비번 check : ", check)
            }
            .disposed(by: disposeBag)
        
        return Output(usernameValidation: nameValid, passwordValidation: passwordValid, everythingValidation: everyValid)
 
    }
    
}
