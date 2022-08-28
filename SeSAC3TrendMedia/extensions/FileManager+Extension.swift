//
//  FileManager+Extension.swift
//  SeSAC3TrendMedia
//
//  Created by 강민혜 on 8/24/22.
//

import Foundation
import UIKit

extension UIViewController {
    
    // MARK: - backup/restore 관련
    
    // Document 경로
    func documentDirectoryPath() -> URL? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documentDirectory
    }
    
    func fetchDocumentZipFile() -> [String] {
        
        do {
            guard let path = documentDirectoryPath() else { return [""] }
            
            let docs = try FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)
            print("docs: \(docs), docs.count : \(docs.count)")
            
            let zip = docs.filter { $0.pathExtension == "zip" }
            print("zip: \(zip)")
            
            let result = zip.map { $0.lastPathComponent }
            print("result: \(result)")
            
            return result
            
        } catch {
            print("앱내 폴더에서 백업용 파일 가져오기 실패!")
            return [""]
        }
    }
    
    func extractURLS() -> [URL] {
        do {
            guard let path = documentDirectoryPath() else { return [] }
            
            let docs = try FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)
            print("docs: \(docs)")
            
            let zip = docs.filter { $0.pathExtension == "zip" }
            print("zip: \(zip)")
            
            return zip
            
        } catch {
            return []
        }
    }
    
    
    // MARK: - 이미지 저장/가져오기/삭제 기능
    func saveImageToDocument(fileName: String, image: UIImage) {
        guard let documentDirectory = documentDirectoryPath() else { return }
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        // fileName edms class내부에 선언
        // 세부 경로, 이미지를 저장할위치
        
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }

        do {
            try data.write(to: fileURL)
            print("이미지 저장 완료! documentDirectory : \(documentDirectory)")
        } catch let error {
            print("file save error", error)
        }
    }
    
    func loadImageFromDocument(fileName: String) -> UIImage? {
        guard let documentDirectory = documentDirectoryPath() else { return nil }
        let fileURL = documentDirectory.appendingPathComponent(fileName) // 세부 경로. 이미지를 저장할 위치
        
        // 이미지 파일이 존재하는지 체크
        if FileManager.default.fileExists(atPath: fileURL.path) {
            return UIImage(contentsOfFile: fileURL.path)
        } else {
            return UIImage(systemName: "star.fill")
        }
    }
    
    func removeImageFromDocument(fileName: String) {
        guard let documentDirectory = documentDirectoryPath() else { return }
        let fileURL = documentDirectory.appendingPathComponent(fileName) // 세부 경로. 이미지를 저장할 위치
    
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch let error {
            print(error)
        }
    }
    
}




