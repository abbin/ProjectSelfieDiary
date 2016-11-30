//
//  PSDSettingsViewController.swift
//  ProjectSelfieDiary
//
//  Created by Abbin Varghese on 28/11/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

import UIKit
import PINCache

struct Constants {
    static let SettingsCacheName = "PSDSettings"
    static let BackupAndSyncSettings = "PSDBackupAndSyncSettings"
    static let SaveMediaSettings = "PSDSaveMediaSettings"
    static let ReminderSettings = "PSDReminderSettings"
    static let ReminderDate = "PSDReminderDate"
}

enum BackupAndSyncSettings: NSString {
    case BackUpToCloud
    case DoNotBackUpToCloud
}

enum SaveMediaSettings: NSString {
    case SaveImagesIntoPhotos
    case DoNotSaveIntoPhotos
}

enum ReminderSettings: NSString {
    case ReminderOn
    case ReminderOff
}

class PSDSettingsViewController: UIViewController {
    
    let cache = PINCache.init(name: Constants.SettingsCacheName)
    
    @IBOutlet weak var backUpToCloudButton: UIButton!
    @IBOutlet weak var doNotBackUpToCloudButton: UIButton!
    @IBOutlet weak var backUpToCloudImageView: UIImageView!
    @IBOutlet weak var doNotBackUpToCloudImageView: UIImageView!
    @IBOutlet weak var saveImagesIntoPhotosButton: UIButton!
    @IBOutlet weak var doNotsaveImagesIntoPhotosButton: UIButton!
    @IBOutlet weak var saveImagesIntoPhotosImageView: UIImageView!
    @IBOutlet weak var doNotsaveImagesIntoPhotosImageView: UIImageView!
    @IBOutlet weak var reminderOnButton: UIButton!
    @IBOutlet weak var reminderOffButton: UIButton!
    @IBOutlet weak var reminderOnImageView: UIImageView!
    @IBOutlet weak var reminderOffImageView: UIImageView!
    @IBOutlet weak var timePicker: UIDatePicker!
    
    @IBAction func dismissSettings(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backUpToCloudClicked(_ sender: UIButton) {
        backUpToCloudButton.setTitleColor(UIColor.init(white: 0.26, alpha: 1), for: .normal)
        doNotBackUpToCloudButton.setTitleColor(UIColor.init(white: 0.70, alpha: 1), for: .normal)
        backUpToCloudImageView.image = #imageLiteral(resourceName: "SettingsSelect")
        doNotBackUpToCloudImageView.image = nil
        cache.setObject(BackupAndSyncSettings.BackUpToCloud.rawValue, forKey: Constants.BackupAndSyncSettings)
    }
    
    @IBAction func doNotBackUpToCloudClicked(_ sender: UIButton) {
        doNotBackUpToCloudButton.setTitleColor(UIColor.init(white: 0.26, alpha: 1), for: .normal)
        backUpToCloudButton.setTitleColor(UIColor.init(white: 0.70, alpha: 1), for: .normal)
        doNotBackUpToCloudImageView.image = #imageLiteral(resourceName: "SettingsSelect")
        backUpToCloudImageView.image = nil
        cache.setObject(BackupAndSyncSettings.DoNotBackUpToCloud.rawValue, forKey: Constants.BackupAndSyncSettings)
    }
    
    @IBAction func saveImagesIntoPhotosClicked(_ sender: UIButton) {
        saveImagesIntoPhotosButton.setTitleColor(UIColor.init(white: 0.26, alpha: 1), for: .normal)
        doNotsaveImagesIntoPhotosButton.setTitleColor(UIColor.init(white: 0.70, alpha: 1), for: .normal)
        saveImagesIntoPhotosImageView.image = #imageLiteral(resourceName: "SettingsSelect")
        doNotsaveImagesIntoPhotosImageView.image = nil
        cache.setObject(SaveMediaSettings.SaveImagesIntoPhotos.rawValue, forKey: Constants.SaveMediaSettings)
    }
    
    @IBAction func doNotSaveImageIntoPhotosClicked(_ sender: UIButton) {
        doNotsaveImagesIntoPhotosButton.setTitleColor(UIColor.init(white: 0.26, alpha: 1), for: .normal)
        saveImagesIntoPhotosButton.setTitleColor(UIColor.init(white: 0.70, alpha: 1), for: .normal)
        doNotsaveImagesIntoPhotosImageView.image = #imageLiteral(resourceName: "SettingsSelect")
        saveImagesIntoPhotosImageView.image = nil
        cache.setObject(SaveMediaSettings.DoNotSaveIntoPhotos.rawValue, forKey: Constants.SaveMediaSettings)
    }
    
    @IBAction func reminderOnClicked(_ sender: UIButton) {
        reminderOnButton.setTitleColor(UIColor.init(white: 0.26, alpha: 1), for: .normal)
        reminderOffButton.setTitleColor(UIColor.init(white: 0.70, alpha: 1), for: .normal)
        reminderOnImageView.image = #imageLiteral(resourceName: "SettingsSelect")
        reminderOffImageView.image = nil
        cache.setObject(ReminderSettings.ReminderOn.rawValue, forKey: Constants.ReminderSettings)
    }
    
    @IBAction func reminderOffCliked(_ sender: UIButton) {
        reminderOffButton.setTitleColor(UIColor.init(white: 0.26, alpha: 1), for: .normal)
        reminderOnButton.setTitleColor(UIColor.init(white: 0.70, alpha: 1), for: .normal)
        reminderOffImageView.image = #imageLiteral(resourceName: "SettingsSelect")
        reminderOnImageView.image = nil
        UIView.animate(withDuration: 0.3, animations: {
            self.timePicker.alpha = 0;
        })
        cache.setObject(ReminderSettings.ReminderOff.rawValue, forKey: Constants.ReminderSettings)
    }
    
    @IBAction func changeTimeClicked(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, animations: {
            self.timePicker.alpha = 1;
        })
    }

