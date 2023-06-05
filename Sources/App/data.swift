import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let clusters: [Cluster]
    let groups: [Group]
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

// MARK: - Group
struct Group: Codable {
    let label: String
    let genes: [String]
}
