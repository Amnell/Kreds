import XCTest
@testable import KredsLib

class KredsLibTests: XCTestCase {

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
        let group = Group(name: "Group Name", properties: properties)
        let result = SwiftSourceGenerator.source(forGroup: group)
        let expectedResult = """
                           struct GroupName {
                               static let property1 = \"value1\"
                               static let property2 = \"value2\"
                               static let property3 = \"value3\"
                           }
                           """
        XCTAssertEqual(result, expectedResult)
    }

    func testSwiftGroupArrayGenerator() {
        let properties = [
            Property(name: "property1", value: "value1"),
            Property(name: "property2", value: "value2"),
            Property(name: "property3", value: "value3")
        ]
        let group = Group(name: "Group Name", properties: properties)
        let result = SwiftSourceGenerator.source(forGroups: [group, group])
        let expectedResult =
        """
        struct Kreds {

            struct GroupName {
                static let property1 = "value1"
                static let property2 = "value2"
                static let property3 = "value3"
            }

            struct GroupName {
                static let property1 = "value1"
                static let property2 = "value2"
                static let property3 = "value3"
            }

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
        let result = ObjectiveCSourceGenerator.source(forGroup: group)
        let expectedResult = """
                           // GroupName
                           NSString *const kGroupNameProperty1 = @\"value1\";
                           NSString *const kGroupNameProperty2 = @\"value2\";
                           NSString *const kGroupNameProperty3 = @\"value3\";
                           """
        XCTAssertEqual(result, expectedResult)
    }

    func testObjectiveCGroupArrayGenerator() {
        let properties = [
            Property(name: "property1", value: "value1"),
            Property(name: "property2", value: "value2"),
            Property(name: "property3", value: "value3")
        ]
        let group = Group(name: "GroupName", properties: properties)
        let result = ObjectiveCSourceGenerator.source(forGroups: [group, group])
        let expectedResult =
        """
        // GroupName
        NSString *const kGroupNameProperty1 = @\"value1\";
        NSString *const kGroupNameProperty2 = @\"value2\";
        NSString *const kGroupNameProperty3 = @\"value3\";

        // GroupName
        NSString *const kGroupNameProperty1 = @\"value1\";
        NSString *const kGroupNameProperty2 = @\"value2\";
        NSString *const kGroupNameProperty3 = @\"value3\";
        """
        XCTAssertEqual(result, expectedResult)
    }

    func testSwiftPropertyToString() {
        let property = Property(name: "Property Name", value: "value")
        let expected = "static let propertyName = \"value\""
        let group = Group(name: "Bogus", properties: [])
        XCTAssertEqual(expected, SwiftSourceGenerator.source(property: property, forGroup: group))
    }

    func testObjcPropertyToString() {
        let group = Group(name: "GroupName", properties: [])
        let property = Property(name: "Property Name", value: "value")
        let expected = "NSString *const kGroupNamePropertyName = @\"value\";"
        XCTAssertEqual(expected, ObjectiveCSourceGenerator.source(property: property, forGroup: group))
    }

    func testDictionaryToGroups() {
        let sourceDict = [
            "service1": [
                "property1": "value1",
                "property2": "value2",
                "property3": "value3",
            ],
            "service2": [
                "property2-1": "value2-1",
                "property2-2": "value2-2",
                "property2-3": "value2-3",
            ]
        ]

        let result = Group.array(fromDictionary: sourceDict)
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result.first?.properties.count, 3)
    }

    func testUppercaseFirstLetter() {
        XCTAssertEqual(String.uppercasedFirstLetter("thisIsASentence"), "ThisIsASentence")
        XCTAssertEqual(String.uppercasedFirstLetter("thisIsASentence"), "ThisIsASentence")
        XCTAssertEqual(String.uppercasedFirstLetter("1ThisIsASentence"), "1ThisIsASentence")
        XCTAssertEqual(String.uppercasedFirstLetter("öThisIsASentence"), "ÖThisIsASentence")
    }

    func testLowercaseFirstLetter() {
        XCTAssertEqual(String.lowercasingFirstLetter("ThisIsASentence"), "thisIsASentence")
        XCTAssertEqual(String.lowercasingFirstLetter("ThisIsASentence"), "thisIsASentence")
        XCTAssertEqual(String.lowercasingFirstLetter("1ThisIsASentence"), "1ThisIsASentence")
        XCTAssertEqual(String.lowercasingFirstLetter("ÖThisIsASentence"), "öThisIsASentence")
    }

    static var allTests = [
        ("testSwiftStructName", testSwiftStructName),
        ("testSwiftPropertyName", testSwiftPropertyName),
        ("testObjCConstName", testObjCConstName),
        ("testSwiftGroupGenerator", testSwiftGroupGenerator),
        ("testSwiftPropertyToString", testSwiftPropertyToString),
        ("testObjcPropertyToString", testObjcPropertyToString),
        ("testObjectiveCGroupGenerator", testObjectiveCGroupGenerator),
        ("testLowercaseFirstLetter", testLowercaseFirstLetter),
        ("testUppercaseFirstLetter", testUppercaseFirstLetter)
    ]
}
