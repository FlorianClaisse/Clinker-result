import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let clusters: [Cluster]
    let links: [Link]
}

// MARK: - Cluster
struct Cluster: Codable {
    let name: String
    let loci: [Locus]
}

// MARK: - Locus
struct Locus: Codable {
    let genes: [Gene]
}

// MARK: - Gene
struct Gene: Codable {
    let uid, label: String
    let names: Names
    let sequence, translation: String
}

// MARK: - Names
struct Names: Codable {
    let gene: String?
    let locusTag, product: String

    enum CodingKeys: String, CodingKey {
        case gene
        case locusTag = "locus_tag"
        case product
    }
}

// MARK: - Link
struct Link: Codable {
    let target: Target
}

// MARK: - Target
struct Target: Codable {
    let uid: String
}
