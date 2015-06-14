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
    
    var slots:[[Slot]] = []
    
    var credits = 0
    var currentBet = 0
    var winnings = 0
    
    
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
//        setupSecondContainer(self.secondContainer) // moved to hardReset()
        setupThirdContainer(self.thirdContainer)
        setupFourthContainer(self.fourthContainer)

        hardReset()
        
//        Factory.createSlots()
//        
//        var factoryInstance = Factory()
//        factoryInstance.createSlot()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // IBActions
    
    func resetButtonPressed(button: UIButton) {
        
        hardReset()
        
    }
    func betOneButtonPressed(button: UIButton) {
        
        if credits <= 0 {
            showAlertWithText(header: "No More Credits", message: "Reset Game")
        }
        else {
            if currentBet < 5 {
                currentBet += 1
                credits -= 1
                updateMainView()
            }
            else {
                showAlertWithText(message: "You can only bet 5 credits at a time!")
            }
        }
        
    }
    
    func betMaxButtonPressed(button: UIButton) {
    
        if credits <= 5 {
            showAlertWithText(header: "Not Enough Credits", message: "Bet Less")
        }
        else {
            if currentBet < 5 {
                var creditsToBetMax = 5 - currentBet
                credits -= creditsToBetMax
                currentBet += creditsToBetMax
                updateMainView()
            }
            else {
                showAlertWithText(message: "You can only bet 5 credits at a time!")
            }
        }
        
        
    }
    
    func spinButtonPressed(button: UIButton) {
        
        removeSlotImageViews() // removing before adding new
        
        slots = Factory.createSlots()
        setupSecondContainer(self.secondContainer)
        
        var winningMultiplier = SlotBrain.computeWinnings(slots)
        winnings = winningMultiplier * currentBet
        credits += winnings
        currentBet = 0
        updateMainView()
        
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

                var slot:Slot
                var slotImageView = UIImageView()
                
                // println("slots count: \(slots.count)")
                
                if slots.count != 0 {
                    let slotContainer = slots[containerNumber]
                    slot = slotContainer[slotNumber]
                    slotImageView.image = slot.image
                }
                else {
                    slotImageView.image = UIImage(named: "Ace")
                }
                
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
        
        self.betOneButton = UIButton()
        self.betOneButton.setTitle("Bet One", forState: UIControlState.Normal)
        self.betOneButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.betOneButton.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size: 12) // ? because this property might not exist // uhh
        self.betOneButton.backgroundColor = UIColor.greenColor()
        self.betOneButton.sizeToFit()
        self.betOneButton.center = CGPoint(x: containerView.frame.width * 3 * kEight, y: containerView.frame.height * kHalf)
        self.betOneButton.addTarget(self, action: "betOneButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(self.betOneButton)
        
        self.betMaxButton = UIButton()
        self.betMaxButton.setTitle("Bet Max", forState: UIControlState.Normal)
        self.betMaxButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.betMaxButton.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size: 12) // ? because this property might not exist // uhh
        self.betMaxButton.backgroundColor = UIColor.greenColor()
        self.betMaxButton.sizeToFit()
        self.betMaxButton.center = CGPoint(x: containerView.frame.width * 5 * kEight, y: containerView.frame.height * kHalf)
        self.betMaxButton.addTarget(self, action: "betMaxButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(self.betMaxButton)
        
        self.spinButton = UIButton()
        self.spinButton.setTitle("Spin", forState: UIControlState.Normal)
        self.spinButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.spinButton.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size: 12) // ? because this property might not exist // uhh
        self.spinButton.backgroundColor = UIColor.greenColor()
        self.spinButton.sizeToFit()
        self.spinButton.center = CGPoint(x: containerView.frame.width * 7 * kEight, y: containerView.frame.height * kHalf)
        self.spinButton.addTarget(self, action: "spinButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(self.spinButton)
    }
    
    func removeSlotImageViews() {
        if self.secondContainer != nil {
            let container:UIView? = self.secondContainer // there's a change there will be no secondContainer, so there's a ? - or was he referring to the ! which was wrong
            let subViews:Array? = container!.subviews // creating another conditional
            for view in subViews! {
                view.removeFromSuperview()
            }
        }
    }
    
    func hardReset() {
        
        removeSlotImageViews()
        slots.removeAll(keepCapacity: true) // keep capacity cos we're gonna fill it soon
        self.setupSecondContainer(self.secondContainer)
        credits = 50 // can be also self.
        currentBet = 0 // can be also self.
        winnings = 0 // can be also self.
        
        updateMainView()
        
    }
    
    func updateMainView() { // update labels actually
        
        self.creditsLabel.text = "\(credits)"
        self.betLabel.text = "\(currentBet)"
        self.winnerPaidLabel.text = "\(winnings)"
        
    }
    
    // show UI alerts
    func showAlertWithText(header:String = "Warning", message:String) { // a default val here
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
}


















