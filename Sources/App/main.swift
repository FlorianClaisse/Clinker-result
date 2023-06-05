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

if let lineData = "Cluster Name\tGene UID\tGene Label\tGene Name\tLocus Tag\tProduct Name\tsequence\ttranslation\tLink Count\n".data(using: .utf8) {
    fileHandle.write(lineData)
} else {
    fatalError("File write failed")
}

for clusters in welcome.data.clusters {
    for loci in clusters.loci {
        for genes in loci.genes {
            var count = 0
            for link in welcome.data.links {
                if genes.uid == link.target.uid {
                    count += 1
                }
            }
            if let lineData = "\(clusters.name)\t\(genes.uid)\t\(genes.label)\t\(genes.names.gene ?? "")\t\(genes.names.locusTag)\t\(genes.names.product)\t\(genes.sequence)\t\(genes.translation)\t\(count)\n".data(using: .utf8) {
                fileHandle.write(lineData)
            } else {
                fatalError("File write failed")
            }
        }
    }
}


fileHandle.closeFile()




