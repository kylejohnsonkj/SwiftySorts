//
//  GameScene.swift
//  Sorts
//
//  Created by Kyle Johnson on 10/14/17.
//  Copyright © 2017 Kyle Johnson. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let count = 50
    var rects = [Int: CGRect]()
    var rectNodes = [Int: SKShapeNode]()
    var countArray: [Int] = []
    var shuffledArray: [Int] = []
    var sortLabel = SKLabelNode()
    var interrupted = false
	var top = 50
    
    override func didMove(to view: SKView) {
        backgroundColor = .lightGray
        
        generateRects()
        generateButtons()
        generateLabel()
    }
    
    func resetScene() {
        self.removeAllChildren()
        rectNodes = [:]
        rects = [:]
        shuffledArray = []
        countArray = []
        top = 50
        
        let reset = SKAction.playSoundFileNamed("reset.mp3", waitForCompletion: false)
        self.run(reset)
    }
    
    func generateRects() {
        
        for index in 1...count {
            countArray.append(index)
        }
        shuffledArray = countArray
        shuffledArray.shuffle()
        countArray.removeAll()
        
        for index in 1...count {
            self.createRect(x: self.shuffledArray[index - 1] * 13 - 338, index: index)
        }
        
        interrupted = false
    }
    
    func generateButtons() {
        let bubbleNode = SKShapeNode(rectOf: CGSize(width: 150, height: 50))
        bubbleNode.fillColor = .black
        bubbleNode.strokeColor = bubbleNode.fillColor
        bubbleNode.name = "bubble"
        bubbleNode.zPosition = 1
        bubbleNode.position = CGPoint(x: -251, y: -165)
        addChild(bubbleNode)
        
        let bubble = SKLabelNode(fontNamed: "Futura Medium")
        bubble.text = "Bubble Sort"
        bubble.fontSize = 23
        bubble.fontColor = .white
        bubble.position = CGPoint(x: 0, y: -8)
        bubble.name = "bubble"
        bubble.zPosition = 2
        bubbleNode.addChild(bubble)
        
        let insertionNode = SKShapeNode(rectOf: CGSize(width: 165, height: 50))
        insertionNode.fillColor = .black
        insertionNode.strokeColor = insertionNode.fillColor
        insertionNode.name = "insertion"
        insertionNode.zPosition = 1
        insertionNode.position = CGPoint(x: -82, y: -165)
        addChild(insertionNode)
        
        let insertion = SKLabelNode(fontNamed: "Futura Medium")
        insertion.text = "Insertion Sort"
        insertion.fontSize = 23
        insertion.fontColor = .white
        insertion.position = CGPoint(x: 0, y: -8)
        insertion.name = "insertion"
        insertion.zPosition = 2
        insertionNode.addChild(insertion)
        
        let mergeNode = SKShapeNode(rectOf: CGSize(width: 150, height: 50))
        mergeNode.fillColor = .black
        mergeNode.strokeColor = mergeNode.fillColor
        mergeNode.name = "merge"
        mergeNode.zPosition = 1
        mergeNode.position = CGPoint(x: 88, y: -165)
        addChild(mergeNode)
        
        let merge = SKLabelNode(fontNamed: "Futura Medium")
        merge.text = "Merge Sort"
        merge.fontSize = 23
        merge.fontColor = .white
        merge.position = CGPoint(x: 0, y: -8)
        merge.name = "merge"
        merge.zPosition = 2
        mergeNode.addChild(merge)
        
        let quickNode = SKShapeNode(rectOf: CGSize(width: 150, height: 50))
        quickNode.fillColor = .black
        quickNode.strokeColor = quickNode.fillColor
        quickNode.name = "quick"
        quickNode.zPosition = 1
        quickNode.position = CGPoint(x: 250, y: -165)
        addChild(quickNode)
        
        let quick = SKLabelNode(fontNamed: "Futura Medium")
        quick.text = "Quick Sort"
        quick.fontSize = 23
        quick.fontColor = .white
        quick.position = CGPoint(x: 0, y: -8)
        quick.name = "quick"
        quick.zPosition = 2
        quickNode.addChild(quick)
    }
    
    func generateLabel() {
        sortLabel = SKLabelNode(text: "Tap to shuffle. Then select a sort.")
        sortLabel.fontName = "Futura"
        sortLabel.position = CGPoint(x: 0, y: 145)
        addChild(sortLabel)
    }
    
    func createRect(x: Int, index: Int) {
        
        let minHeight = 15
        let rect = CGRect(x: x, y: -120, width: 12, height: Int(Double(minHeight + index) * 3.5))
        let rectNode = SKShapeNode(rect: rect)
        rectNode.fillColor = .white
        rectNode.strokeColor = .black
        rectNode.lineWidth = 2
        rects[index] = rect
        rectNodes[index] = rectNode
//        print("index: \(index)  SU: \(shuffledArray[index - 1])")
        addChild(rectNode)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let node: SKNode = self.atPoint(location)
            
            if node.name == "bubble" {
                run(SKAction.run() {
                    self.sortLabel.text = "Bubble Sort"
                    self.bubbleSort(array: &self.shuffledArray)
//                    print(self.shuffledArray)
                })
            } else if node.name == "insertion" {
                run(SKAction.run() {
                    self.sortLabel.text = "Insertion Sort"
                    self.insertionSort(array: &self.shuffledArray)
//                    print(self.shuffledArray)
                })
            } else {
                interrupted = true
                resetScene()
                generateRects()
                generateButtons()
                generateLabel()
            }
        }
    }
    
    func bubbleSort(array: inout [Int]) {
        
        print(array)
        let count = array.count
        
        for index in (0...count) {
            for value in (1...count - 1).reversed() {
                
                if array[value - 1] > array[value] {
                    let largerValue = array[value - 1]
                    array[value - 1] = array[value]
                    array[value] = largerValue
                    
                    delay(Double(index) / 10.0) {
                        self.updateRects(index1: value, index2: value + 1)
                        let tick = SKAction.playSoundFileNamed("tick.wav", waitForCompletion: false)
                        self.run(tick)
                    }
                }
            }
        }
        print(array)
    }
    
    func insertionSort(array: inout [Int]) {
        
        print(array)
        
        for x in (1..<array.count) {
            var y = x
            while y > 0 && array[y] < array[y - 1] {
                array.swapAt(y - 1, y)
                
                delay(Double(x) / 100.0) {
                    self.updateRects(index1: y, index2: y + 1)
                    y -= 1
                    let tick = SKAction.playSoundFileNamed("tick.wav", waitForCompletion: false)
                    self.run(tick)
                }
            }
        }
        print(array)
    }
    
    func updateRects(index1: Int, index2: Int) {

        let temp = rects[index1]
        // here, we swap the larger value for the smaller value
        rects[index1] = rects[index2]
        rects[index2] = temp
        
        print(index1)
        print(index2)
        
        if index2 == top {
            top = top - 1
            self.insertionSort(array: &self.shuffledArray)
        }
        
        let min1 = Int((rects[index1]?.minX)!)
        let min2 = Int((rects[index2]?.minX)!)
        
        self.rectNodes[index1]?.removeFromParent()
        self.rectNodes[index2]?.removeFromParent()

        self.createRect(x: min1, index: index1)
        self.createRect(x: min2, index: index2)
    }
    
    func delay(_ delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

extension MutableCollection {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            let i = index(firstUnshuffled, offsetBy: d)
            swapAt(firstUnshuffled, i)
        }
    }
}

