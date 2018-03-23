//
//  Summary.swift
//  Summary
//
//  Created by Sahil Chaudhary on 03/03/18.
//  Copyright © 2018 Sahil Chaudhary. All rights reserved.
//

import Foundation

public class Summary {
    //Breaks into Paragraphs
    func splitToParagraphs(doc: String) -> [String]{
        return split(content: doc, enume: NSString.EnumerationOptions.byParagraphs)
    }
    //Breaks into Sentences
    func splitContentToSentences(para: String) -> [String] {
        return split(content: para, enume: NSString.EnumerationOptions.bySentences)
    }
    //Breaks into Words
    func splitToWord (sentence: String) -> [String]{
        return split(content: sentence, enume: NSString.EnumerationOptions.byWords)
    }
    //function for splitting strings
    func split(content: String , enume: NSString.EnumerationOptions) -> [String]{
        var conString = content as NSString
        var splitCon = [String]()
        conString.enumerateSubstrings(in: NSMakeRange(0,(conString as NSString).length), options: enume) { (splitString,substringRange ,enclosingRange,stop) -> () in
            var trimmedString = splitString?.trimmingCharacters(in: NSCharacterSet.whitespaces)
            //Remove Blank Lines
            //if (trimmedString?.characters.count > 0){
            splitCon.append(trimmedString as! String)
            //}
            
        }
        return splitCon
    }
    //Intersection Function
    func intersectionFunction(array1:[String] , array2:[String]) -> [String]{
        let lower2 = array2.map({$0.lowercased()})
        return array1.filter({lower2.contains($0.lowercased())})
    }
    
    //Getting intersection score for every sentence
    func getIntersectionScore(sen1: String, sen2: String) -> Float {
        let first = splitToWord(sentence: sen1)
        let second = splitToWord(sentence: sen2)
        
        if first.count + second.count == 0 {
            return 0
        }
        let normaliseFactor = (first.count + second.count) / 2
        let intersection = intersectionFunction(array1: first, array2: second)
        
        return Float(intersection.count) / Float(normaliseFactor)
    }
    
    //Format Sentences
    func formatSentences(sen: String) -> String {
        let regex = try! NSRegularExpression(pattern: "\\W+", options: .caseInsensitive)
    
        //error possible
        let modifiedString = regex.stringByReplacingMatches(in: sen, options: .withTransparentBounds, range: NSRange(location: 0 , length: sen.characters.count), withTemplate: "")
        return modifiedString
    }
    
    //Ranking sentences
    func getRanks(content: String) -> [String:Float]{
        var sentences = splitContentToSentences(para: content)
        var n = sentences.count
        var values = [[Float]]()
        for i in 0 ... n-1 {
           var jvalues = [Float]()
            for j in 0 ... n-1{
                jvalues.append(getIntersectionScore(sen1: sentences[i], sen2: sentences[j]))
            }
            values.append(jvalues)
        }
        //Calculate total score
        var sentencesDict = [String:Float]()
        for i in 0 ... n-1 {
            var score:Float = 0
            var jvalues = [Float]()
            for j in 0 ... n-1 {
                if i == j{
                    continue
                }
                score += values[i][j]
            }
            sentencesDict[formatSentences(sen: sentences[i])] = score
        }
        return sentencesDict
    }
    //Get nest sentence based on score
    func getBestSentences(para:String,sentencesDict:[String:Float]) -> String{
        var sentences = splitContentToSentences(para: para)
        if sentences.count < 2{
            return ""
        }
        var bestSentence = ""
        var maxValue:Float = 0.0
        
        for s in sentences{
            var fs = formatSentences(sen: s)
            if fs.characters.count > 0{
                if sentencesDict[fs]! > maxValue{
                    maxValue = sentencesDict[fs]!
                    bestSentence = s
                }
            }
        }
        return bestSentence
    }
    public func getSummary(text: String) -> String{
       var sentencesDict = getRanks(content: text)
       var paragraphs = splitToParagraphs(doc: text)
       var Summary = [String]()
        //summary.append(title.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()))
        //summary.append("") for title
        for paragraph in paragraphs{
             var sentence = getBestSentences(para: paragraph, sentencesDict: sentencesDict)
             var trimmedSen = sentence.trimmingCharacters(in: NSCharacterSet.whitespaces)
            
            if trimmedSen.characters.count > 0 {
                Summary.append(trimmedSen)
            }
        }
        let splitStringg = text.components(separatedBy: ".")
        let firstLine = splitStringg[0]
        var summ = Summary.joined()
        return "\n\n" + firstLine + ". " + summ
    }
    
}
