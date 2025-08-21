//
//  SimpleValidationViewController.swift
//  SeSACWeek8_day2_Assignment
//
//  Created by 박현진 on 8/20/25.
//

import UIKit
import RxSwift
import RxCocoa

private let minimalUsernameLength = 5
private let minimalPasswordLength = 5

class SimpleValidationViewController: UIViewController {

    let usernameOutlet = {
        let textField = UITextField()
        return textField
    }()
    let usernameValidOutlet = {
        let label = UILabel()
        return label
    }()
    
    let passwordOutlet = {
        let textField = UITextField()
        return textField
    }()
    let passwordValidOutlet = {
        let label = UILabel()
        return label
    }()
    
    let doSomethingOutlet = {
        let button = UIButton()
        button.setTitle("Do Something", for: .normal)
        return button
    }()
    
    let disposeBag = DisposeBag()
    let white = Observable.just(UIColor.white)
    let gray = Observable.just(UIColor.systemGray5)
    let green = Observable.just(UIColor.systemGreen)

    let viewModel = ValidationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
        white
            .bind(to: view.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        gray
            .bind(to: usernameOutlet.rx.backgroundColor, passwordOutlet.rx.backgroundColor, doSomethingOutlet.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        green
            .bind(to: doSomethingOutlet.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        usernameValidOutlet.text = "Username has to be at least \(minimalUsernameLength) characters"
        passwordValidOutlet.text = "Password has to be at least \(minimalPasswordLength) characters"

//        let usernameValid =
//        usernameOutlet.rx.text.orEmpty
//            .map { $0.count >= minimalUsernameLength }
//            .share(replay: 1)
//
//        let passwordValid =
//        passwordOutlet.rx.text.orEmpty
//            .map { $0.count >= minimalPasswordLength }
//            .share(replay: 1)
//
//        let everythingValid =
//        Observable
//            .combineLatest(usernameValid, passwordValid) { $0 && $1 }
//            .share(replay: 1)

//        usernameValid
//            .bind(to: passwordOutlet.rx.isEnabled)
//            .disposed(by: disposeBag)

//        usernameValid
//            .bind(to: usernameValidOutlet.rx.isHidden)
//            .disposed(by: disposeBag)

//        passwordValid
//            .bind(to: passwordValidOutlet.rx.isHidden)
//            .disposed(by: disposeBag)

//        everythingValid
//            .bind(to: doSomethingOutlet.rx.isEnabled)
//            .disposed(by: disposeBag)

        doSomethingOutlet.rx.tap
            .subscribe(onNext: { [weak self] _ in self?.showAlert() })
            .disposed(by: disposeBag)
        
        // 타입 확인용
//        let a = usernameOutlet.rx.text.orEmpty
//        let b = passwordOutlet.rx.text.orEmpty
//        let c = doSomethingOutlet.rx.tap
        
        let input = ValidationViewModel.Input(getUsername: usernameOutlet.rx.text.orEmpty, getPassword: passwordOutlet.rx.text.orEmpty)
        let output = viewModel.transform(input: input)
        
        output.usernameValidation
            .bind(to: passwordOutlet.rx.isEnabled, usernameValidOutlet.rx.isHidden)
            .disposed(by: disposeBag)
        output.passwordValidation
            .bind(to: passwordValidOutlet.rx.isHidden)
            .disposed(by: disposeBag)
        output.everythingValidation
            .bind(to: doSomethingOutlet.rx.isHidden)
            .disposed(by: disposeBag)
        
    }
    
    func showAlert() {
        
        let alert = UIAlertController(title: "RxExample", message: "This is alertful", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func configure() {
        view.addSubview(usernameOutlet)
        view.addSubview(usernameValidOutlet)
        view.addSubview(passwordOutlet)
        view.addSubview(passwordValidOutlet)
        view.addSubview(doSomethingOutlet)
        view.endEditing(true)

        usernameOutlet.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        usernameValidOutlet.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.top.equalTo(usernameOutlet.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        passwordOutlet.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.top.equalTo(usernameValidOutlet.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        passwordValidOutlet.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.top.equalTo(passwordOutlet.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        doSomethingOutlet.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.top.equalTo(passwordValidOutlet.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
    }
}
