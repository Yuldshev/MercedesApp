import Foundation
import FirebaseFirestore

protocol FireStoreProtocol {
  func saveData<T: Encodable>(collection: String, dataId: String, data: T) async throws
  func loadData<T: Decodable>(collection: String, as type: T.Type) async throws -> [T]
  func loadDocument<T: Decodable>(collection: String, documentId: String, as type: T.Type) async throws -> T
}

final class FireStoreService: FireStoreProtocol {
  private let db = Firestore.firestore()
  
  func saveData<T: Encodable>(collection: String, dataId: String, data: T) async throws {
    let dataRef = db.collection(collection).document(dataId)
    try dataRef.setData(from: data)
  }
  
  func loadData<T: Decodable>(collection: String, as type: T.Type) async throws -> [T] {
    let snapshot = try await db.collection(collection).getDocuments()
    return try snapshot.documents.compactMap { doc in
      try doc.data(as: T.self)
    }
  }
  
  func loadDocument<T>(collection: String, documentId: String, as type: T.Type) async throws -> T where T : Decodable {
    let doc = try await db.collection(collection).document(documentId).getDocument()
    
    guard let data = try? doc.data(as: T.self) else {
      throw NSError(domain: "", code: 0, userInfo: nil)
    }
    
    return data
  }
}
