//
//  Logger.swift
//  NewsFlash
//
//  Created by Mena Maher on 8/26/25.
//

import Foundation
import OSLog

extension Logger {
    
    private static var subsystem = Bundle.main.bundleIdentifier!
    
    /// Logs related to the networking.
    static let networking = Logger(subsystem: subsystem, category: "networking")
    
    /// Logs related to local data source errors and debugging
    static let localDataSource = Logger(subsystem: subsystem, category: "local data source")
}
