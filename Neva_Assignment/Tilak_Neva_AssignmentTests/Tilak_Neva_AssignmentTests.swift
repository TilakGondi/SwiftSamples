//
//  Tilak_Neva_AssignmentTests.swift
//  Tilak_Neva_AssignmentTests
//
//  Created by Tilakkumar Gondi on 06/06/19.
//  Copyright © 2019 Tilakkumar Gondi. All rights reserved.
//

import XCTest
@testable import Tilak_Neva_Assignment

class Tilak_Neva_AssignmentTests: XCTestCase {
    
    var profilesList:[Profile]!
    var errorObj:Error?

    

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        let expectation = self.expectation(description: "ProfileData")
        
        APIHandler.sharedInstance.getProfileData { [unowned self] (profiles, error)  in
            self.profilesList = profiles
            self.errorObj = error
            expectation.fulfill()
        }
        
         wait(for: [expectation], timeout: 10)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchProfileData()  {
        XCTAssertNil(self.errorObj,"Failed due to error:\(errorObj?.localizedDescription ?? "API error.")")
        if errorObj != nil { return }
        XCTAssert(self.profilesList.count > 0, "Api returned zero profiles.")
    }
    
    func testValidateProfileData() {
        guard let profiles = profilesList else {
            return
        }
        
        let profileData:Profile = profiles[0]
        XCTAssertEqual(profileData.id, 1)
        XCTAssertEqual(profileData.name, "Vangipurapu Venkata Sai Laxman")
        XCTAssertEqual(profileData.skills, "Cricketer, Batsman")
        XCTAssertEqual(profileData.image, "https://qph.ec.quoracdn.net/main-qimg-4f5029c4319b41270f5643d461979645-c")
    }
    
    func testFetchImageFromUrl() {
        
        guard let profileList = profilesList else {
            return
        }
        let profile = profileList[0]
        
        let imageExpectation = self.expectation(description: "ProfileImage")
        var imageValue:UIImage?
        if let imageUrl = URL(string: profile.image!) {
            APIHandler.sharedInstance.loadImage(from: imageUrl) { (image, error) in
                imageValue = image
                imageExpectation.fulfill()
            }
        }

        wait(for: [imageExpectation], timeout: 10)
        
        XCTAssertNil(imageValue)
    }

}
