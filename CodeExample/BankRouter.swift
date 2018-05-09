//
//  BankRouter.swift
//  CodeExample
//
//  Created by Ethan Riback on 5/8/18.
//  Copyright © 2018 Ethan Riback. All rights reserved.
//

class BankRouter {
    func start(with view: BankViewController) {
        
        let interactor = BankInteractor()
        
        let presenter = BankPresenter()
        presenter.interactorInput = interactor // interactor handles presenter output
        interactor.output = presenter // presenter handles interactor output
        
        view.output = presenter // presenter handles view output
        presenter.viewInput = view // presenter sends input into the view
    }
}
