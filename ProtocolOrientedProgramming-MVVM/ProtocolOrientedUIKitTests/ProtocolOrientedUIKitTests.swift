//
//  ProtocolOrientedUIKitTests.swift
//  ProtocolOrientedUIKitTests
//
//  Created by Furkan Bingöl on 20.07.2023.
//

import XCTest
@testable import ProtocolOrientedUIKit

// UNIT TESTS
final class ProtocolOrientedUIKitTests: XCTestCase {
    
    // XCTestCase'de initializer olmadığı için, force unwrap(!) ile propertyleri tanımladık.
    private var userService: MockUserService!
    private var userViewModel: UserViewModel!
    private var output: MockUserViewModelOutput!

    override func setUpWithError() throws {
        self.userService = MockUserService()
        self.userViewModel = UserViewModel(userService: userService)
        self.output = MockUserViewModelOutput()
        
        userViewModel.output = output    // delegate mantığı
    }

    override func tearDownWithError() throws {
        userViewModel = nil
        userService = nil
        output = nil
    }

    func testUpdateView_whenAPISuccess_showsEmailNameUsername() throws {
        let mockUser = User(id: 1, name: "Furkan", username: "furkanbingol", email: "furkan@gmail.com",
                            address: Address(street: "", suite: "", city: "", zipcode: "", geo: Geo(lat: "", lng: "")),
                            phone: "", website: "",
                            company: Company(name: "", catchPhrase: "", bs: ""))
        
        // Unit Testlerde, API Call etmiyoruz. Mock ederek test ediyoruz.
        userService.fetchUserMockResult = .success(mockUser)
        userViewModel.fetchUsers()
        
        XCTAssertEqual(output.updateViewArray.first?.name, "Furkan")
        XCTAssertEqual(output.updateViewArray.first?.username, "furkanbingol")
        XCTAssertEqual(output.updateViewArray.first?.email, "furkan@gmail.com")
    }
    
    func testUpdateView_whenAPIFailure_showsNoUser() throws {
        userService.fetchUserMockResult = .failure(NSError())
        userViewModel.fetchUsers()

        XCTAssertEqual(output.updateViewArray.first?.name, "No user")
    }

    
}


// Mock: Taklit
class MockUserService: UserService {
    var fetchUserMockResult: Result<ProtocolOrientedUIKit.User, Error>?
    
    func fetchUserDatas(completion: @escaping (Result<ProtocolOrientedUIKit.User, Error>) -> Void) {
        if let result = fetchUserMockResult {
            completion(result)
        }
    }
    
}

class MockUserViewModelOutput: UserViewModelOutput {
    var updateViewArray: [(name: String, username: String, email: String)] = []
    
    func updateView(name: String, username: String, email: String) {
        updateViewArray.append((name,username,email))
    }
    
}
