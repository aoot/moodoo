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

// test
class CalendarViewViewController: UIViewController {

    @IBOutlet weak var calendarView: JTAppleCalendarView!

    let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCalendarView()
    }

    func setupCalendarView(){
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CalendarViewViewController:  JTAppleCalendarViewDataSource {

    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // Getting managed object context
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        do{
            let records = try managedObjectContext.fetch(Mood.fetchRequest())
            
            let firstMoodRecord:Mood = records.first as! Mood
            
            let targetDate = firstMoodRecord.date! as String

        } catch (let error) {
        print("Error occured - \(error) ")
        }
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
       
        
        let startDate = formatter.date(from: "2018 12 31")!
        let endDate = formatter.date(from: "2199 12 31")!
        
        let parameters = ConfigurationParameters(startDate: startDate, endDate: endDate)
        return parameters
    }
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
       // What the fuck does this do
    }
    
}

extension CalendarViewViewController: JTAppleCalendarViewDelegate {
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
        cell.dateLabel.text = cellState.text
        
        if cellState.isSelected {
            cell.selectedView.isHidden = false
        }
        else{
            cell.selectedView.isHidden = true
        }
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        guard let validCell = cell as? CustomCell else {return}
        // show visibility of selected view
        validCell.selectedView.isHidden = false
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        guard let validCell = cell as? CustomCell else {return}
        // show visibility of selected view
        validCell.selectedView.isHidden = true
    }

}
