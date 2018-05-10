//
//  BankRouter.swift
//  CodeExample
//
//  Created by Ethan Riback on 5/8/18.
//  Copyright © 2018 Ethan Riback. All rights reserved.
//

class BankRouter {
    // Note: I like to use the Router to start new feature contexts.
    // Since this example starts with the VC in the Storyboard, not
    // sure how to route that functionality to here first...so I kinda
    // hacked a work around
    func start(with view: BankViewController) {
        
        let interactor = BankInteractor()
        
        let presenter = BankPresenter()
        presenter.interactorInput = interactor // interactor handles presenter output
        interactor.output = presenter // presenter handles interactor output
        
        view.output = presenter // presenter handles view output
        presenter.viewInput = view // presenter sends input into the view
    }
}
