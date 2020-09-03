//
//  ViewController.swift
//  JsonApiToJson_2
//
//  Created by Carlos Diaz on 3/09/20.
//  Copyright © 2020 Carlos Diaz. All rights reserved.
//

import Cocoa
import Japx

class ViewController: NSViewController {

    @IBOutlet weak var inputTextfield: NSTextField!
    @IBOutlet weak var outputTextField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func btnTranslateAction(_ sender: Any) {
        guard let data = inputTextfield.stringValue.data(using: .utf8) else { return }
        outputTextField.stringValue = translateJsonApiToJson(at: data)
    }
    
    @IBAction func btnCopyToClickBoard(_ sender: Any) {
        copyToCliackBoard(text: outputTextField.stringValue)
    }
    
    
    private func translateJsonApiToJson(at jsonApi: Data) -> String {
        do {
            let jsonData = try Japx.Decoder.data(with: jsonApi)
            let translate = String(decoding: jsonData, as: UTF8.self)
            let replacement = translate.replacingOccurrences(of: "\\/", with: "/")
            print("CEDA: translate: \(translate)")
            return replacement
        } catch let error {
            return error.localizedDescription
        }
    }
    
    private func copyToCliackBoard(text: String) {
        let pasteBoard = NSPasteboard.general
        pasteBoard.clearContents()
        pasteBoard.writeObjects([text as NSString])
    }
}

