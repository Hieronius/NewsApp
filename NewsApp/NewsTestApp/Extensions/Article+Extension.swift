import Foundation

extension Article: Equatable {
    static func == (lhs: Article, rhs: Article) -> Bool {
        return lhs.title == rhs.title
    }
}
