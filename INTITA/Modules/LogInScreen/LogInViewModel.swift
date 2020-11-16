//
//  LogInViewModel.swift
//  INTITA
//
//  Created by Stepan Niemykin on 05.11.2020.
//

import Foundation

typealias LogInViewModelCallback = (Error?) -> Void

protocol LogInViewModelDelegate: AnyObject {
    func loginSuccess()
}

class LogInViewModel {
    weak var delegate: LogInViewModelDelegate?
    var updateCallback: LogInViewModelCallback?
    
    func subscribe(updateCallback: LogInViewModelCallback?) {
        self.updateCallback = updateCallback
    }
    
    func login(email: String, password: String) {
        Authorization.login(email: email, password: password, completion: { [weak self] error in
            // имхо: в этом варианте не нравится что старт в одном файле, стоп в разных файлах и таких кейсов как error или success может быть много, которые нужно помнить где и когда остановить спинер
            // второе: что делать в случае, когда крутится спинер на вью, а навигейшн бар доступен пользователю для нажатия Назад? итс ок?, а то первая реализация вызывала от рута на весь экран презентэйшн
            if let error = error {
                self?.updateCallback?(error)
            } else {
                self?.delegate?.loginSuccess()
            }
        })
    }
    
}
