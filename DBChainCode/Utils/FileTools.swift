//
//  FileTools.swift
//  AppProject
//
//  Created by zewu wang on 2018/8/1.
//  Copyright © 2018年 zewu wang. All rights reserved.
//

import UIKit

class FileTools: NSObject {
    
    //MARK:单例
    public static var sharedInstance : FileTools{
        struct Static {
            static let instance : FileTools = FileTools()
        }
        return Static.instance
    }
    
    private let fileManager = FileManager.default
    
    /*得到文件路径*/
    private func getFile(fileName : String , path : String) -> String{
        if fileName == ""{
            return path
        }
        return path + "/" + fileName
    }
    
    /*获取沙盒主目录路径*/
    public func homeDir() -> String{
        return NSHomeDirectory()
    }
    
    /*app路径*/
    public func appDir() -> String{
        let arrays = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.applicationDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        return arrays[0]
    }
    
    /*获取Documents目录路径*/
    public func docDir() -> String{
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        return paths[0]
    }
    
    /*Library*/
    public func libraryDir() -> String{
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        return paths[0]
    }
    
    /*获取Caches目录路径*/
    public func cachesDir() -> String{
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        return paths[0]
    }
    
    /*获取tmp目录路径*/
    public func tmpDir() -> String{
        return NSTemporaryDirectory()
    }
    
    /*文件是否存在*/
    public func isFileExisted(fileName : String = "", path : String) -> Bool{
        return fileManager.fileExists(atPath: getFile(fileName : fileName , path : path))
    }
    
    /*创建指定名字的文件*/
    public func createFile(fileName : String = "", path : String , contents : Data? = nil , attributes : [FileAttributeKey : Any]? = nil) -> Bool{
        if fileManager.fileExists(atPath: path) == true{
            return fileManager.createFile(atPath: getFile(fileName : fileName , path : path), contents: contents, attributes: attributes)
        }
        return false
    }
    
    /*创建指定名字的文件夹*/
    public func createDirectory(folderName : String = "", path : String ,withIntermediateDirectories : Bool = true, attributes : [FileAttributeKey : Any]? = nil) -> Bool{
        if fileManager.fileExists(atPath: path) == false{
            do {
                try fileManager.createDirectory(atPath: getFile(fileName : folderName , path : path), withIntermediateDirectories: withIntermediateDirectories, attributes: attributes)
            }catch{
                return false
            }
            return true
        }
        return false
    }
    
    /*获取某个目录下所有的文件路径*/
    public func filePathsWithDirPath(path : String) -> [String]{
        do{
            let tmpFiles = try fileManager.contentsOfDirectory(atPath: path)
            var files = [String]()
            for fileName in tmpFiles{
                files.append(path + "/" + fileName)
            }
            return files
        }catch{
            return []
        }
    }
    
    /*获取某个目录下所有的文件名字*/
    public func fileWithDirPath(path : String) -> [String]{
        do{
            let tmpFiles = try fileManager.contentsOfDirectory(atPath: path)
            return tmpFiles
        }catch{
            return []
        }
    }
    
    /*删除目录下的所有文件*/
    public func deleteFilesWithDirPath(path : String) -> Bool{
        let fileList = filePathsWithDirPath(path: path)
        for file in fileList{
            if deleteFile(path: file) == false{
                return false
            }
        }
        return true
    }
    
    /*删除文件*/
    public func deleteFile(fileName : String = "", path : String) -> Bool{
        if fileManager.fileExists(atPath: getFile(fileName: fileName, path: path)){
            do{
                try fileManager.removeItem(atPath: getFile(fileName : fileName , path : path))
            }catch{
                return false
            }
            return true
        }
        return false
    }
    
    /*根据url删除文件*/
    public func deleteFileWithUrl(url : URL) -> Bool{
        do{
            try fileManager.removeItem(at: url)
        }catch{
            return false
        }
        return true
    }
    
    /*移动文件*/
    public func moveFile(atName : String = "" , atPath : String , toName : String = "" ,toPath : String) -> Bool{
        do{
            try fileManager.moveItem(atPath: getFile(fileName: atName, path: atPath), toPath: getFile(fileName: toName, path: toPath))
        }catch{
            return false
        }
        return true
    }
    
    /*根据url移动文件*/
    public func moveFile(atUrl : URL , toUrl : URL) -> Bool{
        do{
            try fileManager.moveItem(at: atUrl, to: toUrl)
        }catch{
            return false
        }
        return true
    }
    
    /*复制文件*/
    public func copyFile(atName : String = "" , atPath : String , toName : String = "" ,toPath : String) -> Bool{
        do{
            try fileManager.copyItem(atPath: getFile(fileName: atName, path: atPath), toPath: getFile(fileName: toName, path: toPath))
        }catch{
            return false
        }
        return true
    }
    
    /*根据url复制文件*/
    public func copyFile(atUrl : URL , toUrl : URL) -> Bool{
        do{
            try fileManager.copyItem(at: atUrl, to: toUrl)
        }catch{
            return false
        }
        return true
    }
    
}
