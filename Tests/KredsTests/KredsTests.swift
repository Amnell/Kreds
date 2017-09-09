import XCTest
@testable import Kreds

class KredsTests: XCTestCase {

   func testSwiftStructName() {
      XCTAssertEqual("StructName".toSwiftStructName(), "StructName")
      XCTAssertEqual("structName".toSwiftStructName(), "StructName")
      XCTAssertEqual("struct Name".toSwiftStructName(), "StructName")
      XCTAssertEqual("struCt Name".toSwiftStructName(), "StruCtName")
      XCTAssertEqual("struCt_Name".toSwiftStructName(), "StruCt_Name")
   }

   func testSwiftPropertyName() {
      XCTAssertEqual("VariableName".toSwiftVariableName(), "variableName")
      XCTAssertEqual("variable name".toSwiftVariableName(), "variableName")
      XCTAssertEqual("variaBle nAme".toSwiftVariableName(), "variaBleNAme")
      XCTAssertEqual("Base URL_Prefix".toSwiftVariableName(), "baseURL_Prefix")
   }

   func testObjCConstName() {
      XCTAssertEqual("StructName".toObjCConstName(), "kStructName")
      XCTAssertEqual("structName".toObjCConstName(), "kStructName")
      XCTAssertEqual("struct Name".toObjCConstName(), "kStructName")
      XCTAssertEqual("struCt Name".toObjCConstName(), "kStruCtName")
      XCTAssertEqual("struCt_Name".toObjCConstName(), "kStruCt_Name")
   }

   func testSwiftGroupGenerator() {
      let properties = [
         Property(name: "property1", value: "value1"),
         Property(name: "property2", value: "value2"),
         Property(name: "property3", value: "value3")
      ]
      let group = Group(name: "GroupName", properties: properties)
      let result = group.stringRepresentation(forLanguage: .swift)
      let expectedResult = """
                           struct GroupName {
                              static let property1 = \"value1\"
                              static let property2 = \"value2\"
                              static let property3 = \"value3\"
                           }
                           """
      XCTAssertEqual(result, expectedResult)
   }

   func testObjectiveCGroupGenerator() {
      let properties = [
         Property(name: "property1", value: "value1"),
         Property(name: "property2", value: "value2"),
         Property(name: "property3", value: "value3")
      ]
      let group = Group(name: "GroupName", properties: properties)
      let result = group.stringRepresentation(forLanguage: .objc)
      let expectedResult = """
                           // GroupName
                           NSString *const kGroupNameProperty1 = @\"value1\";
                           NSString *const kGroupNameProperty2 = @\"value2\";
                           NSString *const kGroupNameProperty3 = @\"value3\";
                           """
      XCTAssertEqual(result, expectedResult)
   }

    func testSwiftPropertyToString() {
      let propertyType = Property(name: "Property Name", value: "value")
      let expected = "static let propertyName = \"value\""
      XCTAssertEqual(expected, propertyType.stringRepresentation(inGroup: Group(name: "Bogus", properties: []), forLanguage: .swift))
    }

    func testObjcPropertyToString() {
      let group = Group(name: "GroupName", properties: [])
      let propertyType = Property(name: "Property Name", value: "value")
      let expected = "NSString *const kGroupNamePropertyName = @\"value\";"
      XCTAssertEqual(expected, propertyType.stringRepresentation(inGroup: group, forLanguage: .objc))
    }

    static var allTests = [
      ("testSwiftStructName", testSwiftStructName),
      ("testSwiftPropertyName", testSwiftPropertyName),
      ("testObjCConstName", testObjCConstName),
      ("testSwiftGroupGenerator", testSwiftGroupGenerator),
      ("testSwiftPropertyToString", testSwiftPropertyToString),
      ("testObjcPropertyToString", testObjcPropertyToString),
      ("testObjectiveCGroupGenerator", testObjectiveCGroupGenerator)
    ]
}
