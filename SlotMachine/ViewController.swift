//
//  ViewController.swift
//  SlotMachine
//
//  Created by bartosz on 10/06/2015.
//  Copyright (c) 2015 bartosz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var firstContainer: UIView!
    var secondContainer: UIView!
    var thirdContainer: UIView!
    var fourthContainer: UIView!
    
    var titleLabel: UILabel!
    
    // info labels
    
    var creditsLabel:UILabel!
    var betLabel:UILabel!
    var winnerPaidLabel:UILabel!
    var creditsTitleLabel:UILabel!
    var betTitleLabel:UILabel!
    var winnerPaidTitleLabel:UILabel!
    
    // buttons in 4th container
    
    var resetButton:UIButton!
    var betOneButton:UIButton!
    var betMaxButton:UIButton!
    var spinButton:UIButton!
    
    
    let kMarginForView:CGFloat = 10.0
    let kMarginForSlot:CGFloat = 2.0
    let kSixth:CGFloat = 1.0/6.0
    let kThird:CGFloat = 1.0/3.0
    
    let kHalf:CGFloat = 1.0/2.0
    let kEight:CGFloat = 1.0/8.0
    
    let kNumberOfContainers = 3
    let kNumberOfSlots = 3
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupContainerViews()
        setupFirstContainer(self.firstContainer)
        setupSecondContainer(self.secondContainer)
        setupThirdContainer(self.thirdContainer)
        setupFourthContainer(self.fourthContainer)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // IBActions
    
    func resetButtonPressed(button: UIButton) {
        
        println("resetButton pressed")
        
    }
    
    func setupContainerViews() {
        
        let firstX = self.view.bounds.origin.x + kMarginForView
        let firstY = self.view.bounds.origin.y
        let firstW = self.view.bounds.width - (kMarginForView * 2)
        let firstH = self.view.bounds.height * kSixth
        
        self.firstContainer = UIView(frame: CGRect(x: firstX, y: firstY, width: firstW, height: firstH))
        self.firstContainer.backgroundColor = UIColor.redColor()
        self.view.addSubview(self.firstContainer)
        
        let secondX = self.view.bounds.origin.x + kMarginForView
        let secondY = firstContainer.frame.height // frame == bounce here ?
        let secondW = self.view.bounds.width - (kMarginForView * 2)
        let secondH = self.view.bounds.height * (3 * kSixth)
        
        self.secondContainer = UIView(frame: CGRect(x: secondX, y: secondY, width: secondW, height: secondH))
        self.secondContainer.backgroundColor = UIColor.blackColor()
        self.view.addSubview(self.secondContainer)
        
        let thirdX = self.view.bounds.origin.x + kMarginForView
        let thirdY = firstContainer.frame.height + secondContainer.frame.height
        let thirdW = self.view.bounds.width - (kMarginForView * 2)
        let thirdH = self.view.bounds.height * (1 * kSixth)
        
        self.thirdContainer = UIView(frame: CGRect(x: thirdX, y: thirdY, width: thirdW, height: thirdH))
        self.thirdContainer.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(self.thirdContainer)
        
        let fourthX = self.view.bounds.origin.x + kMarginForView
        let fourthY = firstContainer.frame.height + secondContainer.frame.height + thirdContainer.frame.height
        let fourthW = self.view.bounds.width - (kMarginForView * 2)
        let fourthH = self.view.bounds.height * (1 * kSixth)
        
        self.fourthContainer = UIView(frame: CGRect(x: fourthX, y: fourthY, width: fourthW, height: fourthH))
        self.fourthContainer.backgroundColor = UIColor.blackColor()
        self.view.addSubview(self.fourthContainer)
    }

    func setupFirstContainer(containerView: UIView) {
        self.titleLabel = UILabel()
        self.titleLabel.text = "Super Slots"
        self.titleLabel.textColor = UIColor.yellowColor()
        self.titleLabel.font = UIFont(name: "MarkerFelt-Wide", size: 40)
        self.titleLabel.sizeToFit()
        self.titleLabel.center = containerView.center // based upon the superview
        containerView.addSubview(self.titleLabel)
    }
    
    func setupSecondContainer(containerView: UIView) {
    
        for var containerNumber = 0; containerNumber < kNumberOfContainers; ++containerNumber {
            
            for var slotNumber = 0; slotNumber < kNumberOfSlots; ++slotNumber {
                
                var slotImageView = UIImageView()
                slotImageView.backgroundColor = UIColor.yellowColor()
                
                let slotX = containerView.bounds.origin.x + (containerView.bounds.size.width * CGFloat(containerNumber) * kThird)
                let slotY = containerView.bounds.origin.y + (containerView.bounds.size.height * CGFloat(slotNumber) * kThird)
                let slotW = containerView.bounds.width * kThird - kMarginForSlot
                let slotH = containerView.bounds.height * kThird - kMarginForSlot
                
                slotImageView.frame = CGRect(x: slotX, y: slotY, width: slotW, height: slotH)
                containerView.addSubview(slotImageView)
                
            }
            
        }
        
    }
    
    func setupThirdContainer(containerView: UIView) {

        self.creditsLabel = UILabel()
        self.creditsLabel.text = "000000" // = UILabel()
        self.creditsLabel.textColor = UIColor.redColor()
        self.creditsLabel.font = UIFont(name: "MarkerFelt-Bold", size: 16)
        self.creditsLabel.sizeToFit()
        self.creditsLabel.center = CGPoint(x: containerView.frame.width * kSixth, y: containerView.frame.height * kThird)
        self.creditsLabel.textAlignment = NSTextAlignment.Center
        self.creditsLabel.backgroundColor = UIColor.darkGrayColor()
        containerView.addSubview(self.creditsLabel)
        
        self.betLabel = UILabel()
        self.betLabel.text = "0000" // = UILabel()
        self.betLabel.textColor = UIColor.redColor()
        self.betLabel.font = UIFont(name: "MarkerFelt-Bold", size: 16)
        self.betLabel.sizeToFit()
        self.betLabel.center = CGPoint(x: containerView.frame.width * kSixth * 3, y: containerView.frame.height * kThird)
        self.betLabel.textAlignment = NSTextAlignment.Center
        self.betLabel.backgroundColor = UIColor.darkGrayColor()
        containerView.addSubview(self.betLabel)
        
        self.winnerPaidLabel = UILabel()
        self.winnerPaidLabel.text = "000000" // = UILabel()
        self.winnerPaidLabel.textColor = UIColor.redColor()
        self.winnerPaidLabel.font = UIFont(name: "MarkerFelt-Bold", size: 16)
        self.winnerPaidLabel.sizeToFit()
        self.winnerPaidLabel.center = CGPoint(x: containerView.frame.width * kSixth * 5, y: containerView.frame.height * kThird)
        self.winnerPaidLabel.textAlignment = NSTextAlignment.Center
        self.winnerPaidLabel.backgroundColor = UIColor.darkGrayColor()
        containerView.addSubview(self.winnerPaidLabel)
        
        self.creditsTitleLabel = UILabel()
        self.creditsTitleLabel.text = "Credits" // = UILabel()
        self.creditsTitleLabel.textColor = UIColor.blackColor()
        self.creditsTitleLabel.font = UIFont(name: "AmericanTypeWriter", size: 14)
        self.creditsTitleLabel.sizeToFit()
        self.creditsTitleLabel.center = CGPoint(x: containerView.frame.width * kSixth, y: containerView.frame.height * kThird * 2)
        self.creditsTitleLabel.textAlignment = NSTextAlignment.Center
//        self.creditsTitleLabel.backgroundColor = UIColor.darkGrayColor()
        containerView.addSubview(self.creditsTitleLabel)
        
        self.betTitleLabel = UILabel()
        self.betTitleLabel.text = "Bet" // = UILabel()
        self.betTitleLabel.textColor = UIColor.blackColor()
        self.betTitleLabel.font = UIFont(name: "AmericanTypeWriter", size: 14)
        self.betTitleLabel.sizeToFit()
        self.betTitleLabel.center = CGPoint(x: containerView.frame.width * kSixth * 3, y: containerView.frame.height * kThird * 2)
        self.betTitleLabel.textAlignment = NSTextAlignment.Center
//        self.betTitleLabel.backgroundColor = UIColor.darkGrayColor()
        containerView.addSubview(self.betTitleLabel)
        
        self.winnerPaidTitleLabel = UILabel()
        self.winnerPaidTitleLabel.text = "Winner Paid" // = UILabel()
        self.winnerPaidTitleLabel.textColor = UIColor.blackColor()
        self.winnerPaidTitleLabel.font = UIFont(name: "AmericanTypeWriter", size: 14)
        self.winnerPaidTitleLabel.sizeToFit()
        self.winnerPaidTitleLabel.center = CGPoint(x: containerView.frame.width * kSixth * 5, y: containerView.frame.height * kThird * 2)
        self.winnerPaidTitleLabel.textAlignment = NSTextAlignment.Center
//        self.winnerPaidTitleLabel.backgroundColor = UIColor.darkGrayColor()
        containerView.addSubview(self.winnerPaidTitleLabel)
        
    }
    
    func setupFourthContainer(containerView: UIView) {
        
        self.resetButton = UIButton()
        self.resetButton.setTitle("Reset", forState: UIControlState.Normal)
        self.resetButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.resetButton.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size: 12) // ? because this property might not exist // uhh
        self.resetButton.backgroundColor = UIColor.lightGrayColor()
        self.resetButton.sizeToFit()
        self.resetButton.center = CGPoint(x: containerView.frame.width * kEight, y: containerView.frame.height * kHalf)
        
        self.resetButton.addTarget(self, action: "resetButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside) // send to self, action is named (colon indicates that SOME parameters are goint to be passed - one or more, default event to look for (?)
        
        containerView.addSubview(self.resetButton)
        
        
        
    }
    
}

