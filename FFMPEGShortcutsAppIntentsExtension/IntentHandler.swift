//
//  IntentHandler.swift
//  FFMPEGShortcutsAppIntentsExtension
//
//  Created by Zhuowei Zhang on 2019-06-05.
//  Copyright © 2019 Zhuowei Zhang. All rights reserved.
//

import Intents

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        return FFMPEGIntentHandler()
    }

}
