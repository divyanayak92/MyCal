//
//  ViewController.swift
//  calendar
//
//  Created by Divya Nayak on 13/06/16.
//  Copyright © 2016 Aspire. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
    var selectedDate: Date!
    var calendarManager : CalendarManager!
    var dayOffset : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarManager = CalendarManager()
        self.monthLabel.text = calendarManager.currentMonthAndYear()
        selectedDate = Date()
        dayOffset = (calendarManager.firstWeekDayOfMonth()-1)%7
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DateCell", for: indexPath) as! DateCell
        if indexPath.section == 0{
           cell.dateLabel.text = calendarManager.stringForDay(indexPath.row)
        }else if indexPath.section == 1{
            if indexPath.row < dayOffset{
                cell.dateLabel.text = ""
                return cell
            }
            let date = indexPath.row - dayOffset + 1
            cell.dateLabel.text = NSString(format: "%d", date) as String
        }
        
        if indexPath == indexPathFor(date:Date()){
            cell.selectionView.backgroundColor = UIColor(red:0.59, green:0.05, blue:0.00, alpha:1.0)
            cell.dateLabel.textColor = UIColor.white
        }else if indexPath == indexPathFor(date:selectedDate){
            cell.selectionView.backgroundColor = UIColor(red:0.00, green:0.05, blue:0.55, alpha:1.0)
            cell.dateLabel.textColor = UIColor.white
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: UICollectionViewScrollPosition(rawValue: 0))
        }else{
            cell.selectionView.backgroundColor = UIColor.clear
            cell.dateLabel.textColor = UIColor.black
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        if section == 0 {
            return 7
        }else{
            return calendarManager.numberOfDaysInMonth() + dayOffset
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if dayOffset > indexPath.row || indexPath.section == 0{
            return false
        }
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        selectedDate = dateForIndexPath(indexPath: indexPath)
        let cell = collectionView.cellForItem(at: indexPath) as! DateCell
        if indexPathFor(date:Date()) == indexPath{
            cell.dateLabel.textColor = UIColor.white
            cell.selectionView.backgroundColor = UIColor(red:0.59, green:0.05, blue:0.00, alpha:1.0)
        }else{
            cell.dateLabel.textColor = UIColor.white
            cell.selectionView.backgroundColor = UIColor(red:0.00, green:0.05, blue:0.55, alpha:1.0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! DateCell
        if indexPathFor(date:Date()) == indexPath{
            cell.dateLabel.textColor = UIColor.white
            cell.selectionView.backgroundColor = UIColor(red:0.59, green:0.05, blue:0.00, alpha:1.0)
        }else{
            cell.dateLabel.textColor = UIColor.black
            cell.selectionView.backgroundColor = UIColor.clear
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let size = collectionView.frame.width/7
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        return 0
    }
    
    @IBAction func gotoPreviousMonth(_ sender: AnyObject) {
       previousMonth()
    }

    @IBAction func gotoNextMonth(_ sender: AnyObject) {
        nextMonth()
    }
    
    @IBAction func didSwipe(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == UISwipeGestureRecognizerDirection.right{
            previousMonth()
        }else{
            nextMonth()
        }
    }
    
    private func nextMonth(){
        calendarManager.offsetMonths(1)
        self.monthLabel.text = calendarManager.currentMonthAndYear()
        dayOffset = (calendarManager.firstWeekDayOfMonth()-1) % 7
        collectionView.reloadData()
    }
    
    private func previousMonth(){
        calendarManager.offsetMonths(-1)
        self.monthLabel.text = calendarManager.currentMonthAndYear()
        dayOffset = (calendarManager.firstWeekDayOfMonth()-1) % 7
        collectionView.reloadData()
    }
    
    private func indexPathFor(date : Date) -> IndexPath? {
        if calendarManager.monthForDate(date: date) != calendarManager.monthForDate(date: calendarManager.currentMonth) || calendarManager.yearForDate(date: date) != calendarManager.yearForDate(date: calendarManager.currentMonth){
            return nil
        }
        let day = calendarManager.dayForDate(date: date)
        return IndexPath(row:day + (dayOffset - 1), section:1)
    }
    
    private func dateForIndexPath(indexPath : IndexPath) -> Date {
        let day = indexPath.row - (dayOffset - 1)
        let month = calendarManager.monthForDate(date:calendarManager.currentMonth)
        let year = calendarManager.yearForDate(date:calendarManager.currentMonth)
        return calendarManager.date(day: day, month: month, year: year)
    }
    
    private func isCurrentMonth() -> Bool{
        if calendarManager.monthForDate(date: selectedDate) == calendarManager.monthForDate(date: calendarManager.currentMonth) && calendarManager.yearForDate(date: selectedDate) == calendarManager.yearForDate(date: calendarManager.currentMonth){
            return true
        }else{
            return false
        }
    }
}

