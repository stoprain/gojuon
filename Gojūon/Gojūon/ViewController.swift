//
//  ViewController.swift
//  Gojūon
//
//  Created by stoprain on 2/11/16.
//  Copyright © 2016 stoprain. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    let l = ["", "a", "i", "u", "e", "o",
        "∅", "あ", "い", "う", "え", "お",
        "k", "か", "き", "く", "け", "こ",
        "s", "さ", "し", "す", "せ", "そ",
        "t", "た", "ち", "つ", "て", "と",
        "n", "な", "に", "ぬ", "ね", "の",
        "h", "は", "ひ", "ふ", "へ", "ほ",
        "m", "ま", "み", "む", "め", "も",
        "y", "や", "", "ゆ", "", "よ",
        "r", "ら", "り", "る", "れ", "ろ",
        "w", "わ", "", "", "", "を",
        "", "ん", "", "", "", ""]
    let m = ["", "a", "i", "u", "e", "o",
        "g", "が", "ぎ", "ぐ", "げ", "ご",
        "z", "ざ", "じ", "ず", "ぜ", "ぞ",
        "d", "だ", "ぢ", "づ", "で", "ど",
        "b", "ば", "び", "ぶ", "べ", "ぼ",
        "p", "ぱ", "ぴ", "ぷ", "ぺ", "ぽ"]
    let n = ["", "ya", "yu", "yo", "ya", "yu", "yo",
        "k/g", "きゃ", "きゅ", "きょ", "ぎゃ", "ぎゅ", "ぎょ",
        "s/j", "しゃ", "しゅ", "しょ", "じゃ", "じゅ", "じょ",
        "t/d", "ちゃ", "ちゅ", "ちょ", "ぢゃ", "ぢゅ", "ぢょ",
        "n", "にゃ", "にゅ", "にょ", "", "", "",
        "h/b", "ひゃ", "ひゅ", "ひょ", "びゃ", "びゅ", "びょ",
        "/p", "", "", "", "ぴゃ", "ぴゅ", "ぴょ",
        "m", "みゃ", "みゅ", "みょ", "", "", "",
        "r", "りゃ", "りゅ", "りょ", "", "", ""]
    var t: [String]!
    var currentC = ""
    var currentL = UILabel(frame: CGRectMake(0, 108, 44, 44))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let s = UISegmentedControl(items: ["清音", "浊音／半浊音", "拗音", "练习"])
        s.frame = CGRectMake(0, 20, self.view.frame.size.width, 44)
        s.addTarget(self, action: "segmentedValueChanged:", forControlEvents: .ValueChanged)
        self.view.addSubview(s)
        
        t = l
        self.build()
    }
    
    func build() {
        var a = 6
        if t == n {
            a = 7
        }
        for var i = 0; i < t.count/a; i++ {
            for var j = 0; j < a; j++ {
                let b = UIButton(frame: CGRectMake(CGFloat(j*44), CGFloat(i*44)+64, 44, 44))
                b.setTitle(t[i*a+j], forState: .Normal)
                b.setTitleColor(UIColor.blackColor(), forState: .Normal)
                b.layer.borderWidth = 1
                b.layer.borderColor = UIColor.grayColor().CGColor
                self.view.addSubview(b)
                if j == 0 || i == 0 || t[i*a+j] == "" {
                    b.backgroundColor = UIColor.lightGrayColor()
                } else {
                    b.tag = i*a+j
                    b.addTarget(self, action: "speech:", forControlEvents: .TouchUpInside)
                }
            }
        }
    }
    
    func speech(b: UIButton) {
        let s = t[b.tag]
        let utterance = AVSpeechUtterance(string: s)
        utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
        utterance.rate = AVSpeechUtteranceMinimumSpeechRate
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speakUtterance(utterance)
    }

    func segmentedValueChanged(s: UISegmentedControl) {
        for v in self.view.subviews {
            if !(v is UISegmentedControl) {
                v.removeFromSuperview()
            }
        }
        if s.selectedSegmentIndex == 0 {
            t = l
            self.build()
        } else if s.selectedSegmentIndex == 1 {
            t = m
            self.build()
        } else if s.selectedSegmentIndex == 2 {
            t = n
            self.build()
        } else {
            
            tempImageView.frame = self.view.bounds
            self.view.addSubview(tempImageView)
            
            let b = UIButton(frame: CGRectMake(0, 64, 44, 44))
            b.setTitle("听", forState: .Normal)
            b.setTitleColor(UIColor.blackColor(), forState: .Normal)
            self.view.addSubview(b)
            b.addTarget(self, action: "random:", forControlEvents: .TouchUpInside)
            b.layer.borderWidth = 1
            b.layer.borderColor = UIColor.grayColor().CGColor
            
            let r = UIButton(frame: CGRectMake(44, 64, 44, 44))
            r.setTitle("重听", forState: .Normal)
            r.setTitleColor(UIColor.blackColor(), forState: .Normal)
            self.view.addSubview(r)
            r.addTarget(self, action: "again:", forControlEvents: .TouchUpInside)
            r.layer.borderWidth = 1
            r.layer.borderColor = UIColor.grayColor().CGColor
            
            let s = UIButton(frame: CGRectMake(88, 64, 44, 44))
            s.setTitle("显示", forState: .Normal)
            s.setTitleColor(UIColor.blackColor(), forState: .Normal)
            self.view.addSubview(s)
            s.addTarget(self, action: "show:", forControlEvents: .TouchUpInside)
            s.layer.borderWidth = 1
            s.layer.borderColor = UIColor.grayColor().CGColor
            
            self.view.addSubview(self.currentL)
            self.currentL.font = UIFont.boldSystemFontOfSize(16)
            self.currentL.textColor = UIColor.blackColor()
        }
    }
    
    func random(b: UIButton) {
        let d = ["あ", "い", "う", "え", "お",
            "か", "き", "く", "け", "こ",
            "さ", "し", "す", "せ", "そ",
            "た", "ち", "つ", "て", "と",
            "な", "に", "ぬ", "ね", "の",
            "は", "ひ", "ふ", "へ", "ほ",
            "ま", "み", "む", "め", "も",
            "や", "ゆ", "よ",
            "ら", "り", "る", "れ", "ろ",
            "わ", "を",
            "ん"]
        let r = Int(arc4random_uniform(UInt32(d.count)))
        currentC = d[r]
        let s = currentC
        let utterance = AVSpeechUtterance(string: s)
        utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
        utterance.rate = AVSpeechUtteranceMinimumSpeechRate
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speakUtterance(utterance)
        self.currentL.text = ""
        self.tempImageView.image = nil
    }
    
    func again(b: UIButton) {
        let s = currentC
        let utterance = AVSpeechUtterance(string: s)
        utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
        utterance.rate = AVSpeechUtteranceMinimumSpeechRate
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speakUtterance(utterance)
        self.currentL.text = ""
        self.tempImageView.image = nil
    }
    
    func show(b: UIButton) {
        self.currentL.text = self.currentC
    }
    
    var lastPoint = CGPointZero
    var swiped = false
    var tempImageView = UIImageView()
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        swiped = false
        if let touch = touches.first {
            lastPoint = touch.locationInView(self.view)
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        swiped = true
        if let touch = touches.first {
            let currentPoint = touch.locationInView(view)
            drawLineFrom(lastPoint, toPoint: currentPoint)
            
            // 7
            lastPoint = currentPoint
        }
    }
    
    func drawLineFrom(fromPoint: CGPoint, toPoint: CGPoint) {
        
        // 1
        UIGraphicsBeginImageContext(view.frame.size)
        let context = UIGraphicsGetCurrentContext()
        tempImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        
        // 2
        CGContextMoveToPoint(context, fromPoint.x, fromPoint.y)
        CGContextAddLineToPoint(context, toPoint.x, toPoint.y)
        
        // 3
        CGContextSetLineCap(context, CGLineCap.Round)
        CGContextSetLineWidth(context, 10)
        CGContextSetRGBStrokeColor(context, 1, 0, 0, 1.0)
        CGContextSetBlendMode(context, CGBlendMode.Normal)
        
        // 4
        CGContextStrokePath(context)
        
        // 5
        tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        tempImageView.alpha = 0.8
        UIGraphicsEndImageContext()
        
    }
}

