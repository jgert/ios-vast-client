//
//  VastClient.swift
//  VastClient
//
//  Created by John Gainfort Jr on 4/6/18.
//  Copyright © 2018 John Gainfort Jr. All rights reserved.
//

import Foundation

public struct VastClientOptions {
    public var wrapperLimit: Int
}

extension VastClientOptions {
    public init() {
        self.wrapperLimit = 7
    }
}

public class VastClient {

    private let options: VastClientOptions

    public init(options: VastClientOptions = VastClientOptions()) {
        self.options = options
    }

    public func parseVast(withContentsOf url: URL) throws -> VastModel {
        let parser = VastParser(options: options)
        return try parser.parse(url: url)
    }
    
    public func parseVMAP(withContentsOf url: URL) throws -> VMAPModel {
        let parser = VMAPParser(options: options)
        return try parser.parse(url: url)
        
    }
    
    /**
     Load local files easily with schema specifier "test://"
     
     Use this to chain wrapper parsers to be forced to used local path from VastAdTagURI. Make sure to change all VastAdTagURI to local test path.
     
     - parameter url: URL of local or remote file. For local files the url has to start with `test://` and can not contain ".xml" extension. For example: `test://Pubads_Inline_Model-test` to load file named "Pubads_Inline_Model-test.xml"
     - parameter testbundle: bundle of the test that contains local test xml files
     */
    func parseVast(withContentsOf url: URL, testBundle: Bundle) throws -> VastModel {
        let parser = VastParser(options: options, testFileBundle: testBundle)
        return try parser.parse(url: url)
    }
}
