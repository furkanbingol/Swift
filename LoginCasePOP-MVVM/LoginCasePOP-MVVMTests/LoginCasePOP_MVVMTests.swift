//
//  LoginCasePOP_MVVMTests.swift
//  LoginCasePOP-MVVMTests
//
//  Created by Furkan Bingöl on 28.07.2023.
//

import XCTest
@testable import LoginCasePOP_MVVM

// UNIT TEST
final class LoginCasePOP_MVVMTests: XCTestCase {
    
    private var viewModel: RootViewModel!
    private var loginStorageService: MockLoginStorageServiceImpl!
    private var output: MockRootViewModelOutput!
    

    override func setUpWithError() throws {
        loginStorageService = MockLoginStorageServiceImpl()
        viewModel = RootViewModel(loginStorageService: loginStorageService)
        output = MockRootViewModelOutput()
        
        viewModel.output = output
    }

    override func tearDownWithError() throws {
        viewModel = nil
        loginStorageService = nil
        output = nil
    }

    
    func testShowLogin_whenLoginStorageReturnsEmptyUserAccessToken() throws {
        loginStorageService.storage = [:]
        viewModel.checkLogin()
        
        XCTAssertEqual(output.checkArray.first, .login)
    }
    
    func testShowMainApp_whenLoginStorageReturnsUserAccessToken() throws {
        loginStorageService.storage["ACCESS_TOKEN"] = "asdfghjkl"
        viewModel.checkLogin()
        
        XCTAssertEqual(output.checkArray.first, .mainApp)
    }
    
    func testShowMainApp_whenLoginStorageReturnsEmptyString() throws {
        loginStorageService.storage["ACCESS_TOKEN"] = ""
        viewModel.checkLogin()
        
        XCTAssertEqual(output.checkArray.first, .login)
    }

}

// Mock: Taklit
class MockLoginStorageServiceImpl: LoginStorageService {
    
    var storage = [String:String]()
    
    var userAccessTokenKey: String {
        return "ACCESS_TOKEN"
    }
    
    func setUserAccessToken(token: String) {
        storage[userAccessTokenKey] = token
    }
    
    func getUserAccessToken() -> String? {
        return storage[userAccessTokenKey]
    }
    
}

class MockRootViewModelOutput: RootViewModelOutput {
    
    enum Check {
        case login
        case mainApp
    }
    
    var checkArray = [Check]()
    
    func showLogin() {
        checkArray.append(.login)
    }
    
    func showMainApp() {
        checkArray.append(.mainApp)
    }
    
}
