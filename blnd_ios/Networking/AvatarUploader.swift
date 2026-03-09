import Foundation
import UIKit

enum AvatarUploader {
    /// Uploads a UIImage to Supabase Storage and returns the public URL.
    static func upload(image: UIImage, userId: String) async throws -> String {
        guard let data = image.jpegData(compressionQuality: 0.8) else {
            throw AvatarError.compressionFailed
        }

        let path = "\(userId)/avatar.jpg"
        let urlString = "\(SupabaseConfig.projectURL)/storage/v1/object/\(SupabaseConfig.bucket)/\(path)"

        guard let url = URL(string: urlString) else {
            throw AvatarError.invalidURL
        }

        guard let token = KeychainManager.readString(key: "accessToken") else {
            throw APIError.unauthorized
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("image/jpeg", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("true", forHTTPHeaderField: "x-upsert")
        request.httpBody = data

        let (_, response) = try await URLSession.shared.data(for: request)

        guard let http = response as? HTTPURLResponse,
              200 ..< 300 ~= http.statusCode
        else {
            throw AvatarError.uploadFailed
        }

        let cacheBust = Int(Date().timeIntervalSince1970)
        return "\(SupabaseConfig.projectURL)/storage/v1/object/public/\(SupabaseConfig.bucket)/\(path)?v=\(cacheBust)"
    }

    enum AvatarError: LocalizedError {
        case compressionFailed
        case invalidURL
        case uploadFailed

        var errorDescription: String? {
            switch self {
            case .compressionFailed: return "Failed to compress image"
            case .invalidURL: return "Invalid upload URL"
            case .uploadFailed: return "Failed to upload avatar"
            }
        }
    }
}
