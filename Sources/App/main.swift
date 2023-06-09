import Foundation

let filePath = CommandLine.arguments[1]
let fileURL = URL(fileURLWithPath: filePath)

let data = try Data(contentsOf: fileURL)
let decoder = JSONDecoder()
let welcome = try decoder.decode(Welcome.self, from: data)

let dirPath = fileURL.deletingLastPathComponent().relativePath
let outputFilePath = "\(dirPath)/output.txt"

if !FileManager.default.fileExists(atPath: outputFilePath) {
    FileManager.default.createFile(atPath: outputFilePath, contents: nil, attributes: nil)
}

guard let fileHandle = FileHandle(forWritingAtPath: "\(dirPath)/output.txt") else { fatalError("File open failed") }

fileHandle.truncateFile(atOffset: 0)

if let lineData = "Cluster Name\tGene UID\tGene Label\tGene Name\tPhRog\tTopHit\tLocus Tag\tFunction\tProduct Name\tsequence\ttranslation\tLink Count\tGroup\n".data(using: .utf8) {
    fileHandle.write(lineData)
} else {
    fatalError("File write failed")
}

for clusters in welcome.data.clusters {
    for loci in clusters.loci {
        for gene in loci.genes {
            var count = 1
            var groupName = ""
            for group in welcome.data.groups {
                if group.genes.contains(gene.uid) {
                    count = group.genes.count
                    groupName = group.label
                    break
                }
            }
            if let lineData = "\(clusters.name)\t\(gene.uid)\t\(gene.label)\t\(gene.names.gene ?? "")\t\(gene.names.phrog ?? "")\t\(gene.names.topHit ?? "")\t\(gene.names.locusTag)\t\(gene.names.function ?? "")\t\(gene.names.product)\t\(gene.sequence)\t\(gene.translation)\t\(count)\t\(groupName)\n".data(using: .utf8) {
                fileHandle.write(lineData)
            } else {
                fatalError("File write failed")
            }
        }
    }
}


fileHandle.closeFile()




