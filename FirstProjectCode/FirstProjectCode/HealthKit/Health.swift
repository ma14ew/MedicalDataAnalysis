//
//  Health.swift
//  FirstProject+Code
//
//  Created by Матвей Матюшко on 20.03.2023.
//

import Foundation
import HealthKit

struct Health {
    let healthKitStore: HKHealthStore = HKHealthStore()
    func authorizeHealthKit(completion: ((_ success: Bool, _ error: NSError?) -> Void)!) {
        
        let healthKitTypesToRead = Set(arrayLiteral: HKObjectType.characteristicType(forIdentifier: HKCharacteristicTypeIdentifier.dateOfBirth)!,
                                                    HKObjectType.characteristicType(forIdentifier: HKCharacteristicTypeIdentifier.bloodType)!)
        let healthKitTypesToWrite = Set(arrayLiteral: HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned)!,
                                                    HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)!)
        if !HKHealthStore.isHealthDataAvailable(){
            let error = NSError(domain: "SkillBox.FirstProjectCode", code: 2, userInfo: [NSLocalizedDescriptionKey:"HealthKit is not available in this Device"])
            if(completion != nil) {
                completion(false, error)
            }
            return;
        }
        healthKitStore.requestAuthorization(toShare: healthKitTypesToWrite, read: healthKitTypesToRead) { (success, error) -> Void in
            if( completion != nil ) {
                completion(success, error as NSError?)
            }
        }
    }
    
    func readProfile() -> (age: Date?, bloodType: HKBloodTypeObject?) {
        // Reading Characteristics
        var bloodType : HKBloodTypeObject?
        var dateOfBirth : Date?
        do {
            dateOfBirth = try healthKitStore.dateOfBirthComponents().date
            bloodType = try healthKitStore.bloodType()
        }
        catch {
            print(error)
        }
        return (dateOfBirth, bloodType)
    }
}
