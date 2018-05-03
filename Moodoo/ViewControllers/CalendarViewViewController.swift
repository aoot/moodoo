//
//  CalendarViewViewController.swift
//  Moodoo
//
//  Created by Anthony Lee on 4/23/18.
//  Copyright © 2018 Natascha Brauchle. All rights reserved.
//

import UIKit
import JTAppleCalendar   // Third party framework
import CoreData

class CalendarViewViewController: UIViewController {

    @IBOutlet weak var calendarView: JTAppleCalendarView! 
    @IBOutlet weak var month: UILabel!
    @IBOutlet weak var year: UILabel!
    
    private var cellSelected: CustomCell?
    let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCalendarView()
        calendarView.scrollToDate(Date.init(), animateScroll: false)
        calendarView.visibleDates {visibleDates in
            self.SetUpViewsOfCalendar(from: visibleDates)
        }
        self.navigationItem.title = "Mood History"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        calendarView.reloadData()
    }
    
    func handleCellSelected(view: JTAppleCell?, cellState: CellState){
        
        guard let validCell = view as? CustomCell else { return }
        if validCell.isSelected {
            
            cellSelected = validCell
            if PersistenceService.shared.checkMoodForDay(date: cellSelected!.date!) {
                performSegue(withIdentifier: "showMoodSegue", sender: nil)
            }
            else {
                let alertController = UIAlertController(title: "No Data", message: "You didn't enter a mood for that day", preferredStyle: UIAlertControllerStyle.alert)
                let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action:UIAlertAction) in }
                alertController.addAction(OKAction)
                present(alertController, animated:true, completion:nil)
            }
        }
        else{
            validCell.selectedView.isHidden = true
        }
    }
    
    func handleCellTextcolor(view: JTAppleCell?, cellState: CellState) {
        guard let validCell = view as? CustomCell else {return}
        // color days in the month white, outside of month gray
        if cellState.dateBelongsTo == .thisMonth{
            validCell.dateLabel.textColor! = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            if PersistenceService.shared.checkMoodForDay(date: validCell.date!) {
                validCell.backgroundColor = UIColor.orange
            }
            else {
                validCell.backgroundColor = #colorLiteral(red: 1, green: 0.7906726003, blue: 0.4334131479, alpha: 1)
            }
        }
        else{
            validCell.dateLabel.textColor! = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
        }
    }
    
    func setupCalendarView(){
        self.year.text = ""
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func SetUpViewsOfCalendar(from visibleDates: DateSegmentInfo){
        let date = visibleDates.monthDates.first!.date
        self.formatter.dateFormat = "yyyy"
        let yearStr = self.formatter.string(from:date)
        self.formatter.dateFormat = "MMMM"
        self.month.text = "\(self.formatter.string(from:date)) \(yearStr)"
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMoodSegue" {
            let destinationVC = segue.destination as! ShowMoodView
            destinationVC.mood = PersistenceService.shared.getMood(date: cellSelected!.date!)
        }
    }

}

extension CalendarViewViewController:  JTAppleCalendarViewDataSource {

    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
       
        let finalStartDate = formatter.date(from: "2016 01 01")!
        let endDate = formatter.date(from: "2199 12 31")!
        
        let parameters = ConfigurationParameters(startDate: finalStartDate, endDate: endDate)
        return parameters
    }
    
   func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
       // nothing to do here
    }
    
}

extension CalendarViewViewController: JTAppleCalendarViewDelegate {
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
       
        // display the cell
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
        cell.dateLabel.text = cellState.text
        cell.date = date

        handleCellTextcolor(view: cell, cellState: cellState)

        
       // if cellState.isSelected {
         //   cell.selectedView.isHidden = false
        //}
        //else{
          //cell.selectedView.isHidden = true
        //}
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleCellSelected(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        let date = visibleDates.monthDates.first!.date
        self.formatter.dateFormat = "yyyy"
        let yearStr = self.formatter.string(from:date)
        self.formatter.dateFormat = "MMMM"
        self.month.text = "\(self.formatter.string(from:date)) \(yearStr)"
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleCellSelected(view: cell, cellState: cellState)
    }


}
