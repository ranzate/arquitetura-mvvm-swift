//
//  arquitetura_mvvmUITests.swift
//  arquitetura-mvvmUITests
//
//  Created by Solutis on 16/01/18.
//  Copyright © 2018 Solutis. All rights reserved.
//

import XCTest
import KIF

class arquitetura_mvvmUITests: KIFTestCase {

    // Exemplo de como criar um teste para uma tela de Login.
    func testLogin() {
        tester().waitForView(withAccessibilityLabel: "loginView")
        tester().enterText("leandro.silva@solutis.com.br", intoViewWithAccessibilityLabel: "usuarioField")
        tester().enterText("1234", intoViewWithAccessibilityLabel: "senhaField")
        tester().tapView(withAccessibilityLabel: "loginBotao", traits: UIAccessibilityTraitButton)
    }
    
}
