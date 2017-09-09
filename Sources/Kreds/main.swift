//
//  main.swift
//  Kreds
//
//  Created by Mathias Amnell on 2017-09-09.
//

import KredsLib
import Foundation
import Commander

let generate = command(
    Argument<String>("inputFile", description: "The input plist file"),
    Argument<String>("destination", description: "The destination path")
) { inputFile, destination in
    let outputURL = URL(fileURLWithPath: destination).appendingPathComponent(Kreds.generatedSwiftKredsFilename, isDirectory: false)
    print("outputURL: \(outputURL)")
}

let group = Group()
group.addCommand("generate", "Generates \(Kreds.generatedSwiftKredsFilename) file", generate)
group.run(Kreds.version)
