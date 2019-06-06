//
//  FFMPEGIntentHandler.swift
//  FFMPEGShortcutsAppIntentsExtension
//
//  Created by Zhuowei Zhang on 2019-06-05.
//  Copyright © 2019 Zhuowei Zhang. All rights reserved.
//

import Foundation
import Intents
import UIKit

class FFMPEGIntentHandler: NSObject, IntentIntentHandling {
    func resolveInput_file(for intent: IntentIntent, with completion: @escaping (INFileResolutionResult) -> Void) {
        // what does this do, validate the input?
        completion(INFileResolutionResult.success(with: intent.input_file!))
    }
    
    func handle(intent: IntentIntent, completion: @escaping (IntentIntentResponse) -> Void) {
        //print("User asked us to convert \(intent.input_file)")
        guard let inputFile = intent.input_file else {
            print("you didn't put in the input param")
            return
        }
        if false {
            // no time to configure linking properly
            // this links in Core Video
            _ = UIView(frame: CGRect.zero)
        }
        let outPath = NSTemporaryDirectory() + "/output.wav"
        DispatchQueue.global(qos: .default).async {
            MobileFFmpeg.execute(withArguments: ["-y", "-i",
                                                 inputFile.fileURL!.path,
                                                 outPath])
            var outString = ""
            do {
                let outData = try NSData(contentsOfFile: outPath, options: [])
                outString = outData.base64EncodedString(options: [])
            } catch {
                return
            }
            DispatchQueue.main.async {
                let response = IntentIntentResponse(code: .success, userActivity: nil)
                // yeah I know
                response.output_file = [outString]
                completion(response)
            }
        }
    }
}
