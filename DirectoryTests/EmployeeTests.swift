//
//  URLTests.swift
//  DirectoryTests
//
//  Created by Edward Arribasplata on 12/3/22.
//

import XCTest

final class EmployeeTests: XCTestCase {

    private var sut: EndpointManager!
    
    override func setUpWithError() throws {
         sut = EndpointManager()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    // Invalid URL returns a nil URL.
    func test_invalidURL_returnNil()async {
        let urlString = "hello, world."
        
        let url:URL? = sut.createURL(urlString: urlString)
        XCTAssertNil(url)
    }
    
    // Invalid URL inputed into fetchEmployee function returns an empty list.
    func test_invalidURL_whenFetchingEmployees_returnEmptyList()async {
        let urlString = "invalid url string"
        
        do {
            let actual_employees:[Employee] = try await sut.fetchEmployees(urlString: urlString)
            let expected_employees:[Employee] = []
            
            XCTAssertEqual(actual_employees, expected_employees)
        } catch {
            XCTAssertThrowsError(error)
        }
    }
    
    // Invalid endpoint return an error thrown.
    func test_invalidEndpoint_returnError()async {
        let url = URL(string: "www")!
        do {
            let _ = try await sut.callEndpoint(url: url)
            XCTFail("Expected to throw while awaiting, but succeeded.")
        } catch {
            XCTAssertNotNil(error)
        }
    }
    
    // Malformed employee result returns empty list.
    func test_employeeMalformed_returnEmptyList()async {
        let url = "https://s3.amazonaws.com/sq-mobile-interview/employees_malformed.json"
        
        do {
            let actual_employees:[Employee] = try await sut.fetchEmployees(urlString: url)
            let expected_employees:[Employee] = []
            
            XCTAssertEqual(actual_employees, expected_employees)
        } catch {
            XCTAssertThrowsError(error)
        }
    }
    
    // Empty employee list returns empty list.
    func test_employeeEmpty_returnEmptyList()async {
        let url = "https://s3.amazonaws.com/sq-mobile-interview/employees_empty.json"
        
        do {
            let actual_employees:[Employee] = try await sut.fetchEmployees(urlString: url)
            let expected_employees:[Employee] = []
            
            XCTAssertEqual(actual_employees, expected_employees)
        } catch {
            XCTAssertThrowsError(error)
        }
    }
}
