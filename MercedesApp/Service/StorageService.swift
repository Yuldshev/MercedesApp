import Foundation
import FirebaseStorage
import UIKit

protocol StorageProtocol {
  func uploadImage(data: Data, path: String) async throws -> URL
}

final class StorageService: StorageProtocol {
  private let storageRef = Storage.storage().reference()
  
  func uploadImage(data: Data, path: String) async throws -> URL {
    let ref = storageRef.child(path)
    _ = try await ref.putDataAsync(data)
    return try await ref.downloadURL()
  }
}
