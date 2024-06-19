//
//  ViewController.swift
//  TextEditor
//
//  Created by James Tang on 19/6/2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let html = """
        <ol style="color: white">
            <li>one</li>
                <ol>
                    <li>two</li>
                </ol>
        </ol>
        """

        let data = Data(html.utf8)
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            textView.attributedText = attributedString
        }
    }
}
