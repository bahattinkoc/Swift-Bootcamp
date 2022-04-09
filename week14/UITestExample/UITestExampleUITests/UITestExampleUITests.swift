//
//  UITestExampleUITests.swift
//  UITestExampleUITests
//
//  Created by Bahattin Koç on 9.04.2022.
//

import XCTest

final class UITestExampleUITests: XCTestCase {
    private var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("*** UITest ***")
    }
    
    func test_navigate_to_welcome_view_controller() {
        app.launch()
        
        // ilk ekrandaki öğeler göründü mü?
        XCTAssertTrue(app.isUserNameTextFieldDisplayed)
        XCTAssertTrue(app.isPasswordTextFieldDisplayed)
        XCTAssertTrue(app.isDoneButtonDisplayed)
        
        // ilk ekrandaki öğeler tıklanıp, bir şeyler yazılabiliyor mu?
        app.usernameTextFiled.tap()
        app.usernameTextFiled.typeText("Test")
        app.keyboards.buttons["Return"].tap()
        
        app.passwordTextField.tap()
        app.keys["t"].tap()
        app.keys["e"].tap()
        app.keys["s"].tap()
        app.keys["t"].tap()
        app.keyboards.buttons["Return"].tap()
        
        XCTAssertEqual(app.usernameTextFiled.value as? String, "Test")
        app.doneButton.tap()
        
        // ikinci ekrana geçilip, label okunabiliyor mu?
        XCTAssertTrue(app.isWelcomeLabel)
    }
}

extension XCUIApplication {
    var usernameTextFiled: XCUIElement {
        textFields["userNameTextField"]
    }
    
    var passwordTextField: XCUIElement {
        secureTextFields["passwordTextField"]
    }
    
    var doneButton: XCUIElement {
        buttons["doneButton"]
    }
    
    var welcomeLabel: XCUIElement {
        staticTexts.matching(identifier: "welcomeLabel").element
    }
    
    var isUserNameTextFieldDisplayed: Bool {
        usernameTextFiled.exists
    }
    
    var isPasswordTextFieldDisplayed: Bool {
        passwordTextField.exists
    }
    
    var isDoneButtonDisplayed: Bool {
        doneButton.exists
    }
    
    var isWelcomeLabel: Bool {
        welcomeLabel.exists
    }
}
