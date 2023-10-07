//
//  MultipartRequest.swift
//  Actividades
//
//  Created by Usuario on 05/10/23.
// Codigo adaptado de https://theswiftdev.com/easy-multipart-file-upload-for-swift/

import Foundation
import UIKit

public struct MultipartRequest {
    
    public let boundary: String
    
    private let separator: String = "\r\n"
    private var data: Data

    public init(boundary: String = UUID().uuidString) {
        self.boundary = boundary
        self.data = .init()
    }
    
    private mutating func appendBoundarySeparator() {
        data.append("--\(boundary)\(separator)")
    }
    
    private mutating func appendSeparator() {
        data.append(separator)
    }

    private func disposition(_ key: String) -> String {
        "Content-Disposition: form-data; name=\"\(key)\""
    }

    public mutating func add(
        key: String,
        value: String
    ) {
        appendBoundarySeparator()
        data.append(disposition(key) + separator)
        appendSeparator()
        data.append(value + separator)
    }

    public mutating func add(
        key: String,
        fileName: String,
        fileMimeType: String,
        fileData: Data
    ) {
        appendBoundarySeparator()
        data.append(disposition(key) + "; filename=\"\(fileName)\"" + separator)
        data.append("Content-Type: \(fileMimeType)" + separator + separator)
        data.append(fileData)
        appendSeparator()
    }

    public var httpContentTypeHeadeValue: String {
        "multipart/form-data; boundary=\(boundary)"
    }

    public var httpBody: Data {
        var bodyData = data
        bodyData.append("--\(boundary)--")
        return bodyData
    }
}

extension MultipartRequest{
    
    static func sendActivity(nombre: Int, estatus: Int, usuarioID:Int, entregable: Data ) async throws->Data{
        var multipart = MultipartRequest()
        
        
        let nombreString = String(nombre)
        multipart.add(key:"nombreString", value: nombreString)
        //let entregableString = Text("/entregable")
        multipart.add(key:"entregable", value: entregableString)
        
        
        for field in [
            "usuarioID_": usuarioID,
            "estatus": estatus,
        ] {
            //multipart.add(key: field.key, value: field.value)
        }
        
        if let videoData = FileManager.default.contents(atPath: entregableString){
            multipart.add(
                key: "archivo_res",
                fileName: nombreString + ".mp4",
                fileMimeType: "video/mp4",
    //            fileData: "fake-image-data".data(using: .utf8)!
                fileData: videoData
            )
        }


        /// Create a regular HTTP URL request & use multipart components
//        let url = URL(string: "https://httpbin.org/post")!
        let url = URL(string: "http://127.0.0.1:8000/simple_upload")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(multipart.httpContentTypeHeadeValue, forHTTPHeaderField: "Content-Type")
        request.httpBody = multipart.httpBody

        /// Fire the request using URL sesson or anything else...
        let (data, response) = try await URLSession.shared.data(for: request)

        print((response as! HTTPURLResponse).statusCode)
        print(String(data: data, encoding: .utf8)!)
        return data
    }
}