    @IBAction func timePickerChangedValue(_ sender: UIDatePicker) {
        cache.setObject(sender.date as NSDate, forKey: Constants.ReminderDate)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backUpSetting :BackupAndSyncSettings.RawValue = cache.object(forKey: Constants.BackupAndSyncSettings) as! BackupAndSyncSettings.RawValue
        let saveMediaSetting :SaveMediaSettings.RawValue = cache.object(forKey: Constants.SaveMediaSettings) as! SaveMediaSettings.RawValue
        let ReminderSetting :ReminderSettings.RawValue = cache.object(forKey: Constants.ReminderSettings) as! ReminderSettings.RawValue
        
        if backUpSetting == BackupAndSyncSettings.BackUpToCloud.rawValue {
            backUpToCloudButton.setTitleColor(UIColor.init(white: 0.26, alpha: 1), for: .normal)
            doNotBackUpToCloudButton.setTitleColor(UIColor.init(white: 0.70, alpha: 1), for: .normal)
            backUpToCloudImageView.image = #imageLiteral(resourceName: "SettingsSelect")
            doNotBackUpToCloudImageView.image = nil
        }
        else{
            doNotBackUpToCloudButton.setTitleColor(UIColor.init(white: 0.26, alpha: 1), for: .normal)
            backUpToCloudButton.setTitleColor(UIColor.init(white: 0.70, alpha: 1), for: .normal)
            doNotBackUpToCloudImageView.image = #imageLiteral(resourceName: "SettingsSelect")
            backUpToCloudImageView.image = nil
        }
        
        if saveMediaSetting == SaveMediaSettings.SaveImagesIntoPhotos.rawValue {
            saveImagesIntoPhotosButton.setTitleColor(UIColor.init(white: 0.26, alpha: 1), for: .normal)
            doNotsaveImagesIntoPhotosButton.setTitleColor(UIColor.init(white: 0.70, alpha: 1), for: .normal)
            saveImagesIntoPhotosImageView.image = #imageLiteral(resourceName: "SettingsSelect")
            doNotsaveImagesIntoPhotosImageView.image = nil
        }
        else{
            doNotsaveImagesIntoPhotosButton.setTitleColor(UIColor.init(white: 0.26, alpha: 1), for: .normal)
            saveImagesIntoPhotosButton.setTitleColor(UIColor.init(white: 0.70, alpha: 1), for: .normal)
            doNotsaveImagesIntoPhotosImageView.image = #imageLiteral(resourceName: "SettingsSelect")
            saveImagesIntoPhotosImageView.image = nil
        }
        
        if ReminderSetting == ReminderSettings.ReminderOn.rawValue {
            reminderOnButton.setTitleColor(UIColor.init(white: 0.26, alpha: 1), for: .normal)
            reminderOffButton.setTitleColor(UIColor.init(white: 0.70, alpha: 1), for: .normal)
            reminderOnImageView.image = #imageLiteral(resourceName: "SettingsSelect")
            reminderOffImageView.image = nil
        }
        else{
            reminderOffButton.setTitleColor(UIColor.init(white: 0.26, alpha: 1), for: .normal)
            reminderOnButton.setTitleColor(UIColor.init(white: 0.70, alpha: 1), for: .normal)
            reminderOffImageView.image = #imageLiteral(resourceName: "SettingsSelect")
            reminderOnImageView.image = nil
        }
        
        let setDate :NSDate = cache.object(forKey: Constants.ReminderDate) as! NSDate
        timePicker.setDate(setDate as Date, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
