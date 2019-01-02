const recursive = require("recursive-readdir");
const fs = require("fs");
const indexFileName = "../Index.md";
const sourceDirectory = "..";

let index = {}

if (!Array.prototype.sortIgnoreCase) {
    Array.prototype.sortIgnoreCase = function () {
        return this.sort(function (a, b) {
            return a.toLowerCase().localeCompare(b.toLowerCase());
        });
    };
}


function isDir(path) {
    try {
        const stat = fs.lstatSync(path);
        return stat.isDirectory();
    } catch (e) {
        return false;
    }
}

function processFiles(err, files) {
    if(err !== null) {
        console.log("Error: " + err);
        process.exit(1);
    }

    files.map(f => f.replace("../", ""))
         .forEach(processFile);

    deleteIndexFile();
    processIndex(index);
}

function processFile(file) {
    const fileParts = file.split("/");
    let currentPath = "";

    fileParts.forEach(part => {
        currentPath += "/" + part;

        if(isDir(sourceDirectory + "/" + currentPath)) {
            index[currentPath.replace("/", "")] = [];
        } else {
            const indexName = currentPath.substring(0, currentPath.lastIndexOf("/")).replace("/", "");
            console.log("Indexing ", currentPath);
            index[indexName].push(currentPath);
        }
    });
}

function processIndex(index) {
    const keys = Object.keys(index).sortIgnoreCase();

    keys.forEach(key => {
        writeToIndexFile(`# ${key}\n`)

        index[key].sortIgnoreCase().forEach(entry => {
            const fileName = entry.substring(entry.lastIndexOf("/")).replace("/","")
            writeToIndexFile(`- [${fileName}](.${entry})\n`);
        });

        writeToIndexFile("\n");
    });
}

function writeToIndexFile(line) {
    fs.appendFileSync(indexFileName, line);
}

function deleteIndexFile() {
    try {
        fs.unlinkSync(indexFileName)
    } catch(e) {
        return;
    }
}

recursive(sourceDirectory, [ indexFileName, sourceDirectory + "/build_index.sh",  sourceDirectory + "*/.*", sourceDirectory + "/doc_generate/*", sourceDirectory + "/doc_generate/.gitignore",  "LICENSE", "README.md" ] , processFiles);
