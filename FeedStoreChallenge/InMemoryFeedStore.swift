//
//  InMemoryFeedStore.swift
//  FeedStoreChallenge
//
//  Created by Khoi Nguyen on 4/11/20.
//  Copyright © 2020 Essential Developer. All rights reserved.
//

import Foundation

public class InMemoryFeedStore: FeedStore {
    
    private struct Cache {
        let feed: [LocalFeedImage]
        let timestamp: Date
    }
    
    private var cache: Cache?
    
    public init() {}
    
    public func deleteCachedFeed(completion: @escaping DeletionCompletion) {
        cache = nil
        completion(nil)
    }
    
    public func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
        
        cache = Cache(feed: feed, timestamp: timestamp)
        completion(nil)
    }
    
    public func retrieve(completion: @escaping RetrievalCompletion) {
        if let cache = cache {
            completion(.found(feed: cache.feed, timestamp: cache.timestamp))
        } else {
            completion(.empty)
        }
    }
}
